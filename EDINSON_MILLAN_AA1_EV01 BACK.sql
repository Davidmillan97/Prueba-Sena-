CREATE DATABASE  IF NOT EXISTS `inventariodb` /*!40100 DEFAULT CHARACTER SET utf8mb4 COLLATE utf8mb4_0900_ai_ci */ /*!80016 DEFAULT ENCRYPTION='N' */;
USE `inventariodb`;
-- MySQL dump 10.13  Distrib 8.0.36, for Win64 (x86_64)
--
-- Host: localhost    Database: inventariodb
-- ------------------------------------------------------
-- Server version	8.0.36

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
-- Table structure for table `categoria`
--

DROP TABLE IF EXISTS `categoria`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `categoria` (
  `idCategoria` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  `descripcion` text,
  PRIMARY KEY (`idCategoria`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `categoria`
--

LOCK TABLES `categoria` WRITE;
/*!40000 ALTER TABLE `categoria` DISABLE KEYS */;
INSERT INTO `categoria` VALUES (1,'Laptops','Computadoras portátiles.'),(2,'Monitores','Pantallas de visualización.'),(3,'Periféricos','Dispositivos externos para computadoras.'),(4,'Impresoras','Dispositivos para impresión y escaneo.'),(5,'Almacenamiento','Dispositivos para almacenamiento de datos.'),(6,'Redes','Equipos de red y conectividad.');
/*!40000 ALTER TABLE `categoria` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cliente`
--

DROP TABLE IF EXISTS `cliente`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `cliente` (
  `idCliente` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  `tipoCliente` enum('INDIVIDUAL','EMPRESA') DEFAULT NULL,
  `identificacion` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idCliente`)
) ENGINE=InnoDB AUTO_INCREMENT=11 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cliente`
--

LOCK TABLES `cliente` WRITE;
/*!40000 ALTER TABLE `cliente` DISABLE KEYS */;
INSERT INTO `cliente` VALUES (1,'Juan Pérez','INDIVIDUAL','12345678'),(2,'María López','INDIVIDUAL','87654321'),(3,'Tech Solutions S.A.C.','EMPRESA','12345678901'),(4,'PC World Perú','EMPRESA','09876543210'),(5,'Mega Computadoras EIRL','EMPRESA','45678901234'),(6,'Ana Ramírez','INDIVIDUAL','56789012'),(7,'Pedro Gómez','INDIVIDUAL','34567890'),(8,'ElectroPerú SAC','EMPRESA','98765432109'),(9,'Soluciones Informáticas EIRL','EMPRESA','65432109876'),(10,'Laura Torres','INDIVIDUAL','21098765');
/*!40000 ALTER TABLE `cliente` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `detalle_ingreso`
--

DROP TABLE IF EXISTS `detalle_ingreso`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle_ingreso` (
  `idDetalleIngreso` int NOT NULL AUTO_INCREMENT,
  `cantidad` int DEFAULT NULL,
  `idProducto` int DEFAULT NULL,
  `idIngreso` int DEFAULT NULL,
  PRIMARY KEY (`idDetalleIngreso`),
  KEY `detalleingreso_ibfk_1` (`idProducto`),
  KEY `detalleingreso_ibfk_2` (`idIngreso`),
  CONSTRAINT `detalleingreso_ibfk_1` FOREIGN KEY (`idProducto`) REFERENCES `producto` (`idProducto`),
  CONSTRAINT `detalleingreso_ibfk_2` FOREIGN KEY (`idIngreso`) REFERENCES `ingresoinventario` (`idIngreso`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_ingreso`
--

LOCK TABLES `detalle_ingreso` WRITE;
/*!40000 ALTER TABLE `detalle_ingreso` DISABLE KEYS */;
INSERT INTO `detalle_ingreso` VALUES (1,26,4,4),(2,45,5,5),(3,28,4,5),(4,20,5,6),(5,24,6,7),(6,37,6,8);
/*!40000 ALTER TABLE `detalle_ingreso` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `actualizarStockIngreso` AFTER INSERT ON `detalle_ingreso` FOR EACH ROW BEGIN
    -- Actualizar el stock sumando la cantidad ingresada
    UPDATE inventario
    SET ingreso = ingreso + NEW.cantidad,
        stockActual = stockActual + NEW.cantidad
    WHERE idProducto = NEW.idProducto;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `detalle_salida`
--

DROP TABLE IF EXISTS `detalle_salida`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `detalle_salida` (
  `idDetalleSalida` int NOT NULL AUTO_INCREMENT,
  `cantidad` int DEFAULT NULL,
  `idProducto` int DEFAULT NULL,
  `idSalida` int DEFAULT NULL,
  PRIMARY KEY (`idDetalleSalida`),
  KEY `detallesalida_ibfk_1` (`idProducto`),
  KEY `detallesalida_ibfk_2` (`idSalida`),
  CONSTRAINT `detallesalida_ibfk_1` FOREIGN KEY (`idProducto`) REFERENCES `producto` (`idProducto`),
  CONSTRAINT `detallesalida_ibfk_2` FOREIGN KEY (`idSalida`) REFERENCES `salidainventario` (`idSalida`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `detalle_salida`
--

LOCK TABLES `detalle_salida` WRITE;
/*!40000 ALTER TABLE `detalle_salida` DISABLE KEYS */;
INSERT INTO `detalle_salida` VALUES (1,6,5,1),(2,30,6,2);
/*!40000 ALTER TABLE `detalle_salida` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `actualizarStockSalida` AFTER INSERT ON `detalle_salida` FOR EACH ROW BEGIN
    -- Actualizar el stock restando la cantidad salida
    UPDATE inventario
    SET salida = salida + NEW.cantidad,
        stockActual = stockActual - NEW.cantidad
    WHERE idProducto = NEW.idProducto;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `ingresoinventario`
--

DROP TABLE IF EXISTS `ingresoinventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `ingresoinventario` (
  `idIngreso` int NOT NULL AUTO_INCREMENT,
  `fecha` date DEFAULT NULL,
  `idProveedor` int DEFAULT NULL,
  `idUsuario` int DEFAULT NULL,
  `tipo` enum('INGRESO','SALIDA') DEFAULT NULL,
  PRIMARY KEY (`idIngreso`),
  KEY `ingresoinventario_ibfk_1` (`idProveedor`),
  KEY `ingresoinventario_ibfk_2` (`idUsuario`),
  CONSTRAINT `ingresoinventario_ibfk_1` FOREIGN KEY (`idProveedor`) REFERENCES `proveedor` (`idProveedor`),
  CONSTRAINT `ingresoinventario_ibfk_2` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=9 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `ingresoinventario`
--

LOCK TABLES `ingresoinventario` WRITE;
/*!40000 ALTER TABLE `ingresoinventario` DISABLE KEYS */;
INSERT INTO `ingresoinventario` VALUES (4,'2024-07-12',5,3,'INGRESO'),(5,'2024-07-13',8,3,'INGRESO'),(6,'2024-07-13',2,3,'INGRESO'),(7,'2024-07-12',8,3,'INGRESO'),(8,'2024-07-12',9,3,'INGRESO');
/*!40000 ALTER TABLE `ingresoinventario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventario`
--

DROP TABLE IF EXISTS `inventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `inventario` (
  `idInventario` int NOT NULL AUTO_INCREMENT,
  `idProducto` int DEFAULT NULL,
  `productonombre` varchar(255) DEFAULT NULL,
  `salida` int DEFAULT NULL,
  `ingreso` int DEFAULT NULL,
  `stockActual` int DEFAULT NULL,
  PRIMARY KEY (`idInventario`),
  KEY `inventario_ibfk_1` (`idProducto`),
  CONSTRAINT `inventario_ibfk_1` FOREIGN KEY (`idProducto`) REFERENCES `producto` (`idProducto`)
) ENGINE=InnoDB AUTO_INCREMENT=6 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventario`
--

LOCK TABLES `inventario` WRITE;
/*!40000 ALTER TABLE `inventario` DISABLE KEYS */;
INSERT INTO `inventario` VALUES (2,4,'aaaa',0,0,0),(3,5,'bbbb',6,20,14),(4,6,'ccccc',30,61,31);
/*!40000 ALTER TABLE `inventario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `producto`
--

DROP TABLE IF EXISTS `producto`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `producto` (
  `idProducto` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  `descripcion` text,
  `precio` decimal(10,2) DEFAULT NULL,
  `idCategoria` int DEFAULT NULL,
  `idProveedor` int DEFAULT NULL,
  `stockMinimo` int DEFAULT NULL,
  `activo` tinyint(1) DEFAULT '1',
  `estado` varchar(50) DEFAULT 'Activo',
  PRIMARY KEY (`idProducto`),
  KEY `producto_ibfk_1` (`idCategoria`),
  KEY `producto_ibfk_2` (`idProveedor`),
  CONSTRAINT `producto_ibfk_1` FOREIGN KEY (`idCategoria`) REFERENCES `categoria` (`idCategoria`),
  CONSTRAINT `producto_ibfk_2` FOREIGN KEY (`idProveedor`) REFERENCES `proveedor` (`idProveedor`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `producto`
--

LOCK TABLES `producto` WRITE;
/*!40000 ALTER TABLE `producto` DISABLE KEYS */;
INSERT INTO `producto` VALUES (4,'aaaa','aaaaaa',123.00,3,1,5,1,'Activo'),(5,'bbbb','bbbbb',345.00,6,1,12,1,'Activo'),(6,'ccccc','cccc',456.00,4,9,5,1,'Activo'),(7,'mouse','xxxxxxxxxxxxxxx',456.00,3,8,10,0,'Activo');
/*!40000 ALTER TABLE `producto` ENABLE KEYS */;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_insert_producto` AFTER INSERT ON `producto` FOR EACH ROW BEGIN
    INSERT INTO Inventario (idProducto, productonombre, salida, ingreso, stockActual)
    VALUES (NEW.idProducto, NEW.nombre, 0, 0, 0)
    ON DUPLICATE KEY UPDATE
    productonombre = NEW.nombre;
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
/*!50003 CREATE*/ /*!50017 DEFINER=`root`@`localhost`*/ /*!50003 TRIGGER `after_update_producto` AFTER UPDATE ON `producto` FOR EACH ROW BEGIN
    IF NEW.activo = 0 THEN
        DELETE FROM Inventario WHERE idProducto = OLD.idProducto;
    END IF;
END */;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;

--
-- Table structure for table `proveedor`
--

DROP TABLE IF EXISTS `proveedor`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `proveedor` (
  `idProveedor` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  `direccion` text,
  `telefono` varchar(50) DEFAULT NULL,
  `correo` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`idProveedor`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `proveedor`
--

LOCK TABLES `proveedor` WRITE;
/*!40000 ALTER TABLE `proveedor` DISABLE KEYS */;
INSERT INTO `proveedor` VALUES (1,'HP Inc.','123 Main St, Ciudad','+51 123456789','info@hp.com'),(2,'ASUS Technology','456 First Ave, Ciudad','+51 987654321','info@asus.com'),(3,'LG Electronics','789 Broad St, Ciudad','+51 456789012','info@lg.com'),(4,'Corsair Components','456 Oak Ave, Ciudad','+51 654321098','info@corsair.com'),(5,'Logitech Inc.','789 Elm St, Ciudad','+51 321098765','info@logitech.com'),(6,'HP Inc.','123 Main St, Ciudad','+51 123456789','info@hp.com'),(7,'Seagate Technology','789 Pine St, Ciudad','+51 210987654','info@seagate.com'),(8,'TP-Link Technologies','456 Maple Ave, Ciudad','+51 789012345','info@tplink.com'),(9,'APC by Schneider Electric','789 Oak St, Ciudad','+51 890123456','info@apc.com'),(10,'HDMI Licensing Administrator','456 Elm St, Ciudad','+51 567890123','info@hdmi.com');
/*!40000 ALTER TABLE `proveedor` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `salidainventario`
--

DROP TABLE IF EXISTS `salidainventario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `salidainventario` (
  `idSalida` int NOT NULL AUTO_INCREMENT,
  `fecha` date DEFAULT NULL,
  `idUsuario` int DEFAULT NULL,
  `idCliente` int DEFAULT NULL,
  `tipo` enum('INGRESO','SALIDA') DEFAULT NULL,
  PRIMARY KEY (`idSalida`),
  KEY `salidainventario_ibfk_1` (`idUsuario`),
  KEY `salidainventario_ibfk_2` (`idCliente`),
  CONSTRAINT `salidainventario_ibfk_1` FOREIGN KEY (`idUsuario`) REFERENCES `usuario` (`idUsuario`),
  CONSTRAINT `salidainventario_ibfk_2` FOREIGN KEY (`idCliente`) REFERENCES `cliente` (`idCliente`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `salidainventario`
--

LOCK TABLES `salidainventario` WRITE;
/*!40000 ALTER TABLE `salidainventario` DISABLE KEYS */;
INSERT INTO `salidainventario` VALUES (1,'2024-07-18',3,5,'SALIDA'),(2,'2024-07-27',3,10,'SALIDA');
/*!40000 ALTER TABLE `salidainventario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `usuario`
--

DROP TABLE IF EXISTS `usuario`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `usuario` (
  `idUsuario` int NOT NULL AUTO_INCREMENT,
  `nombre` varchar(255) DEFAULT NULL,
  `apellido` varchar(255) DEFAULT NULL,
  `username` varchar(255) DEFAULT NULL,
  `correo` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `tipo` enum('EMPLEADO','ADMINISTRADOR') DEFAULT NULL,
  `activo` tinyint(1) DEFAULT NULL,
  PRIMARY KEY (`idUsuario`)
) ENGINE=InnoDB AUTO_INCREMENT=8 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `usuario`
--

LOCK TABLES `usuario` WRITE;
/*!40000 ALTER TABLE `usuario` DISABLE KEYS */;
INSERT INTO `usuario` VALUES (3,'Carlos','González','carlos','admin@gmail.com','admin','ADMINISTRADOR',1),(4,'Ana','Martínez','amartinez','amartinez@example.com','securepwd456','EMPLEADO',1),(5,'Diego','Pérez','dperez','dperez@example.com','mypassword789','EMPLEADO',1),(6,'Laura','Ramírez','lramirez','lramirez@example.com','strongpwd321','EMPLEADO',1),(7,'Elena','López','elopez','elopez@example.com','secretpass','EMPLEADO',1);
/*!40000 ALTER TABLE `usuario` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Dumping events for database 'inventariodb'
--

--
-- Dumping routines for database 'inventariodb'
--
/*!50003 DROP PROCEDURE IF EXISTS `BuscarInventario` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `BuscarInventario`(IN text_param VARCHAR(255))
BEGIN

	SELECT *
	FROM inventario
	WHERE productonombre LIKE CONCAT('%', text_param, '%')
	   OR idProducto = text_param;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `BuscarProducto` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `BuscarProducto`(IN text_param VARCHAR(255))
BEGIN
    SELECT *
    FROM producto
    WHERE nombre LIKE CONCAT('%', text_param, '%')
       OR descripcion LIKE CONCAT('%', text_param, '%');
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `movimientoporproductomovimiento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `movimientoporproductomovimiento`(
    IN tipo ENUM('Ingreso', 'Salida')
)
BEGIN
    IF tipo = 'Ingreso' THEN
        SELECT 
            p.idProducto as ID_Producto,
            i.fecha as Fecha,
            p.nombre as NombreProducto,
            di.cantidad as Cantidad,
            pr.nombre as 'Cliente / Proveedor',
            'Ingreso' as TipoMovimiento
        FROM 
            producto p
            INNER JOIN detalle_ingreso di ON p.idProducto = di.idProducto
            INNER JOIN ingresoinventario i ON di.idIngreso = i.idIngreso
            INNER JOIN proveedor pr ON i.idProveedor = pr.idProveedor
        ORDER BY 
            i.fecha;
    ELSEIF tipo = 'Salida' THEN
        SELECT 
            p.idProducto as ID_Producto,
            s.fecha as Fecha,
            p.nombre as NombreProducto,
            ds.cantidad as Cantidad,
            c.nombre as 'Cliente / Proveedor',
            'Salida' as TipoMovimiento
        FROM 
            producto p
            INNER JOIN detalle_salida ds ON p.idProducto = ds.idProducto
            INNER JOIN salidainventario s ON ds.idSalida = s.idSalida
            INNER JOIN cliente c ON s.idCliente = c.idCliente
        ORDER BY 
            s.fecha;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `movimientoporproductonombre` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `movimientoporproductonombre`(
    IN text_param VARCHAR(255)
)
BEGIN
    SELECT 
        p.idProducto as ID_Producto,
        i.fecha as Fecha,
        p.nombre as NombreProducto,
        di.cantidad as Cantidad,
        pr.nombre as 'Cliente / Proveedor',
        'Ingreso' as TipoMovimiento
    FROM 
        producto p
        INNER JOIN detalle_ingreso di ON p.idProducto = di.idProducto
        INNER JOIN ingresoinventario i ON di.idIngreso = i.idIngreso
        INNER JOIN proveedor pr ON i.idProveedor = pr.idProveedor
    WHERE 
        p.nombre LIKE CONCAT('%', text_param, '%')
    
    UNION ALL
    
    SELECT 
        p.idProducto as ID_Producto,
        s.fecha as Fecha,
        p.nombre as NombreProducto,
        ds.cantidad as Cantidad,
        c.nombre as 'Cliente / Proveedor',
        'Salida' as TipoMovimiento
    FROM 
        producto p
        INNER JOIN detalle_salida ds ON p.idProducto = ds.idProducto
        INNER JOIN salidainventario s ON ds.idSalida = s.idSalida
        INNER JOIN cliente c ON s.idCliente = c.idCliente
    WHERE 
        p.nombre LIKE CONCAT('%', text_param, '%')
    
    ORDER BY 
        Fecha;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `movimientoporproductonombreymovimiento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `movimientoporproductonombreymovimiento`(
    IN text_param VARCHAR(255),
    IN tipo ENUM('Ingreso', 'Salida')
)
BEGIN
    IF tipo = 'Ingreso' THEN
        SELECT 
            p.idProducto as ID_Producto,
            i.fecha as Fecha,
            p.nombre as NombreProducto,
            di.cantidad as Cantidad,
            pr.nombre as 'Cliente / Proveedor',
            'Ingreso' as TipoMovimiento
        FROM 
            producto p
            INNER JOIN detalle_ingreso di ON p.idProducto = di.idProducto
            INNER JOIN ingresoinventario i ON di.idIngreso = i.idIngreso
            INNER JOIN proveedor pr ON i.idProveedor = pr.idProveedor
        WHERE 
            p.nombre LIKE CONCAT('%', text_param, '%')
        ORDER BY 
            i.fecha;
    ELSEIF tipo = 'Salida' THEN
        SELECT 
            p.idProducto as ID_Producto,
            s.fecha as Fecha,
            p.nombre as NombreProducto,
            ds.cantidad as Cantidad,
            c.nombre as 'Cliente / Proveedor',
            'Salida' as TipoMovimiento
        FROM 
            producto p
            INNER JOIN detalle_salida ds ON p.idProducto = ds.idProducto
            INNER JOIN salidainventario s ON ds.idSalida = s.idSalida
            INNER JOIN cliente c ON s.idCliente = c.idCliente
        WHERE 
            p.nombre LIKE CONCAT('%', text_param, '%')
        ORDER BY 
            s.fecha;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `movimientoproductogeneral` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `movimientoproductogeneral`()
BEGIN
    SELECT 
        p.idProducto as ID_Producto,
        i.fecha as Fecha,
        p.nombre as NombreProducto,
        di.cantidad as Cantidad,
        pr.nombre as 'Cliente / Proveedor',
        'Ingreso' as TipoMovimiento
    FROM 
        producto p
        INNER JOIN detalle_ingreso di ON p.idProducto = di.idProducto
        INNER JOIN ingresoinventario i ON di.idIngreso = i.idIngreso
        INNER JOIN proveedor pr ON i.idProveedor = pr.idProveedor

    UNION ALL

    SELECT 
        p.idProducto as ID_Producto,
        s.fecha as Fecha,
        p.nombre as NombreProducto,
        ds.cantidad as Cantidad,
        c.nombre as 'Cliente / Proveedor',
        'Salida' as TipoMovimiento
    FROM 
        producto p
        INNER JOIN detalle_salida ds ON p.idProducto = ds.idProducto
        INNER JOIN salidainventario s ON ds.idSalida = s.idSalida
        INNER JOIN cliente c ON s.idCliente = c.idCliente
    ORDER BY 
        Fecha;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerDetallesIngreso` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerDetallesIngreso`(
    IN id_ingreso INT
)
BEGIN
    SELECT 
        di.idDetalleIngreso as idDetalleIngreso,
        p.idProducto as idProducto,
        p.nombre as nombre_producto,
        di.cantidad as cantidad,
        pr.nombre as Proveedor,
        i.fecha as Fecha
    FROM 
        producto p
        INNER JOIN detalle_ingreso di ON p.idProducto = di.idProducto
        INNER JOIN ingresoinventario i ON di.idIngreso = i.idIngreso
        INNER JOIN proveedor pr ON i.idProveedor = pr.idProveedor
    WHERE 
        i.idIngreso = id_ingreso;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `ObtenerDetallesSalida` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `ObtenerDetallesSalida`(
    IN id_salida INT
)
BEGIN
    SELECT 
        ds.idDetalleSalida as idDetalle_salida,
        p.idProducto as idProducto,
        p.nombre as nombre_producto,
        ds.cantidad as cantidad,
        c.nombre as Cliente,
        s.fecha as Fecha
    FROM 
        producto p
        INNER JOIN detalle_salida ds ON p.idProducto = ds.idProducto
        INNER JOIN salidainventario s ON ds.idSalida = s.idSalida
        INNER JOIN cliente c ON s.idCliente = c.idCliente
    WHERE 
        s.idSalida = id_salida;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!50003 DROP PROCEDURE IF EXISTS `obtenerMovimientosPorProductoNombreTipoMovimiento` */;
/*!50003 SET @saved_cs_client      = @@character_set_client */ ;
/*!50003 SET @saved_cs_results     = @@character_set_results */ ;
/*!50003 SET @saved_col_connection = @@collation_connection */ ;
/*!50003 SET character_set_client  = utf8mb4 */ ;
/*!50003 SET character_set_results = utf8mb4 */ ;
/*!50003 SET collation_connection  = utf8mb4_0900_ai_ci */ ;
/*!50003 SET @saved_sql_mode       = @@sql_mode */ ;
/*!50003 SET sql_mode              = 'ONLY_FULL_GROUP_BY,STRICT_TRANS_TABLES,NO_ZERO_IN_DATE,NO_ZERO_DATE,ERROR_FOR_DIVISION_BY_ZERO,NO_ENGINE_SUBSTITUTION' */ ;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `obtenerMovimientosPorProductoNombreTipoMovimiento`(
    IN text_param VARCHAR(255),
    IN tipo ENUM('Ingreso', 'Salida')
)
BEGIN
    IF tipo = 'Ingreso' THEN
        SELECT 
            p.idProducto as ID_Producto,
            i.fecha as Fecha,
            p.nombre as NombreProducto,
            di.cantidad as Cantidad,
            pr.nombre as 'Cliente / Proveedor',
            'Ingreso' as TipoMovimiento
        FROM 
            producto p
            INNER JOIN detalle_ingreso di ON p.idProducto = di.idProducto
            INNER JOIN ingresoinventario i ON di.idIngreso = i.idIngreso
            INNER JOIN proveedor pr ON i.idProveedor = pr.idProveedor
        WHERE 
            p.nombre LIKE CONCAT('%', text_param, '%')
        ORDER BY 
            i.fecha;
    ELSEIF tipo = 'Salida' THEN
        SELECT 
            p.idProducto as ID_Producto,
            s.fecha as Fecha,
            p.nombre as NombreProducto,
            ds.cantidad as Cantidad,
            c.nombre as 'Cliente / Proveedor',
            'Salida' as TipoMovimiento
        FROM 
            producto p
            INNER JOIN detalle_salida ds ON p.idProducto = ds.idProducto
            INNER JOIN salidainventario s ON ds.idSalida = s.idSalida
            INNER JOIN cliente c ON s.idCliente = c.idCliente
        WHERE 
            p.nombre LIKE CONCAT('%', text_param, '%')
        ORDER BY 
            s.fecha;
    END IF;
END ;;
DELIMITER ;
/*!50003 SET sql_mode              = @saved_sql_mode */ ;
/*!50003 SET character_set_client  = @saved_cs_client */ ;
/*!50003 SET character_set_results = @saved_cs_results */ ;
/*!50003 SET collation_connection  = @saved_col_connection */ ;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2024-07-12 19:57:37
