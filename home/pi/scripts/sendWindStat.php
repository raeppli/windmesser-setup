<html>
<?php
include("config.php");
$res=mysql_query("select max(lastTransferred) as lastTransfer from transferlog where cntSent = cntInserted"); // select last succesful transfer date
if(!$res) {
	$msg =  mysql_error($link);
	die("MySql-Error:" . $msg);
}
$row=mysql_fetch_assoc($res);
$lastTransfer = $row['lastTransfer'];
if(!$lastTransfer) $lastTransfer = '1970-01-01';
$query="select * from WindStatBase where dt > '" . $lastTransfer . "' and dt < date(now()) order by dt ASC";
// echo "Query_:" . $query;
$res=mysql_query($query);
$numVals = mysql_num_rows($res);
// echo "NumVals:" . $numVals;
$postString = '';
for($i=0;$i<$numVals;$i++)
{
    $row = mysql_fetch_row($res);
    $postString .= "'" . $row[0] . "',";
    for($j=1;$j<sizeof($row)-1;$j++)
    {
        $postString .= $row[$j] . ',';
    }
    $postString .= $row[$j] . ';';
}
if($numVals > 0) $maxDt = $row[0]; // Datum des letzten eingef?gten Datensatzes
else $maxDt = $lastTransfer; // ansonsten Datum des letzten erfolgreichen inserts (lastTransfer)
$urlPost = array('WindStatBase' => $postString);
//open connection
$ch = curl_init();
$url = $WEBServer . '/transferWindStat.php';
//set the url, number of POST vars, POST data
curl_setopt($ch,CURLOPT_URL, $url);
curl_setopt($ch,CURLOPT_POST, 1);
curl_setopt($ch,CURLOPT_POSTFIELDS, $urlPost);
curl_setopt($ch,CURLOPT_RETURNTRANSFER,TRUE);

//execute post
$result = curl_exec($ch);

//close connection
curl_close($ch);

$pos = strpos($result,"=> ");
if($pos === false) $count = 0;
else $count = intval(substr($result,$pos+3));
echo "Result from remote:<br />" . $result . "<br />";
echo "Number of inserted records acc. to remote:" . $count . "(#Records sent:" . $numVals . ")";
$query="INSERT INTO transferlog VALUES ('" . $maxDt . "'," . $numVals . "," . $count . ",now())";
$res=mysql_query($query);
?>
</html>
