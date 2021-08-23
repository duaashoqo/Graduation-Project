
<?php

$return["error"] = false;
$return["msg"] =  "";

if(isset($_POST["image"]) && isset($_POST["name"])){
  $base64_string = $_POST["image"];
  $image_name = $_POST["name"];
  $outputfile = "flutter_test/" .$image_name . ".jpg" ;
  //save as image.jpg in uploads/ folder

  $filehandler = fopen($outputfile, 'wb' ); 
  //file open with "w" mode treat as text file
  //file open with "wb" mode treat as binary file
  
  fwrite($filehandler, base64_decode($base64_string));
  // we could add validation here with ensuring count($data)>1

  // clean up the file resource
  fclose($filehandler); 
} else{
  $return["error"] = true;
  $return["msg"] =  "No image is submited.";
}
echo json_encode($return);