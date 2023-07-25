-- --------------------------------------------------------
-- Host:                         127.0.0.1
-- Versión del servidor:         10.6.5-MariaDB - mariadb.org binary distribution
-- SO del servidor:              Win64
-- HeidiSQL Versión:             11.3.0.6295
-- --------------------------------------------------------

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET NAMES utf8 */;
/*!50503 SET NAMES utf8mb4 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;


-- Volcando estructura de base de datos para sistema
CREATE DATABASE IF NOT EXISTS `sistema` /*!40100 DEFAULT CHARACTER SET utf8mb3 COLLATE utf8mb3_bin */;
USE `sistema`;

-- Volcando estructura para tabla sistema.candidatos
CREATE TABLE IF NOT EXISTS `candidatos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) COLLATE utf8mb3_bin DEFAULT NULL,
  `apellido` varchar(80) COLLATE utf8mb3_bin DEFAULT NULL,
  `comuna_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_candidato_comuna` (`comuna_id`),
  CONSTRAINT `fk_candidato_comuna` FOREIGN KEY (`comuna_id`) REFERENCES `comunas` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

-- Volcando datos para la tabla sistema.candidatos: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `candidatos` DISABLE KEYS */;
INSERT INTO `candidatos` (`id`, `nombre`, `apellido`, `comuna_id`) VALUES
	(1, 'Candidato 1', 'candidato 1', 1),
	(2, 'Candidato 2', 'candidato 2', 2),
	(3, 'Candidato 3', 'Candidato 3', 5),
	(4, 'Candidato 4', 'Candidato 4', 7);
/*!40000 ALTER TABLE `candidatos` ENABLE KEYS */;

-- Volcando estructura para tabla sistema.comunas
CREATE TABLE IF NOT EXISTS `comunas` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) COLLATE utf8mb3_bin DEFAULT NULL,
  `region_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_comuna_region` (`region_id`),
  CONSTRAINT `fk_comuna_region` FOREIGN KEY (`region_id`) REFERENCES `regiones` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=10 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

-- Volcando datos para la tabla sistema.comunas: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `comunas` DISABLE KEYS */;
INSERT INTO `comunas` (`id`, `nombre`, `region_id`) VALUES
	(1, 'Puerto Montt', 1),
	(2, 'Osorno', 1),
	(3, 'Valdivia', 2),
	(4, 'Futrono', 2),
	(5, 'Temuco', 3),
	(6, 'Villarrica', 3),
	(7, 'Santiago', 4),
	(8, 'Maipu', 4),
	(9, 'San miguel', 4);
/*!40000 ALTER TABLE `comunas` ENABLE KEYS */;

-- Volcando estructura para tabla sistema.opciones
CREATE TABLE IF NOT EXISTS `opciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

-- Volcando datos para la tabla sistema.opciones: ~4 rows (aproximadamente)
/*!40000 ALTER TABLE `opciones` DISABLE KEYS */;
INSERT INTO `opciones` (`id`, `nombre`) VALUES
	(1, 'Web'),
	(2, 'TV'),
	(3, 'Redes Sociales'),
	(4, 'Amigos');
/*!40000 ALTER TABLE `opciones` ENABLE KEYS */;

-- Volcando estructura para tabla sistema.regiones
CREATE TABLE IF NOT EXISTS `regiones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre` varchar(80) COLLATE utf8mb3_bin DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

-- Volcando datos para la tabla sistema.regiones: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `regiones` DISABLE KEYS */;
INSERT INTO `regiones` (`id`, `nombre`) VALUES
	(1, 'Los Lagos'),
	(2, 'Los Rios'),
	(3, 'Araucania'),
	(4, 'Metropolitana');
/*!40000 ALTER TABLE `regiones` ENABLE KEYS */;

-- Volcando estructura para tabla sistema.votaciones
CREATE TABLE IF NOT EXISTS `votaciones` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `nombre_apellido` varchar(150) COLLATE utf8mb3_bin NOT NULL,
  `alias` varchar(80) COLLATE utf8mb3_bin NOT NULL,
  `rut` varchar(255) COLLATE utf8mb3_bin NOT NULL,
  `email` varchar(100) COLLATE utf8mb3_bin DEFAULT NULL,
  `region_id` int(11) DEFAULT NULL,
  `comuna_id` int(11) DEFAULT NULL,
  `candidato_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `rut` (`rut`),
  KEY `fk_votacion_region` (`region_id`),
  KEY `fk_votacion_comuna` (`comuna_id`),
  KEY `fk_votacion_candidato` (`candidato_id`),
  CONSTRAINT `fk_votacion_candidato` FOREIGN KEY (`candidato_id`) REFERENCES `candidatos` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_votacion_comuna` FOREIGN KEY (`comuna_id`) REFERENCES `comunas` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_votacion_region` FOREIGN KEY (`region_id`) REFERENCES `regiones` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=20 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

-- Volcando datos para la tabla sistema.votaciones: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `votaciones` DISABLE KEYS */;
INSERT INTO `votaciones` (`id`, `nombre_apellido`, `alias`, `rut`, `email`, `region_id`, `comuna_id`, `candidato_id`) VALUES
	(19, 'Francisco Valenzuela', 'francisco12', '17.630.430-8', 'francisco@gmail.com', 3, 5, 3);
/*!40000 ALTER TABLE `votaciones` ENABLE KEYS */;

-- Volcando estructura para tabla sistema.votacion_opcion
CREATE TABLE IF NOT EXISTS `votacion_opcion` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `votacion_id` int(11) DEFAULT NULL,
  `opcion_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_opcion_votacion` (`opcion_id`),
  KEY `fk_votacion_opcion` (`votacion_id`),
  CONSTRAINT `fk_opcion_votacion` FOREIGN KEY (`opcion_id`) REFERENCES `opciones` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION,
  CONSTRAINT `fk_votacion_opcion` FOREIGN KEY (`votacion_id`) REFERENCES `votaciones` (`id`) ON DELETE CASCADE ON UPDATE NO ACTION
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb3 COLLATE=utf8mb3_bin;

-- Volcando datos para la tabla sistema.votacion_opcion: ~2 rows (aproximadamente)
/*!40000 ALTER TABLE `votacion_opcion` DISABLE KEYS */;
INSERT INTO `votacion_opcion` (`id`, `votacion_id`, `opcion_id`) VALUES
	(19, 19, 1),
	(20, 19, 2),
	(21, 19, 3),
	(22, 19, 4);
/*!40000 ALTER TABLE `votacion_opcion` ENABLE KEYS */;

/*!40101 SET SQL_MODE=IFNULL(@OLD_SQL_MODE, '') */;
/*!40014 SET FOREIGN_KEY_CHECKS=IFNULL(@OLD_FOREIGN_KEY_CHECKS, 1) */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40111 SET SQL_NOTES=IFNULL(@OLD_SQL_NOTES, 1) */;
