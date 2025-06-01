-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: 127.0.0.1    Database: eventsdb
-- ------------------------------------------------------
-- Server version	8.0.39

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
-- Table structure for table `events`
--

DROP TABLE IF EXISTS `events`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `events` (
  `ID` int NOT NULL AUTO_INCREMENT,
  `EVENT_ID` varchar(50) NOT NULL,
  `USER_NAME` varchar(100) NOT NULL,
  `USER_ID` varchar(50) NOT NULL,
  `TITLE` varchar(200) DEFAULT NULL,
  `DESCRIPTION` text,
  `DATETIME` datetime DEFAULT NULL,
  `TAG` varchar(100) DEFAULT NULL,
  `CREATED_AT` timestamp NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
  PRIMARY KEY (`ID`)
) ENGINE=InnoDB AUTO_INCREMENT=15 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `events`
--

LOCK TABLES `events` WRITE;
/*!40000 ALTER TABLE `events` DISABLE KEYS */;
INSERT INTO `events` VALUES (1,'EVNT01','Events.User@12d404b0','USER-20250531-BIL0HF06','OpenAI is reportedly working on a search feature for ChatGPT','OpenAI is reportedly working on a search feature for ChatGPT','2025-07-04 21:53:00','hackathon','2025-06-01 09:26:41'),(2,'EVNT02','Events.User@2dacbba1','USER-20250531-BIL0HF06','Google Gemini ','Google Gemini','2025-06-01 14:00:00','hackathon','2025-06-01 09:26:41'),(7,'EVNT07','Hope','USER-20250531-BIL0HF06','Google Gemini ','Google Gemini trainings','2025-06-08 23:07:00','Trainings','2025-06-01 09:26:41'),(8,'EVNT08','Hope','USER-20250531-BIL0HF06','Google Gemini ','Google Gemini update test','2025-06-08 23:07:00','Trainings','2025-06-01 09:26:41'),(10,'EVNT09','Hope','USER-20250531-BIL0HF06','Cloud computing trainings','Cloud computing trainings','2025-06-01 17:27:00','Trainings','2025-06-01 09:27:57'),(11,'EVNT10','Hope','USER-20250531-BIL0HF06','Community Cleanup Day(Umuganda)','May umuganda','2025-05-31 07:00:00','Community','2025-06-01 09:43:22'),(12,'EVNT11','Hope','USER-20250531-BIL0HF06','Art Exhibition Opening','Explore the newest works by local artists and meet the creators.','2025-06-01 14:00:00','Art','2025-06-01 09:49:51'),(13,'EVNT12','Hope','USER-20250531-BIL0HF06','Cloud computing trainings','Cloud computing trainings','2025-06-01 21:02:00','Trainings','2025-06-01 21:02:33'),(14,'EVNT13','Hope','USER-20250531-BIL0HF06','Cloud computing trainings','Cloud computing trainings','2025-06-02 09:03:00','Trainings','2025-06-01 21:03:20');
/*!40000 ALTER TABLE `events` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-06-01 23:16:26
