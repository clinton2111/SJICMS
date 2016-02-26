<<<<<<< HEAD
=======
<<<<<<< HEAD
# SJICMS
CMS for SJI
<br>
Features<br>
Admin side:
<ul>
<li> Login for admin </li>
<li> Settings page once the admin logs in to create username and password</li>
<li> Create pages section. Add/edit/delete and pages listing.</li>
<li> Ck editor for add and edit pages</li>
<li> Listing of all the pages. There will be main pages and sub-pages that fall under the main page. (there needs to be a three level hierarchy)</li>
<li> Sorting of pages</li>
<li> Preview of the content before publishing the page</li>
<li> Draft a page for further editing/adding content.</li>
<li> Schedule a page to go online on a specific date.</li>
<li> Contact form entries</li>
<li> Reply for a contact form query</li>
<li> Manage content comments</li>
</ul>
<br>
Frontend side
<ul>
<li> Listing of the pages.</li>
<li> Use suckerfish dropdowns to show the main pages and the secondary level and the third level pages</li>
<li> Display page contents as seen in the preview in the admin section</li>
<li> Contact us form</li>
<li> Use recaptcha to secure the form from spams</li>
<li> Search contents (top header needs to have a search form)</li>
<li> Pages needs to have a commenting facility. Anonymous can post comments but make sure you have a captcha while posting comments.</li>
</ul>
=======
>>>>>>> Develop
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
<<<<<<< HEAD
- Install the bower dependence's from the `bower.json` file in the project root
=======
- Install the bower dependenceis from the `bower.json` file in the project root
>>>>>>> Develop
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
email_id - 'clinton@example.com'
password - 'clinton2111'
```
<<<<<<< HEAD
<<<<<<< HEAD
=======
>>>>>>> 652f15e3fad96e5f8ba392ea026ac26db8dfbb67
- If you get a **ERROR: Invalid domain for site key** with respect to the Google reCaptcha while posting a comment, do one of the following
> 1. If you're running on a virtual host change your virtual host name to **sjicms.com**
> 2. if you're running on a live host or dont want to change your host name then go to https://www.google.com/recaptcha/intro/index.html to obtain new keys for the reCaptcha API. And make changes in the following locations.

```
#in the /Project_Root/frontend/coffee/app.coffee (or /Project_Root/frontend/js/app.js if you want to change the value in the JS directly)
g_reCaptchaKey = New Public Key

#in /Project_Root/apis/source/connection.config.php
$gCaptchaSecretKey = New Secret Key

```
<<<<<<< HEAD

if you have any problems or difficulties setting this up.please do let me know. Thank you. Have a nice day.

Developed and Tested on Windows 10 running XAMPP 1.8.2 with a PHP version of 5.6.3 
=======
=======
>>>>>>> 652f15e3fad96e5f8ba392ea026ac26db8dfbb67

if you have any problems or difficulties setting this up.please do let me know. Thank you. Have a nice day.

Developed and Tested on Windows 10 running XAMPP 1.8.2 with a PHP version of 5.6.3 
<<<<<<< HEAD
>>>>>>> parent of b8d28b7... no message
>>>>>>> Develop
=======
>>>>>>> 652f15e3fad96e5f8ba392ea026ac26db8dfbb67
