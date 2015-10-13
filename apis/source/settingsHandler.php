<?php
include 'connection.config.php';
require_once '../vendor/firebase/php-jwt/Authentication/JWT.php';
$json = file_get_contents('php://input');
$data = json_decode($json);
$JWT = new JWT;
$headers = apache_request_headers();
$header = str_replace("Bearer ", "", $headers['Authorization']);
try {
    $decoded_token = $JWT->decode($header, $key, array($alg));

    if ($data->location == 'updatePassword') {
        updatePassword($data);
    }
} catch (DomainException $ex) {
    header('HTTP/1.0 401 Unauthorized');
    echo "Invalid token";
    exit();
}
function updatePassword($data)
{
    $response = array();
    try {
        $sql = "SELECT 1 FROM users WHERE BINARY id='$data->id' and password='$data->currentPassword'";
        $result = mysql_query($sql) or trigger_error(mysql_error() . $sql);
        $Count = mysql_num_rows($result);
        if ($Count == 1) {
            $sql2 = "UPDATE users SET password='$data->newPassword' WHERE id=$data->id";
            $result2 = mysql_query($sql2) or trigger_error(mysql_error() . $sql2);
            if ($result2 == 1) {
                $response['status'] = 'Success';
                $response['message'] = 'Password Updated';
            }
        } else {
            $response['status'] = 'Error';
            $response['message'] = 'Incorrect password. Please enter your current password';
        }
        echo json_encode($response);
    } catch (Exception $e) {
        $response['status'] = 'Error';
        $response['message'] = $e->getMessage();
        echo json_encode($response);
        die();
    }
}