
# [hideeeeee](http://133.0.215.144/)

```php
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Document</title>
</head>
<body>

<div>
    <form action="" method="post" enctype="multipart/form-data">
        <input type="file" name="upfile" />
        <input type="submit" name="uploaddd">
    </form>
</div>


<?php
highlight_file(__FILE__);

echo file_exists($_GET["file"]);

$tmp_upload_folder = "./uploads";

if(($_FILES["upfile"]["type"] == "image/gif") && (substr($_FILES["upfile"]["name"],strrpos($_FILES["upfile"]["name"],".") + 1)) == "gif"){
    echo $_FILES["upfile"]["name"] . "<br />";
    echo $_FILES["upfile"]["type"] . "<br />";
    echo $_FILES["upfile"]["tmp_name"] . "<br />";
    if(file_exists($tmp_upload_folder . $_FILES["upfile"]["name"])){
        echo $_FILES["upfile"]["name"] . "already exists";
    }else{
        move_uploaded_file($_FILES["upfile"]["tmp_name"], $tmp_upload_folder . "/" . $_FILES["upfile"]["name"]);
        echo "Store in " . $tmp_upload_folder . "/" . $_FILES["upfile"]["name"];
    }
}else{
    echo "invalid file,only gif";
}


class felove {
    public $name;
    public $noclass;

    public function __construct(){
        $this->name = "ksksks";
        $this->noclass = "123";
    }
    public function __destruct(){
        echo file_get_contents("/flag");
    }
}

?>


</body>
</html> invalid file,only gif
```