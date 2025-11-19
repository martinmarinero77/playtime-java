CREATE DATABASE  IF NOT EXISTS `playtime_db` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_general_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `playtime_db`;
-- MySQL dump 10.13  Distrib 8.0.43, for Win64 (x86_64)
--
-- Host: localhost    Database: playtime_db
-- ------------------------------------------------------
-- Server version	8.0.43

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
-- Table structure for table `cancha`
--

DROP TABLE IF EXISTS `cancha`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cancha` (
  `idCancha` int NOT NULL,
  `capacidad` int DEFAULT NULL,
  `precio` varchar(45) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `tipo` varchar(45) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `numero` varchar(45) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `idComplejo` int NOT NULL,
  `deportes_idDeporte` int NOT NULL,
  PRIMARY KEY (`idCancha`),
  KEY `fk_Cancha_Complejo_idx` (`idComplejo`),
  KEY `fk_cancha_deportes1_idx` (`deportes_idDeporte`),
  CONSTRAINT `fk_Cancha_Complejo` FOREIGN KEY (`idComplejo`) REFERENCES `complejo` (`idComplejo`) ON DELETE CASCADE,
  CONSTRAINT `fk_cancha_deportes1` FOREIGN KEY (`deportes_idDeporte`) REFERENCES `deportes` (`idDeporte`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cancha`
--

LOCK TABLES `cancha` WRITE;
/*!40000 ALTER TABLE `cancha` DISABLE KEYS */;
INSERT INTO `cancha` VALUES (1,7,'38000','Cesped Sintetico','1',1,1),(2,7,'38000','Cesped Sintetico','2',1,1),(3,7,'38000','Cesped Sintetico','3',1,1),(4,5,'30000','Cesped Sintetico','1',1,1),(5,5,'30000','Cesped Sintetico','2',1,1),(6,5,'30000','Cesped Sintetico','3',1,1),(7,2,'12000','Hormigon','1',1,3),(8,2,'12000','Hormigon','2',1,3),(9,5,'28000','Cesped Sintetico','1',2,1),(10,5,'20000','Hormigon','1',3,2),(11,5,'30000','Cesped Sintetico','1',3,1),(12,5,'30000','Cesped Sintetico','2',3,1),(13,15,'35000','Cesped','2',6,4),(14,15,'35000','Cesped','1',6,4),(15,2,'20000','Tierra batida','1',8,8),(16,2,'20000','Pista dura','2',8,8),(17,6,'25000','PVC deportivo','1',7,5),(18,5,'20000','PVC deportivo','1',7,7),(19,7,'30000','Cesped','1',9,6),(20,7,'30000','Cesped','2',9,6);
/*!40000 ALTER TABLE `cancha` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `complejo`
--

DROP TABLE IF EXISTS `complejo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `complejo` (
  `idComplejo` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `direccion` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `localidad` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `provincia` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `telefono` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`idComplejo`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `complejo`
--

LOCK TABLES `complejo` WRITE;
/*!40000 ALTER TABLE `complejo` DISABLE KEYS */;
INSERT INTO `complejo` VALUES (1,'Sioux','José Marti 1146 (sur)','Capital','San Juan','0264 661-5544'),(2,'Rufrano','Juan José Castelli 500 (sur)','Capital','San Juan','0264 5416-6200'),(3,'San Pablo','Pedro Echague 451 (este)','Capital','San Juan','0264 5443-2466'),(4,'Los Corales','Calivar 300 (norte)','Rivadavia','San Juan','0264-634-1234'),(5,'90 minutos','Meglioli 1400 (sur)','Rivadavia','San Juan','0264-467-9823'),(6,'San Juan Rugby Club','esquina de Carlos Pellegrini y 12 de Octubre','Santa Lucia','San juan','0264-543-2312'),(7,'Banco Hispano','Paula 300 (sur)','Capital','San Juan','0264-565-3221'),(8,'Lawn Tennis Club','Félix Aguilar O 7 (norte) ','Capital','San juan','0264-676-9863'),(9,'Jockey Club',' República del Líbano 1799 (Oeste) ','Rivadavia','San Juan','0264-432-5643');
/*!40000 ALTER TABLE `complejo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `deportes`
--

DROP TABLE IF EXISTS `deportes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `deportes` (
  `idDeporte` int NOT NULL,
  `nombre` varchar(45) CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci NOT NULL,
  PRIMARY KEY (`idDeporte`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `deportes`
--

LOCK TABLES `deportes` WRITE;
/*!40000 ALTER TABLE `deportes` DISABLE KEYS */;
INSERT INTO `deportes` VALUES (2,'Basket'),(1,'Futbol'),(7,'Handball'),(6,'Hockey'),(3,'Padel'),(4,'Rugby'),(8,'Tenis'),(5,'Voley');
/*!40000 ALTER TABLE `deportes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipo`
--

DROP TABLE IF EXISTS `equipo`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipo` (
  `idEquipo` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `idCapitan` int NOT NULL COMMENT 'El usuario que creó el equipo',
  PRIMARY KEY (`idEquipo`),
  UNIQUE KEY `nombre_UNIQUE` (`nombre`),
  KEY `fk_Equipo_Usuario_Capitan_idx` (`idCapitan`),
  CONSTRAINT `fk_Equipo_Usuario_Capitan` FOREIGN KEY (`idCapitan`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipo`
--

LOCK TABLES `equipo` WRITE;
/*!40000 ALTER TABLE `equipo` DISABLE KEYS */;
/*!40000 ALTER TABLE `equipo` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `equipo_jugador`
--

DROP TABLE IF EXISTS `equipo_jugador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `equipo_jugador` (
  `idEquipo` int NOT NULL,
  `idUsuario` int NOT NULL,
  PRIMARY KEY (`idEquipo`,`idUsuario`),
  KEY `fk_Equipo_Jugador_Usuario_idx` (`idUsuario`),
  CONSTRAINT `fk_Equipo_Jugador_Equipo` FOREIGN KEY (`idEquipo`) REFERENCES `equipo` (`idEquipo`) ON DELETE CASCADE,
  CONSTRAINT `fk_Equipo_Jugador_Usuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `equipo_jugador`
--

LOCK TABLES `equipo_jugador` WRITE;
/*!40000 ALTER TABLE `equipo_jugador` DISABLE KEYS */;
/*!40000 ALTER TABLE `equipo_jugador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reserva`
--

DROP TABLE IF EXISTS `reserva`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reserva` (
  `idReserva` int NOT NULL AUTO_INCREMENT,
  `fechaHoraInicio` datetime NOT NULL,
  `estado` enum('PENDIENTE','CONFIRMADA','CANCELADA') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'PENDIENTE',
  `idUsuarioReserva` int NOT NULL COMMENT 'El usuario que paga/crea la reserva',
  `cancha_idCancha` int NOT NULL,
  `esPublica` tinyint DEFAULT '0',
  PRIMARY KEY (`idReserva`),
  UNIQUE KEY `UQ_cancha_hora_unica` (`fechaHoraInicio`,`cancha_idCancha`,`estado`) /*!80000 INVISIBLE */,
  KEY `fk_Reserva_Usuario_idx` (`idUsuarioReserva`),
  KEY `fk_reserva_cancha1_idx` (`cancha_idCancha`),
  CONSTRAINT `fk_reserva_cancha1` FOREIGN KEY (`cancha_idCancha`) REFERENCES `cancha` (`idCancha`),
  CONSTRAINT `fk_Reserva_Usuario` FOREIGN KEY (`idUsuarioReserva`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE
) ENGINE=InnoDB AUTO_INCREMENT=40 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reserva`
--

LOCK TABLES `reserva` WRITE;
/*!40000 ALTER TABLE `reserva` DISABLE KEYS */;
INSERT INTO `reserva` VALUES (1,'2025-11-16 22:00:00','CONFIRMADA',1,1,0),(14,'2025-11-17 19:00:00','CONFIRMADA',1,1,0),(15,'2025-11-17 23:00:00','CANCELADA',1,1,0),(16,'2025-11-17 22:00:00','CANCELADA',1,2,0),(17,'2025-11-17 22:00:00','CONFIRMADA',1,1,0),(18,'2025-11-17 20:00:00','CONFIRMADA',1,1,0),(19,'2025-11-17 21:00:00','CANCELADA',1,1,0),(23,'2025-11-17 23:00:00','CANCELADA',3,3,0),(24,'2025-11-27 19:00:00','CANCELADA',3,2,0),(25,'2025-11-17 23:00:00','CONFIRMADA',2,1,0),(26,'2025-11-17 22:00:00','CONFIRMADA',1,4,0),(27,'2025-11-17 23:00:00','CANCELADA',1,5,0),(28,'2025-11-17 23:00:00','CONFIRMADA',1,2,1),(29,'2025-11-17 23:00:00','CONFIRMADA',3,4,1),(30,'2025-11-22 22:00:00','CANCELADA',1,2,0),(32,'2025-11-18 16:00:00','CANCELADA',1,9,0),(33,'2025-11-18 22:00:00','CONFIRMADA',1,9,0),(34,'2025-11-18 23:00:00','CONFIRMADA',4,8,0),(35,'2025-11-27 22:00:00','CONFIRMADA',5,8,0),(36,'2025-11-20 19:00:00','CONFIRMADA',1,7,0),(37,'2025-11-22 23:00:00','CANCELADA',1,7,0),(38,'2025-11-24 15:00:00','CONFIRMADA',1,7,0),(39,'2025-11-19 18:00:00','CONFIRMADA',2,7,1);
/*!40000 ALTER TABLE `reserva` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `reserva_jugador`
--

DROP TABLE IF EXISTS `reserva_jugador`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `reserva_jugador` (
  `idReserva` int NOT NULL,
  `idUsuario` int NOT NULL,
  `estadoInvitacion` enum('PENDIENTE','ACEPTADA','RECHAZADA') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'PENDIENTE',
  `camiseta` enum('NINGUNO','CLARA','OSCURA') COLLATE utf8mb4_general_ci NOT NULL DEFAULT 'NINGUNO' COMMENT 'Equipo asignado para este partido',
  `apodo` varchar(45) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`idReserva`,`idUsuario`),
  KEY `fk_Reserva_Jugador_Usuario_idx` (`idUsuario`),
  CONSTRAINT `fk_Reserva_Jugador_Reserva` FOREIGN KEY (`idReserva`) REFERENCES `reserva` (`idReserva`) ON DELETE CASCADE,
  CONSTRAINT `fk_Reserva_Jugador_Usuario` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `reserva_jugador`
--

LOCK TABLES `reserva_jugador` WRITE;
/*!40000 ALTER TABLE `reserva_jugador` DISABLE KEYS */;
INSERT INTO `reserva_jugador` VALUES (17,1,'ACEPTADA','OSCURA',NULL),(17,2,'ACEPTADA','CLARA',NULL),(18,1,'ACEPTADA','OSCURA',NULL),(18,3,'ACEPTADA','NINGUNO',NULL),(25,2,'ACEPTADA','OSCURA',NULL),(26,1,'ACEPTADA','NINGUNO',NULL),(28,1,'ACEPTADA','NINGUNO',NULL),(28,2,'ACEPTADA','NINGUNO',NULL),(34,4,'ACEPTADA','NINGUNO',NULL),(35,2,'ACEPTADA','NINGUNO',NULL),(35,4,'ACEPTADA','NINGUNO',NULL),(35,5,'ACEPTADA','NINGUNO',NULL),(36,1,'ACEPTADA','OSCURA',NULL),(36,2,'ACEPTADA','OSCURA',NULL),(36,3,'ACEPTADA','CLARA',NULL),(36,5,'ACEPTADA','NINGUNO',NULL),(38,1,'ACEPTADA','NINGUNO',NULL),(38,2,'ACEPTADA','NINGUNO',NULL),(38,3,'ACEPTADA','NINGUNO',NULL),(38,4,'ACEPTADA','NINGUNO',NULL),(39,2,'ACEPTADA','NINGUNO',NULL);
/*!40000 ALTER TABLE `reserva_jugador` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `idUsuario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `apellido` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `email` varchar(100) COLLATE utf8mb4_general_ci NOT NULL,
  `password` varchar(255) COLLATE utf8mb4_general_ci NOT NULL,
  `telefono` varchar(20) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `direccion` varchar(255) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `localidad` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  `provincia` varchar(100) COLLATE utf8mb4_general_ci DEFAULT NULL,
  PRIMARY KEY (`idUsuario`),
  UNIQUE KEY `email_UNIQUE` (`email`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_general_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (1,'Martin','Marinero','martinmarinero77@gmail.com','ab34289f8e1763dbfc197f25431922e19c5fd35a0f72e6f148e8c782043e8bcf','2646722504','Meglioli Sur 1335','Rivadavia','San juan'),(2,'Facundo','Marinero','facumarinero@gmail.com','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','2645765432',NULL,NULL,NULL),(3,'Matias','Sanchez','matisanchez@gmail.com','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','02645763421',NULL,NULL,NULL),(4,'Juan','Perez','juanperez@gmail.com','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','2645234567',NULL,NULL,NULL),(5,'Pablo','Flores','pabloflores@gmail.com','ef797c8118f02dfb649607dd5d3f8c7623048c9c063d532cc95c5ed7a898a64f','2645672311',NULL,NULL,NULL);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-11-19  0:49:46
