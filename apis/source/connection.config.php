<?php
/**
 * Created by PhpStorm.
 * User: Clinton
 * Date: 10/11/2015
 * Time: 1:16 PM
 */
$key = md5('mySecretKey');
$alg = 'HS512';

//$SMTPDetails = array();
//$SMTPDetails['Host'] = 'smtp.sendgrid.net';
//$SMTPDetails['Username'] = '';
//$SMTPDetails['Password'] = '';
//$SMTPDetails['SMTPSecure'] = 'ssl';
//$SMTPDetails['Port'] = 465;

define("DB_HOST", "localhost");
// set database host
define("DB_USER", "root");
// set database user
define("DB_PASS", "");
// set database password
define("DB_NAME", "sji_cms");
// set database name

$link = mysql_connect(DB_HOST, DB_USER, DB_PASS) or die("Couldn't make connection.");
$db = mysql_select_db(DB_NAME, $link) or die("Couldn't select database");