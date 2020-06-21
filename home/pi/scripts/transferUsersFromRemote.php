<?php
include "config.php";
$transferUsers = curl_init($WEBServer . "/outputData.php?pref=Users");
curl_setopt($transferUsers,CURLOPT_RETURNTRANSFER,true);
$res = curl_exec($transferUsers);
echo "Result of webservice for user transfer: " . $res;
if($res)
{
    $users = explode("\n",$res);
    $i = 0;
    while($users[$i] != "")
    {
        $users[$i] = substr($users[$i],0,-1);
	$query = "INSERT INTO userdata VALUES (" . $users[$i] .")";

        if($ins = $mysqli->query($query)) {
		echo "Inserted " . $users[$i] . "\n";
	}
        else {
		$fields=explode(",",$users[$i]);
		$query="UPDATE userdata SET emailaddress = " . $fields[3] . ", userpass=" . $fields[2] . " WHERE id=" . $fields[0];
		if($res=$mysqli->query($query)) {
            		echo "Updated " . $fields[0] . "\n";
		}
		else die($mysqli->error);
        }
        echo "String " . $i . ": " . $users[$i++] . "\n";
    }
}
?>