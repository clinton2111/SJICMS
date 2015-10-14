<?php
include 'connection.config.php';
$json = file_get_contents('php://input');
$data = json_decode($json);
try {
    if ($data->location == 'fetchPages') {
        fetchPages($data);
    } elseif ($data->location == 'fetchPageInfo') {
        fetchPageInfo($data);
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
        $sql = "SELECT id,post_title,author_name,publish_date FROM posts WHERE is_draft=0 ORDER BY id DESC LIMIT 4 OFFSET $data->offset ";
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

    try {
        $resultArray = array();
        $sql = "SELECT id,post_title,author_name,publish_date FROM posts WHERE id=$data->id";
        $result = mysql_query($sql) or trigger_error(mysql_error() . $sql);
        $count = mysql_num_rows($result);
        if ($count == 1) {
            while ($row = mysql_fetch_assoc($result)) {

                if (strtotime($data->now) > strtotime($row['publish_date'])) {
                    $resultArray[] = $row;
                    $response['status'] = 'Success';
                    $response['message'] = 'Data present';
                    $response['results'] = json_encode($row);
                } else {
                    $response['status'] = 'Scheduled';
                    $response['message'] = 'Data present';
                }


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