
# README

/index.php?t=1

[LINK](39.104.60.50:18722)

```
<?php


include 'flag.php';
if(isset($_GET['t'])){
    $_COOKIE['bash_token'] = $_GET['t'];
}else{
    die("Token Lost.");
}
if(isset($_GET['code'])){
    $code = $_GET['code'];
    if(strlen($code)>50){
        die("Too Long.");
    }
    if(preg_match("/[A-Za-z0-9_]+/",$code)){
        die("Not Allowed.");
    }
    @eval($code);
}else{
    highlight_file(__FILE__);
}
//$hint =  "php function getFlag() to get flag";
?>
```
