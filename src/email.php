<?php

ini_set('display_errors','Off');
error_reporting(0);

$text_fields = array('name', 'company', 'email', 'project');
$clean_fields = array();

foreach ($text_fields as $f) {
  // Not much to do here so long as we are sending the email as text and not html.
  // But magic quotes are on so that's cool
  $clean_fields[$f] = stripslashes($_POST[$f]);
}

$budget = sprintf("$%d - $%d", $_POST['budget'][0], $_POST['budget'][1]);

$to = str_replace("\n", ",", file_get_contents('email_config'));
$from = "${clean_fields['name']} <${clean_fields['email']}>";
$subject = "Contact via 323productions.com";

$message = "This was submitted via the website contact form.\n\n"
         . "From: $from\n"
         . "Company: ${clean_fields['company']}\n"
         . "Budget: ${budget}\n"
         . "Project: ${clean_fields['project']}\n";

$headers = "From: Three20Three Website <contact@323productions.com>\r\n"
         . "Reply-To: <contact@323productions.com>\r\n"
         . "Return-Path: <contact@323productions.com>\r\n"
         . "Content-Type: text/plain; charset=UTF-8\r\n"
         . "MIME-Version: 1.0\n";

$params  = "-fcontact@323productions.com";

if (!mail($to, $subject, $message, $headers, $params)) {
  header("HTTP/1.1 500 Internal Server Error");
  // Try to mail me about it
  $error = date('r') . "\n---\n$to\n---\n$subject\n---\n$message\n---\n$headers";
  mail("admin@323productions.com", "Contact form failure", "", $headers);
  echo "Mail error";
  exit;
}

?>
