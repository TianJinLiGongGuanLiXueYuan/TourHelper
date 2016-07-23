<?php 
//生成GUID
function create_guid(){
	if (function_exists('com_create_guid')){
		return com_create_guid();
	}else{
		mt_srand((double)microtime()*10000);//optional for php 4.2.0 and up.
		$charid = strtoupper(md5(uniqid(rand(), true)));
		$hyphen = chr(45);// "-"
		$uuid = chr(123)// "{"
		.substr($charid, 0, 8).$hyphen
		.substr($charid, 8, 4).$hyphen
		.substr($charid,12, 4).$hyphen
		.substr($charid,16, 4).$hyphen
		.substr($charid,20,12)
		.chr(125);// "}"
		return $uuid;
	}
}
//https://127.0.0.1/template/upload.php
//$pic_name=$_POST['pic_name'];
// $photourl = create_guid();
//echo $photourl ;
//照片在服务器端的名字

$photourl = create_guid();

$base_path = "./uploadimg/"; // 接收文件目录
$target_path = $base_path.$_FILES['file']['name'].".jpg";

if (move_uploaded_file ( $_FILES ['file'] ['tmp_name'], $target_path )) {
	$array =  array($photourl);

//	echo json_encode ( $array );
	echo json_encode (array('photourl' => $_FILES['file']['name']));
} else {
	$array = array (
			"code" => "0",
			"message" => "There was an error uploading the file, please try again!" . $_FILES ['file'] ['error'] 
	);
	echo json_encode ( $array );
}
?>
