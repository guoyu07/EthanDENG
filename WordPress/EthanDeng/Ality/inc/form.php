<?php
$to = "ddswhu@gmail.com"; //将此电子邮件地址改为自己的。

$name = $_POST['name']; 
$email = $_POST['email']; 
$subject = "来自博客读者的邮件";
$message = $_POST['message'];
mail($to,$subject,$message,"From: ".$email."");
echo 'OK '.$name.', 您的邮件已发送。'; 
?>