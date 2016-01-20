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
>>>>>>> parent of b8d28b7... no message
