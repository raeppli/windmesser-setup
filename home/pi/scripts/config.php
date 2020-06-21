<?php
  //$server = "216.86.146.7";
  //$server = "192.168.1.7";
  //$DBserver = "192.168.1.10";
$DBserver = "127.0.0.1";

  // Connect to the MySQL server
  $mysqli = new mysqli($DBserver, "winduster", "maury01", "aeppli_winduster");
  if ($mysqli->connect_errno) {
      echo "Failed to connect to MySQL: (" . $mysqli->connect_errno . ") " . $mysqli->connect_error;
  }

  $WEBServer = "https://winduster.aeppli.org/";
?>