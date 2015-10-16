SJI Practical task
========================

Overview
---------
- Content management system - Built with AngularJS and PHP 
- Uses Json Web Token for Authentication so as to securely pass data from different sources and also to maintain session information
- Front end coded in CoffeeScript
- Assets used are SVG's so as to provide high quality images but as have a very reasonable filesize
- HTML,CSS and JS are all minified so as to increase performance
- Use's PHPMailer and [SendGrid](https://sendgrid.com/ "title") for mailing functionality
- Use's [Google's reCAPTCHA](https://www.google.com/recaptcha/intro/index.html "title") to prevent spam from bots
- CK Editior for WYSIWYG post development
- .htaccess for caching and enabling compression
- [Materialize](http://materializecss.com/ 'title') css framework used

Installation
------------
- Install the bower dependenceis from the `bower.json` file in the project root
```
# install dependencies listed in bower.json
$ bower install
```
- Install composer dependencies from the `composer.json` (**PROJECT_ROOT/apis/composer.json**)
```
$ php composer.phar install
```
- Once that is done then you can edit the `connection.config.php` file found in **PROJECT_ROOT/apis/source/connection.config.php**
```
#Replace the following with the appropriate details.
# set database host
define("DB_HOST", "localhost");
# set database user
define("DB_USER", "root");
# set database password
define("DB_PASS", "");
# set database name
define("DB_NAME", "sji_cms");
```
- The database `sji_cms.sql` is provided in the SQL folder
- also set `$HOST` to your project root. This variable is resposible for the formating of the urls int\ emails sent.
- To access the admin panel go to **/PROJECT_ROOT/admin**
```
#email_id and Password for Admin Panel
email_id - 'clinton92@gmail.com'
password - 'clinton2111'
```
- If you get a **ERROR: Invalid domain for site key** with respect to the Google reCaptcha while posting a comment, do one of the following
> 1. If you're running on a virtual host change your virtual host name to **sjicms.com**
> 2. if you're running on a live host or dont want to change your host name then go to https://www.google.com/recaptcha/intro/index.html to obtain new keys for the reCaptcha API. And make changes in the following locations.

```
#in the /Project_Root/frontend/coffee/app.coffee (or /Project_Root/frontend/js/app.js if you want to change the value in the JS directly)
g_reCaptchaKey = New Public Key

#in /Project_Root/apis/source/connection.config.php
$gCaptchaSecretKey = New Secret Key

```

if you have any problems or difficulties setting this up.please do let me know. Thank you. Have a nice day.

Developed and Tested on Windows 10 running XAMPP 1.8.2 with a PHP version of 5.6.3 
