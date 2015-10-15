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

    if ($data->location == 'fetchMail') {
        fetchMail($data);
    } elseif ($data->location == 'deleteMail') {
        deleteMail($data);
    } elseif ($data->location == 'sendMail') {
        sendMail($data, $SMTPDetails);
    }
} catch (DomainException $ex) {
    header('HTTP/1.0 401 Unauthorized');
    echo "Invalid token";
    exit();
}
function fetchMail($data)
{
    $response = array();

    try {
        $resultArray = array();
        $sql = "SELECT id,sender_name,sender_email,sender_subject,sender_message,sent_time FROM mail ORDER BY id DESC LIMIT 5 OFFSET $data->offset";
        $result = mysql_query($sql) or trigger_error(mysql_error() . $sql);
        $count = mysql_num_rows($result);
        $index = 0;
        if ($count > 0) {
            while ($row = mysql_fetch_assoc($result)) {
                $resultArray[$index] = $row;
                $index++;
            }
            $response['status'] = 'Success';
            $response['message'] = 'Mail Loaded';
            $response['results'] = json_encode($resultArray);
        } else {
            $response['status'] = 'Error';
            $response['message'] = 'No mail found';
        }
        echo json_encode($response);

    } catch (Exception $e) {
        $response['status'] = 'Error';
        $response['message'] = $e->getMessage();
        echo json_encode($response);
        die();
    }

}

function deleteMail($data)
{
    $response = array();
    try {
        $delete_mail = "DELETE FROM mail WHERE id=$data->id";
        $delete_mail_result = mysql_query($delete_mail) or trigger_error(mysql_error() . $delete_mail);
        if ($delete_mail_result == 1) {
            $response['status'] = 'Success';
            $response['message'] = 'Mail Deleted';
        } else {
            $response['status'] = 'Error';
            $response['message'] = 'Mail could not be deleted';
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

function sendMail($data, $SMTPDetails)
{

    $msgStructure = $data->finalmsg;
    $message['From'] = 'noreply@sjicms.com';
    $message['FromName'] = 'SJI CMS - Admin';

    $message['To'] = $data->to_email;
    $message['ToName'] = $data->to_name;

    $message['Reply'] = null;
    $message['ReplyName'] = null;

    $message['Subject'] = $data->subject;
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
}