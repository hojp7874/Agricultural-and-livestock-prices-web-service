-- MySQL dump 10.13  Distrib 8.0.27, for Win64 (x86_64)
--
-- Host: localhost    Database: foodcoin
-- ------------------------------------------------------
-- Server version	8.0.27

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
-- Table structure for table `accounts_user`
--

DROP TABLE IF EXISTS `accounts_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_user` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `password` varchar(128) NOT NULL,
  `last_login` datetime(6) DEFAULT NULL,
  `is_superuser` tinyint(1) NOT NULL,
  `username` varchar(150) NOT NULL,
  `first_name` varchar(150) NOT NULL,
  `last_name` varchar(150) NOT NULL,
  `email` varchar(254) NOT NULL,
  `is_staff` tinyint(1) NOT NULL,
  `is_active` tinyint(1) NOT NULL,
  `date_joined` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `username` (`username`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_user`
--

LOCK TABLES `accounts_user` WRITE;
/*!40000 ALTER TABLE `accounts_user` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_user_groups`
--

DROP TABLE IF EXISTS `accounts_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `accounts_user_groups_user_id_group_id_59c0b32f_uniq` (`user_id`,`group_id`),
  KEY `accounts_user_groups_group_id_bd11a704_fk_auth_group_id` (`group_id`),
  CONSTRAINT `accounts_user_groups_group_id_bd11a704_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `accounts_user_groups_user_id_52b62117_fk_accounts_user_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_user_groups`
--

LOCK TABLES `accounts_user_groups` WRITE;
/*!40000 ALTER TABLE `accounts_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `accounts_user_user_permissions`
--

DROP TABLE IF EXISTS `accounts_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `accounts_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `accounts_user_user_permi_user_id_permission_id_2ab516c2_uniq` (`user_id`,`permission_id`),
  KEY `accounts_user_user_p_permission_id_113bb443_fk_auth_perm` (`permission_id`),
  CONSTRAINT `accounts_user_user_p_permission_id_113bb443_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `accounts_user_user_p_user_id_e4f0a161_fk_accounts_` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `accounts_user_user_permissions`
--

LOCK TABLES `accounts_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `accounts_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `accounts_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group`
--

DROP TABLE IF EXISTS `auth_group`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(150) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group`
--

LOCK TABLES `auth_group` WRITE;
/*!40000 ALTER TABLE `auth_group` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_group_permissions`
--

DROP TABLE IF EXISTS `auth_group_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_group_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `group_id` int NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_group_permissions_group_id_permission_id_0cd325b0_uniq` (`group_id`,`permission_id`),
  KEY `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` (`permission_id`),
  CONSTRAINT `auth_group_permissio_permission_id_84c5c92e_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `auth_group_permissions_group_id_b120cbf9_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_group_permissions`
--

LOCK TABLES `auth_group_permissions` WRITE;
/*!40000 ALTER TABLE `auth_group_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `auth_group_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `auth_permission`
--

DROP TABLE IF EXISTS `auth_permission`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `auth_permission` (
  `id` int NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `content_type_id` int NOT NULL,
  `codename` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `auth_permission_content_type_id_codename_01ab375a_uniq` (`content_type_id`,`codename`),
  CONSTRAINT `auth_permission_content_type_id_2f476e4b_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=65 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `auth_permission`
--

LOCK TABLES `auth_permission` WRITE;
/*!40000 ALTER TABLE `auth_permission` DISABLE KEYS */;
INSERT INTO `auth_permission` VALUES (1,'Can add user',1,'add_user'),(2,'Can change user',1,'change_user'),(3,'Can delete user',1,'delete_user'),(4,'Can view user',1,'view_user'),(5,'Can add country',2,'add_country'),(6,'Can change country',2,'change_country'),(7,'Can delete country',2,'delete_country'),(8,'Can view country',2,'view_country'),(9,'Can add food',3,'add_food'),(10,'Can change food',3,'change_food'),(11,'Can delete food',3,'delete_food'),(12,'Can view food',3,'view_food'),(13,'Can add item category',4,'add_itemcategory'),(14,'Can change item category',4,'change_itemcategory'),(15,'Can delete item category',4,'delete_itemcategory'),(16,'Can view item category',4,'view_itemcategory'),(17,'Can add kind',5,'add_kind'),(18,'Can change kind',5,'change_kind'),(19,'Can delete kind',5,'delete_kind'),(20,'Can view kind',5,'view_kind'),(21,'Can add product cls',6,'add_productcls'),(22,'Can change product cls',6,'change_productcls'),(23,'Can delete product cls',6,'delete_productcls'),(24,'Can view product cls',6,'view_productcls'),(25,'Can add product rank',7,'add_productrank'),(26,'Can change product rank',7,'change_productrank'),(27,'Can delete product rank',7,'delete_productrank'),(28,'Can view product rank',7,'view_productrank'),(29,'Can add unit',8,'add_unit'),(30,'Can change unit',8,'change_unit'),(31,'Can delete unit',8,'delete_unit'),(32,'Can view unit',8,'view_unit'),(33,'Can add price',9,'add_price'),(34,'Can change price',9,'change_price'),(35,'Can delete price',9,'delete_price'),(36,'Can view price',9,'view_price'),(37,'Can add food product ranks',10,'add_foodproductranks'),(38,'Can change food product ranks',10,'change_foodproductranks'),(39,'Can delete food product ranks',10,'delete_foodproductranks'),(40,'Can view food product ranks',10,'view_foodproductranks'),(41,'Can add food comment',11,'add_foodcomment'),(42,'Can change food comment',11,'change_foodcomment'),(43,'Can delete food comment',11,'delete_foodcomment'),(44,'Can view food comment',11,'view_foodcomment'),(45,'Can add log entry',12,'add_logentry'),(46,'Can change log entry',12,'change_logentry'),(47,'Can delete log entry',12,'delete_logentry'),(48,'Can view log entry',12,'view_logentry'),(49,'Can add permission',13,'add_permission'),(50,'Can change permission',13,'change_permission'),(51,'Can delete permission',13,'delete_permission'),(52,'Can view permission',13,'view_permission'),(53,'Can add group',14,'add_group'),(54,'Can change group',14,'change_group'),(55,'Can delete group',14,'delete_group'),(56,'Can view group',14,'view_group'),(57,'Can add content type',15,'add_contenttype'),(58,'Can change content type',15,'change_contenttype'),(59,'Can delete content type',15,'delete_contenttype'),(60,'Can view content type',15,'view_contenttype'),(61,'Can add session',16,'add_session'),(62,'Can change session',16,'change_session'),(63,'Can delete session',16,'delete_session'),(64,'Can view session',16,'view_session');
/*!40000 ALTER TABLE `auth_permission` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_admin_log`
--

DROP TABLE IF EXISTS `django_admin_log`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_admin_log` (
  `id` int NOT NULL AUTO_INCREMENT,
  `action_time` datetime(6) NOT NULL,
  `object_id` longtext,
  `object_repr` varchar(200) NOT NULL,
  `action_flag` smallint unsigned NOT NULL,
  `change_message` longtext NOT NULL,
  `content_type_id` int DEFAULT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `django_admin_log_content_type_id_c4bce8eb_fk_django_co` (`content_type_id`),
  KEY `django_admin_log_user_id_c564eba6_fk_accounts_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_accounts_user_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`),
  CONSTRAINT `django_admin_log_chk_1` CHECK ((`action_flag` >= 0))
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_admin_log`
--

LOCK TABLES `django_admin_log` WRITE;
/*!40000 ALTER TABLE `django_admin_log` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_admin_log` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_content_type`
--

DROP TABLE IF EXISTS `django_content_type`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_content_type` (
  `id` int NOT NULL AUTO_INCREMENT,
  `app_label` varchar(100) NOT NULL,
  `model` varchar(100) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `django_content_type_app_label_model_76bd3d3b_uniq` (`app_label`,`model`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_content_type`
--

LOCK TABLES `django_content_type` WRITE;
/*!40000 ALTER TABLE `django_content_type` DISABLE KEYS */;
INSERT INTO `django_content_type` VALUES (1,'accounts','user'),(12,'admin','logentry'),(14,'auth','group'),(13,'auth','permission'),(15,'contenttypes','contenttype'),(2,'prices','country'),(3,'prices','food'),(11,'prices','foodcomment'),(10,'prices','foodproductranks'),(4,'prices','itemcategory'),(5,'prices','kind'),(9,'prices','price'),(6,'prices','productcls'),(7,'prices','productrank'),(8,'prices','unit'),(16,'sessions','session');
/*!40000 ALTER TABLE `django_content_type` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_migrations`
--

DROP TABLE IF EXISTS `django_migrations`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_migrations` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `app` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `applied` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=23 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2021-11-22 11:06:25.690785'),(2,'contenttypes','0002_remove_content_type_name','2021-11-22 11:06:26.010324'),(3,'auth','0001_initial','2021-11-22 11:06:26.544362'),(4,'auth','0002_alter_permission_name_max_length','2021-11-22 11:06:26.630600'),(5,'auth','0003_alter_user_email_max_length','2021-11-22 11:06:26.638601'),(6,'auth','0004_alter_user_username_opts','2021-11-22 11:06:26.650603'),(7,'auth','0005_alter_user_last_login_null','2021-11-22 11:06:26.662600'),(8,'auth','0006_require_contenttypes_0002','2021-11-22 11:06:26.673603'),(9,'auth','0007_alter_validators_add_error_messages','2021-11-22 11:06:26.686603'),(10,'auth','0008_alter_user_username_max_length','2021-11-22 11:06:26.707600'),(11,'auth','0009_alter_user_last_name_max_length','2021-11-22 11:06:26.725600'),(12,'auth','0010_alter_group_name_max_length','2021-11-22 11:06:26.920529'),(13,'auth','0011_update_proxy_permissions','2021-11-22 11:06:26.963665'),(14,'auth','0012_alter_user_first_name_max_length','2021-11-22 11:06:26.978773'),(15,'accounts','0001_initial','2021-11-22 11:06:27.888736'),(16,'admin','0001_initial','2021-11-22 11:06:28.127147'),(17,'admin','0002_logentry_remove_auto_add','2021-11-22 11:06:28.138145'),(18,'admin','0003_logentry_add_action_flag_choices','2021-11-22 11:06:28.149145'),(19,'prices','0001_initial','2021-11-22 11:06:31.613261'),(20,'sessions','0001_initial','2021-11-22 11:06:31.681983'),(21,'prices','0002_auto_20211122_2015','2021-11-22 11:19:43.189546'),(22,'prices','0003_auto_20211122_2054','2021-11-22 12:00:52.243071');
/*!40000 ALTER TABLE `django_migrations` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `django_session`
--

DROP TABLE IF EXISTS `django_session`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `django_session` (
  `session_key` varchar(40) NOT NULL,
  `session_data` longtext NOT NULL,
  `expire_date` datetime(6) NOT NULL,
  PRIMARY KEY (`session_key`),
  KEY `django_session_expire_date_a5c62663` (`expire_date`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_session`
--

LOCK TABLES `django_session` WRITE;
/*!40000 ALTER TABLE `django_session` DISABLE KEYS */;
/*!40000 ALTER TABLE `django_session` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prices_country`
--

DROP TABLE IF EXISTS `prices_country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prices_country` (
  `country_code` int NOT NULL,
  `country` varchar(16) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`country_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prices_country`
--

LOCK TABLES `prices_country` WRITE;
/*!40000 ALTER TABLE `prices_country` DISABLE KEYS */;
INSERT INTO `prices_country` VALUES (1,'충주','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(2,'목포','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(3,'마산','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(4,'군산','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(1101,'서울','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(2100,'부산','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(2200,'대구','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(2300,'인천','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(2401,'광주','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(2501,'대전','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(2601,'울산','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(2701,'세종','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(3111,'수원','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(3113,'의정부','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(3145,'용인','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(3211,'춘천','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(3214,'강릉','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(3311,'청주','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(3511,'전주','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(3613,'순천','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(3711,'포항','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(3714,'안동','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(3814,'창원','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(3911,'제주','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000');
/*!40000 ALTER TABLE `prices_country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prices_food`
--

DROP TABLE IF EXISTS `prices_food`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prices_food` (
  `item_code` int NOT NULL,
  `food` varchar(16) NOT NULL,
  `image` varchar(255) NOT NULL,
  `item_category_id` int NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`item_code`),
  UNIQUE KEY `food` (`food`),
  KEY `prices_food_item_category_id_52be936d_fk_prices_it` (`item_category_id`),
  CONSTRAINT `prices_food_item_category_id_52be936d_fk_prices_it` FOREIGN KEY (`item_category_id`) REFERENCES `prices_itemcategory` (`item_category_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prices_food`
--

LOCK TABLES `prices_food` WRITE;
/*!40000 ALTER TABLE `prices_food` DISABLE KEYS */;
INSERT INTO `prices_food` VALUES (111,'쌀','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSK2a-hYwzYVQmWV2e0QuLFqrudTKoKS2SYWxk_J8NnZ8cIX5-HyUuR0Migkz8&s',100,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(112,'찹쌀','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRshL5PF-58eWoiylKxA4axceKREyjCaUQ0ANUyw39netVTwwFVGTnMr3HpiJI&s',100,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(113,'혼합곡','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLdhDl6WSa2c7bcYbbn8RsjTRbwmCBOy5WdqLNzaW3WP1sFRrE-3YOSENv-f4&s',100,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(141,'콩','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjqlmf3eabmTktmCUk8cpNKzhccCSPugCirOmJ838guFJ4BInuTfS17VvrkQ&s',100,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(142,'팥','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUlevOPaXL9AGI_w57qI0WR0giF2PLbYnFZAr572yxJhzm-6Dt5aG07xhOJCw&s',100,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(143,'녹두','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhs7JG60TaYJJJDIn0lBcjpwli4aRW8dIuoaOVxMEgrGLHyRw4vH4SoDHWGQ&s',100,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(144,'메밀','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTiUFhiKoa0aviAnk7WAEi_6iRlZdvqISacAfEF4eC-ivzjlHTggt6WiS0cMw&s',100,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(151,'고구마','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYMDP2HrlQV5mOrin6VdzyLb5AJFE-YoP7qvxBdqAxNjXKGLjExZ9ramhMig&s',100,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(152,'감자','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROB7Rhqq-cgT6hGyb68cbebPH-NYCLhLCvMNSF-bCSl0ze8kXWh5p3UhoWAOw&s',100,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(161,'귀리','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREzs3uUwfagS5cUg3AvCm3cfP0AtIgfuBqYHh1jrZphxQ3sp8pF3vxddEyYw&s',100,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(162,'보리','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQgTuOS9b_Rz_3cx2LVccFlhBgEadkpvE8rl4GoVJMFTDp0eQDy7NqPQKX4QQ&s',100,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(163,'수수','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbqu4_nprS9MXQKdAc4Arp7UIL7FQZbxQJ0JTkUsh03XCUXESMzSAbKSucIm0&s',100,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(164,'율무','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuC6ZhMG5EylMB9I1wov0ZYwIcRJ6uLf9dOnrGzHFIE0sCB-nJvDa3zZXyZZ0&s',100,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(211,'배추','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTuVqPTIRHx9KYQCjOO90eWPNjsmcBFTAwpyhS3xi_cuYAKobwCxlX5gDXMEw&s',200,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(212,'양배추','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7ZVUokxVELnsMuVRVz-2SWUzIm8EEgIjrKZrMU0Yjvut2qbWuStqTWSv1og&s',200,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(213,'시금치','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmgRzEzBVf8rllFGR6bnvmPkWCIYsPPW2QjiDU_XBh8hx-PhYv4fcxfwFn9pg&s',200,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(214,'상추','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKun0L7Jg6sWPlgIkIsJqPo3mvLfr2DfgWTs0fumGxkVV9B2bI8HUFauzV0A&s',200,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(215,'얼갈이배추','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_LS4TjjJXzV7gSRY0_b4X-_biP1aZ1B-yo0T9vrtb0DuBiBTB889kji7gNg&s',200,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(216,'갓','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRVqzSBBHm286r1CcMLifxSSp01MrHh1P34mM383fOWSBfM_8FrKgs0sCjPRWw&s',200,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(221,'수박','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkzk6YFTqOVbn98qRnoBJy-wnOiIPBVF-NXkqptImm_6zWShvh5lmaEB_javA&s',200,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(222,'참외','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyIFehNG9o5OTUxkPKDIlhEkNkZhoZBxqdlNRTwGFAG1H2qPXO9Ci0p1hjvA&s',200,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(223,'오이','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCGuPHVZfzwHas81o3ti7TJuV-3Gf190ZBOVQOeQIq9w6YlfXi1VAzxDw6RQ&s',200,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(224,'호박','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSNi3TTkfi41teWIQdJnZtFGykAABZaR1aGIcP--ceEuO-RyAoAP-wmJCvvQ&s',200,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(225,'토마토','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqToWkKh0X5LNMBj4jDdi2kwiKyBY_X8D7a-6H2nMDbIgUo7aBNiezW6ZXJ6M&s',200,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(226,'딸기','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSC2b3VwGx5FjtMwZEwK3ysYCROXtfJuwlgydtFg3sXoHcl-MPT82E2gI4hkbQ&s',200,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(231,'무','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3zhHPQ28irZNDYm6MjGPvH9yeUEtUgVEZx6NiVUjVTveVkQu9YfR6ekGMUEM&s',200,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(232,'당근','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyOBaBe7KA8tilHePx4LghqYJBKF6cBfej3na2inYW5P0W-GFeHsn_fHweTpg&s',200,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(233,'열무','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfLKpO4g_x1fDZLIuzLtv5WLuPWBWESVFhWPtlbkHXQihnYaifTNxOS_SjJw&s',200,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(241,'건고추','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-N6qAVUD7cbYsXmDgbf4rS5ZKBEN6_UYFDJ8Vx8wFYwrhUBBINfeEsWXa65g&s',200,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(242,'풋고추','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3vpwFjuJOJYRbmAZNCXzjbBESVxSzXp3GZmuUHM4SF6m9VmpecmIHx1aXHw&s',200,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(243,'붉은고추','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTWxEwQgbIJrR-mx-RjosYCuBzisha4GxaIXw-m9wvPwICaxv4CdN4jXU28Q&s',200,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(244,'피마늘','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRA-MGWE_5iQG4zBIBJAzGT2tUz8WchlEwXfFfkBYBfNyp5hHj7bwA8bAagYQ&s',200,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(245,'양파','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQY59bkTH-NUMgOkyh9lQN1oPNWkWKW4ZhWEGh9MdDbN61FhZrWesxRHO7WAbw&s',200,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(246,'파','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSiV7UxRr_eNKWXZn6wwLTPqEDJsF7cgVM2tmWAG9QtqM6MvUVtRoi90OPS4io&s',200,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(247,'생강','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT9Rwx16AMUmJDAjuvTBZ_3T7gHMJ0IjTc5v6WZC7heN69Q72uy_ayUUDRgOA&s',200,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(248,'고춧가루','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTNHmnB6gmS3Jm4FrLKOkU5TL0iH5xlae4Bow7ZUuDohsFXYRMsNKLOnMyDaik&s',200,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(251,'가지','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVRhupMiu8yJk48eYODUsw_tVcrigXgWD9Wt1bUfJ5a3I5FYKfjeHPwgSmRw&s',200,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(252,'미나리','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7qGNGwx0TQfbA_PHacf9Ejo9ZynPBF0XM3vyVJTqHa1sIHfUxAvl8utMa6Y4&s',200,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(253,'깻잎','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_xWTalLogTTEzlnsbsx8EkF2sMlGz2X8xG1NYrQ2z-n9OeTGah-dFikLscw&s',200,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(254,'부추','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0_dFYQ8n3FFCNKnhb_3cBG0BU_pGmhETvzM5WnmbfgKkEEk5DqaxdiNFN22E&s',200,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(255,'피망','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAyhQe1YDJ7_cNDUlVhvWcCvZyOKJ7UhIIFNLHFAcwTHASFfr0L99lfgDZZzY&s',200,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(256,'파프리카','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSsh9V3BB072YlHhXujTpyBhqpUKA0dGK1nvpY_-V-z6lYZMM_mDEYdngthTQ&s',200,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(257,'멜론','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHSlNLbCOb6U_9G-onh2QnlIC-nHB1SEFYI8loa1bf9us01VIlBO9D3Do84II&s',200,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(258,'깐마늘(국산)','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTm56uwmsFWQoXkBmAsxUZpPLSP7q5BRFfu77HtpL9GRlgsZvAEMo3e1SX6QQ&s',200,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(259,'깐마늘(수입)','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9000zxv1dp4qdZ1_0zWTNzHEmtDXjfjgxKw914VMLmDIqBc7sbaqInRlvw8g&s',200,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(261,'브로콜리','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7wrkes4fOcsvXdCeBWLynj82edKPHLhBP2d83Pql4dCHgtIMaOLC7XR_4KVE&s',200,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(262,'양상추','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQODIpaqcFbvdIWr0gwZb5zmOQ8DJmlO8rKQSSodIETR0XBfIPGIVFoiB-jeQ&s',200,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(263,'청경채','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSsMuHVQgum1wnFz0-oNcfGK8QpBcyBRi4KXc9r8xylM3yV0wL7NGFeY21VnA&s',200,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(264,'케일','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_MYdFZRV553QBWWT1lh7iOkZabKjy35Gk43RK4H97InpZGjqyjAZo9UU5rVo&s',200,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(265,'콩나물','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7-2ef0fnbGg6Pq8FrfyZxWfk-4pKLShBMkGJp3PdXjyARY3XLAlCLFSIOUw&s',200,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(312,'참깨','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMC9rrw4_uEMpxx_-bbcbnPElEX2uT9cEEYoM2DeHaNRAZUocQ8_W6zKfeUy0&s',300,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(313,'들깨','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCbyiSpqnma8ib9wTuSrm8xLTMni_sTGo9JZGs_BlBfzuZ2hiPAyqvAd2G-qM&s',300,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(314,'땅콩','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXpKc--_PAseMUPajXPEacxwqf6gPV7d_lLNMkv4roOB6P5WL4mxaJmUQ090w&s',300,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(315,'느타리버섯','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRf77Tuy6dRuAD4CdcSmHf6rOXi-DgfGlO4dFYnA3VvHbB09IVJukCWq6EZmK8&s',300,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(316,'팽이버섯','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyVdxI_Y1XBcvBZJqzfptx7e0gHb9Ru3yy_GvJtgvpZ_5HKm_VjZiz4G-7mwU&s',300,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(317,'새송이버섯','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbyQjPqVkaghOJBTzWP1an4_3m5dZt6VeLPiW0LwuD8_Q3692NgBjKC9sSPg&s',300,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(318,'호두','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7wJbtZjz1G_oKBmmZUgYSIHrYcTspj-Xew0S6_14U1a9ilxaZjbIq0JUm9Ak&s',300,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(319,'아몬드','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZHcxo62hPVTljvvr3cUCS93SqRg7aw_E7YCZ0XtCxJtxnyQRaUOO_8h0G3wY&s',300,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(321,'양송이버섯','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkBnW1F_xWi_g-ggUnGPkUuM3dMgYkhp7LBRsEmokwr2D7WSV4Ei_hduiK4BA&s',300,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(322,'표고버섯','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzK-pvEbFD3aBtizQYuARReDPzN0Mw8pfCehezoMhUC6TFF5FAacyy3n5ia1Q&s',300,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(411,'사과','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6t4KGDBDh-yPbH5XkLXxcGwSUDRgEs_T-yMhKLsRcKHveLo_9I_3_bS6BuQ&s',400,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(412,'배','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbJHH7_-LhGvQsW7o64sicsG6uypu7FxR3us8LhznkgSZ3j7_-OGDYDQlbS-w&s',400,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(413,'복숭아','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS088rHnUaiGpxyHIGoACICxJCQA91OoSZBst02QqG7rzFsk7Q203bEWGNWC1Q&s',400,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(414,'포도','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-Bg0BBBayJrm2ZegiLavgP5xA5K4Uz5O9_hpXn_2SVQx8Mx7buj0lX2jBAQ&s',400,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(415,'감귤','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGQqbP2VbhZjkRf0fBxZoaQzBTorjj_acRa1_ikCOf7ncleX2q1VzBRa-ZT5o&s',400,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(416,'단감','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAB10SL6ud5hnzcf4ZtZOyB1plOh0g6d8rd0omt4PUXmddePxM1sBWC28jP1M&s',400,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(418,'바나나','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfj3R4zilpzs54SMN9clMdE3w2JTk4_8wj6J6-_H-OdVpvAZdvm41Mou5RtA&s',400,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(419,'참다래','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLDTsRIzgi65CxewGA9qU_rlrh5Dc1oxhDTMJP792CKY-jPZtTA4ySxrQjdA&s',400,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(420,'파인애플','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfFMWjxPE7tbHyTHqiHtpfT_jikHYUWm0tpgA8dFZFfX9aXsXbDorW64hF9Q&s',400,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(421,'오렌지','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQqWae1g95YpRYiJtqY5OW3DLq8L8BftVA7YMpbng9-fZEYNNX2ntfDGTqwlhw&s',400,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(422,'방울토마토','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpLDcfc0E7r7ce-itDfD1GdelY-pD2MMIXlMu-JZXvrX1PbmZ4cQtIouR6s98&s',400,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(423,'자몽','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxgz_jKvXlQPPgVUqANuP2ZXQx01qujHkXya-D-BEqpDOsHGfyjErjeqalpA&s',400,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(424,'레몬','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSP1wI0AZYcNp1hGTntJ6FwFQWmil_tvwclSN8Wi5YLOqqAFBAtG13Wo26c-Q&s',400,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(425,'체리','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbEyumT4w0kXwrh3mxy1oNRBtyVYhvyOYrx24adVnc3aeqzZlhLdvtWNhzew&s',400,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(426,'건포도','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYY0SvYfKaYkmVb6tpxq7702OPm7MFbgL7-TIgtIQ9vQQgTpwWIvbg7L8bKdw&s',400,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(427,'건블루베리','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkC64Rg_Ya3cyWXihEGCSN15V626VFq2pPne3B---yqWyVR7A76bcLAngrmw&s',400,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(428,'망고','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvzmuDpfP8lqEor5uVmRVhnMQm0b5VebhcFNCjnyVXJBhcjaaU1-yO46OvFg&s',400,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(512,'쇠고기','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8gbkSnaGlzEv35oPp0zmgcIwytxgRHv5xUmeXTXEfu3tM4YNC68NYNuvjTg&s',500,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(514,'돼지고기','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZ85Rrz5OLWgAB03DVKlCXqeGPTlIAd-zju32S9ZvHvoGZ7HrfkFYmwMA2qVc&s',500,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(515,'닭고기','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxRlKDuoQ0d95zGIJPy-W3CTksj28gW9-a9RwLIuCobHauhGWOAOMonTh8rAM&s',500,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(516,'계란','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQasHl4S8MtdIcbHFnRs5-TvgdUmT7mV8vXnnV7J4oK6q6MyZbi0Lo_3aa1-A&s',500,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(535,'우유','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKljrcsxqiwLWdE1a0TIm5piZirEw4UyWKP1Zx2B28ly2VtwEAhLyRI-gNpw&s',500,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(611,'고등어','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQL4rQ-id92T0UCeKYUG0uMTPzJH8YJ-Yg80M2rwAQZrVuQLYwT6a5Uvm7A6w&s',600,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(612,'꽁치','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbtGFPu5aqypHoO71GWUFWlidZsIxCItbuz01QqUvVOJ2cW8oJMc3I5JjaQqs&s',600,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(613,'갈치','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUQxB-hNTvfNz8RvioZE7ZUf7wuLLZ6h1pMO0GuS1DkRgMctpz28bM5nUZ_g&s',600,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(615,'명태','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5GTsq8fdnhuDvbFOiY9ZBg9cBrLrT6P_J0yD6PfqlUuKGXTRP1M0cEpCr_w&s',600,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(619,'물오징어','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzn4lsKeGHVRa65aj1d_w_jzB6wu9uEv0tac2yInxj8Oedve553OliWUDrUw&s',600,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(638,'건멸치','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1Dre_qL2PTvE0uAWx5DKlTOHtEqKJGC7JUaeOMYBpHoSmMef1ZP7zhYELZIk&s',600,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(639,'북어','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1hYrsKBCtP5JxcI9pBiZOdsNpReJBlZIoyKBQozhWTVd2EXwnM_kn9HQBNw&s',600,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(640,'건오징어','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpItRMpFe9A2oBz1mZybKHDOCB2a-C1qemMQkSNncaxau_zE4EBX2tzpT8Mw&s',600,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(641,'김','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQGtmZyyVG17C6f3C9n1NSIHHlFUah5jEMRFaFK5BLQK41LFVZsdzA9MaYlQ&s',600,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(642,'건미역','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0fG23DlE_d59C63qrkD-7Gfexhoc7lWMzL66BteX5jW3C-wzTikMD2pwoJRI&s',600,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(644,'굴','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQATdjY3jCSY7bxhgApXrXlRG9ejulSJgMozjaxw3F4UxP8NJ7U0y4g1NwlFzQ&s',600,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(649,'수입조기','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQc1FCG7vk0eWBRCB1WPuiERvwmnZpI8JF7qrAETCRvF_33b-uS8cl7aqex6zA&s',600,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(650,'새우젓','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQmmkYYF03hw528mLEtwAWvpv7Gwygqie9uKrp_7nTJm8qaJ8UnufbihmsDXA&s',600,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(651,'멸치액젓','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQeGiTgoYU5QWb9dduEoN3xyoTPEOKLhgQDNCuOc2k85ImNue7geToNeVQ9iZE&s',600,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(652,'굵은소금','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpoBPzry6o6JyPJpfGdDZX39z4yFI3Pzi7iip1EvdIQ6WuEmPb_BtlUAjBOxc&s',600,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(653,'전복','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2VxwzbHLVIt94tUBhm6y_67MwBKfQXJ0KcYlXUKfhqrePbxW7K-R5JGMaSA&s',600,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(654,'새우','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT78bVLov3KXoF2V1H29TiiHXAVX25BLN9FJUwt9cuX2CPbjRhQcj1PWWegdA&s',600,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000');
/*!40000 ALTER TABLE `prices_food` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prices_food_like_users`
--

DROP TABLE IF EXISTS `prices_food_like_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prices_food_like_users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `food_id` int NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `prices_food_like_users_food_id_user_id_3e1d0741_uniq` (`food_id`,`user_id`),
  KEY `prices_food_like_users_user_id_8c7b1f19_fk_accounts_user_id` (`user_id`),
  CONSTRAINT `prices_food_like_users_food_id_cba7dafa_fk_prices_food_item_code` FOREIGN KEY (`food_id`) REFERENCES `prices_food` (`item_code`),
  CONSTRAINT `prices_food_like_users_user_id_8c7b1f19_fk_accounts_user_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prices_food_like_users`
--

LOCK TABLES `prices_food_like_users` WRITE;
/*!40000 ALTER TABLE `prices_food_like_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `prices_food_like_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prices_foodcomment`
--

DROP TABLE IF EXISTS `prices_foodcomment`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prices_foodcomment` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `content` varchar(255) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  `food_id` int NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `prices_foodcomment_food_id_e1a40366_fk_prices_food_item_code` (`food_id`),
  KEY `prices_foodcomment_user_id_a735c642_fk_accounts_user_id` (`user_id`),
  CONSTRAINT `prices_foodcomment_food_id_e1a40366_fk_prices_food_item_code` FOREIGN KEY (`food_id`) REFERENCES `prices_food` (`item_code`),
  CONSTRAINT `prices_foodcomment_user_id_a735c642_fk_accounts_user_id` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prices_foodcomment`
--

LOCK TABLES `prices_foodcomment` WRITE;
/*!40000 ALTER TABLE `prices_foodcomment` DISABLE KEYS */;
/*!40000 ALTER TABLE `prices_foodcomment` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prices_foodcomment_like_users`
--

DROP TABLE IF EXISTS `prices_foodcomment_like_users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prices_foodcomment_like_users` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `foodcomment_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `prices_foodcomment_like__foodcomment_id_user_id_2661a8a6_uniq` (`foodcomment_id`,`user_id`),
  KEY `prices_foodcomment_l_user_id_3aa45bd6_fk_accounts_` (`user_id`),
  CONSTRAINT `prices_foodcomment_l_foodcomment_id_dcd5e87a_fk_prices_fo` FOREIGN KEY (`foodcomment_id`) REFERENCES `prices_foodcomment` (`id`),
  CONSTRAINT `prices_foodcomment_l_user_id_3aa45bd6_fk_accounts_` FOREIGN KEY (`user_id`) REFERENCES `accounts_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prices_foodcomment_like_users`
--

LOCK TABLES `prices_foodcomment_like_users` WRITE;
/*!40000 ALTER TABLE `prices_foodcomment_like_users` DISABLE KEYS */;
/*!40000 ALTER TABLE `prices_foodcomment_like_users` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prices_foodproductranks`
--

DROP TABLE IF EXISTS `prices_foodproductranks`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prices_foodproductranks` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `food_id` int NOT NULL,
  `kind_id` bigint NOT NULL,
  `product_rank_id` varchar(2) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `prices_foodproductra_food_id_50eb84a8_fk_prices_fo` (`food_id`),
  KEY `prices_foodproductranks_kind_id_ba6493b1_fk_prices_kind_id` (`kind_id`),
  KEY `prices_foodproductra_product_rank_id_86a7b64f_fk_prices_pr` (`product_rank_id`),
  CONSTRAINT `prices_foodproductra_food_id_50eb84a8_fk_prices_fo` FOREIGN KEY (`food_id`) REFERENCES `prices_food` (`item_code`),
  CONSTRAINT `prices_foodproductra_product_rank_id_86a7b64f_fk_prices_pr` FOREIGN KEY (`product_rank_id`) REFERENCES `prices_productrank` (`product_rank_code`),
  CONSTRAINT `prices_foodproductranks_kind_id_ba6493b1_fk_prices_kind_id` FOREIGN KEY (`kind_id`) REFERENCES `prices_kind` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=450 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prices_foodproductranks`
--

LOCK TABLES `prices_foodproductranks` WRITE;
/*!40000 ALTER TABLE `prices_foodproductranks` DISABLE KEYS */;
INSERT INTO `prices_foodproductranks` VALUES (1,111,1,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(2,111,1,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(3,111,1,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(4,111,1,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(5,111,2,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(6,111,2,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(7,111,3,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(8,111,3,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(9,111,4,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(10,111,4,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(11,112,5,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(12,112,5,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(13,112,5,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(14,112,5,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(15,113,6,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(16,113,6,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(17,141,7,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(18,141,7,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(19,141,8,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(20,141,8,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(21,141,9,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(22,142,10,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(23,142,10,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(24,142,11,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(25,143,12,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(26,143,12,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(27,143,13,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(28,144,14,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(29,151,15,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(30,151,15,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(31,151,15,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(32,151,15,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(33,152,16,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(34,152,16,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(35,152,16,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(36,152,16,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(37,152,17,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(38,152,17,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(39,161,18,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(40,161,18,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(41,162,19,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(42,162,19,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(43,163,20,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(44,163,20,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(45,164,21,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(46,164,21,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(47,211,22,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(48,211,22,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(49,211,22,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(50,211,22,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(51,211,23,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(52,211,23,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(53,211,24,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(54,211,24,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(55,211,25,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(56,211,25,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(57,212,26,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(58,212,26,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(59,212,26,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(60,212,26,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(61,213,27,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(62,213,27,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(63,213,27,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(64,213,27,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(65,214,28,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(66,214,28,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(67,214,28,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(68,214,28,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(69,214,29,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(70,214,29,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(71,214,29,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(72,214,29,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(73,215,30,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(74,215,30,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(75,216,31,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(76,221,32,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(77,221,32,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(78,222,33,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(79,222,33,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(80,222,33,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(81,222,33,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(82,223,34,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(83,223,34,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(84,223,34,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(85,223,34,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(86,223,35,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(87,223,35,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(88,223,35,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(89,223,35,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(90,223,36,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(91,223,36,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(92,223,36,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(93,223,36,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(94,224,37,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(95,224,37,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(96,224,37,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(97,224,37,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(98,224,38,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(99,224,38,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(100,224,39,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(101,224,39,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(102,225,40,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(103,225,40,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(104,225,40,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(105,225,40,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(106,226,41,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(107,226,41,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(108,226,41,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(109,226,41,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(110,231,42,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(111,231,42,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(112,231,42,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(113,231,42,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(114,231,43,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(115,231,43,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(116,231,44,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(117,231,44,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(118,231,45,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(119,231,45,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(120,232,46,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(121,232,46,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(122,232,46,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(123,232,46,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(124,232,47,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(125,232,47,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(126,232,47,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(127,232,47,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(128,232,48,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(129,232,48,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(130,232,48,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(131,232,48,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(132,232,49,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(133,233,50,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(134,233,50,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(135,241,51,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(136,241,51,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(137,241,52,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(138,241,52,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(139,241,53,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(140,241,53,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(141,241,54,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(142,241,54,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(143,241,55,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(144,242,56,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(145,242,56,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(146,242,56,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(147,242,56,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(148,242,57,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(149,242,57,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(150,242,57,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(151,242,57,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(152,242,58,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(153,242,58,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(154,242,58,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(155,242,58,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(156,242,59,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(157,242,59,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(158,243,60,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(159,243,60,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(160,244,61,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(161,244,61,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(162,244,62,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(163,244,62,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(164,244,63,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(165,244,63,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(166,244,64,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(167,244,64,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(168,244,65,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(169,244,65,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(170,244,66,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(171,244,66,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(172,244,67,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(173,244,67,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(174,244,68,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(175,244,68,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(176,244,69,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(177,244,69,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(178,244,70,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(179,244,70,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(180,245,71,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(181,245,71,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(182,245,71,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(183,245,71,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(184,245,72,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(185,245,72,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(186,245,72,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(187,245,72,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(188,245,73,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(189,246,74,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(190,246,74,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(191,246,74,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(192,246,74,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(193,246,75,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(194,246,75,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(195,246,75,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(196,246,75,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(197,247,76,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(198,247,76,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(199,247,77,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(200,248,78,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(201,248,79,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(202,251,80,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(203,251,80,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(204,251,80,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(205,251,80,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(206,252,81,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(207,252,81,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(208,252,81,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(209,252,81,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(210,253,82,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(211,253,82,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(212,253,82,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(213,253,82,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(214,254,83,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(215,254,83,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(216,254,83,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(217,254,83,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(218,255,84,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(219,255,84,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(220,255,84,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(221,255,84,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(222,256,85,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(223,256,85,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(224,256,85,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(225,256,85,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(226,257,86,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(227,257,86,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(228,258,87,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(229,258,87,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(230,258,87,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(231,258,87,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(232,258,88,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(233,258,88,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(234,258,89,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(235,258,89,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(236,258,90,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(237,258,90,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(238,258,91,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(239,258,91,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(240,259,92,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(241,259,93,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(242,259,93,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(243,261,94,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(244,261,94,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(245,262,95,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(246,262,95,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(247,263,96,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(248,263,96,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(249,264,97,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(250,264,97,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(251,265,98,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(252,265,98,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(253,422,99,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(254,422,99,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(255,422,99,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(256,422,99,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(257,422,100,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(258,422,100,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(259,312,101,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(260,312,101,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(261,312,102,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(262,312,103,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(263,313,104,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(264,313,104,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(265,313,105,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(266,314,106,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(267,314,106,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(268,314,107,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(269,315,108,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(270,315,108,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(271,315,109,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(272,315,109,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(273,316,110,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(274,316,110,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(275,316,110,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(276,316,110,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(277,317,111,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(278,317,111,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(279,317,111,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(280,317,111,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(281,318,112,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(282,319,113,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(283,321,114,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(284,321,114,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(285,322,115,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(286,322,115,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(287,411,116,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(288,411,116,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(289,411,117,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(290,411,117,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(291,411,117,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(292,411,117,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(293,411,118,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(294,411,118,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(295,411,118,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(296,411,118,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(297,411,119,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(298,411,119,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(299,412,120,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(300,412,120,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(301,412,120,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(302,412,120,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(303,412,121,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(304,412,121,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(305,412,122,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(306,412,122,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(307,412,123,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(308,412,123,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(309,413,124,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(310,413,124,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(311,413,125,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(312,413,125,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(313,413,126,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(314,413,126,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(315,414,127,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(316,414,127,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(317,414,127,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(318,414,127,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(319,414,128,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(320,414,128,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(321,414,129,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(322,414,129,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(323,414,130,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(324,414,130,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(325,414,131,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(326,414,131,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(327,414,132,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(328,414,132,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(329,414,133,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(330,414,133,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(331,414,134,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(332,414,134,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(333,414,135,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(334,414,135,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(335,414,136,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(336,414,136,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(337,415,137,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(338,415,137,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(339,415,137,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(340,415,137,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(341,415,138,'16','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(342,415,138,'13','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(343,415,138,'14','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(344,415,138,'15','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(345,415,139,'16','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(346,415,139,'13','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(347,415,139,'14','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(348,415,139,'15','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(349,416,140,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(350,416,140,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(351,416,140,'08','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(352,416,140,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(353,418,141,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(354,418,141,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(355,419,142,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(356,419,142,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(357,419,143,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(358,419,143,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(359,420,144,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(360,420,144,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(361,421,145,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(362,421,145,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(363,421,146,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(364,421,146,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(365,421,147,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(366,421,147,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(367,421,148,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(368,421,148,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(369,421,149,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(370,421,149,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(371,423,150,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(372,423,150,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(373,424,151,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(374,424,151,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(375,425,152,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(376,425,152,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(377,426,153,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(378,427,154,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(379,428,155,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(380,428,155,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(381,512,156,'17','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(382,512,156,'01','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(383,512,156,'03','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(384,512,157,'17','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(385,512,157,'01','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(386,512,157,'03','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(387,512,158,'01','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(388,512,158,'03','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(389,512,159,'17','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(390,512,159,'01','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(391,512,160,'17','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(392,512,160,'01','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(393,512,161,'17','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(394,512,161,'01','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(395,512,161,'03','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(396,512,162,'10','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(397,512,162,'11','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(398,512,163,'10','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(399,512,163,'11','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(400,512,164,'10','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(401,512,164,'11','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(402,512,165,'11','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(403,512,166,'10','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(404,512,166,'11','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(405,512,167,'10','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(406,512,167,'11','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(407,512,168,'10','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(408,512,168,'11','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(409,512,169,'10','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(410,512,169,'11','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(411,514,170,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(412,514,171,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(413,514,172,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(414,514,173,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(415,514,174,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(416,515,175,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(417,515,175,'12','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(418,515,175,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(419,516,176,'07','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(420,516,176,'12','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(421,516,176,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(422,516,177,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(423,535,178,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(424,611,179,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(425,611,180,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(426,611,181,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(427,611,182,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(428,612,183,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(429,613,184,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(430,613,185,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(431,615,186,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(432,615,187,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(433,619,188,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(434,619,189,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(435,638,190,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(436,639,191,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(437,639,192,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(438,640,193,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(439,641,194,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(440,641,195,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(441,642,196,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(442,644,197,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(443,649,198,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(444,649,199,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(445,650,200,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(446,651,201,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(447,652,202,'04','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(448,653,203,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(449,654,204,'05','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000');
/*!40000 ALTER TABLE `prices_foodproductranks` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prices_itemcategory`
--

DROP TABLE IF EXISTS `prices_itemcategory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prices_itemcategory` (
  `item_category_code` int NOT NULL,
  `item_category` varchar(16) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`item_category_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prices_itemcategory`
--

LOCK TABLES `prices_itemcategory` WRITE;
/*!40000 ALTER TABLE `prices_itemcategory` DISABLE KEYS */;
INSERT INTO `prices_itemcategory` VALUES (100,'식량작물','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(200,'채소류','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(300,'특용작물','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(400,'과일류','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(500,'축산물','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(600,'수산물','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000');
/*!40000 ALTER TABLE `prices_itemcategory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prices_kind`
--

DROP TABLE IF EXISTS `prices_kind`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prices_kind` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `kind_code` varchar(2) NOT NULL,
  `kind` varchar(16) NOT NULL,
  `food_id` int NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `prices_kind_food_id_19fb6556_fk_prices_food_item_code` (`food_id`),
  CONSTRAINT `prices_kind_food_id_19fb6556_fk_prices_food_item_code` FOREIGN KEY (`food_id`) REFERENCES `prices_food` (`item_code`)
) ENGINE=InnoDB AUTO_INCREMENT=205 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prices_kind`
--

LOCK TABLES `prices_kind` WRITE;
/*!40000 ALTER TABLE `prices_kind` DISABLE KEYS */;
INSERT INTO `prices_kind` VALUES (1,'01','일반계',111,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(2,'02','백미',111,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(3,'03','현미',111,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(4,'05','햇일반계',111,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(5,'01','일반계',112,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(6,'00','혼합곡',113,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(7,'01','흰 콩(국산)',141,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(8,'02','콩나물콩',141,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(9,'03','흰 콩(수입)',141,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(10,'00','붉은 팥(국산)',142,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(11,'01','붉은 팥(수입)',142,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(12,'00','국산',143,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(13,'01','수입',143,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(14,'01','메밀(수입)',144,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(15,'00','밤',151,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(16,'01','수미',152,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(17,'02','대지마',152,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(18,'01','귀리',161,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(19,'01','보리',162,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(20,'01','수수',163,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(21,'01','율무',164,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(22,'01','봄',211,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(23,'02','고랭지',211,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(24,'03','가을',211,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(25,'06','월동',211,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(26,'00','양배추',212,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(27,'00','시금치',213,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(28,'01','적',214,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(29,'02','청',214,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(30,'00','얼갈이배추',215,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(31,'00','갓',216,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(32,'00','수박',221,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(33,'00','참외',222,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(34,'01','가시계통',223,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(35,'02','다다기계통',223,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(36,'03','취청',223,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(37,'01','애호박',224,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(38,'02','쥬키니',224,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(39,'03','단호박',224,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(40,'00','토마토',225,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(41,'00','딸기',226,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(42,'01','봄',231,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(43,'02','고랭지',231,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(44,'03','가을',231,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(45,'06','월동',231,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(46,'00','당근',232,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(47,'01','무세척',232,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(48,'02','세척',232,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(49,'10','세척(수입)',232,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(50,'00','열무',233,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(51,'00','화건',241,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(52,'01','햇산화건',241,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(53,'02','양건',241,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(54,'03','햇산양건',241,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(55,'10','수입',241,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(56,'00','풋고추',242,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(57,'02','꽈리고추',242,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(58,'03','청양고추',242,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(59,'04','오이맛고추',242,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(60,'00','붉은고추',243,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(61,'01','한지1접',244,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(62,'02','난지1접',244,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(63,'03','한지',244,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(64,'04','난지',244,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(65,'06','햇한지1접',244,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(66,'07','햇난지1접',244,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(67,'21','햇난지(대서)',244,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(68,'22','난지(대서)',244,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(69,'23','햇난지(남도)',244,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(70,'24','난지(남도)',244,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(71,'00','양파',245,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(72,'02','햇양파',245,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(73,'10','수입',245,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(74,'00','대파',246,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(75,'02','쪽파',246,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(76,'00','국산',247,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(77,'01','수입',247,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(78,'00','국산',248,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(79,'01','중국',248,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(80,'00','가지',251,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(81,'00','미나리',252,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(82,'00','깻잎',253,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(83,'00','부추',254,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(84,'00','청',255,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(85,'00','파프리카',256,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(86,'00','멜론',257,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(87,'01','깐마늘(국산)',258,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(88,'03','깐마늘(대서)',258,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(89,'04','햇깐마늘(대서)',258,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(90,'05','깐마늘(남도)',258,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(91,'06','햇깐마늘(남도)',258,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(92,'01','깐마늘(수입)',259,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(93,'03','깐마늘(수입산)',259,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(94,'01','브로콜리',261,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(95,'01','양상추',262,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(96,'01','청경채',263,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(97,'01','케일',264,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(98,'01','콩나물',265,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(99,'01','방울토마토',422,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(100,'02','대추방울토마토',422,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(101,'01','백색(국산)',312,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(102,'02','중국',312,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(103,'03','인도',312,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(104,'01','국산',313,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(105,'02','수입',313,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(106,'01','국산',314,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(107,'02','수입',314,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(108,'00','느타리버섯',315,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(109,'01','애느타리버섯',315,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(110,'00','팽이버섯',316,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(111,'00','새송이버섯',317,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(112,'00','수입',318,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(113,'00','수입',319,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(114,'01','양송이버섯',321,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(115,'01','표고버섯',322,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(116,'01','홍옥',411,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(117,'05','후지',411,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(118,'06','쓰가루',411,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(119,'07','홍로',411,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(120,'01','신고',412,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(121,'02','만삼길',412,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(122,'03','장십랑',412,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(123,'04','원황',412,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(124,'01','백도',413,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(125,'04','창방조생',413,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(126,'05','유명',413,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(127,'01','캠벨얼리',414,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(128,'02','거봉',414,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(129,'03','델라웨어',414,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(130,'06','MBA',414,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(131,'07','수입',414,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(132,'08','레드글로브 칠레',414,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(133,'09','레드글로브 페루',414,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(134,'10','톰슨 미국',414,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(135,'11','톰슨 호주',414,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(136,'12','샤인머스켓',414,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(137,'00','감귤',415,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(138,'01','노지',415,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(139,'02','시설',415,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(140,'00','단감',416,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(141,'02','수입',418,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(142,'01','국산',419,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(143,'02','그린 뉴질랜드',419,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(144,'02','수입',420,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(145,'02','수입',421,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(146,'03','네이블 미국',421,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(147,'04','발렌시아 미국',421,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(148,'05','네이블 EU',421,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(149,'06','네이블 호주',421,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(150,'00','수입',423,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(151,'00','수입',424,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(152,'00','수입',425,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(153,'00','수입',426,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(154,'00','수입',427,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(155,'00','수입',428,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(156,'11','한우갈비',512,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(157,'12','한우등심',512,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(158,'13','한우불고기',512,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(159,'14','한우양지',512,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(160,'15','한우안심',512,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(161,'16','한우설도',512,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(162,'21','미국산갈비',512,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(163,'22','미국산갈비살',512,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(164,'23','미국산불고기',512,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(165,'24','미국산설도',512,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(166,'31','호주산갈비',512,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(167,'32','호주산등심',512,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(168,'33','호주산불고기',512,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(169,'34','호주산설도',512,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(170,'00','삼겹살(국산냉장)',514,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(171,'01','삼겹살(수입냉동)',514,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(172,'02','목살',514,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(173,'03','돼지갈비',514,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(174,'04','앞다리살',514,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(175,'02','도계',515,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(176,'00','특란',516,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(177,'01','특란(소비쿠폰 적용)',516,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(178,'00','우유',535,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(179,'01','생선',611,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(180,'02','냉동',611,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(181,'03','염장',611,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(182,'04','냉동(수입)',611,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(183,'01','냉동(수입)',612,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(184,'01','생선',613,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(185,'02','냉동',613,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(186,'01','생선',615,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(187,'02','냉동',615,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(188,'01','생선',619,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(189,'02','냉동',619,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(190,'00','건멸치',638,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(191,'01','황태',639,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(192,'02','먹태',639,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(193,'00','건오징어',640,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(194,'00','마른김',641,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(195,'01','얼구운김',641,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(196,'00','건미역',642,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(197,'00','굴',644,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(198,'01','부세수입(생선)',649,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(199,'04','부세수입(냉동)',649,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(200,'00','새우젓',650,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(201,'00','멸치액젓',651,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(202,'00','굵은소금',652,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(203,'00','전복',653,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),(204,'01','흰다리(수입)',654,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000');
/*!40000 ALTER TABLE `prices_kind` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prices_price`
--

DROP TABLE IF EXISTS `prices_price`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prices_price` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `date` date NOT NULL,
  `market` varchar(16) NOT NULL,
  `price` int NOT NULL,
  `country_id` int NOT NULL,
  `food_id` int NOT NULL,
  `kind_id` bigint NOT NULL,
  `product_cls_id` varchar(2) NOT NULL,
  `product_rank_id` varchar(2) NOT NULL,
  `unit_id` varchar(4) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`id`),
  KEY `prices_price_country_id_9346ce14_fk_prices_country_country_code` (`country_id`),
  KEY `prices_price_food_id_d3d07514_fk_prices_food_item_code` (`food_id`),
  KEY `prices_price_kind_id_62fa3e96_fk_prices_kind_id` (`kind_id`),
  KEY `prices_price_product_cls_id_4187669d_fk_prices_pr` (`product_cls_id`),
  KEY `prices_price_product_rank_id_0cb10e7c_fk_prices_pr` (`product_rank_id`),
  KEY `prices_price_unit_id_71388816_fk_prices_unit_unit` (`unit_id`),
  CONSTRAINT `prices_price_country_id_9346ce14_fk_prices_country_country_code` FOREIGN KEY (`country_id`) REFERENCES `prices_country` (`country_code`),
  CONSTRAINT `prices_price_food_id_d3d07514_fk_prices_food_item_code` FOREIGN KEY (`food_id`) REFERENCES `prices_food` (`item_code`),
  CONSTRAINT `prices_price_kind_id_62fa3e96_fk_prices_kind_id` FOREIGN KEY (`kind_id`) REFERENCES `prices_kind` (`id`),
  CONSTRAINT `prices_price_product_cls_id_4187669d_fk_prices_pr` FOREIGN KEY (`product_cls_id`) REFERENCES `prices_productcls` (`product_cls_code`),
  CONSTRAINT `prices_price_product_rank_id_0cb10e7c_fk_prices_pr` FOREIGN KEY (`product_rank_id`) REFERENCES `prices_productrank` (`product_rank_code`),
  CONSTRAINT `prices_price_unit_id_71388816_fk_prices_unit_unit` FOREIGN KEY (`unit_id`) REFERENCES `prices_unit` (`unit`)
) ENGINE=InnoDB AUTO_INCREMENT=45545 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prices_price`
--

LOCK TABLES `prices_price` WRITE;
/*!40000 ALTER TABLE `prices_price` DISABLE KEYS */;
/*!40000 ALTER TABLE `prices_price` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prices_productcls`
--

DROP TABLE IF EXISTS `prices_productcls`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prices_productcls` (
  `product_cls_code` varchar(2) NOT NULL,
  `product_cls` varchar(2) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`product_cls_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prices_productcls`
--

LOCK TABLES `prices_productcls` WRITE;
/*!40000 ALTER TABLE `prices_productcls` DISABLE KEYS */;
INSERT INTO `prices_productcls` VALUES ('01','소매','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),('02','도매','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000');
/*!40000 ALTER TABLE `prices_productcls` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prices_productrank`
--

DROP TABLE IF EXISTS `prices_productrank`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prices_productrank` (
  `product_rank_code` varchar(2) NOT NULL,
  `product_rank` varchar(8) NOT NULL,
  `grade_rank` int NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`product_rank_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prices_productrank`
--

LOCK TABLES `prices_productrank` WRITE;
/*!40000 ALTER TABLE `prices_productrank` DISABLE KEYS */;
INSERT INTO `prices_productrank` VALUES ('01','1등급',2,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),('02','2등급',3,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),('03','3등급',4,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),('04','상품',1,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),('05','중품',2,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),('06','하품',3,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),('07','유기농',1,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),('08','무농약',2,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),('10','냉장',1,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),('11','냉동',3,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),('12','무항생제',4,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),('13','S과',1,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),('14','M과',2,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),('15','M과',1,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),('16','S과',2,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),('17','1+등급',1,'0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000');
/*!40000 ALTER TABLE `prices_productrank` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prices_unit`
--

DROP TABLE IF EXISTS `prices_unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prices_unit` (
  `unit` varchar(4) NOT NULL,
  `created_at` datetime(6) NOT NULL,
  `updated_at` datetime(6) NOT NULL,
  PRIMARY KEY (`unit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prices_unit`
--

LOCK TABLES `prices_unit` WRITE;
/*!40000 ALTER TABLE `prices_unit` DISABLE KEYS */;
INSERT INTO `prices_unit` VALUES ('kg','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),('개','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),('리터','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),('마리','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),('속','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),('장','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),('접','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000'),('포기','0000-00-00 00:00:00.000000','0000-00-00 00:00:00.000000');
/*!40000 ALTER TABLE `prices_unit` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-11-22 22:29:19
