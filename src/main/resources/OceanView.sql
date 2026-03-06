-- MySQL dump 10.13  Distrib 8.0.44, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: oceanview_resort
-- ------------------------------------------------------
-- Server version	8.0.44

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!50503 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Table structure for table `bill_items`
--

DROP TABLE IF EXISTS `bill_items`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bill_items` (
  `bill_item_id` int NOT NULL AUTO_INCREMENT,
  `bill_id` int NOT NULL,
  `item_name` varchar(80) NOT NULL,
  `qty` int NOT NULL,
  `unit_price` double NOT NULL,
  `total` double NOT NULL,
  PRIMARY KEY (`bill_item_id`),
  KEY `fk_bill_item_bill` (`bill_id`),
  CONSTRAINT `fk_bill_item_bill` FOREIGN KEY (`bill_id`) REFERENCES `bills` (`bill_id`)
) ENGINE=InnoDB AUTO_INCREMENT=39 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bill_items`
--

LOCK TABLES `bill_items` WRITE;
/*!40000 ALTER TABLE `bill_items` DISABLE KEYS */;
INSERT INTO `bill_items` VALUES (24,11,'Room Stay (after discount)',1,39600,39600),(25,11,'POOL',1,2000,2000),(26,12,'Room Stay (after discount)',1,39600,39600),(27,12,'POOL',1,2000,2000),(28,13,'Room Stay (after discount)',1,19800,19800),(29,13,'POOL',1,2000,2000),(30,13,'DINING',1,5000,5000),(31,14,'Room Stay (after discount)',1,19800,19800),(32,14,'DINING',1,5000,5000),(33,15,'Room Stay (after discount)',1,13500,13500),(34,15,'POOL',1,2000,2000),(35,16,'Room Stay (after discount)',1,22000,22000),(36,17,'Room Stay (after discount)',1,12600,12600),(37,17,'POOL',1,2000,2000),(38,18,'Room Stay (after discount)',1,19800,19800);
/*!40000 ALTER TABLE `bill_items` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `bills`
--

DROP TABLE IF EXISTS `bills`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `bills` (
  `bill_id` int NOT NULL AUTO_INCREMENT,
  `reservation_no` int NOT NULL,
  `nights` int NOT NULL,
  `rate` double NOT NULL,
  `discount` double NOT NULL,
  `total` double NOT NULL,
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`bill_id`),
  KEY `fk_bill_res` (`reservation_no`),
  CONSTRAINT `fk_bill_res` FOREIGN KEY (`reservation_no`) REFERENCES `reservations` (`reservation_no`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `bills`
--

LOCK TABLES `bills` WRITE;
/*!40000 ALTER TABLE `bills` DISABLE KEYS */;
INSERT INTO `bills` VALUES (11,7,2,22000,4400,41600,'2026-02-18 14:41:56'),(12,7,2,22000,4400,41600,'2026-03-01 10:17:15'),(13,6,1,22000,2200,26800,'2026-03-01 10:21:15'),(14,12,1,22000,2200,24800,'2026-03-03 16:02:57'),(15,15,1,13500,0,15500,'2026-03-03 16:47:33'),(16,17,1,22000,0,22000,'2026-03-04 09:06:40'),(17,16,1,14000,1400,14600,'2026-03-05 07:20:18'),(18,12,1,22000,2200,19800,'2026-03-05 07:23:18');
/*!40000 ALTER TABLE `bills` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `guests`
--

DROP TABLE IF EXISTS `guests`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `guests` (
  `guest_id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(100) NOT NULL,
  `address` varchar(200) NOT NULL,
  `contact_number` varchar(20) NOT NULL,
  PRIMARY KEY (`guest_id`),
  UNIQUE KEY `contact_number` (`contact_number`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `guests`
--

LOCK TABLES `guests` WRITE;
/*!40000 ALTER TABLE `guests` DISABLE KEYS */;
INSERT INTO `guests` VALUES (1,'API Test Guest','Galle','0777777777'),(2,'Pramoth Piumal','71/3/H elapaha road','0740440000'),(3,'Thisuri Ekanayake','23/1 Temple road, Homagama','0740440553'),(4,'Gojo satoru','23/2/1 mahawatta, kottawa','0786139665'),(5,'Shamal Sathsara','23/2/1 mahawatta, kottawa','0781589365'),(6,'Binara Mindada','12/2 Mawittara, Piliyandala','0786139552'),(7,'Binara Mindada','12/2 Mawittara, Piliyandala','0775455231');
/*!40000 ALTER TABLE `guests` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reservations`
--

DROP TABLE IF EXISTS `reservations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reservations` (
  `reservation_no` int NOT NULL AUTO_INCREMENT,
  `guest_id` int NOT NULL,
  `room_type` varchar(30) NOT NULL,
  `check_in` date NOT NULL,
  `check_out` date NOT NULL,
  `status` varchar(20) NOT NULL DEFAULT 'ACTIVE',
  `room_id` int DEFAULT NULL,
  PRIMARY KEY (`reservation_no`),
  KEY `fk_res_roomtype` (`room_type`),
  KEY `idx_res_guest_id` (`guest_id`),
  KEY `idx_res_status` (`status`),
  KEY `fk_res_room` (`room_id`),
  CONSTRAINT `fk_res_guest` FOREIGN KEY (`guest_id`) REFERENCES `guests` (`guest_id`),
  CONSTRAINT `fk_res_room` FOREIGN KEY (`room_id`) REFERENCES `rooms` (`room_id`),
  CONSTRAINT `fk_res_roomtype` FOREIGN KEY (`room_type`) REFERENCES `room_rates` (`room_type`)
) ENGINE=InnoDB AUTO_INCREMENT=26 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reservations`
--

LOCK TABLES `reservations` WRITE;
/*!40000 ALTER TABLE `reservations` DISABLE KEYS */;
INSERT INTO `reservations` VALUES (6,2,'DELUXE','2026-02-19','2026-02-20','COMPLETED',3),(7,3,'DELUXE','2026-02-21','2026-02-23','COMPLETED',3),(12,4,'DELUXE','2026-03-05','2026-03-06','COMPLETED',3),(15,4,'SUITE','2026-03-06','2026-03-07','COMPLETED',4),(16,2,'SUITE','2026-03-05','2026-03-06','COMPLETED',4),(17,5,'DELUXE','2026-03-08','2026-03-09','COMPLETED',3),(20,3,'SUITE','2026-03-07','2026-03-08','CANCELLED',4),(21,2,'SUITE','2026-03-07','2026-03-08','ACTIVE',4),(25,4,'STANDARD','2026-03-07','2026-03-08','ACTIVE',2);
/*!40000 ALTER TABLE `reservations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_rates`
--

DROP TABLE IF EXISTS `room_rates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room_rates` (
  `room_type` varchar(30) NOT NULL,
  `price_per_night` double NOT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`room_type`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_rates`
--

LOCK TABLES `room_rates` WRITE;
/*!40000 ALTER TABLE `room_rates` DISABLE KEYS */;
INSERT INTO `room_rates` VALUES ('DELUXE',22000,'images/deluxe.jpg'),('STANDARD',15000,'images/standard.jpg'),('SUITE',35000,'images/suite.jpg');
/*!40000 ALTER TABLE `room_rates` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_rates2`
--

DROP TABLE IF EXISTS `room_rates2`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room_rates2` (
  `rate_id` int NOT NULL AUTO_INCREMENT,
  `room_type_id` int NOT NULL,
  `price_per_night` double NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  `created_at` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`rate_id`),
  KEY `fk_rate_type` (`room_type_id`),
  CONSTRAINT `fk_rate_type` FOREIGN KEY (`room_type_id`) REFERENCES `room_types` (`room_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_rates2`
--

LOCK TABLES `room_rates2` WRITE;
/*!40000 ALTER TABLE `room_rates2` DISABLE KEYS */;
INSERT INTO `room_rates2` VALUES (1,1,15000,1,'2026-02-06 07:42:20'),(2,2,22000,1,'2026-02-06 07:42:20'),(3,3,35000,0,'2026-02-06 07:42:20'),(4,3,14000,1,'2026-02-06 09:48:16'),(5,4,40000,1,'2026-02-22 08:37:16'),(6,5,27000,1,'2026-03-05 10:08:44');
/*!40000 ALTER TABLE `room_rates2` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `room_types`
--

DROP TABLE IF EXISTS `room_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `room_types` (
  `room_type_id` int NOT NULL AUTO_INCREMENT,
  `type_code` varchar(30) NOT NULL,
  `type_name` varchar(60) NOT NULL,
  `description` varchar(255) DEFAULT NULL,
  `image_path` varchar(255) DEFAULT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`room_type_id`),
  UNIQUE KEY `type_code` (`type_code`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `room_types`
--

LOCK TABLES `room_types` WRITE;
/*!40000 ALTER TABLE `room_types` DISABLE KEYS */;
INSERT INTO `room_types` VALUES (1,'STANDARD','Standard Room','Garden view standard room','assets/img/standard.jpg',1),(2,'DELUXE','Deluxe Room','Sea view deluxe room','assets/img/deluxe.jpg',1),(3,'SUITE','Suite','Luxury suite room','assets/img/suite.jpg',1),(4,'lux','luxury room','','',1),(5,'Family ','Family Room ','Family room for 6 person','',1),(6,'Sea View Room','Sea View Room','room windows face to beach','',0);
/*!40000 ALTER TABLE `room_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `rooms`
--

DROP TABLE IF EXISTS `rooms`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `rooms` (
  `room_id` int NOT NULL AUTO_INCREMENT,
  `room_no` varchar(10) NOT NULL,
  `room_type_id` int NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`room_id`),
  UNIQUE KEY `room_no` (`room_no`),
  KEY `fk_room_type` (`room_type_id`),
  CONSTRAINT `fk_room_type` FOREIGN KEY (`room_type_id`) REFERENCES `room_types` (`room_type_id`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `rooms`
--

LOCK TABLES `rooms` WRITE;
/*!40000 ALTER TABLE `rooms` DISABLE KEYS */;
INSERT INTO `rooms` VALUES (1,'101',1,0),(2,'102',1,1),(3,'201',2,1),(4,'301',3,1),(5,'401',4,1),(6,'402',4,0),(7,'501',5,0),(8,'601',6,0),(9,'602',6,1);
/*!40000 ALTER TABLE `rooms` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `services`
--

DROP TABLE IF EXISTS `services`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `services` (
  `service_id` int NOT NULL AUTO_INCREMENT,
  `service_code` varchar(30) NOT NULL,
  `service_name` varchar(60) NOT NULL,
  `price` double NOT NULL,
  `is_active` tinyint(1) NOT NULL DEFAULT '1',
  PRIMARY KEY (`service_id`),
  UNIQUE KEY `service_code` (`service_code`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `services`
--

LOCK TABLES `services` WRITE;
/*!40000 ALTER TABLE `services` DISABLE KEYS */;
INSERT INTO `services` VALUES (1,'POOL','Pool Usage',2000,1),(2,'DINING','Dining Package',5000,1),(3,'LAUNDR','Laundry',1800,1),(4,'PLAY AREA','cricket play ground',1400,1);
/*!40000 ALTER TABLE `services` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `users` (
  `user_id` int NOT NULL AUTO_INCREMENT,
  `username` varchar(50) NOT NULL,
  `password` varchar(64) NOT NULL,
  `role` varchar(20) NOT NULL,
  PRIMARY KEY (`user_id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `users`
--

LOCK TABLES `users` WRITE;
/*!40000 ALTER TABLE `users` DISABLE KEYS */;
INSERT INTO `users` VALUES (1,'admin','240be518fabd2724ddb6f04eeb1da5967448d7e831c08c8fa822809f74c720a9','ADMIN'),(4,'eren12','95213f8227413bd99cf75b9de275a29beea008ad562387b068b10b06dd440366','RECEPTIONIST'),(6,'receptionist1','e5a20e4d548812c5f203dbfcab6569b7335f78ca1a7ddad38f2c552d53bb1169','RECEPTIONIST');
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

-- Dump completed on 2026-03-06 14:30:02
