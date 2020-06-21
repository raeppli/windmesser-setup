<?php
include "config.php";
$transferConfigs = curl_init($WEBServer . "/outputData.php?pref=1");
curl_setopt($transferConfigs,CURLOPT_RETURNTRANSFER,true);
$res = curl_exec($transferConfigs);

if($res)
{
    $prefs = explode("\n",$res);
    $i = 0;
    while($prefs[$i] != "")
    {
        $prefs[$i] = substr($prefs[$i],0,-1);
        $fields=explode(",",$prefs[$i]);
        $fields[1] = "'" . $fields[1] . "'"; // state field is alphanumeric
        $prefs[$i] = implode(",",$fields);
	$query = "INSERT INTO windalert VALUES (" . $prefs[$i] .",null,null)";
        
        if($ins = $mysql_query($query)) {
            echo "Inserted " . $prefs[$i] . "\n";
	}
	else {
            $fields=explode(",",$prefs[$i]);
	    $query = "UPDATE windalert
            SET state = " . $fields[1] . ",
                minTop=" . $fields[2] . ",
                minAvg=" . $fields[3] . ",
                minTemp=" . $fields[4]. ",
                fromHrOfDay=" . $fields[5] . ",
                toHrOfDay=" . $fields[6] . ",
                delay=" . $fields[7] . ",
                address=null
            WHERE id=" . $fields[0];
            if($res=$mysqli->query($query))
	    {
		echo "Updated " . $fields[0] . "\n";
	    }
	    else die($mysqli->error);
        }
        echo "String " . $i . ": " . $prefs[$i++] . "\n";
    }
    echo "Result of webservice for user transfer: " . $prefs[$i+1];
}
?>