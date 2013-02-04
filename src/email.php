<?php

ini_set('display_errors','Off');
error_reporting(0);

$text_fields = array('name', 'company', 'email', 'project');
$clean_fields = array();

foreach ($text_fields as $f) {
  // Not much to do here so long as we are sending the email as text and not html.
  $clean_fields = $_POST[$f];
}

$budget = sprintf("$%d - $%d", $_POST['budget'][0], $_POST['budget'][1]);

$to = str_replace(file_get_contents('email_config'), "\n", ",");
$from = "${clean_fields['name']} <${clean_fields['email']}>";
$subject = "Contact via 323productions.com";

$message = "This was submitted via the website contact form.\n\n"
         . "From: $from\n"
         . "Company: ${clean_fields['company']}\n"
         . "Budget: ${budget}\n"
         . "Project: ${clean_fields['project']}\n";

$headers = "From: $from\r\n"
         . "Reply-To: $from\r\n"
         . "Content-type: text/plain; charset=\"UTF-8\"\r\n";

if (!mail($to, $subject, $message, $headers)) {
  header("HTTP/1.1 500 Internal Server Error");
  // Try to mail me about it
  mail("admin@323productions.com", "Contact form failure", date('r'));
  exit;
}

?>
