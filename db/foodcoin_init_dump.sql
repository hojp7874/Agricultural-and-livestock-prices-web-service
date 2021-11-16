-- MySQL dump 10.13  Distrib 8.0.27, for Linux (aarch64)
--
-- Host: localhost    Database: foodcoin
-- ------------------------------------------------------
-- Server version	8.0.27-0ubuntu0.20.04.1

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
-- Table structure for table `prices_country`
--

DROP TABLE IF EXISTS `prices_country`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prices_country` (
  `country_code` int NOT NULL,
  `country` varchar(16) NOT NULL,
  PRIMARY KEY (`country_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prices_country`
--

LOCK TABLES `prices_country` WRITE;
/*!40000 ALTER TABLE `prices_country` DISABLE KEYS */;
INSERT INTO `prices_country` VALUES (1,'충주'),(2,'목포'),(3,'마산'),(4,'군산'),(1101,'서울'),(2100,'부산'),(2200,'대구'),(2300,'인천'),(2401,'광주'),(2501,'대전'),(2601,'울산'),(2701,'세종'),(3111,'수원'),(3113,'의정부'),(3145,'용인'),(3211,'춘천'),(3214,'강릉'),(3311,'청주'),(3511,'전주'),(3613,'순천'),(3711,'포항'),(3714,'안동'),(3814,'창원'),(3911,'제주');
/*!40000 ALTER TABLE `prices_country` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `prices_unit`
--

DROP TABLE IF EXISTS `prices_unit`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `prices_unit` (
  `unit` varchar(4) NOT NULL,
  PRIMARY KEY (`unit`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prices_unit`
--

LOCK TABLES `prices_unit` WRITE;
/*!40000 ALTER TABLE `prices_unit` DISABLE KEYS */;
INSERT INTO `prices_unit` VALUES ('kg'),('개'),('리터'),('마리'),('속'),('장'),('접'),('포기');
/*!40000 ALTER TABLE `prices_unit` ENABLE KEYS */;
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
  PRIMARY KEY (`product_cls_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prices_productcls`
--

LOCK TABLES `prices_productcls` WRITE;
/*!40000 ALTER TABLE `prices_productcls` DISABLE KEYS */;
INSERT INTO `prices_productcls` VALUES ('01','소매'),('02','도매');
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
  PRIMARY KEY (`product_rank_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prices_productrank`
--

LOCK TABLES `prices_productrank` WRITE;
/*!40000 ALTER TABLE `prices_productrank` DISABLE KEYS */;
INSERT INTO `prices_productrank` VALUES ('01','1등급',2),('02','2등급',3),('03','3등급',4),('04','상품',1),('05','중품',2),('06','하품',3),('07','유기농',1),('08','무농약',2),('10','냉장',1),('11','냉동',3),('12','무항생제',4),('13','S과',1),('14','M과',2),('15','M과',1),('16','S과',2),('17','1+등급',1);
/*!40000 ALTER TABLE `prices_productrank` ENABLE KEYS */;
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
  PRIMARY KEY (`item_category_code`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `prices_itemcategory`
--

LOCK TABLES `prices_itemcategory` WRITE;
/*!40000 ALTER TABLE `prices_itemcategory` DISABLE KEYS */;
INSERT INTO `prices_itemcategory` VALUES (100,'식량작물'),(200,'채소류'),(300,'특용작물'),(400,'과일류'),(500,'축산물'),(600,'수산물');
/*!40000 ALTER TABLE `prices_itemcategory` ENABLE KEYS */;
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
INSERT INTO `prices_food` VALUES (111,'쌀','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSK2a-hYwzYVQmWV2e0QuLFqrudTKoKS2SYWxk_J8NnZ8cIX5-HyUuR0Migkz8&s',100),(112,'찹쌀','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRshL5PF-58eWoiylKxA4axceKREyjCaUQ0ANUyw39netVTwwFVGTnMr3HpiJI&s',100),(113,'혼합곡','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSLdhDl6WSa2c7bcYbbn8RsjTRbwmCBOy5WdqLNzaW3WP1sFRrE-3YOSENv-f4&s',100),(141,'콩','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjqlmf3eabmTktmCUk8cpNKzhccCSPugCirOmJ838guFJ4BInuTfS17VvrkQ&s',100),(142,'팥','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSUlevOPaXL9AGI_w57qI0WR0giF2PLbYnFZAr572yxJhzm-6Dt5aG07xhOJCw&s',100),(143,'녹두','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRhs7JG60TaYJJJDIn0lBcjpwli4aRW8dIuoaOVxMEgrGLHyRw4vH4SoDHWGQ&s',100),(144,'메밀','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTiUFhiKoa0aviAnk7WAEi_6iRlZdvqISacAfEF4eC-ivzjlHTggt6WiS0cMw&s',100),(151,'고구마','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYMDP2HrlQV5mOrin6VdzyLb5AJFE-YoP7qvxBdqAxNjXKGLjExZ9ramhMig&s',100),(152,'감자','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcROB7Rhqq-cgT6hGyb68cbebPH-NYCLhLCvMNSF-bCSl0ze8kXWh5p3UhoWAOw&s',100),(161,'귀리','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcREzs3uUwfagS5cUg3AvCm3cfP0AtIgfuBqYHh1jrZphxQ3sp8pF3vxddEyYw&s',100),(162,'보리','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQgTuOS9b_Rz_3cx2LVccFlhBgEadkpvE8rl4GoVJMFTDp0eQDy7NqPQKX4QQ&s',100),(163,'수수','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbqu4_nprS9MXQKdAc4Arp7UIL7FQZbxQJ0JTkUsh03XCUXESMzSAbKSucIm0&s',100),(164,'율무','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRuC6ZhMG5EylMB9I1wov0ZYwIcRJ6uLf9dOnrGzHFIE0sCB-nJvDa3zZXyZZ0&s',100),(211,'배추','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTuVqPTIRHx9KYQCjOO90eWPNjsmcBFTAwpyhS3xi_cuYAKobwCxlX5gDXMEw&s',200),(212,'양배추','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7ZVUokxVELnsMuVRVz-2SWUzIm8EEgIjrKZrMU0Yjvut2qbWuStqTWSv1og&s',200),(213,'시금치','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRmgRzEzBVf8rllFGR6bnvmPkWCIYsPPW2QjiDU_XBh8hx-PhYv4fcxfwFn9pg&s',200),(214,'상추','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKun0L7Jg6sWPlgIkIsJqPo3mvLfr2DfgWTs0fumGxkVV9B2bI8HUFauzV0A&s',200),(215,'얼갈이배추','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ_LS4TjjJXzV7gSRY0_b4X-_biP1aZ1B-yo0T9vrtb0DuBiBTB889kji7gNg&s',200),(216,'갓','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRVqzSBBHm286r1CcMLifxSSp01MrHh1P34mM383fOWSBfM_8FrKgs0sCjPRWw&s',200),(221,'수박','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkzk6YFTqOVbn98qRnoBJy-wnOiIPBVF-NXkqptImm_6zWShvh5lmaEB_javA&s',200),(222,'참외','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyIFehNG9o5OTUxkPKDIlhEkNkZhoZBxqdlNRTwGFAG1H2qPXO9Ci0p1hjvA&s',200),(223,'오이','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSCGuPHVZfzwHas81o3ti7TJuV-3Gf190ZBOVQOeQIq9w6YlfXi1VAzxDw6RQ&s',200),(224,'호박','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRSNi3TTkfi41teWIQdJnZtFGykAABZaR1aGIcP--ceEuO-RyAoAP-wmJCvvQ&s',200),(225,'토마토','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRqToWkKh0X5LNMBj4jDdi2kwiKyBY_X8D7a-6H2nMDbIgUo7aBNiezW6ZXJ6M&s',200),(226,'딸기','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSC2b3VwGx5FjtMwZEwK3ysYCROXtfJuwlgydtFg3sXoHcl-MPT82E2gI4hkbQ&s',200),(231,'무','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR3zhHPQ28irZNDYm6MjGPvH9yeUEtUgVEZx6NiVUjVTveVkQu9YfR6ekGMUEM&s',200),(232,'당근','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyOBaBe7KA8tilHePx4LghqYJBKF6cBfej3na2inYW5P0W-GFeHsn_fHweTpg&s',200),(233,'열무','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfLKpO4g_x1fDZLIuzLtv5WLuPWBWESVFhWPtlbkHXQihnYaifTNxOS_SjJw&s',200),(241,'건고추','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ-N6qAVUD7cbYsXmDgbf4rS5ZKBEN6_UYFDJ8Vx8wFYwrhUBBINfeEsWXa65g&s',200),(242,'풋고추','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS3vpwFjuJOJYRbmAZNCXzjbBESVxSzXp3GZmuUHM4SF6m9VmpecmIHx1aXHw&s',200),(243,'붉은고추','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQTWxEwQgbIJrR-mx-RjosYCuBzisha4GxaIXw-m9wvPwICaxv4CdN4jXU28Q&s',200),(244,'피마늘','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRA-MGWE_5iQG4zBIBJAzGT2tUz8WchlEwXfFfkBYBfNyp5hHj7bwA8bAagYQ&s',200),(245,'양파','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQY59bkTH-NUMgOkyh9lQN1oPNWkWKW4ZhWEGh9MdDbN61FhZrWesxRHO7WAbw&s',200),(246,'파','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSiV7UxRr_eNKWXZn6wwLTPqEDJsF7cgVM2tmWAG9QtqM6MvUVtRoi90OPS4io&s',200),(247,'생강','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT9Rwx16AMUmJDAjuvTBZ_3T7gHMJ0IjTc5v6WZC7heN69Q72uy_ayUUDRgOA&s',200),(248,'고춧가루','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTNHmnB6gmS3Jm4FrLKOkU5TL0iH5xlae4Bow7ZUuDohsFXYRMsNKLOnMyDaik&s',200),(251,'가지','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTVRhupMiu8yJk48eYODUsw_tVcrigXgWD9Wt1bUfJ5a3I5FYKfjeHPwgSmRw&s',200),(252,'미나리','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7qGNGwx0TQfbA_PHacf9Ejo9ZynPBF0XM3vyVJTqHa1sIHfUxAvl8utMa6Y4&s',200),(253,'깻잎','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_xWTalLogTTEzlnsbsx8EkF2sMlGz2X8xG1NYrQ2z-n9OeTGah-dFikLscw&s',200),(254,'부추','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS0_dFYQ8n3FFCNKnhb_3cBG0BU_pGmhETvzM5WnmbfgKkEEk5DqaxdiNFN22E&s',200),(255,'피망','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAyhQe1YDJ7_cNDUlVhvWcCvZyOKJ7UhIIFNLHFAcwTHASFfr0L99lfgDZZzY&s',200),(256,'파프리카','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSsh9V3BB072YlHhXujTpyBhqpUKA0dGK1nvpY_-V-z6lYZMM_mDEYdngthTQ&s',200),(257,'멜론','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRHSlNLbCOb6U_9G-onh2QnlIC-nHB1SEFYI8loa1bf9us01VIlBO9D3Do84II&s',200),(258,'깐마늘(국산)','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTm56uwmsFWQoXkBmAsxUZpPLSP7q5BRFfu77HtpL9GRlgsZvAEMo3e1SX6QQ&s',200),(259,'깐마늘(수입)','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR9000zxv1dp4qdZ1_0zWTNzHEmtDXjfjgxKw914VMLmDIqBc7sbaqInRlvw8g&s',200),(261,'브로콜리','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT7wrkes4fOcsvXdCeBWLynj82edKPHLhBP2d83Pql4dCHgtIMaOLC7XR_4KVE&s',200),(262,'양상추','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQODIpaqcFbvdIWr0gwZb5zmOQ8DJmlO8rKQSSodIETR0XBfIPGIVFoiB-jeQ&s',200),(263,'청경채','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSsMuHVQgum1wnFz0-oNcfGK8QpBcyBRi4KXc9r8xylM3yV0wL7NGFeY21VnA&s',200),(264,'케일','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR_MYdFZRV553QBWWT1lh7iOkZabKjy35Gk43RK4H97InpZGjqyjAZo9UU5rVo&s',200),(265,'콩나물','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7-2ef0fnbGg6Pq8FrfyZxWfk-4pKLShBMkGJp3PdXjyARY3XLAlCLFSIOUw&s',200),(312,'참깨','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRMC9rrw4_uEMpxx_-bbcbnPElEX2uT9cEEYoM2DeHaNRAZUocQ8_W6zKfeUy0&s',300),(313,'들깨','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQCbyiSpqnma8ib9wTuSrm8xLTMni_sTGo9JZGs_BlBfzuZ2hiPAyqvAd2G-qM&s',300),(314,'땅콩','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTXpKc--_PAseMUPajXPEacxwqf6gPV7d_lLNMkv4roOB6P5WL4mxaJmUQ090w&s',300),(315,'느타리버섯','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRf77Tuy6dRuAD4CdcSmHf6rOXi-DgfGlO4dFYnA3VvHbB09IVJukCWq6EZmK8&s',300),(316,'팽이버섯','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQyVdxI_Y1XBcvBZJqzfptx7e0gHb9Ru3yy_GvJtgvpZ_5HKm_VjZiz4G-7mwU&s',300),(317,'새송이버섯','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbyQjPqVkaghOJBTzWP1an4_3m5dZt6VeLPiW0LwuD8_Q3692NgBjKC9sSPg&s',300),(318,'호두','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR7wJbtZjz1G_oKBmmZUgYSIHrYcTspj-Xew0S6_14U1a9ilxaZjbIq0JUm9Ak&s',300),(319,'아몬드','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZHcxo62hPVTljvvr3cUCS93SqRg7aw_E7YCZ0XtCxJtxnyQRaUOO_8h0G3wY&s',300),(321,'양송이버섯','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSkBnW1F_xWi_g-ggUnGPkUuM3dMgYkhp7LBRsEmokwr2D7WSV4Ei_hduiK4BA&s',300),(322,'표고버섯','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQzK-pvEbFD3aBtizQYuARReDPzN0Mw8pfCehezoMhUC6TFF5FAacyy3n5ia1Q&s',300),(411,'사과','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ6t4KGDBDh-yPbH5XkLXxcGwSUDRgEs_T-yMhKLsRcKHveLo_9I_3_bS6BuQ&s',400),(412,'배','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQbJHH7_-LhGvQsW7o64sicsG6uypu7FxR3us8LhznkgSZ3j7_-OGDYDQlbS-w&s',400),(413,'복숭아','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS088rHnUaiGpxyHIGoACICxJCQA91OoSZBst02QqG7rzFsk7Q203bEWGNWC1Q&s',400),(414,'포도','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS-Bg0BBBayJrm2ZegiLavgP5xA5K4Uz5O9_hpXn_2SVQx8Mx7buj0lX2jBAQ&s',400),(415,'감귤','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTGQqbP2VbhZjkRf0fBxZoaQzBTorjj_acRa1_ikCOf7ncleX2q1VzBRa-ZT5o&s',400),(416,'단감','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSAB10SL6ud5hnzcf4ZtZOyB1plOh0g6d8rd0omt4PUXmddePxM1sBWC28jP1M&s',400),(418,'바나나','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTfj3R4zilpzs54SMN9clMdE3w2JTk4_8wj6J6-_H-OdVpvAZdvm41Mou5RtA&s',400),(419,'참다래','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRLDTsRIzgi65CxewGA9qU_rlrh5Dc1oxhDTMJP792CKY-jPZtTA4ySxrQjdA&s',400),(420,'파인애플','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQfFMWjxPE7tbHyTHqiHtpfT_jikHYUWm0tpgA8dFZFfX9aXsXbDorW64hF9Q&s',400),(421,'오렌지','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQqWae1g95YpRYiJtqY5OW3DLq8L8BftVA7YMpbng9-fZEYNNX2ntfDGTqwlhw&s',400),(422,'방울토마토','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpLDcfc0E7r7ce-itDfD1GdelY-pD2MMIXlMu-JZXvrX1PbmZ4cQtIouR6s98&s',400),(423,'자몽','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxgz_jKvXlQPPgVUqANuP2ZXQx01qujHkXya-D-BEqpDOsHGfyjErjeqalpA&s',400),(424,'레몬','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSP1wI0AZYcNp1hGTntJ6FwFQWmil_tvwclSN8Wi5YLOqqAFBAtG13Wo26c-Q&s',400),(425,'체리','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRbEyumT4w0kXwrh3mxy1oNRBtyVYhvyOYrx24adVnc3aeqzZlhLdvtWNhzew&s',400),(426,'건포도','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRYY0SvYfKaYkmVb6tpxq7702OPm7MFbgL7-TIgtIQ9vQQgTpwWIvbg7L8bKdw&s',400),(427,'건블루베리','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRkC64Rg_Ya3cyWXihEGCSN15V626VFq2pPne3B---yqWyVR7A76bcLAngrmw&s',400),(428,'망고','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTvzmuDpfP8lqEor5uVmRVhnMQm0b5VebhcFNCjnyVXJBhcjaaU1-yO46OvFg&s',400),(512,'쇠고기','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ8gbkSnaGlzEv35oPp0zmgcIwytxgRHv5xUmeXTXEfu3tM4YNC68NYNuvjTg&s',500),(514,'돼지고기','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSZ85Rrz5OLWgAB03DVKlCXqeGPTlIAd-zju32S9ZvHvoGZ7HrfkFYmwMA2qVc&s',500),(515,'닭고기','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTxRlKDuoQ0d95zGIJPy-W3CTksj28gW9-a9RwLIuCobHauhGWOAOMonTh8rAM&s',500),(516,'계란','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQasHl4S8MtdIcbHFnRs5-TvgdUmT7mV8vXnnV7J4oK6q6MyZbi0Lo_3aa1-A&s',500),(535,'우유','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSKljrcsxqiwLWdE1a0TIm5piZirEw4UyWKP1Zx2B28ly2VtwEAhLyRI-gNpw&s',500),(611,'고등어','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQL4rQ-id92T0UCeKYUG0uMTPzJH8YJ-Yg80M2rwAQZrVuQLYwT6a5Uvm7A6w&s',600),(612,'꽁치','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTbtGFPu5aqypHoO71GWUFWlidZsIxCItbuz01QqUvVOJ2cW8oJMc3I5JjaQqs&s',600),(613,'갈치','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTUQxB-hNTvfNz8RvioZE7ZUf7wuLLZ6h1pMO0GuS1DkRgMctpz28bM5nUZ_g&s',600),(615,'명태','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR5GTsq8fdnhuDvbFOiY9ZBg9cBrLrT6P_J0yD6PfqlUuKGXTRP1M0cEpCr_w&s',600),(619,'물오징어','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRzn4lsKeGHVRa65aj1d_w_jzB6wu9uEv0tac2yInxj8Oedve553OliWUDrUw&s',600),(638,'건멸치','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ1Dre_qL2PTvE0uAWx5DKlTOHtEqKJGC7JUaeOMYBpHoSmMef1ZP7zhYELZIk&s',600),(639,'북어','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS1hYrsKBCtP5JxcI9pBiZOdsNpReJBlZIoyKBQozhWTVd2EXwnM_kn9HQBNw&s',600),(640,'건오징어','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpItRMpFe9A2oBz1mZybKHDOCB2a-C1qemMQkSNncaxau_zE4EBX2tzpT8Mw&s',600),(641,'김','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRQGtmZyyVG17C6f3C9n1NSIHHlFUah5jEMRFaFK5BLQK41LFVZsdzA9MaYlQ&s',600),(642,'건미역','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQ0fG23DlE_d59C63qrkD-7Gfexhoc7lWMzL66BteX5jW3C-wzTikMD2pwoJRI&s',600),(644,'굴','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQATdjY3jCSY7bxhgApXrXlRG9ejulSJgMozjaxw3F4UxP8NJ7U0y4g1NwlFzQ&s',600),(649,'수입조기','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQc1FCG7vk0eWBRCB1WPuiERvwmnZpI8JF7qrAETCRvF_33b-uS8cl7aqex6zA&s',600),(650,'새우젓','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQmmkYYF03hw528mLEtwAWvpv7Gwygqie9uKrp_7nTJm8qaJ8UnufbihmsDXA&s',600),(651,'멸치액젓','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQeGiTgoYU5QWb9dduEoN3xyoTPEOKLhgQDNCuOc2k85ImNue7geToNeVQ9iZE&s',600),(652,'굵은소금','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRpoBPzry6o6JyPJpfGdDZX39z4yFI3Pzi7iip1EvdIQ6WuEmPb_BtlUAjBOxc&s',600),(653,'전복','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcS2VxwzbHLVIt94tUBhm6y_67MwBKfQXJ0KcYlXUKfhqrePbxW7K-R5JGMaSA&s',600),(654,'새우','https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT78bVLov3KXoF2V1H29TiiHXAVX25BLN9FJUwt9cuX2CPbjRhQcj1PWWegdA&s',600);
/*!40000 ALTER TABLE `prices_food` ENABLE KEYS */;
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
INSERT INTO `prices_kind` VALUES (1,'01','일반계',111),(2,'02','백미',111),(3,'03','현미',111),(4,'05','햇일반계',111),(5,'01','일반계',112),(6,'00','혼합곡',113),(7,'01','흰 콩(국산)',141),(8,'02','콩나물콩',141),(9,'03','흰 콩(수입)',141),(10,'00','붉은 팥(국산)',142),(11,'01','붉은 팥(수입)',142),(12,'00','국산',143),(13,'01','수입',143),(14,'01','메밀(수입)',144),(15,'00','밤',151),(16,'01','수미',152),(17,'02','대지마',152),(18,'01','귀리',161),(19,'01','보리',162),(20,'01','수수',163),(21,'01','율무',164),(22,'01','봄',211),(23,'02','고랭지',211),(24,'03','가을',211),(25,'06','월동',211),(26,'00','양배추',212),(27,'00','시금치',213),(28,'01','적',214),(29,'02','청',214),(30,'00','얼갈이배추',215),(31,'00','갓',216),(32,'00','수박',221),(33,'00','참외',222),(34,'01','가시계통',223),(35,'02','다다기계통',223),(36,'03','취청',223),(37,'01','애호박',224),(38,'02','쥬키니',224),(39,'03','단호박',224),(40,'00','토마토',225),(41,'00','딸기',226),(42,'01','봄',231),(43,'02','고랭지',231),(44,'03','가을',231),(45,'06','월동',231),(46,'00','당근',232),(47,'01','무세척',232),(48,'02','세척',232),(49,'10','세척(수입)',232),(50,'00','열무',233),(51,'00','화건',241),(52,'01','햇산화건',241),(53,'02','양건',241),(54,'03','햇산양건',241),(55,'10','수입',241),(56,'00','풋고추',242),(57,'02','꽈리고추',242),(58,'03','청양고추',242),(59,'04','오이맛고추',242),(60,'00','붉은고추',243),(61,'01','한지1접',244),(62,'02','난지1접',244),(63,'03','한지',244),(64,'04','난지',244),(65,'06','햇한지1접',244),(66,'07','햇난지1접',244),(67,'21','햇난지(대서)',244),(68,'22','난지(대서)',244),(69,'23','햇난지(남도)',244),(70,'24','난지(남도)',244),(71,'00','양파',245),(72,'02','햇양파',245),(73,'10','수입',245),(74,'00','대파',246),(75,'02','쪽파',246),(76,'00','국산',247),(77,'01','수입',247),(78,'00','국산',248),(79,'01','중국',248),(80,'00','가지',251),(81,'00','미나리',252),(82,'00','깻잎',253),(83,'00','부추',254),(84,'00','청',255),(85,'00','파프리카',256),(86,'00','멜론',257),(87,'01','깐마늘(국산)',258),(88,'03','깐마늘(대서)',258),(89,'04','햇깐마늘(대서)',258),(90,'05','깐마늘(남도)',258),(91,'06','햇깐마늘(남도)',258),(92,'01','깐마늘(수입)',259),(93,'03','깐마늘(수입산)',259),(94,'01','브로콜리',261),(95,'01','양상추',262),(96,'01','청경채',263),(97,'01','케일',264),(98,'01','콩나물',265),(99,'01','방울토마토',422),(100,'02','대추방울토마토',422),(101,'01','백색(국산)',312),(102,'02','중국',312),(103,'03','인도',312),(104,'01','국산',313),(105,'02','수입',313),(106,'01','국산',314),(107,'02','수입',314),(108,'00','느타리버섯',315),(109,'01','애느타리버섯',315),(110,'00','팽이버섯',316),(111,'00','새송이버섯',317),(112,'00','수입',318),(113,'00','수입',319),(114,'01','양송이버섯',321),(115,'01','표고버섯',322),(116,'01','홍옥',411),(117,'05','후지',411),(118,'06','쓰가루',411),(119,'07','홍로',411),(120,'01','신고',412),(121,'02','만삼길',412),(122,'03','장십랑',412),(123,'04','원황',412),(124,'01','백도',413),(125,'04','창방조생',413),(126,'05','유명',413),(127,'01','캠벨얼리',414),(128,'02','거봉',414),(129,'03','델라웨어',414),(130,'06','MBA',414),(131,'07','수입',414),(132,'08','레드글로브 칠레',414),(133,'09','레드글로브 페루',414),(134,'10','톰슨 미국',414),(135,'11','톰슨 호주',414),(136,'12','샤인머스켓',414),(137,'00','감귤',415),(138,'01','노지',415),(139,'02','시설',415),(140,'00','단감',416),(141,'02','수입',418),(142,'01','국산',419),(143,'02','그린 뉴질랜드',419),(144,'02','수입',420),(145,'02','수입',421),(146,'03','네이블 미국',421),(147,'04','발렌시아 미국',421),(148,'05','네이블 EU',421),(149,'06','네이블 호주',421),(150,'00','수입',423),(151,'00','수입',424),(152,'00','수입',425),(153,'00','수입',426),(154,'00','수입',427),(155,'00','수입',428),(156,'11','한우갈비',512),(157,'12','한우등심',512),(158,'13','한우불고기',512),(159,'14','한우양지',512),(160,'15','한우안심',512),(161,'16','한우설도',512),(162,'21','미국산갈비',512),(163,'22','미국산갈비살',512),(164,'23','미국산불고기',512),(165,'24','미국산설도',512),(166,'31','호주산갈비',512),(167,'32','호주산등심',512),(168,'33','호주산불고기',512),(169,'34','호주산설도',512),(170,'00','삼겹살(국산냉장)',514),(171,'01','삼겹살(수입냉동)',514),(172,'02','목살',514),(173,'03','돼지갈비',514),(174,'04','앞다리살',514),(175,'02','도계',515),(176,'00','특란',516),(177,'01','특란(소비쿠폰 적용)',516),(178,'00','우유',535),(179,'01','생선',611),(180,'02','냉동',611),(181,'03','염장',611),(182,'04','냉동(수입)',611),(183,'01','냉동(수입)',612),(184,'01','생선',613),(185,'02','냉동',613),(186,'01','생선',615),(187,'02','냉동',615),(188,'01','생선',619),(189,'02','냉동',619),(190,'00','건멸치',638),(191,'01','황태',639),(192,'02','먹태',639),(193,'00','건오징어',640),(194,'00','마른김',641),(195,'01','얼구운김',641),(196,'00','건미역',642),(197,'00','굴',644),(198,'01','부세수입(생선)',649),(199,'04','부세수입(냉동)',649),(200,'00','새우젓',650),(201,'00','멸치액젓',651),(202,'00','굵은소금',652),(203,'00','전복',653),(204,'01','흰다리(수입)',654);
/*!40000 ALTER TABLE `prices_kind` ENABLE KEYS */;
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
INSERT INTO `prices_foodproductranks` VALUES (1,111,1,'07'),(2,111,1,'04'),(3,111,1,'08'),(4,111,1,'05'),(5,111,2,'07'),(6,111,2,'08'),(7,111,3,'07'),(8,111,3,'08'),(9,111,4,'04'),(10,111,4,'05'),(11,112,5,'07'),(12,112,5,'04'),(13,112,5,'08'),(14,112,5,'05'),(15,113,6,'07'),(16,113,6,'08'),(17,141,7,'04'),(18,141,7,'05'),(19,141,8,'04'),(20,141,8,'05'),(21,141,9,'05'),(22,142,10,'04'),(23,142,10,'05'),(24,142,11,'05'),(25,143,12,'04'),(26,143,12,'05'),(27,143,13,'05'),(28,144,14,'05'),(29,151,15,'07'),(30,151,15,'04'),(31,151,15,'08'),(32,151,15,'05'),(33,152,16,'07'),(34,152,16,'04'),(35,152,16,'08'),(36,152,16,'05'),(37,152,17,'04'),(38,152,17,'05'),(39,161,18,'07'),(40,161,18,'08'),(41,162,19,'07'),(42,162,19,'08'),(43,163,20,'07'),(44,163,20,'08'),(45,164,21,'07'),(46,164,21,'08'),(47,211,22,'07'),(48,211,22,'04'),(49,211,22,'08'),(50,211,22,'05'),(51,211,23,'04'),(52,211,23,'05'),(53,211,24,'04'),(54,211,24,'05'),(55,211,25,'04'),(56,211,25,'05'),(57,212,26,'07'),(58,212,26,'04'),(59,212,26,'08'),(60,212,26,'05'),(61,213,27,'07'),(62,213,27,'04'),(63,213,27,'08'),(64,213,27,'05'),(65,214,28,'07'),(66,214,28,'04'),(67,214,28,'08'),(68,214,28,'05'),(69,214,29,'07'),(70,214,29,'04'),(71,214,29,'08'),(72,214,29,'05'),(73,215,30,'04'),(74,215,30,'05'),(75,216,31,'04'),(76,221,32,'04'),(77,221,32,'05'),(78,222,33,'07'),(79,222,33,'04'),(80,222,33,'08'),(81,222,33,'05'),(82,223,34,'07'),(83,223,34,'04'),(84,223,34,'08'),(85,223,34,'05'),(86,223,35,'07'),(87,223,35,'04'),(88,223,35,'08'),(89,223,35,'05'),(90,223,36,'07'),(91,223,36,'04'),(92,223,36,'08'),(93,223,36,'05'),(94,224,37,'07'),(95,224,37,'04'),(96,224,37,'08'),(97,224,37,'05'),(98,224,38,'04'),(99,224,38,'05'),(100,224,39,'07'),(101,224,39,'08'),(102,225,40,'07'),(103,225,40,'04'),(104,225,40,'08'),(105,225,40,'05'),(106,226,41,'07'),(107,226,41,'04'),(108,226,41,'08'),(109,226,41,'05'),(110,231,42,'07'),(111,231,42,'04'),(112,231,42,'08'),(113,231,42,'05'),(114,231,43,'04'),(115,231,43,'05'),(116,231,44,'04'),(117,231,44,'05'),(118,231,45,'04'),(119,231,45,'05'),(120,232,46,'07'),(121,232,46,'04'),(122,232,46,'08'),(123,232,46,'05'),(124,232,47,'07'),(125,232,47,'04'),(126,232,47,'08'),(127,232,47,'05'),(128,232,48,'07'),(129,232,48,'04'),(130,232,48,'08'),(131,232,48,'05'),(132,232,49,'05'),(133,233,50,'04'),(134,233,50,'05'),(135,241,51,'04'),(136,241,51,'05'),(137,241,52,'04'),(138,241,52,'05'),(139,241,53,'04'),(140,241,53,'05'),(141,241,54,'04'),(142,241,54,'05'),(143,241,55,'05'),(144,242,56,'07'),(145,242,56,'04'),(146,242,56,'08'),(147,242,56,'05'),(148,242,57,'07'),(149,242,57,'04'),(150,242,57,'08'),(151,242,57,'05'),(152,242,58,'07'),(153,242,58,'04'),(154,242,58,'08'),(155,242,58,'05'),(156,242,59,'07'),(157,242,59,'08'),(158,243,60,'04'),(159,243,60,'05'),(160,244,61,'04'),(161,244,61,'05'),(162,244,62,'04'),(163,244,62,'05'),(164,244,63,'04'),(165,244,63,'05'),(166,244,64,'04'),(167,244,64,'05'),(168,244,65,'04'),(169,244,65,'05'),(170,244,66,'04'),(171,244,66,'05'),(172,244,67,'04'),(173,244,67,'05'),(174,244,68,'04'),(175,244,68,'05'),(176,244,69,'04'),(177,244,69,'05'),(178,244,70,'04'),(179,244,70,'05'),(180,245,71,'07'),(181,245,71,'04'),(182,245,71,'08'),(183,245,71,'05'),(184,245,72,'07'),(185,245,72,'04'),(186,245,72,'08'),(187,245,72,'05'),(188,245,73,'05'),(189,246,74,'07'),(190,246,74,'04'),(191,246,74,'08'),(192,246,74,'05'),(193,246,75,'07'),(194,246,75,'04'),(195,246,75,'08'),(196,246,75,'05'),(197,247,76,'04'),(198,247,76,'05'),(199,247,77,'05'),(200,248,78,'04'),(201,248,79,'04'),(202,251,80,'07'),(203,251,80,'04'),(204,251,80,'08'),(205,251,80,'05'),(206,252,81,'07'),(207,252,81,'04'),(208,252,81,'08'),(209,252,81,'05'),(210,253,82,'07'),(211,253,82,'04'),(212,253,82,'08'),(213,253,82,'05'),(214,254,83,'07'),(215,254,83,'04'),(216,254,83,'08'),(217,254,83,'05'),(218,255,84,'07'),(219,255,84,'04'),(220,255,84,'08'),(221,255,84,'05'),(222,256,85,'07'),(223,256,85,'04'),(224,256,85,'08'),(225,256,85,'05'),(226,257,86,'04'),(227,257,86,'05'),(228,258,87,'07'),(229,258,87,'04'),(230,258,87,'08'),(231,258,87,'05'),(232,258,88,'04'),(233,258,88,'05'),(234,258,89,'04'),(235,258,89,'05'),(236,258,90,'04'),(237,258,90,'05'),(238,258,91,'04'),(239,258,91,'05'),(240,259,92,'05'),(241,259,93,'04'),(242,259,93,'05'),(243,261,94,'07'),(244,261,94,'08'),(245,262,95,'07'),(246,262,95,'08'),(247,263,96,'07'),(248,263,96,'08'),(249,264,97,'07'),(250,264,97,'08'),(251,265,98,'07'),(252,265,98,'08'),(253,422,99,'07'),(254,422,99,'04'),(255,422,99,'08'),(256,422,99,'05'),(257,422,100,'04'),(258,422,100,'05'),(259,312,101,'04'),(260,312,101,'05'),(261,312,102,'05'),(262,312,103,'05'),(263,313,104,'04'),(264,313,104,'05'),(265,313,105,'05'),(266,314,106,'04'),(267,314,106,'05'),(268,314,107,'05'),(269,315,108,'04'),(270,315,108,'05'),(271,315,109,'04'),(272,315,109,'05'),(273,316,110,'07'),(274,316,110,'04'),(275,316,110,'08'),(276,316,110,'05'),(277,317,111,'07'),(278,317,111,'04'),(279,317,111,'08'),(280,317,111,'05'),(281,318,112,'05'),(282,319,113,'05'),(283,321,114,'07'),(284,321,114,'08'),(285,322,115,'07'),(286,322,115,'08'),(287,411,116,'04'),(288,411,116,'05'),(289,411,117,'07'),(290,411,117,'04'),(291,411,117,'08'),(292,411,117,'05'),(293,411,118,'07'),(294,411,118,'04'),(295,411,118,'08'),(296,411,118,'05'),(297,411,119,'04'),(298,411,119,'05'),(299,412,120,'07'),(300,412,120,'04'),(301,412,120,'08'),(302,412,120,'05'),(303,412,121,'04'),(304,412,121,'05'),(305,412,122,'04'),(306,412,122,'05'),(307,412,123,'04'),(308,412,123,'05'),(309,413,124,'04'),(310,413,124,'05'),(311,413,125,'04'),(312,413,125,'05'),(313,413,126,'04'),(314,413,126,'05'),(315,414,127,'07'),(316,414,127,'04'),(317,414,127,'08'),(318,414,127,'05'),(319,414,128,'04'),(320,414,128,'05'),(321,414,129,'04'),(322,414,129,'05'),(323,414,130,'04'),(324,414,130,'05'),(325,414,131,'04'),(326,414,131,'05'),(327,414,132,'04'),(328,414,132,'05'),(329,414,133,'04'),(330,414,133,'05'),(331,414,134,'04'),(332,414,134,'05'),(333,414,135,'04'),(334,414,135,'05'),(335,414,136,'04'),(336,414,136,'05'),(337,415,137,'07'),(338,415,137,'04'),(339,415,137,'08'),(340,415,137,'05'),(341,415,138,'16'),(342,415,138,'13'),(343,415,138,'14'),(344,415,138,'15'),(345,415,139,'16'),(346,415,139,'13'),(347,415,139,'14'),(348,415,139,'15'),(349,416,140,'07'),(350,416,140,'04'),(351,416,140,'08'),(352,416,140,'05'),(353,418,141,'04'),(354,418,141,'05'),(355,419,142,'04'),(356,419,142,'05'),(357,419,143,'04'),(358,419,143,'05'),(359,420,144,'04'),(360,420,144,'05'),(361,421,145,'04'),(362,421,145,'05'),(363,421,146,'04'),(364,421,146,'05'),(365,421,147,'04'),(366,421,147,'05'),(367,421,148,'04'),(368,421,148,'05'),(369,421,149,'04'),(370,421,149,'05'),(371,423,150,'04'),(372,423,150,'05'),(373,424,151,'04'),(374,424,151,'05'),(375,425,152,'04'),(376,425,152,'05'),(377,426,153,'05'),(378,427,154,'05'),(379,428,155,'04'),(380,428,155,'05'),(381,512,156,'17'),(382,512,156,'01'),(383,512,156,'03'),(384,512,157,'17'),(385,512,157,'01'),(386,512,157,'03'),(387,512,158,'01'),(388,512,158,'03'),(389,512,159,'17'),(390,512,159,'01'),(391,512,160,'17'),(392,512,160,'01'),(393,512,161,'17'),(394,512,161,'01'),(395,512,161,'03'),(396,512,162,'10'),(397,512,162,'11'),(398,512,163,'10'),(399,512,163,'11'),(400,512,164,'10'),(401,512,164,'11'),(402,512,165,'11'),(403,512,166,'10'),(404,512,166,'11'),(405,512,167,'10'),(406,512,167,'11'),(407,512,168,'10'),(408,512,168,'11'),(409,512,169,'10'),(410,512,169,'11'),(411,514,170,'05'),(412,514,171,'05'),(413,514,172,'05'),(414,514,173,'05'),(415,514,174,'05'),(416,515,175,'07'),(417,515,175,'12'),(418,515,175,'05'),(419,516,176,'07'),(420,516,176,'12'),(421,516,176,'05'),(422,516,177,'05'),(423,535,178,'04'),(424,611,179,'05'),(425,611,180,'05'),(426,611,181,'05'),(427,611,182,'05'),(428,612,183,'05'),(429,613,184,'05'),(430,613,185,'05'),(431,615,186,'05'),(432,615,187,'05'),(433,619,188,'05'),(434,619,189,'05'),(435,638,190,'05'),(436,639,191,'05'),(437,639,192,'05'),(438,640,193,'05'),(439,641,194,'05'),(440,641,195,'05'),(441,642,196,'04'),(442,644,197,'04'),(443,649,198,'05'),(444,649,199,'05'),(445,650,200,'04'),(446,651,201,'04'),(447,652,202,'04'),(448,653,203,'05'),(449,654,204,'05');
/*!40000 ALTER TABLE `prices_foodproductranks` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2021-11-16  8:11:00
