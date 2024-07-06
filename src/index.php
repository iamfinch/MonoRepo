<?php
require("utilities/Email.class.php");
echo "hello world";
$email = new Email("iamfinch47@gmail.com", "an Email", "this is an email");
$email->sendEmail();
?>