<?php
include 'connection.config.php';
$json = file_get_contents('php://input');
$data = json_decode($json);
try {
    if ($data->location == 'fetchPages') {
        fetchPages($data);
    } elseif ($data->location == 'fetchPageInfo') {
        fetchPageInfo($data);
    } elseif ($data->location == 'postComment') {
        postComment($data, $secretKey = $gCaptchaSecretKey);
    } else if ($data->location == 'loadMoreComments') {
        loadMoreComments($data);
    } else if ($data->location == 'sendEmail') {
        sendEmail($data);
    } else if ($data->location == 'fetchSearchResults') {
        fetchSearchResults($data);
    }

} catch (Exception $e) {
    echo 'Error ' . $e->getMessage();
    die();
}
function fetchPages($data)
{
    $response = array();

    try {
        $resultArray = array();
        $sql = "SELECT id,post_title,author_name,publish_date FROM posts WHERE is_draft=0 ORDER BY id DESC LIMIT 6 OFFSET $data->offset ";
        $result = mysql_query($sql) or trigger_error(mysql_error() . $sql);
        $count = mysql_num_rows($result);
        $index = 0;
        if ($count > 0) {
            while ($row = mysql_fetch_assoc($result)) {

                if (strtotime($data->now) > strtotime($row['publish_date'])) {
                    $resultArray[$index] = $row;
                    $index++;
                }


            }
            $response['status'] = 'Success';
            $response['message'] = 'Data present';
            $response['results'] = json_encode($resultArray);
        } else {
            $response['status'] = 'Error';
            $response['message'] = 'No Posts found';
        }
        echo json_encode($response);

    } catch (Exception $e) {
        $response['status'] = 'Error';
        $response['message'] = $e->getMessage();
        echo json_encode($response);
        die();
    }

}

function fetchPageInfo($data)
{
    $response = array();
    $results = array();
    try {

        $sql = "Select posts.post_title,posts.author_name,posts.publish_date,posts.post_content,comments.name,comments.comment,comments.time_posted "
            . "from posts left join comments "
            . "on posts.id=comments.post_id "
            . "where posts.id=$data->id "
            . "LIMIT 5";
        $result = mysql_query($sql) or trigger_error(mysql_error() . $sql);
        $count = mysql_num_rows($result);
        $index = 0;
        $flag = true;
        if ($count >= 1) {
            $temp = array();
            while ($row = mysql_fetch_assoc($result)) {

                if ((strtotime($data->now) > strtotime($row['publish_date'])) == true) {
                    if ($index == 0) {
                        $results[$index]['post_title'] = $row['post_title'];
                        $results[$index]['author_name'] = $row['author_name'];
                        $results[$index]['publish_date'] = $row['publish_date'];
                        $results[$index]['post_content'] = $row['post_content'];

                        $temp[$index]['name'] = $row['name'];
                        $temp[$index]['comment'] = $row['comment'];
                        $temp[$index]['time_posted'] = $row['time_posted'];
                    } else {

                        $temp[$index]['name'] = $row['name'];
                        $temp[$index]['comment'] = $row['comment'];
                        $temp[$index]['time_posted'] = $row['time_posted'];
                    }
                    $index++;
                } else {
                    $flag = false;
                }
            }
            if ($flag == false) {
                $response['status'] = 'Scheduled';
                $response['message'] = 'Data present';
            } else {
                $results[0]['comments'] = $temp;
                $response['status'] = 'Success';
                $response['message'] = 'Data present';
                $response['results'] = $results;
            }

        } else {
            $response['status'] = '404';
            $response['message'] = 'Post does not exist';
        }
        echo json_encode($response);

    } catch (Exception $e) {
        $response['status'] = 'Error';
        $response['message'] = $e->getMessage();
        echo json_encode($response);
        die();
    }

}

function postComment($data, $secretKey)
{
    $captcha = $data->g_recaptcha_response;

    $postdata = http_build_query(
        array(
            'secret' => $secretKey, //secret KEy provided by google
            'response' => $captcha,                    // g-captcha-response string sent from client
            'remoteip' => $_SERVER['REMOTE_ADDR']
        )
    );
    $opts = array('http' =>
        array(
            'method' => 'POST',
            'header' => 'Content-type: application/x-www-form-urlencoded',
            'content' => $postdata
        )
    );
    $context = stream_context_create($opts);
    $response = file_get_contents("https://www.google.com/recaptcha/api/siteverify", false, $context);
    $response = json_decode($response, true);

    $clientResponse = array();
    if ($response["success"] === false) {

        $clientResponse['status'] = 'Error';
        $clientResponse['message'] = 'Robots Not allowed (Captcha verification failed)';

    } else {

        try {
            $sql = "INSERT INTO comments (name,comment,time_posted,post_id) VALUES ('" . addslashes($data->name) . "','" . addslashes($data->comment) . "','" . $data->now . "','" . $data->post_id . "')";
            $result = mysql_query($sql) or die(mysql_error());
            if ($result == 1) {
                $clientResponse['status'] = 'Success';
                $clientResponse['message'] = 'Comment posted successfully';
            } else {
                $clientResponse['status'] = 'Error';
                $clientResponse['message'] = 'Could not post comment';
            }


        } catch (exception $e) {
            $clientResponse['status'] = 'Error';
            $clientResponse['message'] = $e->getMessage();
            echo json_encode($response);
            die();
        }
    }
    echo json_encode($clientResponse);
}

function loadMoreComments($data)
{
    $response = array();

    try {
        $resultArray = array();
        $sql = "SELECT name,comment,time_posted FROM comments WHERE post_id=$data->id LIMIT 5 OFFSET $data->offset ";
        $result = mysql_query($sql) or trigger_error(mysql_error() . $sql);
        $count = mysql_num_rows($result);
        $index = 0;
        if ($count > 0) {
            while ($row = mysql_fetch_assoc($result)) {
                $resultArray[$index] = $row;
                $index++;
            }
            $response['status'] = 'Success';
            $response['message'] = 'Comments fetched';
            $response['results'] = ($resultArray);
        } else {
            $response['status'] = 'Error';
            $response['message'] = 'No Comments found';
        }
        echo json_encode($response);

    } catch (Exception $e) {
        $response['status'] = 'Error';
        $response['message'] = $e->getMessage();
        echo json_encode($response);
        die();
    }

}

function sendEmail($data)
{
    $response = array();
    try {
        $sql = "INSERT INTO mail (sender_name,sender_email,sender_subject,sender_message,sent_time) VALUES ('" . $data->name . "','" . $data->address . "','" . $data->subject . "','" . addslashes($data->msg) . "','" . $data->now . "')";
        $result = mysql_query($sql) or die(mysql_error());
        if ($result == 1) {
            $response['status'] = 'Success';
            $response['message'] = 'Email sent successfully';
        } else {
            $response['status'] = 'Error';
            $response['message'] = 'Could not send email';
        }

        echo json_encode($response);
    } catch (exception $e) {
        $response['status'] = 'Error';
        $response['message'] = $e->getMessage();
        echo json_encode($response);
        die();
    }
}

function fetchSearchResults($data)
{
    $response = array();

    try {
        $resultArray = array();
        $sql = "SELECT id,post_title,author_name,publish_date FROM posts`post_title` WHERE (post_title LIKE '%$data->query%') OR (post_content LIKE '%$data->query%')OR (author_name LIKE '%$data->query%')";
        $result = mysql_query($sql) or trigger_error(mysql_error() . $sql);
        $count = mysql_num_rows($result);
        $index = 0;
        if ($count > 0) {
            while ($row = mysql_fetch_assoc($result)) {

                if (strtotime($data->now) > strtotime($row['publish_date'])) {
                    $resultArray[$index] = $row;
                    $index++;
                }


            }
            $response['status'] = 'Success';
            $response['message'] = 'Data present';
            $response['results'] = json_encode($resultArray);
        } else {
            $response['status'] = 'Error';
            $response['message'] = 'No Posts found';
        }
        echo json_encode($response);

    } catch (Exception $e) {
        $response['status'] = 'Error';
        $response['message'] = $e->getMessage();
        echo json_encode($response);
        die();
    }

}