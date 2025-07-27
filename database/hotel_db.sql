-- MySQL dump 10.13  Distrib 8.0.40, for Win64 (x86_64)
--
-- Host: localhost    Database: hms
-- ------------------------------------------------------
-- Server version	8.0.40

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8mb4 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bookings`
--

DROP TABLE IF EXISTS `bookings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bookings` (
  `bookingid` int NOT NULL AUTO_INCREMENT,
  `guestid` int DEFAULT NULL,
  `roomid` int DEFAULT NULL,
  `total_bill` decimal(10,2) DEFAULT NULL,
  `room_price` decimal(10,2) DEFAULT NULL,
  `taxes` decimal(10,2) DEFAULT NULL,
  `beverages` decimal(10,2) DEFAULT NULL,
  `check_in` timestamp NULL DEFAULT NULL,
  `check_out` timestamp NULL DEFAULT NULL,
  `booked_days` int DEFAULT NULL,
  `booked_by` int DEFAULT NULL,
  PRIMARY KEY (`bookingid`),
  KEY `guestid` (`guestid`),
  KEY `roomid` (`roomid`),
  KEY `booked_by` (`booked_by`),
  CONSTRAINT `bookings_ibfk_1` FOREIGN KEY (`guestid`) REFERENCES `guests` (`guestid`),
  CONSTRAINT `bookings_ibfk_2` FOREIGN KEY (`roomid`) REFERENCES `rooms` (`roomid`),
  CONSTRAINT `bookings_ibfk_3` FOREIGN KEY (`booked_by`) REFERENCES `userdetails` (`userid`),
  CONSTRAINT `chk_beverages` CHECK ((`beverages` > 0)),
  CONSTRAINT `chk_room_price` CHECK ((`room_price` > 0)),
  CONSTRAINT `chk_taxes` CHECK ((`taxes` > 0)),
  CONSTRAINT `chk_total_bill` CHECK ((`total_bill` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bookings`
--

LOCK TABLES `bookings` WRITE;
/*!40000 ALTER TABLE `bookings` DISABLE KEYS */;
INSERT INTO `bookings` VALUES (2,2,3,7210.00,3000.00,540.00,670.00,'2024-12-08 05:40:38','2024-12-08 05:40:57',2,1),(3,2,5,12760.00,4000.00,360.00,400.00,'2024-12-08 08:11:39','2024-12-10 06:00:02',3,1),(5,NULL,NULL,12880.00,4000.00,480.00,400.00,'2024-12-08 11:54:00',NULL,3,1),(6,NULL,NULL,12640.00,4000.00,240.00,400.00,'2024-12-08 11:54:32',NULL,3,1),(7,NULL,NULL,12640.00,4000.00,240.00,400.00,'2024-12-08 11:55:34',NULL,3,1),(9,4,11,22620.00,6000.00,1620.00,3000.00,'2024-12-08 12:55:16','2024-12-08 12:55:47',3,6),(10,3,3,18871.20,3102.00,1861.20,1500.00,'2024-12-16 15:01:58',NULL,5,1),(12,4,3,15700.00,5000.00,500.00,200.00,'2024-12-25 13:34:27','2024-12-26 05:35:55',3,1),(13,10,15,11800.00,2000.00,1800.00,NULL,'2024-12-26 05:35:44','2024-12-26 10:14:13',5,8),(14,12,6,4720.00,2000.00,720.00,NULL,'2024-12-26 05:37:57',NULL,2,8),(15,12,10,5546.00,4700.00,846.00,NULL,'2024-12-26 05:38:48',NULL,1,8),(17,1,5,14580.00,4000.00,1080.00,1500.00,'2024-12-26 10:10:16',NULL,3,1),(18,4,3,10450.00,3000.00,450.00,1000.00,'2025-07-27 15:37:21','2025-07-27 15:37:27',3,1);
/*!40000 ALTER TABLE `bookings` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `calculateTotal_Bill_insert` BEFORE INSERT ON `bookings` FOR EACH ROW BEGIN
    SET NEW.total_bill = COALESCE(NEW.room_price, 0) * COALESCE(NEW.booked_days, 0)
                       + COALESCE(NEW.taxes, 0) 
                       + COALESCE(NEW.beverages, 0);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `calculateTotal_Bill_Update` BEFORE UPDATE ON `bookings` FOR EACH ROW BEGIN
    SET NEW.total_bill = COALESCE(NEW.room_price, 0) * COALESCE(NEW.booked_days, 0)
                       + COALESCE(NEW.taxes, 0) 
                       + COALESCE(NEW.beverages, 0);
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `emp`
--

DROP TABLE IF EXISTS `emp`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emp` (
  `Name` varchar(255) DEFAULT NULL,
  `Occupation` varchar(255) DEFAULT NULL,
  `Working_Date` date DEFAULT NULL,
  `Working_hours` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emp`
--

LOCK TABLES `emp` WRITE;
/*!40000 ALTER TABLE `emp` DISABLE KEYS */;
INSERT INTO `emp` VALUES ('Harsh','Scientist','2020-10-21',12.00),('Raj','Software Eng','2020-08-11',10.00),('Ravi','Actor','2020-10-22',10.00);
/*!40000 ALTER TABLE `emp` ENABLE KEYS */;
UNLOCK TABLES;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `validateNegativeHours` BEFORE INSERT ON `emp` FOR EACH ROW begin 
    if NEW.Working_hours < 0 then 
    set NEW.Working_hours = 0;
    end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `ValidateWorkingDate` BEFORE INSERT ON `emp` FOR EACH ROW Begin
    if new.Working_Date > date_format(now(), '%Y-%m-%d') then 
        signal sqlstate '45000'
        set message_text = "working Date cannot be greater then the entered date!";
    end if;
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `trgInsertIntoEmpAudit` AFTER INSERT ON `emp` FOR EACH ROW BEGIN
    INSERT INTO emp_audit
    VALUES (NEW.name, CONCAT('A row has been inserted in emp table at ', DATE_FORMAT(NOW(), '%d-%m-%Y'), ' at ', DATE_FORMAT(NOW(), '%h:%i:%s %p')));
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `TotalWorkingHrsInsert` AFTER INSERT ON `emp` FOR EACH ROW begin
    update Total_working_hours set total_hrs = (Select ifnull(sum(Working_hours),0) from emp);
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `empUpdateData` AFTER UPDATE ON `emp` FOR EACH ROW begin
    insert into EmpChanges values (new.Name, new.Occupation, old.Occupation, date_format(now(), '%Y-%m-%d'));
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `TotalWorkingHrsUpdate` AFTER UPDATE ON `emp` FOR EACH ROW begin
    update Total_working_hours set total_hrs = (Select ifnull(sum(Working_hours),0) from emp);
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `empArcheives` BEFORE DELETE ON `emp` FOR EACH ROW begin
   insert into  Emp_archeives values (old.Name, old.Occupation, old.Working_Date, old.Working_hours, date_format(now(),'%Y-%m-%d'));
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `TotalWorkingHrsDelete` AFTER DELETE ON `emp` FOR EACH ROW begin
    update Total_working_hours set total_hrs = (Select ifnull(sum(Working_hours),0) from emp);
end */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `emp_archeives`
--

DROP TABLE IF EXISTS `emp_archeives`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emp_archeives` (
  `Name` varchar(256) DEFAULT NULL,
  `Occupation` varchar(256) DEFAULT NULL,
  `Working_date` date DEFAULT NULL,
  `WorkingHours` decimal(10,2) DEFAULT NULL,
  `Deletedate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emp_archeives`
--

LOCK TABLES `emp_archeives` WRITE;
/*!40000 ALTER TABLE `emp_archeives` DISABLE KEYS */;
INSERT INTO `emp_archeives` VALUES ('Rahul','Doctor','2020-10-04',11.00,'2024-12-12'),('Tejas','Software eng','2024-10-06',9.00,'2024-12-12'),('Tejas','Software eng','2024-10-06',9.00,'2024-12-12');
/*!40000 ALTER TABLE `emp_archeives` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `emp_audit`
--

DROP TABLE IF EXISTS `emp_audit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `emp_audit` (
  `name` varchar(18) DEFAULT NULL,
  `audit_description` varchar(100) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `emp_audit`
--

LOCK TABLES `emp_audit` WRITE;
/*!40000 ALTER TABLE `emp_audit` DISABLE KEYS */;
INSERT INTO `emp_audit` VALUES ('Tejas','A row has been inserted in emp table at 12-12-2024 at 10:56:31 AM'),('Tejas','A row has been inserted in emp table at 12-12-2024 at 10:58:28 AM');
/*!40000 ALTER TABLE `emp_audit` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `empchanges`
--

DROP TABLE IF EXISTS `empchanges`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `empchanges` (
  `Name` varchar(256) DEFAULT NULL,
  `New_Occupation` varchar(256) DEFAULT NULL,
  `Old_Occupation` varchar(256) DEFAULT NULL,
  `Updatedate` date DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `empchanges`
--

LOCK TABLES `empchanges` WRITE;
/*!40000 ALTER TABLE `empchanges` DISABLE KEYS */;
INSERT INTO `empchanges` VALUES ('Raj','Software Eng','Engineer','2024-12-12');
/*!40000 ALTER TABLE `empchanges` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guests`
--

DROP TABLE IF EXISTS `guests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guests` (
  `guestid` int NOT NULL AUTO_INCREMENT,
  `lname` varchar(256) DEFAULT NULL,
  `fname` varchar(256) DEFAULT NULL,
  `address1` varchar(256) DEFAULT NULL,
  `address2` varchar(256) DEFAULT NULL,
  `city` varchar(256) DEFAULT NULL,
  `state` varchar(256) DEFAULT NULL,
  `country` varchar(256) DEFAULT NULL,
  `pincode` int DEFAULT NULL,
  `UID_type` varchar(256) DEFAULT NULL,
  `UID_NO` varchar(256) DEFAULT NULL,
  `phone` varchar(256) DEFAULT NULL,
  `created_on` timestamp NULL DEFAULT NULL,
  `update_on` timestamp NULL DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`guestid`),
  KEY `created_by` (`created_by`),
  KEY `updated_by` (`updated_by`),
  CONSTRAINT `guests_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `userdetails` (`userid`),
  CONSTRAINT `guests_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `userdetails` (`userid`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guests`
--

LOCK TABLES `guests` WRITE;
/*!40000 ALTER TABLE `guests` DISABLE KEYS */;
INSERT INTO `guests` VALUES (1,'Thomas','John','asdfasdf','asdfasdf','Mumbai(updated for test )','thane(updated for test )','kalyan(updated for test )',2323,'PAN(updated for test )','23232323','8369867623','2024-12-04 11:30:33','2024-12-25 13:47:24',1,1),(2,'Desai','Tejas','Jay vijay','goregaon','mumbai(updated for test )','maharashtra(updated for test )','India(updated for test )',400104,'Pan(updated for test )','2323423423','9987199583','2024-12-08 05:40:19','2024-12-25 13:47:48',1,1),(3,'sharma','rohit','Borivali west','mumbai suburban','mumbai','maharashtra','India',341212,'PAN','32112312313','7575757575','2024-12-08 12:46:32',NULL,5,NULL),(4,'ABD','CDE','Mumbai','Mumbai','Mumbai','maharashtra','India',341212,'PAN','1412312323','9988776644','2024-12-08 12:54:20','2024-12-08 12:54:31',6,6),(10,'Williams','John','Vikas Sadan,New Delhi','India','New Delhi','NCT','India',55352,'Aadhar card','8348364365374','8467346434','2024-12-26 05:33:25',NULL,8,NULL),(11,'virat','kohli','andheri',NULL,'mumbai','mah','india',40000,'Aadhar card','462457246263','8674634532','2024-12-26 05:34:47',NULL,8,NULL),(12,'Dhangar','Panchangni','andheri','India','mumbai','mah','India',35624,'Pan','627524625446298','9978686753','2024-12-26 05:37:11',NULL,8,NULL),(13,'ASDF','FDA','ASDF','SADFASDF','ASDF121','ASDF','ASDF',400122,'Pan','123123123','1238191211','2024-12-26 05:46:46','2024-12-26 05:47:51',1,1);
/*!40000 ALTER TABLE `guests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rooms`
--

DROP TABLE IF EXISTS `rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rooms` (
  `roomid` int NOT NULL AUTO_INCREMENT,
  `room_no` int DEFAULT NULL,
  `status` varchar(256) DEFAULT NULL,
  `room_type` varchar(256) DEFAULT NULL,
  `price_per_day` decimal(10,3) DEFAULT NULL,
  `room_dscrpt` varchar(256) DEFAULT NULL,
  `created_on` timestamp NULL DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  `type_id` int DEFAULT NULL,
  PRIMARY KEY (`roomid`),
  KEY `created_by` (`created_by`),
  KEY `updated_by` (`updated_by`),
  KEY `type_id` (`type_id`),
  CONSTRAINT `rooms_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `userdetails` (`userid`),
  CONSTRAINT `rooms_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `userdetails` (`userid`),
  CONSTRAINT `rooms_ibfk_3` FOREIGN KEY (`type_id`) REFERENCES `roomstypesdetails` (`type_id`),
  CONSTRAINT `chk_price` CHECK ((`price_per_day` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rooms`
--

LOCK TABLES `rooms` WRITE;
/*!40000 ALTER TABLE `rooms` DISABLE KEYS */;
INSERT INTO `rooms` VALUES (1,101,'Unoccupied','Normal',1240.000,'ASDFASDFASDF','2024-12-03 14:32:51','2024-12-18 00:40:56',1,1,1),(3,102,'Unoccupied','Triple Room',3000.000,'3 bed , bath tubh, shower, wifi.','2024-12-03 17:52:00',NULL,1,NULL,3),(5,103,'Occupied','Quad Room',4000.000,'4 Bed, Wifi ,Balcony (updated value for test)','2024-12-03 18:01:44','2024-12-25 13:41:18',1,1,4),(6,105,'Occupied','Double Room',2000.000,'asdfasdf22212121','2024-12-03 18:24:25','2024-12-03 18:32:13',1,1,2),(9,201,'Unoccupied','Triple Room',3000.000,'Wifi, 3-bed , balcony','2024-12-08 12:36:18','2024-12-08 12:36:28',4,4,3),(10,202,'Occupied','Five Capacity room',4700.000,'Wifi , 5 -bed capacity, attached washroom to each bedroom','2024-12-08 12:44:48','2024-12-08 12:45:21',5,5,7),(11,302,'Unoccupied','six bed capacity',6000.000,'6 bedroom with attached washrooms to each, wifi','2024-12-08 12:53:22',NULL,6,NULL,8),(15,308,'Unoccupied','small',2000.000,'iuhiodjpijir','2024-12-26 05:29:40','2024-12-26 05:30:39',1,1,10),(16,500,'Unoccupied','small room',4000.000,'small room','2024-12-26 06:05:15','2024-12-26 06:06:06',1,1,11),(17,506,'Unoccupied','Normal',1200.000,'asdfasdfasdf','2024-12-26 10:01:25',NULL,7,NULL,1),(18,210,'Unoccupied','Double Room',2000.000,'asdfasdf','2025-04-07 12:40:58',NULL,1,NULL,2);
/*!40000 ALTER TABLE `rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roomstypesdetails`
--

DROP TABLE IF EXISTS `roomstypesdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `roomstypesdetails` (
  `type_id` int NOT NULL AUTO_INCREMENT,
  `type` varchar(256) DEFAULT NULL,
  `type_price` decimal(10,2) DEFAULT NULL,
  `created_on` timestamp NULL DEFAULT NULL,
  `updated_on` timestamp NULL DEFAULT NULL,
  `created_by` int DEFAULT NULL,
  `updated_by` int DEFAULT NULL,
  PRIMARY KEY (`type_id`),
  KEY `created_by` (`created_by`),
  KEY `updated_by` (`updated_by`),
  CONSTRAINT `roomstypesdetails_ibfk_1` FOREIGN KEY (`created_by`) REFERENCES `userdetails` (`userid`),
  CONSTRAINT `roomstypesdetails_ibfk_2` FOREIGN KEY (`updated_by`) REFERENCES `userdetails` (`userid`),
  CONSTRAINT `chk_type_price` CHECK ((`type_price` > 0))
) ENGINE=InnoDB AUTO_INCREMENT=12 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roomstypesdetails`
--

LOCK TABLES `roomstypesdetails` WRITE;
/*!40000 ALTER TABLE `roomstypesdetails` DISABLE KEYS */;
INSERT INTO `roomstypesdetails` VALUES (1,'Normal',1200.00,'2024-11-24 04:06:45',NULL,1,NULL),(2,'Double Room',2000.00,'2024-12-03 14:57:35',NULL,1,NULL),(3,'Triple Room',3000.00,'2024-12-03 14:58:18',NULL,1,NULL),(4,'Quad Room',4000.00,'2024-12-03 15:01:00',NULL,1,NULL),(7,'Five Capacity room',4700.00,'2024-12-08 12:44:09',NULL,5,NULL),(8,'six bed capacity',6000.00,'2024-12-08 12:52:42',NULL,6,NULL),(10,'small',2000.00,'2024-12-26 05:24:39',NULL,1,NULL),(11,'small room',4000.00,'2024-12-26 06:04:04',NULL,1,NULL);
/*!40000 ALTER TABLE `roomstypesdetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `total_working_hours`
--

DROP TABLE IF EXISTS `total_working_hours`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `total_working_hours` (
  `total_hrs` decimal(10,2) DEFAULT NULL
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `total_working_hours`
--

LOCK TABLES `total_working_hours` WRITE;
/*!40000 ALTER TABLE `total_working_hours` DISABLE KEYS */;
INSERT INTO `total_working_hours` VALUES (32.00);
/*!40000 ALTER TABLE `total_working_hours` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `userdetails`
--

DROP TABLE IF EXISTS `userdetails`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `userdetails` (
  `userid` int NOT NULL AUTO_INCREMENT,
  `UserName` varchar(256) DEFAULT NULL,
  `fName` varchar(256) DEFAULT NULL,
  `lName` varchar(256) DEFAULT NULL,
  `Email` varchar(256) DEFAULT NULL,
  `Password` varchar(256) DEFAULT NULL,
  `UserType` varchar(256) DEFAULT NULL,
  `CreatedOn` timestamp NULL DEFAULT NULL,
  `UpdatedOn` timestamp NULL DEFAULT NULL,
  `EmployeeNo` varchar(256) DEFAULT NULL,
  `phone` varchar(256) DEFAULT NULL,
  PRIMARY KEY (`userid`),
  UNIQUE KEY `EmployeeNo` (`EmployeeNo`),
  UNIQUE KEY `UserName` (`UserName`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `userdetails`
--

LOCK TABLES `userdetails` WRITE;
/*!40000 ALTER TABLE `userdetails` DISABLE KEYS */;
INSERT INTO `userdetails` VALUES (1,'Tejas007','Tejas','Desai','tejasdesai056@gmail.com','Tejas007','Admin','2024-11-15 07:10:06',NULL,'2024510013','8369867623'),(4,'Tejas008','Tejas','Desai','tejas@gmail.com','Tejas008','Admin','2024-12-08 12:35:29',NULL,'2024510088','1212121212'),(5,'Tejas021','Tejas','Desai','tejas@gmail.com','Tejas021','Admin','2024-12-08 12:43:44',NULL,'2024510089','1212121212'),(6,'Tejas043','Tejas','Desai','tejas@gmail.com','Tejas043','Admin','2024-12-08 12:52:12',NULL,'2024510090','1212121212'),(7,'Bhagyashree007','Bhagyashree','asdf','Bhagyashree@gmail.com','Bhagyashree007','Admin','2024-12-17 10:10:17',NULL,'2024510015','2389284932'),(8,'Panchangni23','Panchangni','Dhangar','panchangnidhangar@gmail.com','Panchangni23','Admin','2024-12-26 05:28:50',NULL,'2','8656435664'),(10,'John987','John','Thomas','JohnThomas234@gmail.com','John@987','Manager','2025-03-20 14:45:09',NULL,'2024510100','9987199583');
/*!40000 ALTER TABLE `userdetails` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL,
  `password` varchar(255) NOT NULL,
  `createdAt` datetime NOT NULL,
  `updatedAt` datetime NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `email` (`email`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
/*!40000 ALTER TABLE `users` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-07-27 21:25:07
