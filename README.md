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

if you have any problems or difficulties setting this up.please do let me know. Thank you. Have a nice day.

Developed and Tested on Windows 10 running XAMPP 1.8.2 with a PHP version of 5.6.3 