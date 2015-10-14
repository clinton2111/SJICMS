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
    } elseif ($data->location == 'deletePost') {
        deletePost($data);
    } elseif ($data->location == 'fetchPagesNames') {
        fetchPagesNames();
    } elseif ($data->location == 'fetchPagesForEditing') {
        fetchPagesForEditing($data);
    } else if ($data->location == 'updatePage') {
        updatePageInfo($data);

    }
} catch (DomainException $ex) {
    header('HTTP/1.0 401 Unauthorized');
    echo "Invalid token";
    exit();
}

function fetchPagesForEditing($data)
{
    $response = array();
    $resultArray = [];
    try {
        $sql = "SELECT id,post_title,post_content,parent_page_id FROM posts WHERE id=$data->id";
        $result = mysql_query($sql) or trigger_error(mysql_error() . $sql);
        $resultCount = mysql_num_rows($result);
        if ($resultCount > 0) {
            while ($row = mysql_fetch_assoc($result)) {
                $resultArray[] = $row;
            }
            $response['status'] = 'Success';
            $response['message'] = "Post Obtained";
            $response['results'] = $resultArray;
        } else {
            $response['status'] = 'Error';
            $response['message'] = 'No Pages in the Database';
            die();
        }
        echo json_encode($response);
    } catch (exception $e) {
        $response['status'] = 'Error';
        $response['message'] = $e->getMessage();
        echo json_encode($response);
        die();
    }
}

function fetchPagesNames()
{
    $response = array();
    $resultArray = [];
    try {
        $sql = "SELECT id,post_title FROM posts";
        $result = mysql_query($sql) or trigger_error(mysql_error() . $sql);
        $resultCount = mysql_num_rows($result);
        if ($resultCount > 0) {
            while ($row = mysql_fetch_assoc($result)) {
                $resultArray[] = $row;

            }
            $response['status'] = 'Success';
            $response['message'] = "Post's Obtained";
            $response['results'] = $resultArray;
        } else {
            $response['status'] = 'Error';
            $response['message'] = 'No Pages in the Database';
            die();
        }
        echo json_encode($response);
    } catch (exception $e) {
        $response['status'] = 'Error';
        $response['message'] = $e->getMessage();
        echo json_encode($response);
        die();
    }
}

function savePageData($data)
{
    $response = array();
    try {
        $sql = "INSERT INTO posts (post_title,post_content,publish_date,is_draft,author_name,parent_page_id) VALUES ('" . addslashes($data->title) . "','" . addslashes($data->content) . "','" . $data->publish_date . "','" . $data->is_draft . "','" . addslashes($data->author) . "','" . $data->is_parent . "')";
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

function deletePost($data)
{
    $response = array();
    try {
        $new_parent_page_id = null;
        $fetch_parent_id = "SELECT parent_page_id FROM `posts` WHERE id=$data->id";
        $fetch_result = mysql_query($fetch_parent_id) or trigger_error(mysql_error() . $fetch_parent_id);
        $resultCount = mysql_num_rows($fetch_result);
        if ($resultCount > 0) {
            while ($row = mysql_fetch_assoc($fetch_result)) {
                $new_parent_page_id = $row['parent_page_id'];

                $update_parent_children = "UPDATE posts SET parent_page_id=$new_parent_page_id WHERE parent_page_id=$data->id";
                $update_parent_children_result = mysql_query($update_parent_children) or trigger_error(mysql_error() . $update_parent_children);
                if ($update_parent_children_result == 1) {
                    $delete_post = "DELETE FROM posts WHERE id=$data->id";
                    $delete_result = mysql_query($delete_post) or trigger_error(mysql_error() . $delete_post);
                    if ($delete_result == 1) {
                        $delete_comments = "DELETE FROM comments WHERE post_id=$data->id";
                        $delete_comments_result = mysql_query($delete_comments) or trigger_error(mysql_error() . $delete_comments);
                        if ($delete_comments_result == 1) {
                            $response['status'] = 'Success';
                            $response['message'] = 'Post Deleted';
                        } else {
                            $response['status'] = 'Error';
                            $response['message'] = 'Comments could not be deleted';
                            die();
                        }

                    } else {
                        $response['status'] = 'Error';
                        $response['message'] = 'Post could not be deleted';
                        die();
                    }
                } else {
                    $response['status'] = 'Error';
                    $response['message'] = 'Could not update children';
                    die();
                }
            }
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
        $sql_1 = "SELECT id,post_title,publish_date,is_draft from `posts` WHERE parent_page_id=0 LIMIT 4 OFFSET $data->offset";
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

function updatePageInfo($data)
{
    $response = array();
    try {
        $update_post = "UPDATE `posts` SET post_title='$data->title',post_content='$data->content',publish_date='$data->publish_date',author_name='$data->author',is_draft='data->is_draft' WHERE id=$data->id";
        $update_post_result = mysql_query($update_post) or trigger_error(mysql_error() . $update_post);
        if ($update_post_result == 1) {
            $response['status'] = 'Success';
            $response['message'] = 'Post Updates';
        } else {
            $response['status'] = 'Error';
            $response['message'] = 'Could not update post';
        }
        echo json_encode($response);
    } catch (exception $e) {
        $response['status'] = 'Error';
        $response['message'] = $e->getMessage();
        echo json_encode($response);
        die();
    }
}

