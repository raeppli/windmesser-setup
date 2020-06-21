-- MySQL dump 10.13  Distrib 5.5.46, for debian-linux-gnu (armv7l)
--
-- Host: localhost    Database: aeppli_winduster
-- ------------------------------------------------------
-- Server version	5.5.46-0+deb7u1

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Temporary table structure for view `WindStatBase`
--

DROP TABLE IF EXISTS `WindStatBase`;
/*!50001 DROP VIEW IF EXISTS `WindStatBase`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `WindStatBase` (
  `dt` tinyint NOT NULL,
  `Hr` tinyint NOT NULL,
  `Dir` tinyint NOT NULL,
  `cnt` tinyint NOT NULL,
  `topWind` tinyint NOT NULL,
  `topAvgWind` tinyint NOT NULL,
  `avgTopWind` tinyint NOT NULL,
  `avgWind` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Table structure for table `sentalarms`
--

DROP TABLE IF EXISTS `sentalarms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sentalarms` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `time` datetime DEFAULT NULL,
  `address` varchar(45) NOT NULL,
  `windalert_id` int(11) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_sentalarms_windalert1` (`windalert_id`),
  CONSTRAINT `fk_sentalarms_windalert10` FOREIGN KEY (`windalert_id`) REFERENCES `windalert` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=79395 DEFAULT CHARSET=latin1 COMMENT='Used to store alarms sent and receiver';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sentalarms`
--


--
-- Table structure for table `transferlog`
--

DROP TABLE IF EXISTS `transferlog`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `transferlog` (
  `lastTransferred` date DEFAULT NULL,
  `cntSent` int(11) DEFAULT NULL,
  `cntInserted` int(11) DEFAULT NULL,
  `loggedAt` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `transferlog`
--

--
-- Table structure for table `userdata`
--

DROP TABLE IF EXISTS `userdata`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `userdata` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(20) COLLATE latin1_general_ci DEFAULT NULL,
  `userpass` varchar(100) COLLATE latin1_general_ci DEFAULT NULL,
  `emailaddress` varchar(90) COLLATE latin1_general_ci DEFAULT NULL,
  `joineddate` datetime DEFAULT NULL,
  `lastlogin` datetime DEFAULT NULL,
  `ip` varchar(16) COLLATE latin1_general_ci DEFAULT NULL,
  `firstname` varchar(30) COLLATE latin1_general_ci DEFAULT NULL,
  `name` varchar(70) COLLATE latin1_general_ci DEFAULT NULL,
  `address` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `suburb` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `state` varchar(50) COLLATE latin1_general_ci DEFAULT NULL,
  `postcode` varchar(6) COLLATE latin1_general_ci DEFAULT NULL,
  `phone1` varchar(11) COLLATE latin1_general_ci DEFAULT NULL,
  `phone2` varchar(11) COLLATE latin1_general_ci DEFAULT NULL,
  `transferred` char(1) COLLATE latin1_general_ci NOT NULL DEFAULT 'N',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=115 DEFAULT CHARSET=latin1 COLLATE=latin1_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userdata`
--


--
-- Table structure for table `windalert`
--

DROP TABLE IF EXISTS `windalert`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `windalert` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `state` char(1) NOT NULL,
  `minTop` int(11) NOT NULL,
  `minAvg` int(11) NOT NULL,
  `minTemp` int(11) DEFAULT NULL,
  `fromHrOfDay` int(11) NOT NULL,
  `toHrOfDay` int(11) NOT NULL,
  `delay` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `address` varchar(45) DEFAULT NULL,
  `lastSent` datetime DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_windalert_userdata1` (`user_id`),
  CONSTRAINT `fk_windalert_userdata10` FOREIGN KEY (`user_id`) REFERENCES `userdata` (`id`) ON DELETE NO ACTION ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=108 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `windalert`
--

--
-- Table structure for table `winddata_detail`
--

DROP TABLE IF EXISTS `winddata_detail`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `winddata_detail` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `topWind` int(10) unsigned NOT NULL,
  `avgWind` int(10) unsigned NOT NULL,
  `dirWind` varchar(45) NOT NULL,
  `temp` int(11) DEFAULT NULL,
  `timestamp` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `timestamp_UNIQUE` (`timestamp`)
) ENGINE=InnoDB AUTO_INCREMENT=1608261 DEFAULT CHARSET=latin1 COMMENT='All measurements in full details';
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `winddata_detail`
--

--
-- Temporary table structure for view `windstatbase`
--

DROP TABLE IF EXISTS `windstatbase`;
/*!50001 DROP VIEW IF EXISTS `windstatbase`*/;
SET @saved_cs_client     = @@character_set_client;
SET character_set_client = utf8;
/*!50001 CREATE TABLE `windstatbase` (
  `dt` tinyint NOT NULL,
  `Hr` tinyint NOT NULL,
  `Dir` tinyint NOT NULL,
  `cnt` tinyint NOT NULL,
  `topWind` tinyint NOT NULL,
  `topAvgWind` tinyint NOT NULL,
  `avgTopWind` tinyint NOT NULL,
  `avgWind` tinyint NOT NULL
) ENGINE=MyISAM */;
SET character_set_client = @saved_cs_client;

--
-- Final view structure for view `WindStatBase`
--

/*!50001 DROP TABLE IF EXISTS `WindStatBase`*/;
/*!50001 DROP VIEW IF EXISTS `WindStatBase`*/;
/*!50001 SET @saved_cs_client          = @@character_set_client */;
/*!50001 SET @saved_cs_results         = @@character_set_results */;
/*!50001 SET @saved_col_connection     = @@collation_connection */;
/*!50001 SET character_set_client      = utf8 */;
/*!50001 SET character_set_results     = utf8 */;
/*!50001 SET collation_connection      = utf8_general_ci */;
/*!50001 CREATE ALGORITHM=UNDEFINED */
/*!50001 VIEW `WindStatBase` AS select cast(`winddata_detail`.`timestamp` as date) AS `dt`,hour(`winddata_detail`.`timestamp`) AS `Hr`,floor((((`winddata_detail`.`dirWind` + 2) % 36) / 4.5)) AS `Dir`,count(floor((((`winddata_detail`.`dirWind` + 2) % 36) / 4.5))) AS `cnt`,max(`winddata_detail`.`topWind`) AS `topWind`,max(`winddata_detail`.`avgWind`) AS `topAvgWind`,avg(`winddata_detail`.`topWind`) AS `avgTopWind`,avg(`winddata_detail`.`avgWind`) AS `avgWind` from `winddata_detail` group by cast(`winddata_detail`.`timestamp` as date),hour(`winddata_detail`.`timestamp`),floor((((`winddata_detail`.`dirWind` + 2) % 36) / 4.5)) */;
/*!50001 SET character_set_client      = @saved_cs_client */;
/*!50001 SET character_set_results     = @saved_cs_results */;
/*!50001 SET collation_connection      = @saved_col_connection */;


/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2020-06-16 22:48:31
