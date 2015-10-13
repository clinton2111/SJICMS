<?php
header('Content-Type: application/javascript');
include 'connection.config.php';
require_once '../vendor/firebase/php-jwt/Authentication/JWT.php';
include 'mailer.php';
$json = file_get_contents('php://input');
$data = json_decode($json);
$JWT = new JWT;
$headers = apache_request_headers();
$header = str_replace("Bearer ", "", $headers['Authorization']);
try {
    $decoded_token = $JWT->decode($header, $key, array($alg));

    if ($data->location == 'updatePassword') {
        updatePassword($data);
    } elseif ($data->location == 'addUser') {
        addNewUser($data,$SMTPDetails,$HOST);
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

function addNewUser($data,$SMTPDetails,$HOST)
{
    try {
        $sql = "SELECT id,username FROM users WHERE BINARY email='$data->email'";
        $result = mysql_query($sql) or die(mysql_error());
        $count = mysql_num_rows($result);

        if ($count != 1) {
            $sql = "Insert into users (email,password,username,role) VALUES ('" . $data->email . "','" . $data->passEncrypted . "','" . $data->name . "','" . $data->role . "')";
            $result = mysql_query($sql) or die(mysql_error());
            if ($result == 1) {
                $msgStructure = 'Hello ' . $data->name . '<br> You have assigned as a ' . $data->role . ' at SJICMS.Please use the following credentials to log into ' . $HOST . '/admin/#/auth/login//  the admin panel<br>Email:' . $data->email . '<br>Password:' . $data->password;
                $message['From'] = 'noreply@sjicms.com';
                $message['FromName'] = 'SJI CMS - Admin Role';

                $message['To'] = $data->email;
                $message['ToName'] = $data->name;

                $message['Reply'] = null;
                $message['ReplyName'] = null;

                $message['Subject'] = 'Admin Panel Login Details';
                $message['Body'] = $msgStructure;
                $message['AltBody'] = htmlentities($msgStructure);

                $message['SuccessMessage'] = 'Message Sent. Please check your Inbox';

                try {
                    SMTPSend($message, $SMTPDetails);
                } catch (Exception $e) {
                    $response['status'] = 'Error';
                    $response['message'] = $e->getMessage();
                    echo json_encode($response);
                }


//                $response['status'] = 'Success';
//                $response['message'] = 'User Created successfully';
            } else {
                $response['status'] = 'Error';
                $response['message'] = 'User Creation failed';
                echo json_encode($response);
            }


        } else {
            $response['status'] = 'Error';
            $response['message'] = 'Email id already in use';
            echo json_encode($response);
        }

    } catch (exception $e) {
        header('HTTP/1.0 401 Unauthorized');
        $response['status'] = 'Error';
        $response['message'] = $e->getMessage();
        echo json_encode($response);
    }
}