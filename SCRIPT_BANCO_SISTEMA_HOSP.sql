CREATE DATABASE IF NOT EXISTS `hospital_uc12` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `hospital_uc12`;

-- MySQL dump 10.13  Distrib 8.0.31, for Win64 (x86_64)
--
-- Host: localhost    Database: hospital_uc12
-- ------------------------------------------------------
-- Server version	8.0.31

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
-- Table structure for table `consulta`
--

DROP TABLE IF EXISTS `consulta`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `consulta` (
  `ID_CONSULTA` int NOT NULL,
  `DATA_HORA` datetime DEFAULT NULL,
  `VALOR` double DEFAULT NULL,
  `NUM_CARTEIRA_CONV` varchar(45) DEFAULT NULL,
  `ID_CONVENIO_FK` int NOT NULL,
  `ID_PACIENTE_FK` int NOT NULL,
  `ID_MEDICO_FK` int NOT NULL,
  `ID_ESPECIALIDADE_FK` int NOT NULL,
  PRIMARY KEY (`ID_CONSULTA`),
  KEY `fk_CONSULTA_CONVENIO1` (`ID_CONVENIO_FK`),
  KEY `fk_CONSULTA_PACIENTE1` (`ID_PACIENTE_FK`),
  KEY `fk_CONSULTA_MEDICO1` (`ID_MEDICO_FK`),
  KEY `fk_CONSULTA_ESPECIALIDADE1` (`ID_ESPECIALIDADE_FK`),
  CONSTRAINT `fk_CONSULTA_CONVENIO1` FOREIGN KEY (`ID_CONVENIO_FK`) REFERENCES `convenio` (`ID_CONVENIO`),
  CONSTRAINT `fk_CONSULTA_ESPECIALIDADE1` FOREIGN KEY (`ID_ESPECIALIDADE_FK`) REFERENCES `especialidade` (`ID_ESPECIALIDADE`),
  CONSTRAINT `fk_CONSULTA_MEDICO1` FOREIGN KEY (`ID_MEDICO_FK`) REFERENCES `medico` (`ID_MEDICO`),
  CONSTRAINT `fk_CONSULTA_PACIENTE1` FOREIGN KEY (`ID_PACIENTE_FK`) REFERENCES `paciente` (`ID_PACIENTE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `consulta`
--

LOCK TABLES `consulta` WRITE;
/*!40000 ALTER TABLE `consulta` DISABLE KEYS */;
/*!40000 ALTER TABLE `consulta` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `convenio`
--

DROP TABLE IF EXISTS `convenio`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `convenio` (
  `ID_CONVENIO` int NOT NULL AUTO_INCREMENT,
  `NOME_CONVENIO` varchar(45) DEFAULT NULL,
  `TEMPO_CARENCIA` varchar(45) DEFAULT NULL,
  `CNPJ` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ID_CONVENIO`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `convenio`
--

LOCK TABLES `convenio` WRITE;
/*!40000 ALTER TABLE `convenio` DISABLE KEYS */;
INSERT INTO `convenio` VALUES (1,'Amil','30 dias','12345678901234'),(2,'SulAmérica','60 dias','56789012345678'),(3,'Unimed','90 dias','90123456789012'),(4,'Bradesco Saúde','120 dias','34567890123456'),(5,'Medial Saúde','180 dias','78901234567890');
/*!40000 ALTER TABLE `convenio` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `especialidade`
--

DROP TABLE IF EXISTS `especialidade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `especialidade` (
  `ID_ESPECIALIDADE` int NOT NULL,
  `DESCRICAO_ESPEC` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ID_ESPECIALIDADE`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `especialidade`
--

LOCK TABLES `especialidade` WRITE;
/*!40000 ALTER TABLE `especialidade` DISABLE KEYS */;
/*!40000 ALTER TABLE `especialidade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medico`
--

DROP TABLE IF EXISTS `medico`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medico` (
  `ID_MEDICO` int NOT NULL AUTO_INCREMENT,
  `CRM` varchar(45) DEFAULT NULL,
  `ENDERECO` varchar(45) DEFAULT NULL,
  `TELEFONE` varchar(45) DEFAULT NULL,
  `EMAIL` varchar(45) DEFAULT NULL,
  `DATA_NASC` varchar(45) DEFAULT NULL,
  `UF` varchar(45) DEFAULT NULL,
  PRIMARY KEY (`ID_MEDICO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medico`
--

LOCK TABLES `medico` WRITE;
/*!40000 ALTER TABLE `medico` DISABLE KEYS */;
/*!40000 ALTER TABLE `medico` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `medico_especialidade`
--

DROP TABLE IF EXISTS `medico_especialidade`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `medico_especialidade` (
  `ID_MEDICO` int NOT NULL,
  `ID_ESPECIALIDADE` int NOT NULL,
  PRIMARY KEY (`ID_MEDICO`,`ID_ESPECIALIDADE`),
  KEY `FK_ID_ESPEC` (`ID_ESPECIALIDADE`),
  CONSTRAINT `FK_ID_ESPEC` FOREIGN KEY (`ID_ESPECIALIDADE`) REFERENCES `especialidade` (`ID_ESPECIALIDADE`),
  CONSTRAINT `FK_ID_MEDICO` FOREIGN KEY (`ID_MEDICO`) REFERENCES `medico` (`ID_MEDICO`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `medico_especialidade`
--

LOCK TABLES `medico_especialidade` WRITE;
/*!40000 ALTER TABLE `medico_especialidade` DISABLE KEYS */;
/*!40000 ALTER TABLE `medico_especialidade` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `paciente`
--

DROP TABLE IF EXISTS `paciente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `paciente` (
  `ID_PACIENTE` int NOT NULL AUTO_INCREMENT,
  `NOME` varchar(45) DEFAULT NULL,
  `ENDERECO` varchar(45) DEFAULT NULL,
  `DATA_NASC` date DEFAULT NULL,
  `TELEFONE` varchar(45) DEFAULT NULL,
  `CPF` varchar(45) DEFAULT NULL,
  `RG` varchar(45) DEFAULT NULL,
  `ID_CONVENIO_FK` int NOT NULL,
  PRIMARY KEY (`ID_PACIENTE`),
  KEY `fk_PACIENTE_CONVENIO1` (`ID_CONVENIO_FK`),
  CONSTRAINT `fk_PACIENTE_CONVENIO1` FOREIGN KEY (`ID_CONVENIO_FK`) REFERENCES `convenio` (`ID_CONVENIO`)
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `paciente`
--

LOCK TABLES `paciente` WRITE;
/*!40000 ALTER TABLE `paciente` DISABLE KEYS */;
INSERT INTO `paciente` VALUES (1,'Maria da Silva','Rua A, 123','1990-01-01','(11) 1234-5678','123.456.789-00','1234567',1),(2,'Carlos dos Santos','Rua B, 456','1985-05-15','(11) 8765-4321','987.654.321-00','7654321',2),(3,'Eduardo Souza','Rua C, 789','2000-11-30','(11) 9876-5432','456.789.123-00','4567891',3),(4,'João Silva','Rua D, 987','1995-08-10','(11) 4567-8901','159.753.456-00','1597534',4);
/*!40000 ALTER TABLE `paciente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `receita_medica`
--

DROP TABLE IF EXISTS `receita_medica`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `receita_medica` (
  `ID_RECEITA_MEDICA` int NOT NULL,
  `MEDICAMENTOS` varchar(45) DEFAULT NULL,
  `QUANTIDADE` varchar(45) DEFAULT NULL,
  `INSTRUCAO_USO` varchar(45) DEFAULT NULL,
  `ID_CONSULTA_FK` int NOT NULL,
  PRIMARY KEY (`ID_RECEITA_MEDICA`),
  KEY `fk_RECEITA_MEDICA_CONSULTA1` (`ID_CONSULTA_FK`),
  CONSTRAINT `fk_RECEITA_MEDICA_CONSULTA1` FOREIGN KEY (`ID_CONSULTA_FK`) REFERENCES `consulta` (`ID_CONSULTA`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `receita_medica`
--

LOCK TABLES `receita_medica` WRITE;
/*!40000 ALTER TABLE `receita_medica` DISABLE KEYS */;
/*!40000 ALTER TABLE `receita_medica` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2023-03-08 19:43:02

SELECT * FROM paciente; -- Exibe a tabela 'paciente'.
