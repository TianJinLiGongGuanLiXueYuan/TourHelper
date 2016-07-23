<?php
//连接服务器  
$conn=mysql_connect('localhost','root','sheperd');  
//状态  
if(!$conn){  
echo "connection failed";  
exit;  
}
//选择数据库  
$sql='phptest';  
//conn通道进行  
$rs=mysql_query($sql,$conn);  
//设置字符集  
$sql='set names utf8';  
mysql_query($sql,$conn);    
?>
