<?php
header('Content-Type: application/javascript');
include 'connection.config.php';
require_once '../vendor/firebase/php-jwt/Authentication/JWT.php';
$json = file_get_contents('php://input');
$data = json_decode($json);
$JWT = new JWT;
$headers = apache_request_headers();
$header = str_replace("Bearer ", "", $headers['Authorization']);
try {
    $decoded_token = $JWT->decode($header, $key, array($alg));

    if ($data->location == 'fetchComments') {
        fetchComments($data);
    } elseif ($data->location == 'deleteComment') {
        deleteComment($data);
    }
} catch (DomainException $ex) {
    header('HTTP/1.0 401 Unauthorized');
    echo "Invalid token";
    exit();
}
function fetchComments($data)
{
    $response = array();

    try {
        $resultArray = array();
        $sql = "SELECT id,name,comment,time_posted FROM comments WHERE post_id=$data->id LIMIT 5 OFFSET $data->offset";
        $result = mysql_query($sql) or trigger_error(mysql_error() . $sql);
        $count = mysql_num_rows($result);
        $index = 0;
        if ($count > 0) {
            while ($row = mysql_fetch_assoc($result)) {
                $resultArray[$index] = $row;
                $index++;
            }
            $response['status'] = 'Success';
            $response['message'] = 'Comments Loaded';
            $response['results'] = json_encode($resultArray);
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

function deleteComment($data)
{
    $response = array();
    try {
        $delete_mail = "DELETE FROM comments WHERE id=$data->id";
        $delete_mail_result = mysql_query($delete_mail) or trigger_error(mysql_error() . $delete_mail);
        if ($delete_mail_result == 1) {
            $response['status'] = 'Success';
            $response['message'] = 'Comment Deleted';
        } else {
            $response['status'] = 'Error';
            $response['message'] = 'Comment could not be deleted';
            die();
        }
        echo json_encode($response);
    } catch (Exception $e) {
        $response['status'] = 'Error';
        $response['message'] = $e->getMessage();
        echo json_encode($response);
        die();
    }
}

