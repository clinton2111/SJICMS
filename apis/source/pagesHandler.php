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

    if ($data->location == 'savePage') {
        savePageData($data);
    } elseif ($data->location == 'fetchPagesInfo') {
        fetchPagesInfo($data);
    }
} catch (DomainException $ex) {
    header('HTTP/1.0 401 Unauthorized');
    echo "Invalid token";
    exit();
}

function savePageData($data)
{
    $response = array();
    try {
        $sql = "INSERT INTO posts (post_title,post_content,publish_date,is_draft,author_name,parent_page_id) VALUES ('" . $data->title . "','" . $data->content . "','" . $data->publish_date . "','" . $data->is_draft . "','" . $data->author . "','" . $data->is_parent . "')";
        $result = mysql_query($sql) or die(mysql_error());
        if ($result == 1) {
            $response['status'] = 'Success';
            $response['message'] = 'Post uploaded successfully';
        } else {
            $response['status'] = 'Error';
            $response['message'] = 'Photo upload failed';
        }
        echo json_encode($response);

    } catch (exception $e) {
        $response['status'] = 'Error';
        $response['message'] = $e->getMessage();
        echo json_encode($response);
        die();
    }
}

function fetchPagesInfo($data)
{
    $response = array();
    $resultArray_1 = array();
    try {
        $sql_1 = "SELECT id,post_title,publish_date,is_draft from `posts` WHERE parent_page_id=0";
        $result_1 = mysql_query($sql_1) or trigger_error(mysql_error() . $sql_1);
        $resultCount_1 = mysql_num_rows($result_1);
        $index_1 = 0;
        if ($resultCount_1 > 0) {
            while ($row_1 = mysql_fetch_assoc($result_1)) {
                $resultArray_1[] = $row_1;

                $temp_id_1 = $row_1['id'];
                $sql_2 = "SELECT id,post_title,publish_date,is_draft from `posts` WHERE parent_page_id=$temp_id_1";
                $result_2 = mysql_query($sql_2) or trigger_error(mysql_error() . $sql_2);
                $resultCount_2 = mysql_num_rows($result_2);
                $resultArray_2 = array();
                $index_2 = 0;
                if ($resultCount_2 > 0) {
                    while ($row_2 = mysql_fetch_assoc($result_2)) {
                        $resultArray_2[] = $row_2;


                        $temp_id_2 = $row_2['id'];
                        $sql_3 = "SELECT id,post_title,publish_date,is_draft from `posts` WHERE parent_page_id=$temp_id_2";
                        $result_3 = mysql_query($sql_3) or trigger_error(mysql_error() . $sql_3);
                        $resultCount_3 = mysql_num_rows($result_3);
                        $resultArray_3 = array();

                        if ($resultCount_3 > 0) {
                            while ($row_3 = mysql_fetch_assoc($result_3)) {
                                $resultArray_3[] = $row_3;

                            }
                        }
                        if (sizeof($resultArray_3) > 0) {
                            $resultArray_2[$index_2]['children'] = $resultArray_3;
                        }
                        $index_2++;

                    }
                }
                if (sizeof($resultArray_2) > 0) {
                    $resultArray_1[$index_1]['children'] = $resultArray_2;
                }
                $index_1++;
            }
            $response['status'] = 'Success';
            $response['message'] = 'Data present';
            $response['results'] = $resultArray_1;
        } else {
            $response['status'] = 'Error';
            $response['message'] = 'No pages found';
        }


        echo json_encode($response);

    } catch (exception $e) {
        $response['status'] = 'Error';
        $response['message'] = $e->getMessage();
        echo json_encode($response);
        die();
    }
}
