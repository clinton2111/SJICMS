<?php

$key = md5('mySecretKey');
$alg = 'HS512';

$HOST = 'http://sjicms.com';

$SMTPDetails = array();
$SMTPDetails['Host'] = 'smtp.sendgrid.net';
$SMTPDetails['Username'] = 'aventador_21';
$SMTPDetails['Password'] = 'Aventador2106';
$SMTPDetails['SMTPSecure'] = 'ssl';
$SMTPDetails['Port'] = 465;

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