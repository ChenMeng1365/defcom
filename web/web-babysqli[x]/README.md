
# README

flag格式为flag{}

[LINK](39.104.60.50:18113)

```php
<?php
show_source(__file__);
include "config.php";
$db = new PDO($dsn, $user, $pass);
if (!$db){
    die("database error");
}

$filter = "flag|select|and|where|union|join|sleep|benchmark|,|\(|\)|like|rlike|regexp|limit|or";
$id = $_GET['id'];
if (preg_match("/".$filter."/is",$id)==1){
    die("Hacker ...");
}
// $sql = "SELECT flag FROM flag";
$sql = "SELECT * FROM users WHERE id=".addslashes($id);
$result = $db->query($sql)->fetchAll();
?>
```
