-- MySQL dump 10.13  Distrib 8.0.38, for Win64 (x86_64)
--
-- Host: localhost    Database: vaccinedb
-- ------------------------------------------------------
-- Server version	9.0.1

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
INSERT INTO `auth_permission` VALUES (1,'Can add log entry',1,'add_logentry'),(2,'Can change log entry',1,'change_logentry'),(3,'Can delete log entry',1,'delete_logentry'),(4,'Can view log entry',1,'view_logentry'),(5,'Can add permission',2,'add_permission'),(6,'Can change permission',2,'change_permission'),(7,'Can delete permission',2,'delete_permission'),(8,'Can view permission',2,'view_permission'),(9,'Can add group',3,'add_group'),(10,'Can change group',3,'change_group'),(11,'Can delete group',3,'delete_group'),(12,'Can view group',3,'view_group'),(13,'Can add content type',4,'add_contenttype'),(14,'Can change content type',4,'change_contenttype'),(15,'Can delete content type',4,'delete_contenttype'),(16,'Can view content type',4,'view_contenttype'),(17,'Can add session',5,'add_session'),(18,'Can change session',5,'change_session'),(19,'Can delete session',5,'delete_session'),(20,'Can view session',5,'view_session'),(21,'Can add category',6,'add_category'),(22,'Can change category',6,'change_category'),(23,'Can delete category',6,'delete_category'),(24,'Can view category',6,'view_category'),(25,'Can add user',7,'add_user'),(26,'Can change user',7,'change_user'),(27,'Can delete user',7,'delete_user'),(28,'Can view user',7,'view_user'),(29,'Can add vaccine',8,'add_vaccine'),(30,'Can change vaccine',8,'change_vaccine'),(31,'Can delete vaccine',8,'delete_vaccine'),(32,'Can view vaccine',8,'view_vaccine'),(33,'Can add application',9,'add_application'),(34,'Can change application',9,'change_application'),(35,'Can delete application',9,'delete_application'),(36,'Can view application',9,'view_application'),(37,'Can add access token',10,'add_accesstoken'),(38,'Can change access token',10,'change_accesstoken'),(39,'Can delete access token',10,'delete_accesstoken'),(40,'Can view access token',10,'view_accesstoken'),(41,'Can add grant',11,'add_grant'),(42,'Can change grant',11,'change_grant'),(43,'Can delete grant',11,'delete_grant'),(44,'Can view grant',11,'view_grant'),(45,'Can add refresh token',12,'add_refreshtoken'),(46,'Can change refresh token',12,'change_refreshtoken'),(47,'Can delete refresh token',12,'delete_refreshtoken'),(48,'Can view refresh token',12,'view_refreshtoken'),(49,'Can add id token',13,'add_idtoken'),(50,'Can change id token',13,'change_idtoken'),(51,'Can delete id token',13,'delete_idtoken'),(52,'Can view id token',13,'view_idtoken'),(53,'Can add vaccination campaign',14,'add_vaccinationcampaign'),(54,'Can change vaccination campaign',14,'change_vaccinationcampaign'),(55,'Can delete vaccination campaign',14,'delete_vaccinationcampaign'),(56,'Can view vaccination campaign',14,'view_vaccinationcampaign'),(57,'Can add dose',15,'add_dose'),(58,'Can change dose',15,'change_dose'),(59,'Can delete dose',15,'delete_dose'),(60,'Can view dose',15,'view_dose'),(61,'Can add injection',16,'add_injection'),(62,'Can change injection',16,'change_injection'),(63,'Can delete injection',16,'delete_injection'),(64,'Can view injection',16,'view_injection');
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
  KEY `django_admin_log_user_id_c564eba6_fk_vaccines_user_id` (`user_id`),
  CONSTRAINT `django_admin_log_content_type_id_c4bce8eb_fk_django_co` FOREIGN KEY (`content_type_id`) REFERENCES `django_content_type` (`id`),
  CONSTRAINT `django_admin_log_user_id_c564eba6_fk_vaccines_user_id` FOREIGN KEY (`user_id`) REFERENCES `vaccines_user` (`id`),
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
INSERT INTO `django_content_type` VALUES (1,'admin','logentry'),(3,'auth','group'),(2,'auth','permission'),(4,'contenttypes','contenttype'),(10,'oauth2_provider','accesstoken'),(9,'oauth2_provider','application'),(11,'oauth2_provider','grant'),(13,'oauth2_provider','idtoken'),(12,'oauth2_provider','refreshtoken'),(5,'sessions','session'),(6,'vaccines','category'),(15,'vaccines','dose'),(16,'vaccines','injection'),(7,'vaccines','user'),(14,'vaccines','vaccinationcampaign'),(8,'vaccines','vaccine');
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
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `django_migrations`
--

LOCK TABLES `django_migrations` WRITE;
/*!40000 ALTER TABLE `django_migrations` DISABLE KEYS */;
INSERT INTO `django_migrations` VALUES (1,'contenttypes','0001_initial','2025-04-23 09:18:29.867285'),(2,'contenttypes','0002_remove_content_type_name','2025-04-23 09:18:29.979785'),(3,'auth','0001_initial','2025-04-23 09:18:30.553685'),(4,'auth','0002_alter_permission_name_max_length','2025-04-23 09:18:30.695614'),(5,'auth','0003_alter_user_email_max_length','2025-04-23 09:18:30.707351'),(6,'auth','0004_alter_user_username_opts','2025-04-23 09:18:30.718957'),(7,'auth','0005_alter_user_last_login_null','2025-04-23 09:18:30.731833'),(8,'auth','0006_require_contenttypes_0002','2025-04-23 09:18:30.743989'),(9,'auth','0007_alter_validators_add_error_messages','2025-04-23 09:18:30.754601'),(10,'auth','0008_alter_user_username_max_length','2025-04-23 09:18:30.765912'),(11,'auth','0009_alter_user_last_name_max_length','2025-04-23 09:18:30.778156'),(12,'auth','0010_alter_group_name_max_length','2025-04-23 09:18:30.809026'),(13,'auth','0011_update_proxy_permissions','2025-04-23 09:18:30.824340'),(14,'auth','0012_alter_user_first_name_max_length','2025-04-23 09:18:30.840452'),(15,'vaccines','0001_initial','2025-04-23 09:18:31.965093'),(16,'admin','0001_initial','2025-04-23 09:18:32.258721'),(17,'admin','0002_logentry_remove_auto_add','2025-04-23 09:18:32.269965'),(18,'admin','0003_logentry_add_action_flag_choices','2025-04-23 09:18:32.282246'),(19,'oauth2_provider','0001_initial','2025-04-23 09:18:33.562443'),(20,'oauth2_provider','0002_auto_20190406_1805','2025-04-23 09:18:33.650210'),(21,'oauth2_provider','0003_auto_20201211_1314','2025-04-23 09:18:33.766165'),(22,'oauth2_provider','0004_auto_20200902_2022','2025-04-23 09:18:34.320525'),(23,'oauth2_provider','0005_auto_20211222_2352','2025-04-23 09:18:34.376644'),(24,'oauth2_provider','0006_alter_application_client_secret','2025-04-23 09:18:34.407017'),(25,'oauth2_provider','0007_application_post_logout_redirect_uris','2025-04-23 09:18:34.455992'),(26,'oauth2_provider','0008_alter_accesstoken_token','2025-04-23 09:18:34.471958'),(27,'oauth2_provider','0009_add_hash_client_secret','2025-04-23 09:18:34.546896'),(28,'oauth2_provider','0010_application_allowed_origins','2025-04-23 09:18:34.597542'),(29,'oauth2_provider','0011_refreshtoken_token_family','2025-04-23 09:18:34.645403'),(30,'oauth2_provider','0012_add_token_checksum','2025-04-23 09:18:35.004592'),(31,'sessions','0001_initial','2025-04-23 09:18:35.061341'),(32,'vaccines','0002_vaccinationcampaign_dose_injection','2025-04-24 10:08:14.292908'),(33,'vaccines','0003_remove_vaccine_outline_dose_note','2025-04-24 10:08:14.297709');
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
-- Table structure for table `oauth2_provider_accesstoken`
--

DROP TABLE IF EXISTS `oauth2_provider_accesstoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2_provider_accesstoken` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `token` longtext NOT NULL,
  `expires` datetime(6) NOT NULL,
  `scope` longtext NOT NULL,
  `application_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `source_refresh_token_id` bigint DEFAULT NULL,
  `id_token_id` bigint DEFAULT NULL,
  `token_checksum` varchar(64) NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `oauth2_provider_accesstoken_token_checksum_85319a26_uniq` (`token_checksum`),
  UNIQUE KEY `source_refresh_token_id` (`source_refresh_token_id`),
  UNIQUE KEY `id_token_id` (`id_token_id`),
  KEY `oauth2_provider_acce_application_id_b22886e1_fk_oauth2_pr` (`application_id`),
  KEY `oauth2_provider_accesstoken_user_id_6e4c9a65_fk_vaccines_user_id` (`user_id`),
  CONSTRAINT `oauth2_provider_acce_application_id_b22886e1_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  CONSTRAINT `oauth2_provider_acce_id_token_id_85db651b_fk_oauth2_pr` FOREIGN KEY (`id_token_id`) REFERENCES `oauth2_provider_idtoken` (`id`),
  CONSTRAINT `oauth2_provider_acce_source_refresh_token_e66fbc72_fk_oauth2_pr` FOREIGN KEY (`source_refresh_token_id`) REFERENCES `oauth2_provider_refreshtoken` (`id`),
  CONSTRAINT `oauth2_provider_accesstoken_user_id_6e4c9a65_fk_vaccines_user_id` FOREIGN KEY (`user_id`) REFERENCES `vaccines_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_accesstoken`
--

LOCK TABLES `oauth2_provider_accesstoken` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_accesstoken` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth2_provider_accesstoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_provider_application`
--

DROP TABLE IF EXISTS `oauth2_provider_application`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2_provider_application` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `client_id` varchar(100) NOT NULL,
  `redirect_uris` longtext NOT NULL,
  `client_type` varchar(32) NOT NULL,
  `authorization_grant_type` varchar(32) NOT NULL,
  `client_secret` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `user_id` bigint DEFAULT NULL,
  `skip_authorization` tinyint(1) NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `algorithm` varchar(5) NOT NULL,
  `post_logout_redirect_uris` longtext NOT NULL,
  `hash_client_secret` tinyint(1) NOT NULL,
  `allowed_origins` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `client_id` (`client_id`),
  KEY `oauth2_provider_application_user_id_79829054_fk_vaccines_user_id` (`user_id`),
  KEY `oauth2_provider_application_client_secret_53133678` (`client_secret`),
  CONSTRAINT `oauth2_provider_application_user_id_79829054_fk_vaccines_user_id` FOREIGN KEY (`user_id`) REFERENCES `vaccines_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_application`
--

LOCK TABLES `oauth2_provider_application` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_application` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth2_provider_application` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_provider_grant`
--

DROP TABLE IF EXISTS `oauth2_provider_grant`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2_provider_grant` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `code` varchar(255) NOT NULL,
  `expires` datetime(6) NOT NULL,
  `redirect_uri` longtext NOT NULL,
  `scope` longtext NOT NULL,
  `application_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `code_challenge` varchar(128) NOT NULL,
  `code_challenge_method` varchar(10) NOT NULL,
  `nonce` varchar(255) NOT NULL,
  `claims` longtext NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `code` (`code`),
  KEY `oauth2_provider_gran_application_id_81923564_fk_oauth2_pr` (`application_id`),
  KEY `oauth2_provider_grant_user_id_e8f62af8_fk_vaccines_user_id` (`user_id`),
  CONSTRAINT `oauth2_provider_gran_application_id_81923564_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  CONSTRAINT `oauth2_provider_grant_user_id_e8f62af8_fk_vaccines_user_id` FOREIGN KEY (`user_id`) REFERENCES `vaccines_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_grant`
--

LOCK TABLES `oauth2_provider_grant` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_grant` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth2_provider_grant` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_provider_idtoken`
--

DROP TABLE IF EXISTS `oauth2_provider_idtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2_provider_idtoken` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `jti` char(32) NOT NULL,
  `expires` datetime(6) NOT NULL,
  `scope` longtext NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `application_id` bigint DEFAULT NULL,
  `user_id` bigint DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `jti` (`jti`),
  KEY `oauth2_provider_idto_application_id_08c5ff4f_fk_oauth2_pr` (`application_id`),
  KEY `oauth2_provider_idtoken_user_id_dd512b59_fk_vaccines_user_id` (`user_id`),
  CONSTRAINT `oauth2_provider_idto_application_id_08c5ff4f_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  CONSTRAINT `oauth2_provider_idtoken_user_id_dd512b59_fk_vaccines_user_id` FOREIGN KEY (`user_id`) REFERENCES `vaccines_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_idtoken`
--

LOCK TABLES `oauth2_provider_idtoken` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_idtoken` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth2_provider_idtoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `oauth2_provider_refreshtoken`
--

DROP TABLE IF EXISTS `oauth2_provider_refreshtoken`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `oauth2_provider_refreshtoken` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `token` varchar(255) NOT NULL,
  `access_token_id` bigint DEFAULT NULL,
  `application_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `created` datetime(6) NOT NULL,
  `updated` datetime(6) NOT NULL,
  `revoked` datetime(6) DEFAULT NULL,
  `token_family` char(32) DEFAULT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `access_token_id` (`access_token_id`),
  UNIQUE KEY `oauth2_provider_refreshtoken_token_revoked_af8a5134_uniq` (`token`,`revoked`),
  KEY `oauth2_provider_refr_application_id_2d1c311b_fk_oauth2_pr` (`application_id`),
  KEY `oauth2_provider_refr_user_id_da837fce_fk_vaccines_` (`user_id`),
  CONSTRAINT `oauth2_provider_refr_access_token_id_775e84e8_fk_oauth2_pr` FOREIGN KEY (`access_token_id`) REFERENCES `oauth2_provider_accesstoken` (`id`),
  CONSTRAINT `oauth2_provider_refr_application_id_2d1c311b_fk_oauth2_pr` FOREIGN KEY (`application_id`) REFERENCES `oauth2_provider_application` (`id`),
  CONSTRAINT `oauth2_provider_refr_user_id_da837fce_fk_vaccines_` FOREIGN KEY (`user_id`) REFERENCES `vaccines_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `oauth2_provider_refreshtoken`
--

LOCK TABLES `oauth2_provider_refreshtoken` WRITE;
/*!40000 ALTER TABLE `oauth2_provider_refreshtoken` DISABLE KEYS */;
/*!40000 ALTER TABLE `oauth2_provider_refreshtoken` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vaccines_category`
--

DROP TABLE IF EXISTS `vaccines_category`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vaccines_category` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=36 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vaccines_category`
--

LOCK TABLES `vaccines_category` WRITE;
/*!40000 ALTER TABLE `vaccines_category` DISABLE KEYS */;
INSERT INTO `vaccines_category` VALUES (1,'Vắc xin 5in1','https://vnvc.vn/wp-content/uploads/2022/05/iterm-2.png'),(2,'Vắc xin Viêm gan B người lớn','https://vnvc.vn/wp-content/uploads/2022/05/iterm-2-1.png'),(3,'Vắc xin 4in1','https://vnvc.vn/wp-content/uploads/2022/05/iterm-16.png'),(4,'Vắc xin Rota Virus','https://vnvc.vn/wp-content/uploads/2022/05/iterm-3.png'),(5,'Vắc xin 3in1','https://vnvc.vn/wp-content/uploads/2022/05/iterm-9-1.png'),(6,'Vắc xin Viêm não Nhật bản','https://vnvc.vn/wp-content/uploads/2022/05/iterm-1-2.png'),(7,'Vắc xin Phế cầu khuẩn','https://vnvc.vn/wp-content/uploads/2022/05/iterm-4.png'),(8,'Vắc xin Viêm gan A','https://vnvc.vn/wp-content/uploads/2022/05/iterm-12.png'),(9,'Vắc xin Viêm gan A+B','https://vnvc.vn/wp-content/uploads/2022/05/iterm-7-1.png'),(10,'Vắc xin phòng Lao','https://vnvc.vn/wp-content/uploads/2022/05/iterm-5.png'),(11,'Vắc xin phòng Ung thư cổ tử cung và các bệnh do HPV','https://vnvc.vn/wp-content/uploads/2022/05/iterm-3-1.png'),(12,'Vắc xin Uốn ván','https://vnvc.vn/wp-content/uploads/2022/05/iterm-4-1.png'),(13,'Vắc xin Viêm gan B Trẻ em','https://vnvc.vn/wp-content/uploads/2022/05/iterm-6.png'),(14,'Vắc xin Thương hàn','https://vnvc.vn/wp-content/uploads/2022/05/iterm-5-1.png'),(15,'Vắc xin phòng Tả','https://vnvc.vn/wp-content/uploads/2022/05/iterm-6-1.png'),(16,'Vắc xin phòng Tả','https://vnvc.vn/wp-content/uploads/2022/05/iterm-7.png'),(17,'Vắc xin Viêm màng não do HIB','https://vnvc.vn/wp-content/uploads/2022/05/iterm-10-1.png'),(18,'Vắc xin phòng Dại','https://vnvc.vn/wp-content/uploads/2022/05/iterm-11-1.png'),(19,'Vắc xin phòng Cúm','https://vnvc.vn/wp-content/uploads/2022/05/iterm-8.png'),(20,'Vắc xin Sốt vàng','https://vnvc.vn/wp-content/uploads/2022/05/iterm-12-1.png'),(21,'Vắc xin 6in1','https://vnvc.vn/wp-content/uploads/2022/05/iterm-1-1.png'),(22,'Vắc xin phòng Sởi','https://vnvc.vn/wp-content/uploads/2022/05/iterm-9.png'),(23,'Vắc xin Uốn Ván- Bạch Hầu','https://vnvc.vn/wp-content/uploads/2022/05/iterm-1-1.png'),(24,'Vắc xin phòng Sởi - Quai bị - Rubella','https://vnvc.vn/wp-content/uploads/2022/05/iterm-10.png'),(25,'Huyết thanh phòng Uốn ván','https://vnvc.vn/wp-content/uploads/2022/05/iterm-2.png'),(26,'Vắc xin phòng Thủy đậu','https://vnvc.vn/wp-content/uploads/2022/05/iterm-11.png'),(27,'Vắc xin Covid-19','https://vnvc.vn/wp-content/uploads/2022/05/iterm-15.png'),(28,'Vắc xin cho Trẻ 0 đến dưới 2 tháng tuổi','https://vnvc.vn/wp-content/uploads/2022/05/iterm-1-3.png'),(29,'Vắc xin cho Trẻ 7 đến 12 tháng tuổi','https://vnvc.vn/wp-content/uploads/2022/05/iterm-3-2.png'),(30,'Vắc xin cho Trẻ 13 đến 24 tháng tuổi','https://vnvc.vn/wp-content/uploads/2022/05/iterm-4-2.png'),(31,'Vắc xin dành cho Trẻ tiền học đường','https://vnvc.vn/wp-content/uploads/2022/05/iterm-7-2.png'),(32,'Vắc xin cho Trẻ vị thành niên','https://vnvc.vn/wp-content/uploads/2022/05/iterm-8-1.png'),(33,'Vắc xin cho Phụ nữ trước mang thai','https://vnvc.vn/wp-content/uploads/2022/05/iterm-9-2.png'),(34,'Vắc xin cho Người trưởng thành','https://vnvc.vn/wp-content/uploads/2022/05/iterm-10-2.png'),(35,'Vắc xin cho Trẻ 2 đến 6 tháng tuổi','https://vnvc.vn/wp-content/uploads/2022/05/iterm-2-2.png');
/*!40000 ALTER TABLE `vaccines_category` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vaccines_dose`
--

DROP TABLE IF EXISTS `vaccines_dose`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vaccines_dose` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `number` int NOT NULL,
  `days_after_previous` int NOT NULL,
  `vaccine_id` varchar(255) NOT NULL,
  `note` longtext,
  PRIMARY KEY (`id`),
  KEY `vaccines_dose_vaccine_id_cb65a632_fk_vaccines_vaccine_id` (`vaccine_id`),
  CONSTRAINT `vaccines_dose_vaccine_id_cb65a632_fk_vaccines_vaccine_id` FOREIGN KEY (`vaccine_id`) REFERENCES `vaccines_vaccine` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=173 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

ALTER TABLE vaccines_dose AUTO_INCREMENT = 1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vaccines_dose`
--

LOCK TABLES `vaccines_dose` WRITE;
/*!40000 ALTER TABLE `vaccines_dose` DISABLE KEYS */;
INSERT INTO `vaccines_dose` (`vaccine_id`, `number`, `days_after_previous`, `note`) VALUES
-- MMR
('vac-xin-mmr', 1, 0, 'Tiêm khi trẻ 12-15 tháng tuổi'),
('vac-xin-mmr', 2, 1095, 'Tiêm khi trẻ 4-6 tuổi'),

-- Shingrix
('vac-xin-shingrix', 1, 0, 'Người từ 18 tuổi trở lên có nguy cơ cao'),

-- Bexsero
('vac-xin-bexsero', 1, 0, 'Trẻ từ 2-6 tháng tuổi'),
('vac-xin-bexsero', 2, 60, 'Cách mũi 1 ít nhất 2 tháng'),

-- Vaxigrip Tetra
('vaxigrip-tetra', 1, 0, 'Trẻ từ 6 tháng đến dưới 9 tuổi'),
('vaxigrip-tetra', 2, 28, 'Cách mũi 1 ít nhất 4 tuần'),

-- VA-Mengoc-BC
('va-mengoc-bc-vac-xin-phong-viem-mang-nao-nao-mo-cau-b-c', 1, 0, 'Mũi đầu tiên'),
('va-mengoc-bc-vac-xin-phong-viem-mang-nao-nao-mo-cau-b-c', 2, 45, 'Cách mũi 1 45 ngày'),

-- Rotavin
('rotavin-m1-vac-xin-phong-benh-tieu-chay-cap-rotavirus', 1, 0, 'Có thể uống từ 6 tuần tuổi'),
('rotavin-m1-vac-xin-phong-benh-tieu-chay-cap-rotavirus', 2, 28, 'Cách mũi 1 ít nhất 4 tuần'),

-- Rotateq
('vac-xin-rotateq', 1, 0, 'Khi trẻ 7.5-12 tuần tuổi'),
('vac-xin-rotateq', 2, 28, 'Cách mũi 1 ít nhất 4 tuần'),
('vac-xin-rotateq', 3, 28, 'Cách mũi 2 ít nhất 4 tuần'),

-- Rotarix
('vac-xin-rotarix', 1, 0, 'Có thể uống từ 6 tuần tuổi'),
('vac-xin-rotarix', 2, 28, 'Cách mũi 1 ít nhất 4 tuần'),

-- BCG
('bcg-vac-xin-phong-lao', 1, 0, 'Chỉ tiêm 1 mũi duy nhất'),

-- Synflorix
('synflorix-vac-xin-phong-viem-nao-viem-phoi-nhiem-khuan-huyet-viem-tai-giua-h-influenzae-khong-dinh-tuyp', 1, 0, '2 tháng tuổi'),
('synflorix-vac-xin-phong-viem-nao-viem-phoi-nhiem-khuan-huyet-viem-tai-giua-h-influenzae-khong-dinh-tuyp', 2, 30, '3 tháng tuổi'),
('synflorix-vac-xin-phong-viem-nao-viem-phoi-nhiem-khuan-huyet-viem-tai-giua-h-influenzae-khong-dinh-tuyp', 3, 30, '4 tháng tuổi'),
('synflorix-vac-xin-phong-viem-nao-viem-phoi-nhiem-khuan-huyet-viem-tai-giua-h-influenzae-khong-dinh-tuyp', 4, 180, 'Mũi nhắc sau 6 tháng'),

-- MMR-II
('mmr-ii-vac-xin-phong-3-benh-soi-quai-bi-rubella', 1, 0, 'Trẻ từ 12 tháng tuổi'),
('mmr-ii-vac-xin-phong-3-benh-soi-quai-bi-rubella', 2, 90, '3 tháng sau mũi 1 hoặc 4-6 tuổi'),

-- Influvac Tetra
('influvac-tetra', 1, 0, 'Trẻ từ 6 tháng đến dưới 9 tuổi'),
('influvac-tetra', 2, 28, 'Cách mũi 1 ít nhất 4 tuần'),

-- Heberbiovac HB
('heberbiovac-hb', 1, 0, 'Mũi đầu tiên'),
('heberbiovac-hb', 2, 30, '1 tháng sau mũi 1'),
('heberbiovac-hb', 3, 180, '6 tháng sau mũi 1'),

-- GC FLU Quadrivalent
('gcflu-quadrivalent', 1, 0, 'Trẻ từ 6 tháng đến 9 tuổi'),
('gcflu-quadrivalent', 2, 28, 'Cách mũi 1 ít nhất 4 tuần'),

-- Euvax B
('vac-xin-euvax-b', 1, 0, 'Mũi đầu tiên'),
('vac-xin-euvax-b', 2, 30, '1 tháng sau mũi 1'),
('vac-xin-euvax-b', 3, 180, '6 tháng sau mũi 1'),

-- Engerix B
('engerix-b-vac-xin-phong-viem-gan-b', 1, 0, 'Mũi đầu tiên'),
('engerix-b-vac-xin-phong-viem-gan-b', 2, 30, '1 tháng sau mũi 1'),
('engerix-b-vac-xin-phong-viem-gan-b', 3, 150, '5 tháng sau mũi 2'),

-- Boostrix
('boostrix', 1, 0, 'Trẻ từ 4 tuổi trở lên đã tiêm lịch cơ bản'),

-- Prevenar 13
('prevenar-13-vac-xin-phong-benh-viem-phoi-viem-mang-nao-viem-tai-giua-nhiem-khuan-huyet-phe-cau-khuan', 1, 0, 'Trẻ từ 6 tuần tuổi'),
('prevenar-13-vac-xin-phong-benh-viem-phoi-viem-mang-nao-viem-tai-giua-nhiem-khuan-huyet-phe-cau-khuan', 2, 30, '1 tháng sau mũi 1'),
('prevenar-13-vac-xin-phong-benh-viem-phoi-viem-mang-nao-viem-tai-giua-nhiem-khuan-huyet-phe-cau-khuan', 3, 30, '1 tháng sau mũi 2'),
('prevenar-13-vac-xin-phong-benh-viem-phoi-viem-mang-nao-viem-tai-giua-nhiem-khuan-huyet-phe-cau-khuan', 4, 240, '8 tháng sau mũi 3'),

-- Gene-HBVax
('vac-xin-gene-hbvax', 1, 0, 'Mũi đầu tiên'),
('vac-xin-gene-hbvax', 2, 28, 'Cách mũi 1 ít nhất 4 tuần'),
('vac-xin-gene-hbvax', 3, 180, '6 tháng sau mũi 1'),

-- Priorix
('vac-xin-priorix', 1, 0, 'Trẻ từ 9-12 tháng tuổi'),
('vac-xin-priorix', 2, 90, '3 tháng sau mũi 1'),

-- MRVac
('vac-xin-mrvac', 1, 0, 'Trẻ từ 12 tháng tuổi trở lên'),

-- Abhayrab
('vac-xin-abhayrab', 1, 0, 'Ngày 0'),
('vac-xin-abhayrab', 2, 7, 'Ngày 7'),
('vac-xin-abhayrab', 3, 21, 'Ngày 21 hoặc 28'),

-- Gardasil-9
('vac-xin-gardasil-9', 1, 0, 'Trẻ từ 9-15 tuổi'),
('vac-xin-gardasil-9', 2, 180, '6-12 tháng sau mũi 1'),

-- Qdenga
('vac-xin-qdenga', 1, 0, 'Người từ 4 tuổi trở lên'),
('vac-xin-qdenga', 2, 90, '3 tháng sau mũi 1'),

-- Menactra
('menactra-vac-xin-nao-mo-cau-nhom-acy-va-w-135-polysaccharide-cong-hop-giai-doc-bach-hau', 1, 0, 'Trẻ từ 9 tháng đến dưới 24 tháng'),
('menactra-vac-xin-nao-mo-cau-nhom-acy-va-w-135-polysaccharide-cong-hop-giai-doc-bach-hau', 2, 90, '3 tháng sau mũi 1'),

-- Pentaxim
('pentaxim-vac-xin-5-trong-1', 1, 0, 'Mũi đầu tiên'),
('pentaxim-vac-xin-5-trong-1', 2, 30, '1 tháng sau mũi 1'),
('pentaxim-vac-xin-5-trong-1', 3, 30, '1 tháng sau mũi 2'),
('pentaxim-vac-xin-5-trong-1', 4, 365, '1 năm sau mũi 3'),

-- Infanrix IPV+Hib
('vac-xin-5-trong-1-infanrix-ipv-hib', 1, 0, 'Mũi đầu tiên'),
('vac-xin-5-trong-1-infanrix-ipv-hib', 2, 30, '1 tháng sau mũi 1'),
('vac-xin-5-trong-1-infanrix-ipv-hib', 3, 30, '1 tháng sau mũi 2'),
('vac-xin-5-trong-1-infanrix-ipv-hib', 4, 180, '6 tháng sau mũi 3'),

-- Gardasil
('gardasil-vac-xin-phong-ung-thu-co-tu-cung', 1, 0, 'Mũi đầu tiên'),
('gardasil-vac-xin-phong-ung-thu-co-tu-cung', 2, 60, '2 tháng sau mũi 1'),
('gardasil-vac-xin-phong-ung-thu-co-tu-cung', 3, 180, '6 tháng sau mũi 1'),

-- Stamaril
('stamaril-vac-xin-phong-benh-sot-vang', 1, 0, 'Mũi duy nhất'),

-- Pneumovax 23
('vac-xin-pneumovax-23', 1, 0, 'Trẻ từ 2 tuổi trở lên'),

-- Infanrix Hexa
('infanrix-vac-xin-6-trong-1', 1, 0, 'Mũi đầu tiên'),
('infanrix-vac-xin-6-trong-1', 2, 30, '1 tháng sau mũi 1'),
('infanrix-vac-xin-6-trong-1', 3, 30, '1 tháng sau mũi 2'),
('infanrix-vac-xin-6-trong-1', 4, 180, '6 tháng sau mũi 3'),

-- Hexaxim
('hexaxim-vac-xin-6-trong-1', 1, 0, 'Mũi đầu tiên'),
('hexaxim-vac-xin-6-trong-1', 2, 30, '1 tháng sau mũi 1'),
('hexaxim-vac-xin-6-trong-1', 3, 30, '1 tháng sau mũi 2'),
('hexaxim-vac-xin-6-trong-1', 4, 180, '6 tháng sau mũi 3'),

-- Varicella
('vac-xin-varicella', 1, 0, 'Trẻ từ 12 tháng đến 12 tuổi'),
('vac-xin-varicella', 2, 90, '3 tháng sau mũi 1'),

-- Varivax
('varivax-vac-xin-phong-thuy-dau', 1, 0, 'Trẻ từ 12 tháng đến 12 tuổi'),
('varivax-vac-xin-phong-thuy-dau', 2, 90, '3 tháng sau mũi 1'),

-- Varilrix
('varilrix-vac-xin-phong-benh-thuy-dau', 1, 0, 'Trẻ từ 9 tháng đến 12 tuổi'),
('varilrix-vac-xin-phong-benh-thuy-dau', 2, 90, '3 tháng sau mũi 1'),

-- Uốn ván (huyết thanh)
('huyet-thanh-uon-van-sat', 1, 0, 'Phương pháp Besredka: 0.1ml'),
('huyet-thanh-uon-van-sat', 2, 0, 'Phương pháp Besredka: 0.25ml sau 30 phút'),
('huyet-thanh-uon-van-sat', 3, 0, 'Phương pháp Besredka: liều còn lại sau 30 phút');
/*!40000 ALTER TABLE `vaccines_dose` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vaccines_injection`
--

DROP TABLE IF EXISTS `vaccines_injection`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vaccines_injection` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `injection_time` datetime(6) NOT NULL,
  `dose_id` bigint NOT NULL,
  `user_id` bigint NOT NULL,
  `vaccination_campaign_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  KEY `vaccines_injection_dose_id_81e0280f_fk_vaccines_dose_id` (`dose_id`),
  KEY `vaccines_injection_user_id_e6343626_fk_vaccines_user_id` (`user_id`),
  KEY `vaccines_injection_vaccination_campaign_8ac15d43_fk_vaccines_` (`vaccination_campaign_id`),
  CONSTRAINT `vaccines_injection_dose_id_81e0280f_fk_vaccines_dose_id` FOREIGN KEY (`dose_id`) REFERENCES `vaccines_dose` (`id`),
  CONSTRAINT `vaccines_injection_user_id_e6343626_fk_vaccines_user_id` FOREIGN KEY (`user_id`) REFERENCES `vaccines_user` (`id`),
  CONSTRAINT `vaccines_injection_vaccination_campaign_8ac15d43_fk_vaccines_` FOREIGN KEY (`vaccination_campaign_id`) REFERENCES `vaccines_vaccinationcampaign` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vaccines_injection`
--

LOCK TABLES `vaccines_injection` WRITE;
/*!40000 ALTER TABLE `vaccines_injection` DISABLE KEYS */;
/*!40000 ALTER TABLE `vaccines_injection` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vaccines_user`
--

DROP TABLE IF EXISTS `vaccines_user`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vaccines_user` (
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
) ENGINE=InnoDB AUTO_INCREMENT=2 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vaccines_user`
--

LOCK TABLES `vaccines_user` WRITE;
/*!40000 ALTER TABLE `vaccines_user` DISABLE KEYS */;
INSERT INTO `vaccines_user` VALUES (1,'pbkdf2_sha256$1000000$lTzdW8RGoOwDNJ695qiryP$chI8dko5VxKsXGjkuqgd5NTCpvl5PvH0En+YAMWX+s8=',NULL,1,'admin','','','admin@gmail.com',1,1,'2025-04-23 09:19:46.852091');
/*!40000 ALTER TABLE `vaccines_user` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vaccines_user_groups`
--

DROP TABLE IF EXISTS `vaccines_user_groups`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vaccines_user_groups` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `group_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `vaccines_user_groups_user_id_group_id_8e573336_uniq` (`user_id`,`group_id`),
  KEY `vaccines_user_groups_group_id_55da7c37_fk_auth_group_id` (`group_id`),
  CONSTRAINT `vaccines_user_groups_group_id_55da7c37_fk_auth_group_id` FOREIGN KEY (`group_id`) REFERENCES `auth_group` (`id`),
  CONSTRAINT `vaccines_user_groups_user_id_7ae7bee9_fk_vaccines_user_id` FOREIGN KEY (`user_id`) REFERENCES `vaccines_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vaccines_user_groups`
--

LOCK TABLES `vaccines_user_groups` WRITE;
/*!40000 ALTER TABLE `vaccines_user_groups` DISABLE KEYS */;
/*!40000 ALTER TABLE `vaccines_user_groups` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vaccines_user_user_permissions`
--

DROP TABLE IF EXISTS `vaccines_user_user_permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vaccines_user_user_permissions` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `user_id` bigint NOT NULL,
  `permission_id` int NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `vaccines_user_user_permi_user_id_permission_id_82289a7a_uniq` (`user_id`,`permission_id`),
  KEY `vaccines_user_user_p_permission_id_9739121a_fk_auth_perm` (`permission_id`),
  CONSTRAINT `vaccines_user_user_p_permission_id_9739121a_fk_auth_perm` FOREIGN KEY (`permission_id`) REFERENCES `auth_permission` (`id`),
  CONSTRAINT `vaccines_user_user_p_user_id_58fff13d_fk_vaccines_` FOREIGN KEY (`user_id`) REFERENCES `vaccines_user` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vaccines_user_user_permissions`
--

LOCK TABLES `vaccines_user_user_permissions` WRITE;
/*!40000 ALTER TABLE `vaccines_user_user_permissions` DISABLE KEYS */;
/*!40000 ALTER TABLE `vaccines_user_user_permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vaccines_vaccinationcampaign`
--

DROP TABLE IF EXISTS `vaccines_vaccinationcampaign`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vaccines_vaccinationcampaign` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `start_date` datetime(6) NOT NULL,
  `end_date` datetime(6) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vaccines_vaccinationcampaign`
--

LOCK TABLES `vaccines_vaccinationcampaign` WRITE;
/*!40000 ALTER TABLE `vaccines_vaccinationcampaign` DISABLE KEYS */;
/*!40000 ALTER TABLE `vaccines_vaccinationcampaign` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vaccines_vaccine`
--

DROP TABLE IF EXISTS `vaccines_vaccine`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vaccines_vaccine` (
  `active` tinyint(1) NOT NULL DEFAULT '1',
  `created_date` datetime(6) NOT NULL,
  `updated_date` datetime(6) NOT NULL,
  `id` varchar(255) NOT NULL,
  `name` varchar(255) NOT NULL,
  `description` longtext NOT NULL,
  `origin` longtext NOT NULL,
  `injection` longtext NOT NULL,
  `recommend` longtext NOT NULL,
  `manual` longtext NOT NULL,
  `preserve` longtext NOT NULL,
  `patient` longtext NOT NULL,
  `effects` longtext NOT NULL,
  `disease` varchar(255) NOT NULL,
  `image` varchar(255) NOT NULL,
  `price` double NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vaccines_vaccine`
--

LOCK TABLES `vaccines_vaccine` WRITE;
/*!40000 ALTER TABLE `vaccines_vaccine` DISABLE KEYS */;
INSERT INTO `vaccines_vaccine` VALUES (1,'2025-04-23 16:25:19.472903','2025-04-23 16:25:19.472903','avaxim-vac-xin-phong-viem-gan','Vắc xin Avaxim','Vắc xin Avaxim 80U tạo miễn dịch chủ động phòng ngừa virus gây bệnh viêm gan siêu vi A.','Vắc xin Avaxim 80U được nghiên cứu và phát triển bởi tập đoàn hàng đầu thế giới về dược phẩm và chế phẩm sinh học Sanofi Pasteur (Pháp).','Tiêm bắp vào cơ delta trên cánh tay.','Hoãn việc tiêm chủng nếu có sốt hay nhiễm trùng cấp tính. Bệnh mãn tính trong giai đoạn tiến triển.\nKhông tiêm cho người bị dị ứng với hoạt chất, với bất kỳ thành phần tá dược nào có trong vắc xin, với neomycin, với polysorbate hoặc nếu trước đây đã từng bị mẩn mãn sau khi tiêm vắc xin này.','Trẻ bị suy giảm miễn dịch.\nTác dụng phòng bệnh sẽ mất đi nếu tiêm vắc xin trong thời kỳ ủ bệnh.\nTrong một số trường hợp đặc biệt, những người bị giảm tiểu cầu hay có nguy cơ bị chảy máu, thì có thể tiêm bằng đường tiêm dưới da.\nGiống như khi tiêm các vắc xin khác, luôn phải theo dõi và phòng ngừa phản ứng có hại, có sẵn thuốc cấp cứu chống phản ứng phản vệ sau khi tiêm vắc xin.','Vắc xin được bảo quản ở nhiệt độ từ 2 đến 8 độ C. Tránh ánh sáng. Không được đông băng.','Vắc xin Avaxim 80U được chỉ định cho trẻ từ 12 tháng đến dưới 16 tuổi.','Sau khi tiêm vắc xin phòng bệnh Viêm gan A, người tiêm hay gặp những phản ứng nhẹ, không kéo dài và không cần điều trị đặc biệt. Đó là sự đáp ứng miễn dịch của cơ thể, cụ thể như sau:\nTại chỗ tiêm: có thể sưng quầng đỏ tại chỗ tiêm 1-2 ngày.\nPhản ứng sau tiêm toàn thân: Sốt nhẹ, đau đầu, đau cơ, mệt mỏi,…','Viêm gan A','https://vnvc.vn/wp-content/uploads/2017/04/vac-xin-avaxim-80U.jpg',660000),(1,'2025-04-23 16:25:19.452798','2025-04-23 16:25:19.452798','bcg-vac-xin-phong-lao','Vắc xin BCG','Vắc xin BCG phòng ngừa hiệu quả các hình thái lao nguy hiểm, trong đó có lao viêm màng não với độ bảo vệ lên tới 70%. Vắc xin được khuyến cáo cho trẻ sơ sinh và trẻ nhỏ, chỉ cần tiêm 1 liều duy nhất có thể bảo vệ trọn đời, không cần tiêm nhắc lại.','Vắc xin phòng Lao – BCG (Bacille Calmette-Guerin) được sản xuất tại Việt Nam.','Tiêm trong da chính xác, ở mặt ngoài phía trên cánh tay hoặc vai trái.\nNhân viên y tế cần sử dụng bơm kim tiêm riêng để tiêm vắc xin BCG.','Không tiêm vắc xin phòng lao cho trẻ có dấu hiệu hoặc triệu chứng bệnh AIDS.\nCác trường hợp chống chỉ định khác theo hướng dẫn của nhà sản xuất vắc xin lao.','Phần lớn trẻ em đều có phản ứng tại vết tiêm, thông thường ngay sau khi tiêm BCG sẽ xuất hiện một nốt nhỏ tại chỗ tiêm và biến mất sau khoảng 30 phút. Sau khoảng 2 tuần sẽ xuất hiện một vết loét đỏ có kích thước bằng đầu bút chì. Sau đó 2 tuần vết loét tự lành tạo nên một vết sẹo nhỏ có đường kính 5mm.','Vắc xin BCG được bảo quản ở nhiệt độ 2-8 độ C (vắc xin không bị hỏng bởi đông băng nhưng dung môi thì không được đông băng). Sau khi hoàn nguyên dung dịch tiêm cần được bảo quản ở nhiệt độ 2-8 độ C trong vòng 6 giờ. Phần còn lại của lọ vắc xin sau mỗi buổi tiêm chủng hoặc sau 6 giờ cần phải hủy bỏ.','Vắc xin Lao (BCG) được chỉ định tiêm cho trẻ có cân nặng từ 2.000 gram trở lên và tiêm càng sớm càng tốt trong 30 ngày sau khi sinh.','Sau khi tiêm Lao thì bé có sốt không?\nSau khi tiêm vắc xin Lao, trẻ hay gặp những phản ứng nhẹ, không kéo dài và không cần điều trị đặc biệt. Đó là sự đáp ứng miễn dịch của cơ thể. Cụ thể như sau:\nTại chỗ tiêm: đau, sưng, nóng.\nToàn thân: Trẻ sốt nhẹ, quấy khóc, bú kém, thường hết sau một vài ngày.\nThông thường sau khi tiêm BCG, trẻ có thể xuất hiện nốt nhỏ tại chỗ tiêm và biến mất sau 30 phút. Khoảng 2 tuần xuất hiện một vết loét đỏ có kích thước nhỏ, sau 2 tuần vết loét tự lành và để lại sẹo khoảng 5mm, điều này chứng tỏ trẻ đã có miễn dịch.\nNếu trong thời gian đó xuất hiện hạch cổ, hạch nách, hạch dưới xương đòn trái, nốt mủ quá to tại chỗ tiêm (đường kính trên 1cm) cần đến cơ sở y tế khám lại ngay.','Lao','https://vnvc.vn/wp-content/uploads/2017/04/vac-xin-bcg.jpg',155000),(1,'2025-04-23 16:25:19.454792','2025-04-23 16:25:19.454792','boostrix','Vắc xin Boostrix','Vắc xin Boostrix (Bỉ) tạo đáp ứng kháng thể chống 3 bệnh ho gà – bạch hầu – uốn ván.','Vắc xin Boostrix được nghiên cứu và phát triển bởi tập đoàn hàng đầu thế giới về dược phẩm và chế phẩm sinh học Glaxosmithkline (GSK) – Bỉ.','Vắc xin Boostrix được chỉ định tiêm bắp với liều 0.5ml. Không được tiêm dưới da hoặc tĩnh mạch. Ở trẻ lớn và người lớn, thường tiêm vào cơ delta còn trẻ nhỏ thường vào mặt trước – bên đùi.','Tiền sử quá mẫn với thành phần của vắc xin. Quá mẫn sau khi tiêm vắc xin bạch hầu, ho gà hoặc uốn ván trước đó.\nNgười đã từng bị các biểu hiện về não: hôn mê, bất tỉnh, co giật kéo dài.\nNgười có tiền sử giảm tiểu cầu thoáng qua hoặc biến chứng thần kinh sau chủng ngừa bạch hầu và/hoặc uốn ván trước đó.','Đối tượng đang sốt cao cấp tính (hoãn tiêm cho đến khi trẻ hết sốt).\nTrẻ bị rối loạn thần kinh tiến triển bao gồm chứng co thắt, động kinh không kiểm soát hoặc bệnh não tiến triển (hoãn tiêm cho đến khi bệnh khỏi hoặc ổn định, hoặc cân nhắc nguy cơ/lợi ích).\nCân nhắc sử dụng đối với trường hợp sau tiêm chủng vắc xin có thành phần ho gà trong vòng 48 giờ có biểu hiện sốt, quấy khóc…','Vắc xin được bảo quản ở nhiệt độ từ 2 đến 8 độ C. Không được để đông băng.','Vắc xin Boostrix phòng ho gà – bạch hầu – uốn ván được chỉ định cho trẻ từ 4 tuổi trở lên và người lớn.','Sau tiêm vắc xin 3 trong 1 Boostrix có biểu hiện sốt không?\nSau khi tiêm vắc xin Boostrix, người tiêm hay gặp những phản ứng nhẹ, không kéo dài và không cần điều trị đặc biệt. Đó là sự đáp ứng miễn dịch của cơ thể. Cụ thể như sau:\nTrẻ em 4-9 tuổi: Chán ăn, ngủ gà gật, nhạy chỗ tiêm (đau, nổi ban đỏ hoặc sưng nhẹ – những triệu chứng này thường biến mất sau 72 giờ) và cáu kỉnh, nôn, tiêu chảy, rối loạn tiêu hóa; sốt ≥37.5oC.\nNgười lớn, thanh thiếu niên và trẻ em ≥10 tuổi: Đau đầu, nhạy chỗ tiêm (đau, nổi ban đỏ hoặc sưng nhẹ – những triệu chứng này thường biến mất sau 72 giờ), mệt mỏi, khó chịu chóng mặt; buồn nôn, rối loạn tiêu hóa; sốt ≥37.5°C.','Bạch hầu, ho gà, uốn ván','https://vnvc.vn/wp-content/uploads/2020/02/vac-xin-boostrix.jpg',795000),(1,'2025-04-23 16:25:19.479407','2025-04-23 16:25:19.479407','engerix-b-vac-xin-phong-viem-gan-b','Vắc xin Engerix B','Vắc xin Engerix B phòng bệnh do virus viêm gan B – loại virus này có thể lây truyền qua đường máu, qua quan hệ tình dục và từ mẹ truyền sang con.','Vắc xin Engerix được nghiên cứu và phát triển bởi tập đoàn hàng đầu thế giới về dược phẩm và chế phẩm sinh học Glaxosmithkline (GSK) – Bỉ.','Engerix B được chỉ định tiêm bắp (vùng cơ delta). Ngoại lệ với những bệnh nhân bị rối loạn chảy máu hay giảm tiểu cầu có thể tiêm dưới da.','Không nên dùng Engerix B cho những đối tượng được biết là quá mẫn cảm với một trong các thành phần của vắc xin, hoặc những đối tượng có biểu hiện mẫn cảm với vắc xin ở lần tiêm trước.\nNhiễm HIV không được xem là chống chỉ định đối với việc chủng ngừa viêm gan B.','Nên hoãn tiêm vắc xin viêm gan B cho các đối tượng đang bị sốt hoặc nhiễm trùng cấp tính. Tuy nhiên những trường hợp nhiễm trùng nhẹ thì không có chống chỉ định tiêm phòng vắc xin viêm gan B. Do thời kỳ ủ bệnh của viêm gan B dài, có thể vào lúc chủng ngừa bệnh nhân đã bị nhiễm virus mà không biết; trong những trường hợp như vậy, vắc xin có thể không ngăn ngừa được sự lây nhiễm viêm gan B.\nSự đáp ứng miễn dịch của vắc xin viêm gan B còn phụ thuộc vào các yếu tố: tuổi cao (như người trên 40 tuổi), nam giới trên 40 tuổi, bệnh béo phì, bệnh tiểu đường, thói quen hút thuốc lá, đường tiêm không thích hợp (mông, trong da), người nhiễm HIV,… Những đối tượng này thường có đáp ứng miễn dịch kém hơn, vì vậy nên cân nhắc liều bổ sung.','Vắc xin được bảo quản ở nhiệt độ từ 2 độ C đến 8 độ C. Không để đông băng.','Vắc xin Engerix B 10mcg/0.5ml phòng ngừa viêm gan B được dùng để chủng ngừa cho trẻ sơ sinh đến dưới 20 tuổi.\nVắc xin Engerix B 20mcg/1ml phòng ngừa viêm gan B được dùng để chủng ngừa cho người từ 20 tuổi trở lên.','Sau khi tiêm Viêm gan B thì người tiêm có sốt không?\nSau khi tiêm viêm gan B, người tiêm có thể gặp những phản ứng nhẹ, không kéo dài và không cần điều trị đặc biệt. Đó là sự đáp ứng miễn dịch của cơ thể. Cụ thể:\nTại chỗ tiêm: đau, sưng nhẹ.\nToàn thân: sốt nhẹ, trẻ quấy khóc.\nCác triệu chứng thường hết sau vài giờ đến 1-2 ngày.','','https://vnvc.vn/wp-content/uploads/2017/04/vac-xin-engerix-b.jpg',0),(1,'2025-04-23 16:25:19.452798','2025-04-23 16:25:19.452798','gardasil-vac-xin-phong-ung-thu-co-tu-cung','Vắc xin Gardasil 4','Vắc xin Gardasil (Mỹ) phòng bệnh ung thư cổ tử cung, âm hộ, âm đạo, các tổn thương tiền ung thư và loạn sản, mụn cóc sinh dục, các bệnh lý do nhiễm virus HPV, được chỉ định dành cho trẻ em và phụ nữ trong độ tuổi từ 9-26 tuổi.','Vắc xin Gardasil được nghiên cứu và phát triển bởi tập đoàn hàng đầu thế giới Merck Sharp and Dohm (Mỹ).','Tiêm bắp với liều 0.5ml vào vùng cơ Delta vào phần trên cánh tay hoặc phần trước bên của phía trên đùi.\nKhông được tiêm tĩnh mạch. Chưa có nghiên cứu về đường tiêm trong da hoặc dưới da nên không có khuyến cáo tiêm theo hai đường tiêm này','Người mẫn cảm với các thành phần có trong vắc xin.\nKhông được tiếp tục dùng Gardasil nếu có phản ứng quá mẫn với lần tiêm trước.','* Trên phụ nữ có thai:','Vắc xin được bảo quản ở nhiệt độ từ 2-8 độ C, không được đông băng và tránh ánh sáng.\nKhi đưa ra khỏi tủ bảo quản nên sử dụng vắc xin ngay nhưng cũng có thể để ngoài nhiệt độ phòng <25 độ C trong thời gian 3 ngày mà không bị ảnh hưởng đến chất lượng vắc xin. Sau 3 ngày, vắc xin cần được loại bỏ.','Vắc xin Gardasil (Mỹ) phòng bệnh ung thư cổ tử cung, âm hộ, âm đạo, các tổn thương tiền ung thư và loạn sản, mụn cóc sinh dục và bệnh lý do nhiễm virus HPV, được chỉ định dành cho trẻ em gái và phụ nữ trong độ tuổi từ 9-26 tuổi.','Sau khi tiêm vắc xin phòng ung thư cổ tử cung do virus HPV, có thể có những phản ứng nhẹ, không kéo dài và không cần điều trị đặc biệt. Đó là sự đáp ứng miễn dịch của cơ thể. Cụ thể như sau:\nTại chỗ tiêm: có thể ban đỏ, sưng, đau, ngứa','','https://vnvc.vn/wp-content/uploads/2017/04/vac-xin-gardasil.jpg',0),(1,'2025-04-23 16:25:19.477410','2025-04-23 16:25:19.477410','gcflu-quadrivalent','Vắc xin GCFLU Quadrivalent phòng Cúm mùa','Vắc xin GCFlu Quadrivalent được chỉ định để phòng ngừa bệnh cúm mùa do virus cúm thuộc 2 chủng cúm A (H1N1, H3N2) và 2 chủng cúm B (Victoria và Yamagata).','Vắc xin GC Flu Quadrivalent được nghiên cứu và sản xuất bởi Green Cross (Hàn Quốc).','Đường dùng: Tiêm bắp.','Bệnh nhân sốt hoặc người bị suy dinh dưỡng.\nBệnh nhân bị rối loạn tim mạch, rối loạn thận hoặc bệnh gan trong khi bệnh đang trong giai đoạn cấp tính, hoặc hoạt động.\nBệnh nhân mắc bệnh hô hấp cấp tính hoặc bệnh truyền nhiễm tích cực khác.\nBệnh nhân mắc bệnh thể ẩn và trong giai đoạn dưỡng bệnh.\nNgười quá mẫn với các thành phần của vắc xin.\nNgười bị dị ứng với trứng, thịt gà, mọi sản phẩm từ thịt gà.\nNgười bị sốt trong vòng 2 ngày hoặc có triệu chứng dị ứng như phát ban toàn thân sau tiêm tại lần tiêm phòng trước.\nNgười có triệu chứng co giật trong vòng 1 năm trước khi tiêm chủng.\nNgười có hội chứng Guillain-Barre hoặc người bị rối loạn thần kinh trong vòng 6 tuần kể từ lần chủng ngừa cúm trước.\nNgười được chẩn đoán mắc bệnh suy giảm miễn dịch.','Người tiêm vắc xin nên giữ trạng thái ổn định về tâm lý, giữ cho vị trí tiêm sạch sẽ, và khi có các triệu chứng sốt cao, co giật cần liên hệ ngay với bác sĩ.\nCũng như với tất cả các vắc xin tiêm, điều trị nội khoa thích hợp và việc giám sát phải luôn luôn sẵn sàng trong trường hợp xảy ra phản ứng quá mẫn sau khi tiêm vắc xin.\nKhông được tiêm tĩnh mạch trong bất kỳ trường hợp nào.\nĐáp ứng kháng thể có thể không hoàn thiện ở những bệnh nhân mắc chứng thiếu hụt miễn dịch bẩm sinh hoặc do điều trị.','Vắc xin cúm GC Flu Quadrivalent phải được bảo quản tại 2°C đến 8°C (trong tủ lạnh).\nKhông được đông băng.\nBảo quản trong bao bì gốc. Tránh tiếp xúc ánh sáng.','GC FLU Quadrivalent (Hàn Quốc) dành cho trẻ từ 6 tháng tuổi trở lên và người lớn.','Vắc xin GCFlu Quadrivalent là vắc xin có độ an toàn cao. Tuy nhiên, sau khi tiêm vắc xin phòng bệnh cúm, người tiêm hay gặp những phản ứng nhẹ, không kéo dài và không cần điều trị đặc biệt. Đó là sự đáp ứng miễn dịch của cơ thể. Cụ thể như sau:\nTại chỗ tiêm: đau, đỏ, sưng\nToàn thân: sốt,mệt mỏi, đau đầu','','https://vnvc.vn/wp-content/uploads/2021/12/GCFlu-Quadrivalent.jpg',0),(1,'2025-04-23 16:25:19.464904','2025-04-23 16:25:19.464904','heberbiovac-hb','Vắc xin Heberbiovac','Vắc xin Heberbiovac HB là vắc xin viêm gan B tái tổ hợp phòng bệnh do virus viêm gan B – loại virus có thể lây truyền dễ dàng qua đường máu, quan hệ tình dục và từ mẹ truyền sang con.','','','','','','Vắc xin Heberbiovac HB được chỉ định tiêm chủng cho trẻ sơ sinh và người lớn.\nVắc xin Heberbiovac HB 10mcg/0.5ml phòng ngừa viêm gan B được dùng để chủng ngừa cho trẻ sơ sinh đến trẻ tròn 10 tuổi.\nVắc xin Heberbiovac HB 20mcg/1ml phòng ngừa viêm gan B được dùng để chủng ngừa cho trẻ trên 10 tuổi (10 tuổi 1 ngày) trở lên và người lớn.','','viêm gan b','https://vnvc.vn/wp-content/uploads/2022/08/vac-xin-Heberbiovac-HB.jpg',270000),(1,'2025-04-23 16:25:19.452099','2025-04-23 16:25:19.452099','hexaxim-vac-xin-6-trong-1','Vắc xin Hexaxim','Vắc xin Hexaxim là vắc xin kết hợp phòng được 6 loại bệnh trong 1 mũi tiêm, bao gồm: Ho gà, bạch hầu, uốn ván, bại liệt, viêm gan B và các bệnh viêm phổi, viêm màng não mủ do H.Influenzae týp B (Hib). Tích hợp trong duy nhất trong 1 vắc xin, 6 trong 1 Hexaxim giúp giảm số mũi tiêm, đồng nghĩa với việc hạn chế đau đớn cho bé khi phải tiêm quá nhiều. ','Vắc xin Hexaxim được nghiên cứu và phát triển bởi tập đoàn hàng đầu thế giới về dược phẩm và chế phẩm sinh học Sanofi Pasteur (Pháp).','Hexaxim được chỉ định tiêm bắp. Vị trí tiêm là mặt trước – ngoài của phần trên đùi và vùng cơ delta ở trẻ 15 tháng tuổi trở lên.','Tiền sử trước đây bị phản ứng phản vệ sau khi tiêm Hexaxim.\nQuá mẫn với các hoạt chất hay bất cứ tá dược nào được liệt kê trong thành phần của vắc xin, với các dư lượng vết (glutaraldehyde (1), formaldehyde (2), neomycin, streptomycin, polymyxin B), với vắc xin ho gà bất kỳ, hoặc trước đây từng bị phản ứng quá mẫn sau khi tiêm Hexaxim hoặc sau khi tiêm vắc xin chứa các thành phần tương tự .\nĐối tượng có bệnh lý não (tổn thương ở não) không rõ nguyên nhân, xảy ra trong vòng 7 ngày sau khi tiêm 1 vắc xin chứa thành phần ho gà (vắc xin ho gà vô bào hay nguyên bào). Trong trường hợp này, nên ngừng tiêm vắc xin ho gà và có thể tiếp tục với quá trình tiêm chủng với các vắc xin Bạch hầu, Uốn ván, Viêm gan B, Bại liệt và Hib.\nKhông nên tiêm vắc xin ho gà cho người có rối loạn thần kinh không kiểm soát hoặc động kinh không kiểm soát cho đến khi bệnh được điều trị, bệnh ổn định và lợi ích rõ ràng vượt trội nguy cơ.\nTrẻ bị dị ứng với một trong các thành phần của vắc xin hay với vắc xin ho gà (vô bào hoặc nguyên bào), hay trước đây trẻ đã có phản ứng dị ứng sau khi tiêm vắc xin có chứa các chất tương tự.\nTrẻ có bệnh não tiến triển hoặc tổn thương ở não.','Như tất cả các vắc xin dùng đường tiêm khác, phải thận trọng khi sử dụng vắc xin Hexaxim cho người bị giảm tiểu cầu hay bị rối loạn đông máu vì có thể bị chảy máu sau khi tiêm bắp.','Vắc xin được bảo quản ở nhiệt độ từ 2 độ C đến 8 độ C.','Vắc xin Hexaxim được chỉ định tiêm cho trẻ từ 6 tuần tuổi đến 2 tuổi phòng 6 bệnh: Bạch hầu, Ho gà, Uốn ván, Bại liệt, Viêm gan B và các bệnh do Hib.','Vắc xin Hexaxim có độ an toàn cao. Tuy nhiên, sau khi tiêm vắc xin 6 trong 1 Infanrix Hexa (Bỉ), trẻ có thể gặp những phản ứng nhẹ, không kéo dài và không cần điều trị đặc biệt, vì đó là đáp ứng miễn dịch của cơ thể. Cụ thể như:\nTại chỗ tiêm: sưng đỏ, đau từ 1 – 3 ngày. Có thể nổi cục cứng, sau khoảng 1-3 tuần sẽ tự khỏi\nToàn thân: Trẻ có thể sốt, quấy khóc, nôn, tiêu chảy, bú kém.\nSau khi tiêm các vắc xin chứa thành phần Haemophilus influenzae tuýp b, có thể phản ứng sưng phù chi dưới. Những phản ứng này khởi phát trong 24-72 giờ sau tiêm và tự khỏi trong 3-5 ngày.','Ho gà, bạch hầu, uốn ván, viêm gan B, bại liệt và các bệnh do Hib','https://vnvc.vn/wp-content/uploads/2018/06/vacxin-hexaxim.jpg',996000),(1,'2025-04-23 16:25:19.475895','2025-04-23 16:25:19.475895','huyet-thanh-uon-van-sat','Huyết thanh uốn ván','Huyết thanh uốn ván SAT được dùng để phòng ngừa uốn ván ở người vừa mới bị vết thương có thể nhiễm bào tử uốn ván, bao gồm những người không tiêm ngừa uốn ván trong 10 năm gần đây, hoặc không nhớ rõ lịch tiêm uốn ván. ','Huyết thanh uốn ván SAT được nghiên cứu và phát triển bởi Viện Vắc xin và Sinh phẩm Y tế (IVAC – Việt Nam).','Huyết thanh uốn ván SAT được chỉ định tiêm bắp.','Những trường hợp có tiền sử dị ứng với huyết thanh kháng độc tố uốn ván nguồn gốc từ ngựa. Những trường hợp này nếu bắt buộc dùng nên dùng loại huyết thanh uốn ván nguồn gốc từ người.\nPhụ nữ đang mang thai.','Cần phải tìm hiểu tiền sử dị ứng của bệnh nhân, sẵn sàng thuốc và các biện pháp chống sốc.\nThử phản ứng mẫn cảm thuốc trước khi tiêm.\nNhững trường hợp trước đây chưa dùng huyết thanh từ ngựa, tiêm 1 lần hết liều.\nNhững trường hợp có kết quả phản ứng mẫn cảm dương tính thì phải dùng phương pháp giải mẫn cảm Besredka như sau: tiêm bắp hoặc dưới da liều 0,1 ml, theo dõi 30 phút, nếu không có phản ứng, tiếp tục tiêm liều 0,25ml theo dõi 30 phút, nếu không có phản ứng xảy ra tiêm hết liều còn lại.\nTrường hợp cần thiết có thể dùng các thuốc kháng histamin trước khi tiêm huyết thanh.\nThời kỳ cho con bú: hiện tại không có dữ liệu về vấn đề này.','Bảo quản ở nhiệt độ lạnh (từ 2 – 8 độ C). Không được đóng băng.','Huyết thanh Uốn ván SAT được dùng để dự phòng bệnh uốn ván trong trường hợp bị các vết thương, vết cắn súc vật. Điều trị bệnh nhân bị bệnh uốn ván (khi đã có triệu chứng bệnh).','Huyết thanh Uốn ván SAT có độ an toàn cao. Tuy nhiên, những người có cơ địa dị ứng, người dùng huyết thanh nhiều lần thường có nguy cơ phản ứng dị ứng với huyết thanh như nổi mề đay, ngứa phù, viêm thận, trường hợp nặng có thể bị choáng, sốc phản vệ.\nBiểu hiện dị ứng có thể xảy ra ngay tức thời sau khi dùng huyết thanh, sau vài giờ hoặc 7 đến 10 ngày sau khi tiêm.','Uốn ván','https://vnvc.vn/wp-content/uploads/2021/02/huyet-thanh-uon-van-SAT.jpg',245000),(1,'2025-04-23 16:25:19.472903','2025-04-23 16:25:19.472903','imojev-vac-xin-phong-viem-nao-nhat-ban-moi','Vắc xin Imojev','Imojev là vắc xin phòng viêm não Nhật Bản được chỉ định cho trẻ em từ 9 tháng tuổi trở lên và người lớn.','Vắc xin Imojev được nghiên cứu và phát triển bởi tập đoàn hàng đầu thế giới về dược phẩm và chế phẩm sinh học Sanofi Pasteur (Pháp). Sản xuất tại Thái Lan.','Trẻ từ 9 tháng tuổi đến 24 tháng tuổi: Tiêm tại mặt trước – bên của đùi hoặc vùng cơ Delta ở cánh tay.\nTrẻ từ 2 tuổi trở lên và người lớn: Tiêm tại vùng cơ Delta ở cánh tay.\nLiều tiêm: 0,5ml/liều Imojev hoàn nguyên.','Người có tiền sử phản ứng dị ứng với bất kỳ thành phần nào của Imojev.\nNgười suy giảm miễn dịch bẩm sinh hoặc mắc phải làm suy yếu miễn dịch tế bào.\nNgười nhiễm HIV có triệu chứng hoặc bằng chứng suy giảm chức năng miễn dịch.\nPhụ nữ có thai hoặc cho con bú sữa mẹ.','Không được tiêm vào lòng mạch máu.\nĐối với những người điều trị corticosteroid liều cao đường toàn thân trong 14 ngày hay trên 14 ngày, sau khi ngưng điều trị nên chờ ít nhất 1 tháng hoặc đến khi hồi phục chức năng miễn dịch rồi mới tiến hành tiêm vắc xin Imojev.','Vắc xin Imojev cần bảo quản ở nhiệt độ từ 2 đến 8 độ C, không được để đông băng.\nGiữ vắc xin trong hộp để tránh ánh sáng.','Vắc xin Imojev được chỉ định phòng viêm não Nhật Bản cho trẻ em từ 9 tháng tuổi trở lên và người lớn.','Sau khi tiêm vắc xin Viêm não Nhật Bản B, bé có sốt không?\nSau khi tiêm vắc xin phòng bệnh Viêm não Nhật Bản B, bé hay gặp những phản ứng nhẹ, không kéo dài và không cần điều trị đặc biệt. Đó là sự đáp ứng miễn dịch của cơ thể. Cụ thể như sau:\nTại chỗ tiêm: đau, sưng, đỏ tại vị trí tiêm là triệu chứng thường gặp\nToàn thân: sốt, đau đầu,đau cơ, mệt mỏi, cáu kỉnh, mất cảm giác thèm ăn, nôn','Viêm não nhật bản','https://vnvc.vn/wp-content/uploads/2019/07/vac-xin-imojev.jpg',875000),(1,'2025-04-23 16:25:19.463106','2025-04-23 16:25:19.463106','infanrix-vac-xin-6-trong-1','Vắc xin Infanrix Hexa','Vắc xin Infanrix Hexa là vắc xin kết hợp phòng được 6 loại bệnh trong 1 mũi tiêm, bao gồm: Ho gà, bạch hầu, uốn ván, bại liệt, viêm gan B và các bệnh viêm phổi, viêm màng não mủ do H.Influenzae týp B (Hib). Tích hợp trong duy nhất trong 1 vắc xin, 6 trong 1 Infanrix Hexa giúp giảm số mũi tiêm, đồng nghĩa với việc hạn chế đau đớn cho bé khi phải tiêm quá nhiều mũi.','Vắc xin Infanrix Hexa được nghiên cứu và phát triển bởi tập đoàn hàng đầu thế giới về dược phẩm và chế phẩm sinh học Glaxosmithkline (GSK) – Bỉ.','Infanrix Hexa được chỉ định tiêm bắp sâu. Không được tiêm tĩnh mạch hoặc trong da.','Chống chỉ định đối với những trường hợp mẫn cảm với các hoạt chất hay bất cứ tá dược hoặc chất tồn dư nào trong thuốc.\nQuá mẫn sau mũi tiêm vắc xin bạch hầu, uốn ván, ho gà, viêm gan B, bại liệt hoặc Hib trước đó.\nInfanrix hexa chống chỉ định đối với những trẻ trong tiền sử đã có bệnh về não không rõ nguyên nhân trong vòng 7 ngày sau khi tiêm vắc xin chứa thành phần ho gà.','Nên hoãn tiêm vắc xin Infanrix Hexa ở những trẻ sốt cao cấp tính.\nNên thận trọng cân nhắc quyết định có sử dụng thêm vắc xin chứa thành phần ho gà nếu có bất kỳ một trong những biểu hiện sau xuất hiện cùng một lúc và có liên quan đến việc tiêm chủng bằng vắc xin chứa thành phần ho gà: sốt cao ≥ 40 độ C trong vòng 48 giờ mà không do các nguyên nhân khác, suy sụp hoặc tình trạng giống sốc (giai đoạn sốc nhược – giảm đáp ứng) trong vòng 48 giờ sau tiêm vắc xin, quấy khóc kéo dài ≥ 3 giờ, co giật có hoặc không kèm theo sốt xảy ra trong vòng 3 ngày sau khi tiêm vắc xin. Ở những trẻ có hội chứng thần kinh tiến triển bao gồm cơn co thắt giai đoạn sớm, cơn động kinh không kiểm soát hoặc bệnh não tiến triển tốt nhất nên hoãn tiêm vắc xin ho gà (Pa và Pw) cho đến khi bệnh đã được xác định rõ hoặc đã ổn định. Việc tiêm vắc xin này phải được cân nhắc kỹ giữa nguy cơ và lợi ích cho người tiêm.\nInfanrix Hexa chứa rất ít neomycin (1) và polymycin (2). Nên thận trọng khi sử dụng vắc xin này cho những bệnh nhân đã biết quá mẫn với một trong hai kháng sinh trên.\nKhông chống chỉ định dùng Infanrix Hexa khi có tiền sử co giật do sốt, tiền sử gia đình về co giật, tiền sử gia đình về Hội chứng tử vong đột ngột ở nhũ nhi (SIDS). Trẻ có tiền sử co giật do sốt nên được theo dõi chặt chẽ khi tiêm vắc xin vì có thể xuất hiện tác dụng phụ trong vòng 2 đến 3 ngày sau tiêm.\nSuy giảm miễn dịch mắc phải do virus (HIV) không được xem là chống chỉ định. Có thể không đạt được đáp ứng miễn dịch như mong đợi sau khi tiêm chủng cho những bệnh nhân ức chế miễn dịch.\nKhông phải tất cả các trẻ tiêm vắc xin đều có đáp ứng miễn dịch bảo vệ. Các số liệu nghiên cứu giới hạn ở 169 trẻ đẻ non đã chỉ ra rằng vắc xin Infanrix Hexa có thể tiêm cho những trẻ đẻ non. Tuy nhiên, đáp ứng miễn dịch ở những trẻ này thấp hơn và mức độ bảo vệ trên lâm sàng vẫn chưa được biết rõ.','Vắc xin được bảo quản ở nhiệt độ từ 2 – 8 độ C. Không đông đá huyền dịch DTPa-HB-IPV và vắc xin đã hoàn nguyên. Loại bỏ nếu vắc xin bị đông băng.','Vắc xin Infanrix Hexa được chỉ định tiêm cho trẻ từ 6 tuần tuổi đến 2 tuổi phòng 6 bệnh: Bạch hầu, Ho gà, Uốn ván, Bại liệt, Viêm gan B và các bệnh do Hib.','Vắc xin Infanrix Hexa có độ an toàn cao. Tuy nhiên, sau khi tiêm vắc xin 6 trong 1 Infanrix Hexa (Bỉ), trẻ có thể gặp những phản ứng nhẹ, không kéo dài và không cần điều trị đặc biệt, vì đó là đáp ứng miễn dịch của cơ thể. Cụ thể như:\nTại chỗ tiêm: sưng đỏ, đau từ 1 – 3 ngày. Có thể nổi cục cứng, sau khoảng 1-3 tuần sẽ tự khỏi\nToàn thân: Trẻ có thể sốt, quấy khóc, nôn, tiêu chảy, bú kém.','Ho gà, bạch hầu, uốn ván, bại liệt, viêm gan B và các bệnh do HIB','https://vnvc.vn/wp-content/uploads/2017/04/vac-xin-Infanrix-hexa.jpg',996000),(1,'2025-04-23 16:25:19.462101','2025-04-23 16:25:19.462101','influvac-tetra','Vắc xin Influvac Tetra','Vắc xin Cúm Tứ giá Influvac Tetra được chỉ định để phòng ngừa bệnh cúm mùa do virus cúm thuộc hai chủng cúm A (H1N1, H3N2) và hai chủng cúm B (Yamagata, Victoria).','Vắc xin Influvac Tetra được nghiên cứu và sản xuất bởi hãng Abbott – Hà Lan.','Tiêm bắp hoặc tiêm sâu dưới da.','Người mẫn cảm với các thành phần hoạt tính, với bất kỳ tá dược hoặc bất cứ thành phần nào có thể chỉ có mặt với một lượng rất nhỏ như trứng (ovalbumin, protein gà), formaldehyde, cetyltrimethylammonium bromide, polysorbat 80, hoặc gentamicin.\nCác bệnh nhân/trẻ em có triệu chứng sốt hoặc nhiễm trùng cấp tính sẽ phải hoãn tiêm chủng.','Không được tiêm tĩnh mạch. Đáp ứng kháng thể có thể bị giảm ở bệnh nhân có ức chế miễn dịch nội sinh hoặc do điều trị.\nCũng như với tất cả các vắc xin tiêm, điều trị nội khoa thích hợp và việc giám sát phải luôn luôn sẵn sàng trong trường hợp xảy ra phản ứng quá mẫn sau khi tiêm vắc xin.','Vắc xin cúm Influvac Tetra phải được bảo quản tại 2°C đến 8°C (trong tủ lạnh).\nKhông được đông băng.\nBảo quản trong bao bì gốc. Tránh ánh sáng.','Vắc xin Influvac Tetra 0.5ml được chỉ định cho trẻ từ 6 tháng tuổi trở lên và người lớn.','Vắc xin Influvac Tetra là vắc xin có độ an toàn cao. Sau khi tiêm vắc xin phòng bệnh cúm hay gặp những phản ứng nhẹ, không kéo dài và không cần điều trị đặc biệt. Đó là sự đáp ứng miễn dịch của cơ thể. Cụ thể như sau:\nTại chỗ tiêm: đau, đỏ, sưng\nToàn thân: sốt,mệt mỏi, đau đầu','Cúm','https://vnvc.vn/wp-content/uploads/2021/11/vac-xin-influvac-tetra.jpg',356000),(1,'2025-04-23 16:25:19.480485','2025-04-23 16:25:19.480485','jevax-vac-xin-phong-viem-nao-nhat-ban-b','Vắc xin Jevax','Jevax là vắc xin phòng viêm não Nhật Bản được chỉ định cho trẻ em từ 12 tháng tuổi trở lên và người lớn.','Vắc xin Jevax được nghiên cứu và sản xuất bởi Vabiotech – Việt Nam.','Tiêm dưới da.','Người nhạy cảm với bất kỳ thành phần nào trong vắc xin.\nNgười bị bệnh tim, gan, thận.\nMệt mỏi, sốt cao hoặc nhiễm trùng tiến triển.\nNgười đang mắc bệnh tiểu đường hoặc suy dinh dưỡng.\nBệnh ung thư máu và các bệnh ác tính nói chung.\nPhụ nữ có thai.\nBệnh quá mẫn.','Thường gặp là sưng, đau và nổi ban đỏ tại nơi tiêm. Những phản ứng này thường sẽ tự hết sau 1-2 ngày.\nPhản ứng toàn thân thường gặp như sốt, đau đầu, buồn nôn, chóng mặt có thể xảy ra với một số người.','Vắc xin được bảo quản ở nhiệt độ từ 2 đến 8 độ C và không được đông băng.','Jevax là vắc xin được chỉ định để phòng viêm não Nhật bản cho trẻ em từ 12 tháng tuổi trở lên và người lớn.','Sau khi tiêm vắc xin Jevax về thì có sốt không?\nSau khi tiêm vắc xin phòng bệnh Viêm não Nhật Bản B, người tiêm hay gặp những phản ứng nhẹ, không kéo dài và không cần điều trị đặc biệt. Đó là sự đáp ứng miễn dịch của cơ thể. Cụ thể như sau:\nTại chỗ tiêm: đau, sưng, đỏ.\nToàn thân: mệt mỏi, đau đầu, sốt','Viêm não Nhật Bản','https://vnvc.vn/wp-content/uploads/2017/04/JEVAX.jpg',198000),(1,'2025-04-23 16:25:19.448854','2025-04-23 16:25:19.448854','menactra-vac-xin-nao-mo-cau-nhom-acy-va-w-135-polysaccharide-cong-hop-giai-doc-bach-hau','Vắc xin Menactra','Vắc xin Menactra được chỉ định để tạo miễn dịch chủ động cơ bản và nhắc lại phòng bệnh xâm lấn do N.meningitidis (vi khuẩn não mô cầu) các nhóm huyết thanh A, C, Y, W-135 gây ra, như: viêm màng não, nhiễm trùng huyết, viêm phổi…','Vắc xin Menactra được sản xuất bởi hãng vắc xin hàng đầu thế giới – Sanofi Pasteur (Pháp). Được sản xuất tại Mỹ.','Menactra được chỉ định tiêm bắp, tốt nhất là ở mặt trước – ngoài của đùi hoặc vùng cơ delta tùy theo tuổi và khối cơ của đối tượng. Không được tiêm tĩnh mạch hoặc tiêm trong da & dưới da đối với vắc xin Menactra.','Người đã bị phản ứng quá mẫn toàn thân với bất cứ thành phần của vắc xin, hoặc sau một lần tiêm vắc xin này hoặc một vắc xin chứa cùng một thành phần trước đây.\nSốt hay bệnh cấp tính: thông thường, trong trường hợp sốt vừa hoặc nặng và/hoặc bệnh cấp tính nên trì hoãn tiêm chủng.','Rất thận trọng khi tiêm vắc xin viêm màng não mô cầu Menactra cho phụ nữ có thai, cần cân nhắc giữa lợi ích và nguy cơ hoặc trong trường hợp thật cần thiết.\nLuôn có sẵn thiết bị và phác đồ phòng sốc phản vệ.\nBệnh nhân suy giảm miễn dịch, thiếu hụt bổ thể hoặc đang dùng các thuốc ức chế miễn dịch có thể không đáp miễn dịch đầy đủ với vắc xin.\nNgười được chẩn đoán mắc hội chứng Guillain-Barré (GBS) trước đây có thể tăng nguy cơ bị GBS sau khi tiêm Menactra. Cần lưu ý lợi ích và nguy cơ tiềm tàng khi quyết định sử dụng vắc xin.\nNgất (bất tỉnh) đã được báo cáo sau khi tiêm chủng với Menactra. Cần có sẵn các quy trình đề phòng thương tích do té ngã và xử trí phản ứng ngất.','Vắc xin được bảo quản ở nhiệt độ từ 2 độ C đến 8 độ C. Không được đông băng. ','Vắc xin Menactra (Mỹ) được chỉ định tiêm cho trẻ từ 9 tháng đến 55 tuổi (trước sinh nhật lần thứ 56) phòng bệnh viêm màng não mô cầu ACYW do các nhóm huyết thanh A,C,Y, W-135 gây ra.\n⇒ Tìm hiểu thêm: Viêm não mô cầu AC tiêm cho trẻ mấy tuổi? Tối thiểu mấy tháng tuổi?','Sau khi tiêm vắc xin phòng bệnh Menactra, trẻ thường gặp những phản ứng nhẹ, không kéo dài và không cần điều trị đặc biệt. Đó là sự đáp ứng miễn dịch của cơ thể. Cụ thể như sau:\nTại chỗ tiêm: đau, sưng, đỏ tại vị trí tiêm\nToàn thân: ngủ gà, cáu kỉnh, nhức đầu, mệt mỏi, tiêu chảy, chán ăn. Các triệu chứng thường nhẹ và thoáng qua.\nCác phản ứng sau tiêm có thể gặp trong vòng 7 ngày sau tiêm chủng','viêm màng não, nhiễm khuẩn huyết và viêm phổi do não mô cầu khuẩn tuýp A,C,Y và W-135','https://vnvc.vn/wp-content/uploads/2020/02/vacxin-menactra-1.jpg',1370000),(1,'2025-04-23 16:25:19.470912','2025-04-23 16:25:19.470912','mmr-ii-vac-xin-phong-3-benh-soi-quai-bi-rubella','Vắc xin MMR II','Vắc xin phối hợp MMR-II của Mỹ là vắc xin sống giảm độc lực tạo miễn dịch chủ động dùng để ngăn ngừa nhiễm virus bệnh sởi, quai bị và rubella. Thuốc hoạt động bằng cách giúp cơ thể tạo kháng thể chống lại virus.','Vắc xin MMR-II được nghiên cứu và phát triển bởi tập đoàn hàng đầu thế giới Merck Sharp and Dohm (Mỹ).','Tiêm dưới da, không được tiêm tĩnh mạch.','Người dị ứng với bất kỳ thành phần nào trong vắc xin, kể cả gelatin.\nNgười đang mang thai, phải tránh mang thai 3 tháng sau khi tiêm vắc xin cho phụ nữ.\nCó tiền sử dị ứng với neomycin.\nĐang có bệnh lý sốt hoặc viêm đường hô hấp.\nBệnh lao đang tiến triển mà chưa được điều trị hoặc người đang điều trị bằng thuốc ức chế miễn dịch.\nNgười có rối loạn về máu, bệnh bạch cầu hay u hạch bạch huyết; hoặc ở người có những khối u tân sinh ác tính ảnh hưởng tới tủy xương hoặc hệ bạch huyết.\nNgười bị bệnh suy giảm miễn dịch tiên phát hoặc thứ phát, bao gồm cả người mắc bệnh AIDS và người có biểu hiện lâm sàng về nhiễm virus gây suy giảm miễn dịch; các bệnh gây giảm hoặc bất thường gammaglobulin máu.\nNgười có tiền sử trong gia đình suy giảm miễn dịch bẩm sinh hoặc di truyền cho đến khi chứng minh được họ có khả năng đáp ứng miễn dịch với vắc xin.','Luôn có sẵn dụng cụ và phác đồ cấp cứu sốc phản vệ khi tiêm chủng vắc xin\nCẩn trọng với người có tiền sử co giật và có tiền sử tổn thương não. Thông báo với bác sĩ nếu tình trạng sốt xảy ra sau khi tiêm.\nQuá mẫn với trứng: người có phản ứng dị ứng với trứng cần đặc biệt thận trọng khi tiêm vắc xin này bởi vì vắc xin sống phòng sởi và quai bị được nuôi cấy trên phôi gà.\nGiảm tiểu cầu: sau khi tiêm vắc xin ở những người có bệnh giảm tiểu cầu thì mức độ giảm tiểu cầu sẽ trầm trọng hơn. Mức độ giảm tiểu cầu sẽ lũy tiến khi tiêm nhắc lại lần sau.\nĐối với những trẻ có nhiễm virus HIV nhưng không có biểu hiện lâm sàng của suy giảm miễn dịch thì vẫn có thể tiêm phòng bằng MMR-II nhưng phải theo dõi hiệu quả gây đáp ứng miễn dịch đối với các bệnh đã tiêm phòng. Bởi vì khả năng đáp ứng miễn dịch có thể không bằng so với các trẻ bình thường khác.\nĐã có nghiên cứu cho thấy vắc xin sởi-quai bị- rubella có thể làm ức chế tạm thời tính nhạy cảm của da với tuberculin, vì vậy phải thực hiện test tuberculin trước hoặc đồng thời với việc tiêm vắc xin\nChưa có nghiên cứu về việc tác động của vắc xin lên trẻ em đang bị nhiễm lao mà chưa được điều trị.\nCũng như các vắc xin khác, MMR-II không gây được đáp ứng thể dịch 100% trên người đã được tiêm chủng.\nPhụ nữ đang cho con bú: cần thận trọng khi tiêm phòng, chưa có thông tin về việc vắc xin sởi, quai bị có bài tiết qua sữa mẹ hay không. Đã có thông tin về việc vắc xin rubella bài tiết qua sữa mẹ và có biểu hiện lâm sàng nhiễm virus rubella trên trẻ bú mẹ. Chưa thấy trẻ nào mắc bệnh nặng trong số những trẻ có bằng chứng về huyết thanh đã nhiễm virus rubella, tuy vậy có 1 trẻ có biểu hiện lâm sàng nhẹ, điển hình do nhiễm rubella. Cẩn trọng khi tiêm MMR-II ở phụ nữ cho con bú.','Trước khi hoàn nguyên, vắc xin cần được bảo quản ở nhiệt độ 2-8 độ C và tránh ánh sáng.\nSau khi hoàn nguyên nên sử dụng ngay vắc xin,có thể sử dụng được vắc xin đã hoàn nguyên nếu được bảo quản ở chỗ tối nhiệt độ từ 2-8 độ C, tránh ánh sáng. Sau 8 giờ phải hủy bỏ vắc xin theo quy định.','Vắc xin MMR-II phòng Sởi – Quai bị – Rubella được chỉ định dành cho trẻ từ 12 tháng tuổi trở lên và người  lớn.','Sau khi tiêm Sởi – Quai bị – Rubella, người tiêm có sốt không?\nVắc xin Sởi-Quai bị-Rubella là vắc xin có độ an toàn cao. Sau khi tiêm vắc xin MMR-II, người tiêm hay gặp những phản ứng nhẹ, không kéo dài và không cần điều trị đặc biệt. Đó là sự đáp ứng miễn dịch của cơ thể. Cụ thể:\nTại chỗ tiêm: đau, đỏ, sưng\nToàn thân: Sốt, ban, ho và sổ mũi','Sởi, quai bị, rubella','https://vnvc.vn/wp-content/uploads/2017/04/vac-xin-MMR-II.jpg',445000),(1,'2025-04-23 16:25:19.474898','2025-04-23 16:25:19.474898','morcvax-vac-xin-phong-benh-ta','Vắc xin mOrcvax','Vắc xin mORCVAX phòng bệnh bệnh truyền nhiễm cấp tính do vi khuẩn tả Vibrio cholerae gây nên.','Vắc xin mORCVAX được nghiên cứu và sản xuất bởi Vabiotech – Việt Nam.','Chỉ dùng đường uống. Liều dùng: 1,5ml/liều.','Không dùng vắc xin mORCVAX cho trẻ đã quá mẫn cảm ở lần uống đầu tiên hoặc với bất kỳ thành phần nào của vắc xin.\nKhông dùng cho người mắc các bệnh nhiễm trùng đường ruột cấp tính, các bệnh cấp tính và mãn tính đang thời kỳ tiến triển.\nKhông dùng cho bệnh nhân đang sử dụng thuốc ức chế miễn dịch, thuốc chống ung thư. ','Khi dự định uống vắc xin phòng bệnh tả mORCVAX cần trao đổi với bác sĩ về những lưu ý trước khi uống vắc xin như:','Vắc xin được bảo quản ở nhiệt độ từ 2 độ C đến 8 độ C.','Vắc xin tả mORCVAX được chỉ định cho trẻ từ 2 tuổi trở lên và người lớn.','Sau khi uống có thể có cảm giác buồn nôn, nôn và các triệu chứng hiếm gặp: đau đầu, đau bụng, tiêu chảy, sốt… Các triệu chứng này tự khỏi mà không cần điều trị.','Tả','https://vnvc.vn/wp-content/uploads/2019/06/vac-xin-mORCVAX.jpg',165000),(1,'2025-04-23 16:25:19.464904','2025-04-23 16:25:19.464904','pentaxim-vac-xin-5-trong-1','Vắc xin Pentaxim','Vắc xin Pentaxim là vắc xin kết hợp phòng được 5 loại bệnh trong 1 mũi tiêm, bao gồm: Ho gà, bạch hầu, uốn ván, bại liệt và các bệnh viêm phổi, viêm màng não mủ do H.Influenzae týp B (Hib). Tích hợp trong duy nhất trong 1 vắc xin, 5 trong 1 Pentaxim giúp giảm số mũi tiêm, đồng nghĩa với việc hạn chế đau đớn cho bé khi phải tiêm quá nhiều.','Vắc xin Pentaxim được nghiên cứu và phát triển bởi tập đoàn hàng đầu thế giới về dược phẩm và chế phẩm sinh học Sanofi Pasteur (Pháp).','Vắc xin Pentaxim được chỉ định tiêm bắp (ở mặt trước – bên đùi).','Chống chỉ định đối với những trường hợp mẫn cảm với các hoạt chất hay bất cứ tá dược nào trong thuốc.\nTrẻ bị dị ứng với một trong các thành phần của vắc xin hay với vắc xin ho gà (vô bào hoặc nguyên bào), hay trước đây trẻ đã có phản ứng dị ứng sau khi tiêm vắc xin có chứa các chất tương tự.\nTrẻ có bệnh não tiến triển hoặc tổn thương ở não.\nNếu lần trước trẻ từng bị bệnh não (tổn thương ở não) trong vòng 7 ngày sau khi tiêm vắc xin ho gà (ho gà vô bào hay nguyên bào).','Có nguy cơ bị chảy máu khi tiêm bắp nếu trẻ bị giảm tiểu cầu hay bị rối loạn đông máu.\nTrong vắc xin có một lượng rất nhỏ glutaraldehyde, neomycin, streptomycin và polymycin B, vì vậy hãy cẩn trọng đối với những trẻ có tiền sử dị ứng với một trong các thành phần này.\nCần cân nhắc cẩn thận khi quyết định dùng tiếp các liều vắc xin chứa ho gà nếu đã từng có bất kỳ một trong các triệu chứng sau đây xảy ra:','Bảo quản ở nhiệt độ lạnh (từ 2 – 8 độ C). Không được đóng băng.\nVắc xin phải được hoàn nguyên trước khi tiêm, tạo nên hỗn dịch màu trắng đục. Sau khi hoàn nguyên nên sử dụng ngay.','Vắc xin Pentaxim được chỉ định tiêm cho trẻ từ 2 tháng tuổi đến tròn 2 tuổi phòng 5 bệnh: Bạch hầu, Ho gà, Uốn ván, Bại liệt và các bệnh do Hib.','Vắc xin Pentaxim có độ an toàn cao. Tuy nhiên, người được tiêm có thể gặp một số phản ứng nhẹ, kéo dài từ 1- 2 ngày:\nTại chỗ tiêm: nốt quầng đỏ, nốt cứng. Các triệu chứng trên thường gặp trong 48 giờ sau khi tiêm và có thể kéo dài 48 – 72 giờ.\nToàn thân: trẻ có thể sốt, quấy khóc, tiêu chảy, nôn, chán ăn, buồn ngủ, phát ban.','Ho gà, bạch hầu, uốn ván, bại liệt và các bệnh do HIB','https://vnvc.vn/wp-content/uploads/2017/04/vac-xin-pentaxim-1.jpg',795000),(1,'2025-04-23 16:25:19.446694','2025-04-23 16:25:19.446694','prevenar-13-vac-xin-phong-benh-viem-phoi-viem-mang-nao-viem-tai-giua-nhiem-khuan-huyet-phe-cau-khuan','Vắc xin Prevenar 13','Vắc xin Prevenar 13 là vắc xin phế cầu, phòng các bệnh phế cầu khuẩn xâm lấn gây nguy hiểm cho trẻ em và người lớn như viêm phổi, viêm màng não, nhiễm khuẩn huyết (nhiễm trùng máu), viêm tai giữa cấp tính,… do 13 chủng phế cầu khuẩn Streptococcus Pneumoniae gây ra (type 1, 3, 4, 5, 6A, 6B, 7F, 9V, 14, 18C, 19A, 19F và 23F). ','Vắc xin Prevenar-13 được nghiên cứu và phát triển bởi tập đoàn hàng đầu thế giới về dược phẩm và chế phẩm sinh học – Pfizer (Mỹ). Prevenar-13 được sản xuất tại Bỉ.','Vắc xin Prevenar-13 được chỉ định tiêm bắp (vùng cơ delta) với liều 0.5ml','Không dùng vắc xin Prevenar-13 trong thai kỳ.\nKhông tiêm vắc xin Prevenar-13 với người quá mẫn cảm với thành phần trong vắc xin hoặc với độc tố bạch hầu.','Prevenar-13 không được tiêm nội mạch.\nNên hoàn tất phác đồ với cùng một loại vắc xin Synflorix hoặc Prevenar-13.\nTrong trường hợp bất khả kháng, có thể chuyển đổi vắc xin Synflorix và Prevenar-13 vào bất cứ thời điểm nào trong lịch trình tiêm chủng.\nKhông tiêm vắc xin Prevenar-13 ở bệnh nhân giảm tiểu cầu hoặc bất kỳ rối loạn đông máu nào.\nTrẻ em từ 2 tuổi đã hoàn thành phác đồ tiêm Synflorix trước đó có thể được khuyến cáo tiêm 1 liều Prevenar-13 để kích thích sinh miễn dịch với 3 type huyết thanh bổ sung. Mũi tiêm Prevenar-13 bổ sung được tiêm cách mũi Synflorix cuối cùng 2 tháng.','Bảo quản ở nhiệt độ lạnh (từ 2 – 8 độ C). Không được đóng băng.','Vắc xin Prevenar-13 (Bỉ) được chỉ định cho trẻ từ 6 tuần tuổi trở lên và người lớn.\n* Lưu ý:  Khách hàng đã tiêm Pneumo23\nĐối với Khách hàng có sức khỏe bình thường: khoảng cách tối thiểu giữa Prevenar-13 và Pneumo23 là 1 năm (không tiêm đồng thời, nên hoàn thành lịch tiêm vắc xin Prevenar 13 trước).\nĐối với Khách hàng có bệnh lý hoặc có tình trạng suy giảm miễn dịch làm tăng nguy cơ mắc bệnh phế cầu xâm lấn cần tham khảo hướng dẫn của bác sĩ khám sàng lọc.','Vắc xin Prevenar-13 có độ an toàn cao. Tuy nhiên, người được tiêm có thể gặp một số phản ứng nhẹ, kéo dài từ 1- 2 ngày:\nTại chỗ tiêm: ban đỏ, chai cứng, sưng đau, tăng nhạy cảm tại chỗ tiêm.\nToàn thân: sốt, đau đầu, buồn ngủ, giảm cảm giác thèm ăn, nôn mửa, tiêu chảy.','Viêm phổi, viêm màng não, viêm tai giữa cấp tính, nhiễm khuẩn huyết… do phế cầu khuẩn','https://vnvc.vn/wp-content/uploads/2019/11/prevenar-13.jpg',1190000),(1,'2025-04-23 16:25:19.467985','2025-04-23 16:25:19.467985','rotavin-m1-vac-xin-phong-benh-tieu-chay-cap-rotavirus','Vắc xin Rotavin','Vắc xin Rotavin là vắc xin sống giảm độc lực có tác dụng phòng nguy cơ nhiễm virus Rota – nguyên nhân gây tình trạng tiêu chảy cấp ở trẻ nhỏ. Vắc xin có dung dịch màu hồng, được sản xuất trên dây chuyền công nghệ hiện đại, đạt các tiêu chuẩn của Tổ chức Y tế Thế giới (WHO) về vắc xin uống.','Vắc xin Rotavin được nghiên cứu và sản xuất bởi Polyvac – Việt Nam.','Chỉ được dùng đường uống, không được tiêm.\nLiều uống: 2ml/liều.','Không dùng Rotavin cho trẻ quá mẫn sau khi uống liều vắc xin đầu tiên, hoặc quá mẫn với bất cứ thành phần nào của thuốc.\nKhông sử dụng vắc xin Rotavin nếu trẻ có bệnh lý nặng, cấp tính, sốt cao, trẻ đang bị tiêu chảy hoặc nôn.\nKhông sử dụng Rotavin cho trẻ bị dị tật bẩm sinh đường tiêu hóa, bị lồng ruột hay đang bị suy giảm miễn dịch nặng.\nVắc xin không dự kiến sử dụng ở người lớn. Không có chỉ định sử dụng vắc xin ở phụ nữ có thai và cho con bú.\nViệc cho con bú không làm giảm hiệu quả của vắc xin, nên vẫn có thể cho con bú sau khi trẻ đã sử dụng vắc xin.','Cần thận trọng đối với những trường hợp có tiền sử dị ứng, co giật.\nKhông nên cho uống vắc xin trong trường hợp đang sốt hay đang trong quá trình điều trị có ảnh hưởng đến hệ miễn dịch (như dùng thuốc, truyền máu hay các chế phẩm từ máu…). Chỉ cho trẻ uống vắc xin sau khi đã hết sốt ít nhất 3 ngày và sau khi kết thúc điều trị tối thiểu 4 tuần.\nNếu trẻ trớ ra phần lớn lượng vắc xin ngay sau khi uống thì nên cho trẻ uống ngay liều vắc xin thay thế. Chú ý không nên cho trẻ bú mẹ trước và sau khi cho uống vắc xin 30 phút.','Vắc xin được bảo quản ở nhiệt độ từ 2 độ C đến 8 độ C.','Vắc xin Rotavin được chỉ định chủng ngừa cho trẻ từ 6 tuần tuổi phòng tiêu chảy cấp do Rotavirus.','Vắc xin Rotavin là vắc xin có độ an toàn cao. Sau khi uống vắc xin, trẻ hay gặp những phản ứng nhẹ, không kéo dài và không cần điều trị đặc biệt. Đó là sự đáp ứng miễn dịch của cơ thể. Cụ thể như sau:\nToàn thân: rối loạn tiêu hóa và thường tự khỏi sau vài ngày.\nNếu đi ngoài phân nước nhiều lần, nôn nhiều, có dấu hiệu mất nước nên khám lại ngay tại cơ sở y tế.','Tiêu chảy','https://vnvc.vn/wp-content/uploads/2020/05/vac-xin-rotavin-1.jpg',490000),(1,'2025-04-23 16:25:19.481482','2025-04-23 16:25:19.481482','stamaril-vac-xin-phong-benh-sot-vang','Vắc xin STAMARIL phòng bệnh sốt vàng','Vắc xin Stamaril là vắc xin duy nhất cung cấp miễn dịch bảo vệ hiệu quả cao và tạo miễn dịch chủ động suốt đời khỏi virus thuộc họ Flaviviridae gây bệnh Sốt vàng nguy hiểm. ','','','','','','Vắc xin Stamaril được chỉ định tiêm cho trẻ từ 9 tháng tuổi đến người lớn 60 tuổi phòng bệnh sốt vàng.','Vắc xin Stamaril có độ an toàn cao. Tuy nhiên, sau khi tiêm vắc xin, người tiêm có thể có cảm giác buồn nôn, nôn và các triệu chứng hiếm gặp: đau đầu, đau bụng, tiêu chảy, sốt… Các triệu chứng này tự khỏi mà không cần điều trị.','Sốt vàng','https://vnvc.vn/wp-content/uploads/2019/07/STAMARIL-vacxin-phong-benh-sot-vang.jpg',650000),(1,'2025-04-23 16:25:19.452798','2025-04-23 16:25:19.452798','synflorix-vac-xin-phong-viem-nao-viem-phoi-nhiem-khuan-huyet-viem-tai-giua-h-influenzae-khong-dinh-tuyp','Vắc xin Synflorix','Vắc xin Synflorix phòng tránh 10 chủng vi khuẩn phế cầu (Streptococcus pneumoniae) gây các bệnh như: Hội chứng nhiễm trùng, viêm màng não, viêm phổi, nhiễm khuẩn huyết và viêm tai giữa cấp,…','Vắc xin Synflorix được nghiên cứu và phát triển bởi tập đoàn hàng đầu thế giới về dược phẩm và chế phẩm sinh học Glaxosmithkline (GSK) – Bỉ.','Vắc xin Synflorix tiêm bắp ở mặt trước – bên đùi của trẻ nhỏ và tiêm ở cơ delta cánh tay của trẻ lớn. Không được tiêm tĩnh mạch hoặc tiêm trong da đối với vắc xin Synflorix.','Synflorix không được tiêm cho các đối tượng quá mẫn với bất kỳ thành phần nào trong vắc xin.','Nên hoãn việc tiêm vắc xin nếu đang sốt hoặc nhiễm trùng cấp tính.\nSynflorix chỉ có tác dụng phòng ngừa đối với các vi khuẩn có tuýp huyết thanh đã được chỉ ra trong thành phần của vắc xin. Vì vậy vắc xin polysaccharid 23 tuýp phế cầu (Pneumo 23) cần được chỉ định khi trẻ ≥ 2 tuổi.\nLiệu trình sử dụng Synflorix được thích hợp để chỉ định cho trẻ dưới 2 tuổi.','Vắc xin được bảo quản ở nhiệt độ từ 2 độ C đến 8 độ C, không được để đông băng (*).','Vắc xin Synflorix (Bỉ) phòng bệnh do phế cầu như viêm phổi, viêm màng não, viêm tai giữa, nhiễm khuẩn huyết được chỉ định cho trẻ từ 6 tuần tuổi trở lên và trước sinh nhật lần thứ 6.','Sau khi tiêm Synflorix (Bỉ) người tiêm hay gặp phản ứng gì?\nVắc xin Synflorix có độ an toàn cao. Sau khi tiêm vắc xin phòng bệnh do phế cầu, trẻ hay gặp những phản ứng nhẹ, không kéo dài và không cần điều trị đặc biệt. Đó là sự đáp ứng miễn dịch của cơ thể. Cụ thể như:\nTại chỗ tiêm: sưng, đau, đỏ.\nToàn thân: trẻ có thể sốt trên 38 độ C, ăn uống kém, bị kích thích, quấy khóc.','Bệnh do phế cầu khuẩn','https://vnvc.vn/wp-content/uploads/2017/04/Synflorix-1.jpg',1024000),(1,'2025-04-23 16:25:19.473900','2025-04-23 16:25:19.473900','twinrix-vac-xin-phong-viem-gan-ab','Vắc xin Twinrix','Vắc xin Twinrix được chỉ định để phòng 2 bệnh viêm gan A và viêm gan B ở trẻ em từ 1 tuổi và người lớn chưa có miễn dịch.','Vắc xin Twinrix được nghiên cứu và phát triển bởi tập đoàn hàng đầu thế giới về dược phẩm và chế phẩm sinh học Glaxosmithkline (GSK) – Bỉ.','Tiêm bắp.','Người nhạy cảm với bất kỳ thành phần nào trong vắc xin hoặc có biểu hiện quá mẫn với vắc xin phòng viêm gan B và viêm gan A đơn lẻ.','Người đang sốt cao, cấp tính.\nVắc xin không phòng được bệnh viêm gan do các tác nhân khác như viêm gan C và viêm gan E.\nPhụ nữ có thai và cho con bú: không có chống chỉ định nhưng phải có sự cân nhắc của chuyên gia y tế.','Vắc xin được bảo quản ở nhiệt độ từ 2 đến 8 độ C và không được đông băng.','Vắc xin phòng bệnh Viêm gan A+B (Twinrix) được chỉ định tiêm cho trẻ từ 12 tháng tuổi trở lên và người lớn.','Sau khi tiêm vắc xin phòng bệnh Viêm gan A+B, người tiêm hay gặp những phản ứng nhẹ, không kéo dài và không cần điều trị đặc biệt. Đó là sự đáp ứng miễn dịch của cơ thể, cụ thể như sau:\nTại chỗ tiêm: đau, sưng, đỏ\nToàn thân: đau đầu, khó chịu.','Viêm gan A, viêm gan B','https://vnvc.vn/wp-content/uploads/2017/04/vac-xin-twinrix.jpg',690000),(1,'2025-04-23 16:25:19.473900','2025-04-23 16:25:19.473900','typhim-vi-vac-xin-phong-thuong-han','Vắc xin Typhim VI','Vắc xin Typhim VI phòng ngừa bệnh Thương hàn (bệnh về đường tiêu hóa) gây ra bởi vi khuẩn thương hàn (Salmonella typhi) cho trẻ từ trên 2 tuổi và người lớn. ','Vắc xin Typhim VI được nghiên cứu và phát triển bởi tập đoàn hàng đầu thế giới về dược phẩm và chế phẩm sinh học Sanofi Pasteur (Pháp).','Tiêm bắp hoặc tiêm dưới da.','Mẫn cảm với các thành phần trong vắc xin.\nKhông tiêm bắp cho người bị rối loạn đông máu hoặc giảm tiểu cầu.\nTrẻ em dưới 2 tuổi vì đáp ứng miễn dịch thấp.','Hoãn sử dụng vắc xin khi đang có biểu hiện sốt hoặc nhiễm trùng.\nPhải chắc chắn rằng không được tiêm vắc xin vào trong lòng mạch máu.\nVắc xin Typhim Vi chỉ phòng được bệnh sốt thương hàn do Samonella typhi còn không phòng được bệnh thương hàn do Samonella paratyphi tuýp A và B gây ra.\nLuôn có sẵn phác đồ chống sốc phản vệ khi tiêm phòng vắc xin mặc dù rất hiếm gặp các phản ứng dị ứng này xảy ra khi tiêm Typhim Vi.\nPhụ nữ có thai và cho con bú: Không có chống chỉ định cho phụ nữ có thai, tuy nhiên việc dùng thuốc trong thời gian thai kỳ phải có chỉ định của bác sĩ.\nPhụ nữ cho con bú: vẫn có thể tiêm phòng vắc xin.','Vắc xin được bảo quản ở nhiệt độ từ 2 độ C đến 8 độ C.','Vắc xin thương hàn được chỉ định cho trẻ từ trên 2 tuổi (2 tuổi 1 ngày) trở lên và người lớn.','Sau khi tiêm vắc xin phòng Thương hàn, người tiêm hay gặp những phản ứng nhẹ, không kéo dài và không cần điều trị đặc biệt. Đó là sự đáp ứng miễn dịch của cơ thể, cụ thể như sau:\nPhản ứng tại chỗ: sưng, đau, có quầng đỏ tại vết tiêm.\nPhản ứng toàn thân: sốt, đau đầu, đau khớp','Thương hàn','https://vnvc.vn/wp-content/uploads/2017/04/vac-xin-typhim-vi.jpg',390000),(1,'2025-04-23 16:25:19.480485','2025-04-23 16:25:19.480485','typhoid-vi-polysaccharide-vi-vac-xin-phong-benh-thuong-han','Vắc xin Typhoid VI','Vắc xin Typhoid VI phòng ngừa bệnh Thương hàn (bệnh về đường tiêu hóa) gây ra bởi vi khuẩn thương hàn (Salmonella typhi) cho trẻ từ trên 2 tuổi và người lớn. ','Vắc xin thương hàn Typhoid Vi được sản xuất bởi nhà sản xuất vắc xin và sinh phẩm uy tín tại Việt Nam – Viện Pasteur Đà Lạt (DAVAC).','Vắc xin phòng bệnh thương hàn Typhoid Vi được chỉ định tiêm dưới da hoặc tiêm bắp với liều 0.5ml.','Không sử dụng Typhoid Vi cho trường hợp có tiền sử dị ứng với một trong các thành phần của vắc xin.\nPhụ nữ đang mang thai, trường hợp bắt buộc phải tiêm, cần hỏi ý kiến của bác sĩ.\nTrong trường hợp bị sốt hoặc mắc bệnh cấp tính, nên hoãn tiêm vắc xin.','Không khuyến cáo tiêm cho trẻ em dưới 2 tuổi.\nKhông được tiêm theo đường nội mạch.','Vắc xin được bảo quản ở nhiệt độ từ 2 độ C đến 8 độ C. Không được đóng băng.','Vắc xin thương hàn được chỉ định cho trẻ từ trên 2 tuổi (2 tuổi 1 ngày) trở lên và người lớn.','Sau khi tiêm vắc xin phòng vắc xin thương hàn, người tiêm thường gặp những phản ứng nhẹ, không kéo dài và không cần điều trị đặc biệt. Đó là sự đáp ứng miễn dịch của cơ thể. Cụ thể như sau:\nPhản ứng tại chỗ: sưng, đau, có quầng đỏ tại vết tiêm.\nPhản ứng toàn thân: sốt, đau đầu, đau khớp','Thương hàn','https://vnvc.vn/wp-content/uploads/2019/12/vac-xin-Typhoid-Vi.jpg',265000),(1,'2025-04-23 16:25:19.467985','2025-04-23 16:25:19.467985','va-mengoc-bc-vac-xin-phong-viem-mang-nao-nao-mo-cau-b-c','Vắc xin Mengoc BC','Vắc xin VA-Mengoc-BC phòng bệnh viêm màng não do não mô cầu khuẩn Meningococcal tuýp B và C gây ra.','Vắc xin VA-Mengoc-BC được nghiên cứu và sản xuất bởi Finlay Institute (Cu Ba).','Tiêm bắp sâu, tốt nhất là vào vùng cơ delta cánh tay. Tuy nhiên ở trẻ nhỏ có thể tiêm bắp đùi, ở mặt trước ngoài của đùi.\nKhông được tiêm tĩnh mạch.','Người quá mẫn với các thành phần của vắc xin.\nNgười đang sốt, nhiễm khuẩn cấp tính, dị ứng đang tiến triển.\nHiếm khi có phản ứng dị ứng nhưng cần ngưng liều thứ 2 nếu liều 1 có dấu hiệu dị ứng.','Rất thận trọng khi tiêm vắc xin viêm màng não mô cầu BC cho phụ nữ có thai, cần cân nhắc giữa lợi ích và nguy cơ hoặc trong trường hợp thật cần thiết.\nLuôn có sẵn thiết bị và phác đồ phòng sốc phản vệ.\nBệnh nhân suy giảm miễn dịch hoặc đang dùng các thuốc ức chế miễn dịch có thể không đáp miễn dịch đầy đủ với vắc xin.','Vắc xin cần được bảo quản ở nhiệt độ từ 2 độ C đến 8 độ C và không được đông băng.','Vắc xin phòng viêm màng não do mô cầu BC của CuBa được chỉ định tiêm cho trẻ từ 6 tháng tuổi trở lên và người lớn đến 45 tuổi.','Sau khi tiêm vắc xin phòng bệnh Viêm màng não do mô cầu VA-Mengoc-BC có thể gặp những phản ứng nhẹ, không kéo dài và không cần điều trị đặc biệt. Đó là sự đáp ứng miễn dịch của cơ thể. Cụ thể như sau:\nTại chỗ tiêm: sưng đau, có thể tạo cục cứng, sau khoảng 72 giờ sẽ tự khỏi.\nToàn thân: sốt nhẹ.','Viêm màng não do não mô cầu','https://vnvc.vn/wp-content/uploads/2017/04/vac-xin-va-mengoc-bc.jpg',385000),(1,'2025-04-23 16:25:19.479407','2025-04-23 16:25:19.479407','vac-xin-5-trong-1-infanrix-ipv-hib','Vắc xin Infranrix IPV + Hib','Vắc xin Infanrix IPV+Hib là vắc xin kết hợp phòng được 5 loại bệnh trong 1 mũi tiêm, bao gồm: Ho gà, bạch hầu, uốn ván, bại liệt và các bệnh viêm phổi, viêm màng não mủ do H. Influenzae týp B (Hib). Tích hợp trong một loại vắc xin, Infanrix IPV+Hib giúp giảm số mũi tiêm, đồng nghĩa với việc hạn chế đau đớn cho bé khi phải tiêm quá nhiều. ','Vắc xin Infanrix IPV+Hib được nghiên cứu và phát triển bởi tập đoàn hàng đầu thế giới về dược phẩm và chế phẩm sinh học Glaxosmithkline (GSK) – Bỉ.','Vắc xin Infanrix IPV+Hib được chỉ định tiêm bắp sâu (ở mặt trước-bên đùi). ','Trẻ quá mẫn cảm với bất kỳ thành phần nào của vắc xin Infanrix IPV+Hib.\nTrẻ đã từng có phản ứng quá mẫn sau mũi tiêm vắc xin bạch hầu, ho gà, uốn ván, bại liệt bất hoạt hoặc Hib trước đó.\nTrẻ mắc các bệnh về não nhưng không rõ nguyên nhân, xảy ra trong vòng 7 ngày sau khi tiêm vắc xin ho gà trước đó.\nKhông khuyến cáo sử dụng cho người lớn, trẻ vị thành niên và trẻ em từ 5 tuổi trở lên.','Hoãn tiêm vắc xin cho các đối tượng đang sốt.\nRối loạn thần kinh tiến triển bao gồm chứng co thắt, động kinh không kiểm soát hoặc bệnh não tiến triển (hoãn tiêm cho đến khi bệnh khỏi hoặc ổn định, cần cân nhắc yếu tố nguy cơ/ lợi ích).\nThận trọng khi tiêm vắc xin cho những đối tượng bị giảm tiểu cầu hoặc rối loạn máu chảy máu vì có thể gây chảy máu sau khi tiêm bắp ở những đối tượng này.','Vắc xin Infanrix IPV+Hib được bảo quản ở nhiệt độ 2-8 độ C. Không được để thành phần Infanrix IPV đông băng. Tránh ánh sáng.','Vắc xin Infanrix IPV+Hib được chỉ định tiêm cho trẻ từ 2 tháng tuổi đến trước sinh nhật 5 tuổi phòng 5 bệnh: bạch hầu, ho gà, uốn ván, bại liệt và các bệnh do Hib.','Không cần điều kiện đặc biệt nào trước tiêm vắc xin 5 trong 1 Infanrix IPV+Hib. Quý khách có thể sắp xếp đến Trung tâm VNVC để bác sĩ thăm khám và chỉ định mũi tiêm phù hợp.\nVắc xin Infanrix IPV+Hib có độ an toàn cao. Tuy nhiên, người được tiêm có thể gặp một số phản ứng nhẹ, kéo dài từ 1- 2 ngày:\nTại chỗ tiêm: đau, đỏ, sưng thường diễn ra từ 1-4 ngày sau tiêm.\nToàn thân: sốt, kích thích, chán ăn.','','https://vnvc.vn/wp-content/uploads/2021/06/vac-xin-Infanrix-IPV-Hib.jpg',0),(1,'2025-04-23 16:25:19.457063','2025-04-23 16:25:19.457063','vac-xin-abhayrab','Vắc xin Abhayrab','Vắc xin Abhayrab có tác dụng tạo miễn dịch chủ động phòng bệnh dại cho cả người lớn và trẻ em, sau khi tiếp xúc hoặc bị con vật nghi bị dại cắn.','Vắc xin Abhayrab phòng bệnh dại tế bào vero tinh chế do công ty Human Biological Institute (Ấn Độ) sản xuất.','Tiêm bắp (IM): người lớn tiêm ở vùng cơ Delta cánh tay, trẻ em tiêm ở mặt trước bên đùi. Không tiêm vào vùng mông.\nTrong một số trường hợp có thể áp dụng tiêm trong da (ID), tiêm ở cẳng tay hoặc cánh tay.','Không tiêm bắp ở người có rối loạn chảy máu như hemophilia hoặc giảm tiểu cầu.','Không sử dụng đồng thời các thuốc ức chế miễn dịch như corticosteroid vì những thuốc này có thể cản trở quá trình sinh kháng thể bảo vệ.\nSau khi bị cắn, rửa ngay vết thương với xà phòng và dưới vòi nước chảy liên tục trong thời gian từ 10-15 phút. Nếu không có xà phòng, có thể rửa tạm vết thương bằng nước sạch dưới vòi nước chảy liên tục 15 phút. Đây là phương pháp sơ cứu hiệu quả nhất để chống lại bệnh dại.\nTránh băng bó, đắp thuốc kín vết thương, tránh khâu vết thương vì có thể khiến virus dại xâm nhập dễ dàng hơn\nTrong trường hợp vết cắn rất nặng và vị trí vết thương gần đầu, nên thấm tại chỗ vết thương bằng globulin miễn dịch kháng virus dại.\nTrì hoãn việc bắt đầu điều trị sau phơi nhiễm, điều trị không triệt để hay không đủ phác đồ có thể làm cho việc bảo vệ khỏi virus dại bị thất bại.','Bảo quản ở nhiệt độ lạnh (từ 2 – 8 độ C). Không được đóng băng.','Vắc xin Abhayrab phòng bệnh dại được chỉ định tiêm cho trẻ em và người lớn ở mọi lứa tuổi.','Vắc xin Abhayrab có độ an toàn cao. Tuy nhiên, người được tiêm có thể gặp một số phản ứng nhẹ, kéo dài từ 1- 2 ngày:\nTại chỗ tiêm: đau, quầng đỏ, sưng, ngứa và nốt cứng\nToàn thân: sốt, đau đầu, chóng mặt, mệt mỏi.\nLưu ý: Khi có phơi nhiễm (bị súc vật liếm, cào, cắn…) phải sơ cứu và rửa sạch vết thương với thật nhiều nước và xà phòng. Sau đó rửa lại thật kỹ bằng nước sạch. Tiếp tục rửa vết thương bằng cồn Iod. Đưa bệnh nhân tới trung tâm tiêm chủng. Tùy vào mức độ của tiếp xúc mà bác sĩ tiêm ngừa có thể chỉ định tiêm thêm globulin miễn dịch.\nNên tiêm thêm vắc xin uốn ván ở tất cả các trường hợp có phơi nhiễm.','Dại','https://vnvc.vn/wp-content/uploads/2021/02/vac-xin-abhayrab.jpg',345000),(1,'2025-04-23 16:25:19.456067','2025-04-23 16:25:19.456067','vac-xin-adacel','Vắc xin Adacel','Vắc xin Adacel tạo miễn dịch chủ động nhắc lại nhằm phòng bệnh ho gà – bạch hầu – uốn ván.','Vắc xin Adacel ngừa ho gà – bạch hầu – uốn ván được nghiên cứu và phát triển bởi tập đoàn hàng đầu thế giới về dược phẩm và chế phẩm sinh học Sanofi Pasteur – Pháp. Vắc xin Adacel được sản xuất tại Canada.','Tiêm bắp. ','Người quá mẫn với thành phần của vắc xin.\nBệnh lý não (ví dụ hôn mê, giảm tri giác, co giật kéo dài) xảy ra trong vòng 7 ngày sau khi tiêm một liều vắc xin bất kỳ có chứa thành phần ho gà mà không xác định được nguyên nhân nào khác.','Hoãn việc sử dụng vắc xin khi có sốt cao hoặc các bệnh cấp tính.\nKhông nên tiêm bắp Adacel cho những người bị các rối loạn chảy máu, như bệnh máu khó đông hoặc giảm tiểu cầu.','Vắc xin được bảo quản ở nhiệt độ từ +2 đến +8 độ C. Không được để đông băng.','Vắc xin Adacel được chỉ định cho trẻ từ 4 tuổi trở lên và người lớn đến 64 tuổi.','Sau tiêm vắc xin 3 trong 1 Adacel có biểu hiện sốt không?\nSau khi tiêm 3 trong 1, người tiêm hay gặp những phản ứng nhẹ, không kéo dài và không cần điều trị đặc biệt. Đó là sự đáp ứng miễn dịch của cơ thể, cụ thể như sau:\nTại chỗ tiêm: đau, sưng, đỏ\nToàn thân: sốt, mệt mỏi, đau đầu, rối loạn tiêu hóa','Bạch hầu, ho gà, uốn ván','https://vnvc.vn/wp-content/uploads/2021/02/Adacel.jpg',775000),(1,'2025-04-23 16:25:19.446694','2025-04-23 16:25:19.446694','vac-xin-bexsero','Vắc xin Bexsero','Vắc xin Bexsero được chỉ định để chủng ngừa cho trẻ và người lớn từ 2 tháng tuổi đến 50 tuổi (chưa đến sinh nhật 51 tuổi) chống lại bệnh não mô cầu xâm lấn do Neisseria meningitidis nhóm B gây ra với hiệu quả lên đến 95%.','Vắc xin Bexsero là loại vắc xin đa thành phần (tái tổ hợp, hấp phụ) do hãng dược phẩm Glaxosmithkline – GSK sản xuất.','Vắc xin Bexsero được dùng dưới dạng tiêm bắp sâu, nên ưu tiên tiêm ở mặt trước bên cơ đùi của nhũ nhi hoặc vùng cơ delta cánh tay trên ở những đối tượng lớn hơn.\nNếu phải tiêm đồng thời nhiều loại vắc xin khác thì phải tiêm ở nhiều vị trí riêng biệt.','Quá mẫn với các hoạt chất hoặc bất kỳ tá dược nào được liệt kê trong bảng thành phần của vắc xin.','Hoãn tiêm vắc xin Bexsero cho những bệnh nhân đang sốt cao cấp tính.\nVắc xin Bexsero không được tiêm dưới dạng tiêm tĩnh mạch, tiêm dưới da hoặc tiêm trong da.\nNhững người bị suy giảm khả năng đáp ứng miễn dịch, dù do sử dụng liệu pháp ức chế miễn dịch, rối loạn di truyền hoặc do các nguyên nhân khác, đều có thể bị giảm đáp ứng kháng thể với chủng ngừa chủ động.\nKhông phải tất cả các đối tượng được tiêm vắc xin Bexsero đều có đáp ứng miễn dịch bảo vệ.\nVắc xin Bexsero không mong đợi bảo vệ chống lại được tất cả các chủng não mô cầu nhóm B đang lưu hành. Dữ liệu về những bệnh nhân mắc bệnh mạn tính còn hạn chế.\nCần cân nhắc nguy cơ tiềm tàng gây ngưng thở và cần theo dõi chức năng hô hấp trong vòng 48-72 giờ sau khi tiêm vắc xin với các liều cơ bản cho trẻ sinh cực non (≤ 28 tuần tuổi thai) và đặc biệt ở những trẻ sinh có tiền sử phổi chưa trưởng thành. Do lợi ích của việc tiêm vắc xin ở những trẻ này là cao, vì vậy không nên ngưng hoặc trì hoãn việc tiêm phòng.\nMặc dù không phát hiện mủ cao su tự nhiên trong nắp ống tiêm, vẫn chưa xác định được tính an toàn khi sử dụng Bexsero ở những người nhạy cảm với mủ cao su.\nKanamycin được sử dụng trong giai đoạn đầu của quá trình sản xuất và bị loại bỏ trong giai đoạn sau. Nếu hiện diện, nồng độ kanamycin trong vắc xin thành phẩm ở mức dưới 0.01 microgram mỗi liều. Việc sử dụng Bexsero ở những người nhạy cảm với kanamycin chưa được thiết lập.\nVắc xin Bexsero không ảnh hưởng hoặc ảnh hưởng rất ít đến khả năng lái xe và vận hành máy móc.','Vắc xin được bảo quản ở nhiệt độ từ 2 độ C đến 8 độ C.','Trẻ em và người lớn từ 2 tháng tuổi đến 50 tuổi (chưa đến sinh nhật 51 tuổi).','','Viêm màng não do Neisseria meningitidis nhóm B gây ra.','https://vnvc.vn/wp-content/uploads/2024/02/bexsero.jpg',1750000),(1,'2025-04-23 16:25:19.480485','2025-04-23 16:25:19.480485','vac-xin-euvax-b','Vắc xin Euvax B','Vắc xin Euvax B phòng bệnh do virus viêm gan B – loại virus này có thể lây truyền qua đường máu, qua quan hệ tình dục và từ mẹ truyền sang con.','Vắc xin Euvax được nghiên cứu và phát triển bởi tập đoàn hàng đầu thế giới về dược phẩm và chế phẩm sinh học – Sanofi Pasteur (Pháp). Vắc xin Euvax sản xuất tại Hàn Quốc.','Euvax B chỉ dùng đường tiêm bắp, không nên tiêm ở vùng mông, và không được tiêm tĩnh mạch.\nPhải lắc kỹ trước khi dùng, bởi vì trong quá trình bảo quản vắc xin có thể trở thành dạng chất lắng trắng mịn với dịch nổi bên trên trong suốt không màu.','Người mẫn cảm với bất kỳ thành phần nào của Euvax B.','Phải hoãn dùng Euvax B ở những bệnh nhân có bệnh có sốt cấp tính, nặng.\nỞ bệnh nhân mắc bệnh xơ cứng rải rác, bất cứ một kích thích hệ thống miễn dịch nào cũng có thể làm trầm trọng thêm các triệu chứng. Tuy nhiên, ở các bệnh nhân này cần phải cân nhắc giữa lợi ích của việc chủng ngừa viêm gan siêu vi B với nguy cơ của việc làm nặng thêm bệnh xơ cứng rải rác (xem Tác dụng ngoại ý).\nCần lưu ý rằng việc chủng ngừa không đạt được hiệu quả bảo vệ ở bệnh nhân viêm gan siêu vi B giai đoạn tiềm ẩn hay tiến triển.\nCũng như khi dùng các vắc xin dạng tiêm khác, cần phải chuẩn bị sẵn sàng các thuốc và phương tiện điều trị trong trường hợp sốc phản vệ sau khi tiêm vắc xin (hiếm gặp).','Vắc xin được bảo quản ở nhiệt độ từ 2 độ C đến 8 độ C. Không được để đông băng.','Vắc xin Euvax B 0.5ml phòng ngừa viêm gan B được dùng để chủng ngừa cho trẻ sơ sinh đến dưới 16 tuổi.\nVắc xin Euvax B 1ml phòng ngừa viêm gan B được dùng để chủng ngừa cho người từ 16 tuổi trở lên.','Sau khi tiêm Viêm gan B thì bé có sốt không?\nSau khi tiêm Viêm gan B, người tiêm có thể gặp những phản ứng nhẹ, không kéo dài và không cần điều trị đặc biệt. Đó là sự đáp ứng miễn dịch của cơ thể. Cụ thể như sau:\nTại chỗ tiêm: đau, sưng nhẹ.\nToàn thân: sốt nhẹ, trẻ quấy khóc.\nCác triệu chứng thường hết sau vài giờ đến 1-2 ngày.','','https://vnvc.vn/wp-content/uploads/2021/02/EUVAX.jpg',0),(1,'2025-04-23 16:25:19.450683','2025-04-23 16:25:19.450683','vac-xin-gardasil-9','Vắc xin Gardasil 9','Vắc xin thế hệ mới Gardasil 9 được xem là vắc xin bình đẳng giới vì mở rộng cả đối tượng và phạm vi phòng bệnh rộng hơn ở nam và nữ giới, bảo vệ khỏi 9 tuýp virus HPV phổ biến 6, 11, 16, 18, 31, 33, 45, 52 và 58 gây bệnh ung thư cổ tử cung, ung thư âm hộ, ung thư âm đạo, ung thư hậu môn, ung thư hầu họng, mụn cóc sinh dục, các tổn thương tiền ung thư hoặc loạn sản…, với hiệu quả bảo vệ lên đến trên 90%.','Vắc xin Gardasil 9 được nghiên cứu và phát triển bởi tập đoàn hàng đầu thế giới về dược phẩm và chế phẩm sinh học – Merck Sharp & Dohme (MSD – Mỹ).','Vắc xin Gardasil 9 được chỉ định tiêm bắp. Vị trí phù hợp là vùng cơ delta của phần trên cánh tay hoặc ở vùng trước phía trên đùi.\nKhông được tiêm Gardasil 9 vào mạch máu, tiêm dưới da hoặc tiêm trong da.\nKhông được trộn lẫn vắc xin trong cùng một ống tiêm với bất kỳ loại vắc xin và dung dịch nào khác.','Người quá mẫn với các hoạt chất hoặc với bất kỳ tá dược nào của vắc xin được liệt kê trong phần “Thành phần”.\nNhững người bị quá mẫn sau khi tiêm Gardasil 9 hoặc Gardasil trước đây không nên tiêm Gardasil 9.','Hoãn tiêm chủng ở những người đang bị sốt nặng cấp tính. Tuy nhiên, tình trạng nhiễm trùng nhẹ, như nhiễm trùng đường hô hấp trên nhẹ hoặc sốt mức độ nhẹ không chống chỉ định tiêm Gardasil 9.','Vắc xin Gardasil 9 được bảo quản trong tủ lạnh (2°C – 8°C). Không để đông lạnh.','Vắc xin Gardasil 9 được chỉ định tiêm chủng cho cả nam giới và nữ giới, từ 9 đến 45 tuổi.','Vắc xin Gardasil 9 có độ an toàn cao. Tuy nhiên, người được tiêm có thể gặp một số phản ứng nhẹ, kéo dài từ 1-2 ngày:\nPhản ứng tại chỗ tiêm: Nổi ban đỏ, chai cứng, sưng đau, ngứa, tăng nhạy cảm tại chỗ tiêm.\nCác phản ứng toàn thân khác: Sốt nhẹ, đau đầu, buồn ngủ, giảm cảm giác thèm ăn, buồn nôn, nôn mửa, tiêu chảy.','Ung thư cổ tử cung và sùi mào gà','https://vnvc.vn/wp-content/uploads/2022/05/vacxin-gardasil-9.jpg',2950000),(1,'2025-04-23 16:25:19.462101','2025-04-23 16:25:19.462101','vac-xin-gene-hbvax','Vắc xin Gene Hbvax','Vắc xin phòng viêm gan B tái tổ hợp Gene-HBvax phòng bệnh do virus viêm gan B – loại virus này có thể lây truyền qua đường máu, qua quan hệ tình dục và từ mẹ truyền sang con với khả năng lây nhiễm cao gấp 10 lần so với virus HIV. Một khi nhiễm virus viêm gan B người bệnh phải chấp nhận sống chung với bệnh suốt đời. 25% trong bệnh nhân viêm gan siêu vi B sẽ phát sinh những vấn đề nghiêm trọng về gan, kể cả ung thư gan.','Vắc xin phòng viêm gan B tái tổ hợp Gene-HBvax được sản xuất bởi Công ty TNHH MTV Vắc xin và Sinh phẩm số 1 VABIOTECH (Việt Nam).','Không được tiêm đường tĩnh mạch hoặc trong da, vắc xin Gene-HBvax được chỉ định tiêm bắp. Ở người lớn thì tiêm vắc xin vào vùng cơ delta, song ở trẻ sơ sinh và trẻ nhỏ thì nên tiêm vào vùng đùi ngoài thì tốt hơn vì cơ delta còn nhỏ. Ngoại lệ có thể tiêm vắc xin theo đường dưới da cho những bệnh nhân ưa chảy máu. Lắc kỹ lọ vắc xin trước khi tiêm.','Những người mẫn cảm với bất cứ thành phần nào của vắc xin;\nMắc các bệnh bẩm sinh;\nMệt mỏi, sốt cao hoặc phản ứng toàn thân với bất kỳ một bệnh nhiễm trùng đang tiến triển;\nBệnh tim, bệnh thận hoặc bệnh gan chưa điều trị ổn định;\nBệnh tiểu đường chưa điều trị ổn định hoặc suy dinh dưỡng;\nBệnh ung thư máu và các bệnh ác tính nói chung;\nBệnh quá mẫn.','Thận trọng','Bảo quản ở nhiệt độ lạnh (từ +2 đến +8 độ C). Không được đông băng.','Vắc xin Gene-HBvax được chỉ định phòng viêm gan B cho trẻ sơ sinh và người lớn.','','Viêm gan B tiến triển thành viêm gan mạn tính, xơ gan và ung thư gan ở giai đoạn cuối.','https://vnvc.vn/wp-content/uploads/2023/03/vac-xin-Gene-HBvax.jpg',220000),(1,'2025-04-23 16:25:19.472903','2025-04-23 16:25:19.472903','vac-xin-havax','Vắc xin Havax','Vắc xin Havax được dùng để phòng ngừa bệnh viêm gan A cho mọi đối tượng người lớn và trẻ em từ 24 tháng tuổi trở lên, đặc biệt cho những người có nguy cơ phơi nhiễm với virus viêm gan A.','Vắc xin Havax được nghiên cứu và sản xuất bởi Vabiotech – Việt Nam.','Tiêm bắp. Không được tiêm vào đường tĩnh mạch hoặc trong da.\nỞ người lớn thì tiêm vắc-xin vào vùng cơ Delta song ở trẻ em nên tiêm vào vùng đùi ngoài thì tốt hơn vì cơ Delta còn nhỏ.','Không tiêm Havax cho những người quá nhạy cảm với bất cứ thành phần nào của vắc xin.\nBệnh tim, bệnh thận hoặc bệnh gan.\nBệnh tiểu đường.\nBệnh ung thư máu và các bệnh ác tính nói chung.\nBệnh quá mẫn.\nKhông được tiêm tĩnh mạch trong bất cứ trường hợp nào.\nKhông tiêm cho trẻ em dưới 2 tuổi (24 tháng tuổi).\nKhông tiêm cho các đối tượng mắc bệnh bẩm sinh.\nHoãn tiêm ở người đang mệt mỏi, sốt cao hoặc phản ứng toàn thân hoặc bệnh nhiễm trùng đang tiến triển.','Cũng giống như tất cả các loại vắc xin khác: luôn phải có sẵn Epinephrine để đề phòng các trường hợp hãn hữu phản ứng phản vệ sau khi tiêm vắc xin có thể xảy ra.\nKhông được tiêm Havax vào mông hoặc trong da vì các đường tiêm này không cho đáp ứng miễn dịch tối ưu.\nVới đối tượng bệnh nhân đang chạy thận nhân tạo hoặc suy giảm miễn dịch, thì sau khi tiêm có thể hàm lượng kháng thể không được cao như mong đợi. Với các đối tượng này có thể phải tiêm các liều bổ sung.\nThời kỳ ủ bệnh viêm gan A có thể kéo dài. Vì vậy nếu tiêm vắc xin đang trong giai đoạn ủ bệnh thì vắc xin có thể sẽ không bảo vệ được cho các đối tượng này.','Vắc xin được bảo quản ở nhiệt độ từ +2 đến +8 độ C. Không để đông đá. Tránh ánh sáng.','Vắc xin Havax được khuyến cáo chủng ngừa cho trẻ từ 24 tháng tuổi đến dưới 18 tuổi, sử dụng cho những người có nguy cơ phơi nhiễm với virus viêm gan A như: \nNhững người chưa tiêm vắc xin Viêm gan A và có dự định đi du lịch đến những vùng dịch lưu hành (những vùng thường có virus viêm gan A).\nCác đối tượng vì nghề nghiệp có phơi nhiễm: hộ lý, y tá, cán bộ viên chức làm công tác chăm sóc phục vụ trẻ tàn tật, nhân viên xử lý nước, nước thải và thực phẩm công nghiệp.\nNhững người đặc biệt có nguy cơ lây nhiễm (bệnh nhân ưa chảy máu, truyền dịch nhiều lần, tiêm tĩnh mạch,đồng tính).\nHavax không bảo vệ chống lại được các bệnh gan do các tác nhân gây bệnh và các virút viêm gan khác gây ra.\nHavax không bảo vệ chống lại được các bệnh viêm gan do các tác nhân gây bệnh là các virus viêm gan khác gây ra.','Sau khi tiêm vắc xin phòng bệnh Viêm gan A, người tiêm có thể gặp phải những phản ứng nhẹ, không kéo dài và không cần điều trị đặc hiệu, cụ thể như sau:\nTại chỗ tiêm: có thể sưng quầng đỏ tại chỗ tiêm 1-2 ngày.\nToàn thân: Sốt nhẹ, đau đầu, đau cơ, mệt mỏi,…','Viêm gan A','https://vnvc.vn/wp-content/uploads/2021/02/vac-xin-havax.jpg',255000),(1,'2025-04-23 16:25:19.468915','2025-04-23 16:25:19.468915','vac-xin-ivacflu-s','Vắc xin Ivacflu-S','Vắc xin Ivacflu – S phòng 3 chủng cúm A(H3N2), cúm A(H1N1),và cúm B (Victoria/Yamagata).','Vắc xin Ivacflu – S được nghiên cứu và sản xuất bởi Viện Vắc xin và Sinh phẩm Y tế IVAC – Việt Nam.','Vắc xin Ivacflu-S được sử dụng qua đường tiêm bắp. Vị trí tiêm: Cơ delta (bắp cánh tay). Không được tiêm vắc xin vào mạch máu.','Có tiền sử sốc phản vệ với vắc xin cúm IVACFLU-S.\nTiền sử mẫn cảm với bất cứ chủng virus cúm nào trong thành phần vắc xin.\nTiền sử mẫn cảm với cao su (của nút lọ đựng vắc xin) hoặc các thành phần pha chế vắc xin như dung dịch PBS.\nNgười có hội chứng Guilain-Barre, có rối loạn thần kinh.\nNgười bị động kinh đang tiến triển hoặc có tiền sử co giật.\nNgười có cơ địa mẫn cảm nặng với các vắc xin khác (đã từng bị sốc phản vệ khi tiêm vắc xin)\nHoãn tiêm chủng nếu người tiêm có tình trạng bệnh lý mà cán bộ tiêm chủng nhận thấy không an toàn khi tiêm vắc xin (sốt trên 38oC; bệnh nhiễm trùng cấp tính…) hoặc không đảm bảo hiệu quả của vắc xin (đang dùng thuốc ức chế miễn dịch trên 14 ngày, mắc lao thể hoạt động…).','Vắc xin cúm mùa Ivacflu-S nên để đạt bằng nhiệt độ phòng ngay trước khi sử dụng. Nên lắc kỹ trước khi sử dụng. Cần giám sát chặt phản ứng quá mẫn sau khi tiêm vắc xin.\nĐáp ứng miễn dịch có thể không đủ mức bảo vệ trong trường hợp suy giảm miễn dịch bẩm sinh hoặc mắc phải.\nPhụ nữ tuổi sinh đẻ tốt nhất nên tiêm vắc xin cúm mùa trước khi chuẩn bị mang thai.\nKhông chống chỉ định đối với toàn bộ đối tượng có bệnh mãn tính, đặc biệt nên tiêm vắc xin Ivacflu-S cho đối tượng làm việc ở các cơ sở xã hội đông người, nằm viện lâu ngày. Trong những trường hợp này cần theo chỉ định của bác sĩ.\nNgười bị bệnh đường hô hấp mãn tính như hội chứng COPD nên tiêm vắc xin cúm mùa hàng năm theo chỉ định của bác sĩ\nNhân viên y tế và người cao tuổi nên tiêm vắc xin trước mùa cúm hàng năm.\nĐối tượng đi du lịch đến các nước vùng dịch nên tiêm một liều ít nhất 7 ngày trước khi đi. (Nếu chưa tiêm vắc xin cúm trong vòng 1 năm trước đó).','Nhiệt độ bảo quản vắc xin từ 2 đến 8 độ C, tránh đông băng. Bảo quản vắc xin nguyên trong hộp để tránh ánh sáng.','Vắc xin dành cho người lớn từ 18 tuổi đến 60 tuổi (đến sinh nhật lần thứ 60 tuổi). Lưu ý, không chỉ định tiêm cho phụ nữ mang thai.','Sau khi tiêm vắc xin phòng bệnh cúm, người tiêm hay gặp những phản ứng nhẹ, không kéo dài và không cần điều trị đặc biệt. Đó là sự đáp ứng miễn dịch của cơ thể. Cụ thể như sau:\nTại chỗ tiêm: đau, đỏ, sưng\nToàn thân: sốt,mệt mỏi, đau đầu','','https://vnvc.vn/wp-content/uploads/2021/02/vac-xin-ivacflu-s.jpg',0),(1,'2025-04-23 16:25:19.462101','2025-04-23 16:25:19.462101','vac-xin-jeev','Vắc xin Jeev','Vắc xin JEEV là loại vắc xin tinh khiết, bất hoạt qua nuôi cấy từ tế bào Vero, giúp cơ thể tạo ra miễn dịch chủ động nhằm dự phòng bệnh viêm não Nhật Bản.','','','','','','Vắc xin JEEV được chỉ định tiêm chủng cho trẻ em từ tròn 12 tháng tuổi đến người lớn ≤ 49 tuổi.','Vắc xin JEEV có độ an toàn cao. Tuy nhiên, trong một số thử nghiệm lâm sàng có kiểm soát, đánh giá tính an toàn của vắc xin JEEV, các đối tượng được tiêm có thể xuất hiện ít nhất một phản ứng bất lợi. Các phản ứng này thường xảy ra trong khoảng 3 ngày đầu tính từ ngày tiêm, các phản ứng gặp phải thường ở mức độ nhẹ trung bình và sẽ biến mất trong vòng một vài ngày. Không có sự gia tăng các phản ứng bất lợi giữa liều đầu tiên và liều thứ 2. Các phản ứng có thể gặp gồm:\nPhản ứng tại chỗ tiêm: Sưng, đau, xuất hiện quầng đỏ tại vị trí tiêm, nhạy cảm đau,…\nCác phản ứng toàn thân khác: Đau nhức các cơ, sốt, khó chịu, mệt mỏi, trẻ quấy khóc, giảm sự thèm ăn, ban đỏ, …\nHệ thần kinh trung ương và ngoại vi: Đau đầu, chóng mặt, buồn ngủ, ngủ lơ mơ,…\nDạ dày, ruột: Nôn mửa, viêm dạ dày, tiêu chảy, táo bón, buồn nôn,…\nTuy nhiên, đây là những phản ứng phụ sau tiêm thông thường và sẽ tự hết sau vài ngày mà không cần điều trị.','Viêm não Nhật Bản','https://vnvc.vn/wp-content/uploads/2023/03/vac-xin-jeev.jpg',399000),(1,'2025-04-23 16:25:19.478410','2025-04-23 16:25:19.478410','vac-xin-mmr','Vắc xin Measles – Mumps – Rubella','Sởi là bệnh truyền nhiễm cấp tính do virus Paramyxoviridae gây ra, có thể gây viêm tai giữa , viêm thanh quản, viêm phế quản – phổi, viêm màng não,…','Vắc xin MMR được nghiên cứu và phát triển bởi công ty Serum Institute of India Ltd.','Vắc xin được tiêm theo đường tiêm dưới da sâu ở vị trí mặt trước bên đùi đối với trẻ nhỏ và vị trí bắp tay đối với trẻ lớn hơn.','Những người đang sử dụng corticosteroids, các thuốc ức chế miễn dịch khác hoặc đang xạ trị có thể không có đáp ứng miễn dịch tối ưu.\nKhông được tiêm vắc xin cho những người đang sốt, có thai, mắc các bệnh truyền nhiễm cấp tính, bệnh bạch hầu, thiếu máu nghiêm trọng và các bệnh nặng khác về máu, có tổn thương chức năng thận, bệnh tim mất bù, đang sử dụng gammaglobulin hoặc truyền máu hoặc các đối tượng có khả năng dị ứng với các thành phần của vắc xin.\nVắc xin có thể còn vết của neomycin.\nChống chỉ định tuyệt đối với người có phản ứng quá mẫn hoặc dạng quá mẫn với neomycin, có tiền sử phản ứng quá mẫn hoặc dạng quá mẫn.\nKhông chống chỉ định với các trường hợp sốt nhẹ, viêm đường hô hấp nhẹ hoặc tiêu chảy và các triệu chứng ốm nhẹ khác.\nKhông có báo cáo phản ứng phụ nghiêm trọng nào ở phụ nữ có thai vô tình được tiêm vắc xin có thành phần Rubella ở giai đoạn sớm thai kỳ.','Do nguy cơ bị mất hoạt tính, nên không tiêm vắc xin MMR trong vòng 6 tuần và nếu có thể trong vòng 3 tháng kể từ khi sử dụng immunoglobulins hoặc một sản phẩm máu khác có chứa immunoglobulins (máu hoặc huyết tương).\nCũng với lý do trên, không được sử dụng immunoglobulins trong vòng 2 tuần sau khi tiêm vắc xin.\nNhững người có phản ứng Tuberculin dương tính có thể chuyển thành âm tính sau khi tiêm vắc xin.','Cả vắc xin và nước hồi chỉnh đều phải tránh ánh sáng. Cần bảo quản vắc xin ở chỗ tối, nhiệt độ từ 2-8 độ C. Nước hồi chỉnh phải bảo quản nơi mát, không để đông băng.','Tạo miễn dịch chủ động phòng bệnh sởi, quai bị và rubella ở trẻ em từ 12 tháng tuổi đến 10 tuổi.','','','https://vnvc.vn/wp-content/uploads/2022/06/MMR.jpg',0),(1,'2025-04-23 16:25:19.457063','2025-04-23 16:25:19.457063','vac-xin-mrvac','Vắc xin Sởi – Rubella MRVAC','Vắc xin MRVAC là chế phẩm sinh học có chứa kháng nguyên của virus sởi và rubella đã được giảm độc lực, không còn khả năng gây bệnh nhưng vẫn đảm bảo khả năng kích thích hệ thống miễn dịch sản sinh kháng thể đặc hiệu, chủ động chống lại sự tấn công và xâm nhập của virus sởi và rubella. Nhờ đó, bảo vệ người được tiêm khỏi nguy cơ mắc bệnh sởi và rubella.','Vắc xin MRVAC là một trong những thành tựu quan trọng của ngành y tế Việt Nam trong công tác phòng ngừa bệnh tật và ngăn chặn nguy cơ bùng phát dịch bệnh gây ra bởi 2 căn bệnh truyền nhiễm nguy hiểm hàng đầu là sởi và rubella. Vắc xin MRVAC được nghiên cứu, phát triển và sản xuất bởi Trung tâm nghiên cứu sản xuất vắc xin và sinh phẩm y tế (POLYVAC) tại Việt Nam, đánh dấu bước tiến quan trọng trong việc tự chủ nguồn cung cấp vắc xin trong nước.','MRVAC được chỉ định tiêm dưới da;\nKhông được tiêm tĩnh mạch','0,5mL/liều','Người có tiền sử dị ứng nghiêm trọng với bất kỳ thành phần nào của vắc xin;\nNgười có phản ứng nặng của lần tiêm chủng trước đối với vắc xin Sởi, Sởi – Rubella (MR), Sởi – Quai bị – Rubella (MMR);\nPhụ nữ mang thai;\nNgười bị mắc bệnh lao tiến triển chưa được điều trị hay suy giảm miễn dịch;\nNgười bị bệnh ác tính.','Lọ vắc xin dạng đông khô và lọ nước pha tiêm có hạn sử dụng là 24 tháng kể từ ngày sản xuất.','Vắc xin MRVAC được khuyến cáo chủng ngừa cho trẻ em từ 12 tháng tuổi trở lên, thanh thiếu niên và người lớn','Tác dụng không mong muốn thường gặp nhất có thể là:\nPhản ứng tại chỗ: sưng, đau, ban đỏ tại chỗ tiêm\nPhản ứng toàn thân: sốt nhẹ, ho, sổ mũi hoặc phát ban nhẹ\nCác phản ứng thông thường này diễn biến ở mức độ nhẹ, nhanh chóng thuyên giảm và sẽ hết sau khi tiêm 1 – 3 ngày mà không cần điều trị.','','https://vnvc.vn/wp-content/uploads/2024/09/vac-xin-mrvac.jpg',0),(1,'2025-04-23 16:25:19.470912','2025-04-23 16:25:19.470912','vac-xin-mvvac','Vắc xin Mvvac','Vắc xin MVVAC tạo miễn dịch chủ động phòng bệnh sởi cho trẻ từ 9 tháng tuổi trở lên và người chưa có kháng thể sởi.','Vắc xin MVVAC được nghiên cứu và sản xuất bởi Polyvac – Việt Nam.','Vắc xin MVVAC chỉ được tiêm dưới da, không được tiêm tĩnh mạch.','Trường hợp mẫn cảm với bất cứ thành phần nào của vắc xin;\nPhụ nữ có thai;\nTrường hợp bị nhiễm trùng cấp tính đường hô hấp, mắc bệnh lao tiến triển chưa được điều trị;\nNgười bị suy giảm miễn dịch (trừ trẻ em bị HIV);\nNgười bị bệnh ác tính.','Cần thận trọng đối với những trường hợp có tiền sử sốt cao, dị ứng, co giật, tổn thương não, giảm tiểu cầu;\nKhông nên tiêm vắc xin trong trường hợp đang sốt hay đang trong quá trình điều trị có ảnh hưởng đến hệ miễn dịch (như dùng thuốc, truyền máu, hay các chế phẩm từ máu…).\nChỉ tiêm vắc xin cho trẻ khi đã hết sốt ít nhất là 3 ngày và sau khi kết thúc điều trị ảnh hưởng đến hệ miễn dịch tối thiểu là 4 tuần.','Lọ vắc xin sởi dạng đông khô được bảo quản ở khoảng nhiệt độ  ≤ 8 độ C và tránh ánh sáng.\nLọ nước pha tiêm được bảo quản nhiệt độ dưới 30oC, không được làm đông băng.\nLọ vắc xin sau khi pha hồi chỉnh bằng nước pha tiêm sẽ được bảo quản ở nhiệt độ 2 độ C đến 8 độ C và chỉ sử dụng trong vòng 6 giờ.','Vắc xin MVVAC phòng bệnh sởi cho trẻ từ 9 tháng tuổi trở lên và người chưa có kháng thể sởi.','Sau khi tiêm sởi, người tiêm có sốt không?\nSau khi tiêm vắc xin phòng bệnh sởi, trẻ hay gặp những phản ứng nhẹ, không kéo dài và không cần điều trị đặc biệt. Đó là sự đáp ứng miễn dịch của cơ thể. Cụ thể như sau:\nTại chỗ tiêm: đau, đỏ, sưng\nToàn thân: Sốt, ban, ho và sổ mũi\nCác triệu chứng này thường kéo dài từ 1 đến 3 ngày rồi tự khỏi mà không cần điều trị.','Sởi','https://vnvc.vn/wp-content/uploads/2021/02/vac-xin-MVVAC.jpg',396000),(1,'2025-04-23 16:25:19.446694','2025-04-23 16:25:19.446694','vac-xin-pneumovax-23','Vắc xin Pneumovax 23','Pneumovax 23, hay còn được biết đến với tên gọi vắc xin Polysaccharide phế cầu 23-valent, là vắc xin được chỉ định để ngăn ngừa các bệnh nhiễm trùng do vi khuẩn phế cầu (Streptococcus pneumoniae) gây ra như viêm phổi, viêm màng não, nhiễm khuẩn huyết (nhiễm trùng máu)…','Vắc xin Pneumovax 23 là sản phẩm do công ty dược phẩm đa quốc gia hàng đầu tại Mỹ – Merck Sharp & Dohme (MSD) nghiên cứu, phát triển và sản xuất. Đây là một trong những vắc xin phổ biến được sử dụng rộng rãi trên khắp thế giới để phòng ngừa các bệnh do vi khuẩn Streptococcus pneumoniae gây ra.','Pneumovax 23 được tiêm dưới dạng dung dịch trong lọ đơn liều 0,5ml, qua đường tiêm bắp hoặc tiêm dưới da, thường là vào bắp tay (cơ delta) ở người lớn.\nKhông được tiêm vào mạch máu và phải thận trọng để đảm bảo kim không đi vào mạch máu.\nKhông được tiêm vắc xin trong da vì có liên quan đến tăng các phản ứng tại chỗ.','Những người có tiền sử dị ứng nặng, quá mẫn với bất kỳ thành phần, tá dược nào của vắc xin.\nNgười đang bị sốt cao hoặc có tình trạng nhiễm trùng cấp tính nên hoãn tiêm phòng cho tới khi hồi phục.','Cân nhắc cẩn thận ở những người có tiền sử sốc phản vệ hoặc các phản ứng nghiêm trọng khác đối với vắc xin.','Pneumovax 23 cần được bảo quản ở nhiệt độ từ 2°C đến 8°C (36°F đến 46°F), tránh đông lạnh. Phải đảm bảo rằng vắc xin được bảo quản đúng quy định trước khi sử dụng để đảm bảo hiệu quả tối đa.','Vắc xin Pneumovax 23 được khuyến cáo sử dụng cho trẻ em từ 2 tuổi trở lên, thanh thiếu niên và người lớn','Giống như tất cả các loại vắc xin/thuốc khi được đưa vào cơ thể để chống lại virus/vi khuẩn, người được tiêm chủng có khả năng gặp phải các phản ứng sau tiêm tại chỗ hoặc toàn thân, thường nhẹ không đáng lo và sẽ nhanh khỏi như:\nTriệu chứng toàn thân: sốt, mệt mỏi, đau đầu…\nTriệu chứng tại chỗ: ban đỏ, chai cứng, đau sưng nhức tại vết tiêm','Viêm phổi, viêm màng não, nhiễm khuẩn huyết (nhiễm trùng máu)… do phế cầu khuẩn.','https://vnvc.vn/wp-content/uploads/2024/08/vaccine-pneumovax-23.jpg',1450000),(1,'2025-04-23 16:25:19.465903','2025-04-23 16:25:19.465903','vac-xin-priorix','Vắc xin Priorix','Vắc xin Priorix có thể tiêm sớm cho trẻ từ 9 tháng tuổi, Priorix có thể tăng khả năng bảo vệ lên đến 98% nếu tiêm đủ 2 mũi. Priorix bảo vệ sớm cho trẻ, giảm tỷ lệ bệnh nặng và tử vong, giúp ngăn ngừa sự lây lan của virus.','Không tiêm vắc xin Priorix cho phụ nữ có thai.','Không có số liệu ở người liên quan đến việc dùng Priorix cho phụ nữ cho con bú. Có thể tiêm vắc xin khi lợi ích thu được vượt trội nguy cơ.','','','Không có số liệu ở người liên quan đến việc dùng Priorix cho phụ nữ cho con bú. Có thể tiêm vắc xin khi lợi ích thu được vượt trội nguy cơ.','Vắc xin Priorix được chỉ định tiêm chủng cho trẻ em từ 9 tháng tuổi và người lớn.','','Sởi - quai bị - rubella','https://vnvc.vn/wp-content/uploads/2022/07/vac-xin-priorix.jpg',495000),(1,'2025-04-23 16:25:19.444699','2025-04-23 16:25:19.444699','vac-xin-qdenga','Vắc xin Qdenga','Vắc xin Qdenga là chế phẩm sinh học đặc biệt có khả năng phòng bệnh sốt xuất huyết do virus Dengue gây ra, có khả năng bảo vệ chống lại cả 4 nhóm huyết thanh của virus dengue, bao gồm DEN-1, DEN-2, DEN-3 và DEN-4, được chỉ định tiêm cho người từ 4 tuổi trở lên với hiệu lực bảo vệ hơn 80% nguy cơ mắc bệnh do 4 tuýp virus Dengue và trên 90% nguy cơ nhập viện, mắc bệnh nặng và biến chứng nguy hiểm do bệnh sốt xuất huyết gây ra.','Vắc xin Qdenga là vắc xin sống giảm độc lực được nghiên cứu, phát triển và sản xuất bởi Hãng vắc xin và dược phẩm Takeda – Nhật Bản, xuất xứ tại Đức.','Sau khi hoàn nguyên hoàn toàn vắc xin đông khô với chất pha loãng (dung môi), Qdenga nên được tiêm dưới da, tốt nhất là ở cánh tay trên ở vùng cơ delta.\nQdenga không được tiêm vào mạch, không được tiêm trong da hoặc tiêm bắp.\nKhông nên trộn vắc xin trong cùng một ống tiêm với bất kỳ loại vắc xin hoặc sản phẩm thuốc tiêm nào khác.','Quá mẫn cảm với hoạt chất hoặc với bất kỳ tá dược nào hoặc quá mẫn cảm với liều Qdenga trước đó\nNhững người bị suy giảm miễn dịch bẩm sinh hoặc mắc phải, bao gồm sử dụng các liệu pháp ức chế miễn dịch như hóa trị hoặc dùng corticosteroid toàn thân liều cao (ví dụ: với liều 20mg/ngày hoặc liều tương đương với prednisone 2 mg/kg/ngày trong 2 tuần trở lên) trong vòng 4 tuần trước khi tiêm chủng, tương tự như với các vắc xin sống giảm độc lực khác\nNhững người nhiễm HIV có triệu chứng hoặc nhiễm HIV không có triệu chứng kèm theo bằng chứng suy giảm chức năng hệ miễn dịch\nPhụ nữ có thai\nPhụ nữ cho con bú','Giống như tất cả các loại vắc xin khác, cần có sẵn phương pháp điều trị y tế thích hợp và giám sát trong trường hợp xảy ra phản ứng phản vệ hiếm gặp sau khi tiêm vắc xin. Trước khi tiêm chủng, bác sĩ khám sàng lọc sẽ xem xét bệnh sử của người được tiêm phòng (đặc biệt là về lần tiêm chủng trước đó và các phản ứng quá mẫn có thể xảy ra sau khi tiêm chủng).','Vắc xin được bảo quản ở nhiệt độ từ 2 –  8°C.\nTránh tiếp xúc với chất bảo quản, thuốc sát trùng, chất tẩy rửa và các chất chống vi rút khác vì chúng có thể làm bất hoạt vắc xin.\nChỉ sử dụng ống tiêm vô trùng không chứa chất bảo quản, chất khử trùng, chất tẩy rửa và các chất chống virus khác để pha và tiêm Qdenga.\nQdenga phải được hoàn nguyên trước khi dùng.','Vắc xin Qdenga được chỉ định phòng ngừa bệnh sốt xuất huyết cho bất kỳ loại huyết thanh virus sốt xuất huyết nào gây ra ở những người từ 4 tuổi trở lên.','','Sốt xuất huyết','https://vnvc.vn/wp-content/uploads/2024/09/vaccine-qdenga-1.jpg',1390000),(1,'2025-04-23 16:25:19.474898','2025-04-23 16:25:19.474898','vac-xin-quimi-hib','Vắc xin Quimihib','Vắc xin Quimihib phòng ngừa bệnh viêm phổi, viêm màng não mủ do tác nhân Haemophilus Influenzae type b gây ra ở trẻ nhỏ.','Vắc xin QuimiHib được nghiên cứu và phát triển bởi tập đoàn hàng đầu thế giới về dược phẩm và chế phẩm sinh học C.I.G.B – Cuba.','Tiêm bắp.\nTiêm vào vùng trước bên đùi của trẻ dưới 2 tuổi.\nTiêm vào vùng cơ delta đối với trẻ trên 2 tuổi.','Không tiêm QuimiHib cho đối tượng dị ứng, mẫn cảm với bất kỳ thành phần nào của vắc xin.\nKhông tiêm cho đối tượng đang sốt cao hoặc bệnh cấp tính.\nKhông tiêm vào mạch máu, tĩnh mạch trong bất cứ trường hợp nào.','Như mọi vắc xin khác, trước tiêm vắc xin QuimiHib luôn cần phải chuẩn bị sẵn adrenalin và corticosteroids để dự phòng khi xảy ra các phản ứng quá mẫn, sốc phản vệ.\nKhông tiêm các liều Quimi-Hib cho các đối tượng có biểu hiện quá mẫn khi tiêm các liều trước đó.\nTiêm cho đối tượng suy giảm miễn dịch hoặc đang sử dụng các thuốc ức chế miễn dịch, có thể cho đáp ứng hạn chế hoặc không hình thành đủ miễn dịch.\nQuimi-Hib có thể tạo kháng thể kháng uốn ván nhưng không thể thay thế vắc xin DTP.\nKhông sử dụng vắc xin cho phụ nữ có thai hoặc đang cho con bú.','Vắc xin được bảo quản ở nhiệt độ từ 2 đến 8 độ C. Không được để đông đá vắc xin. Loại bỏ vắc xin nếu bị đông đá. Vắc xin cần được tiêm ngay sau khi mở lọ.','Vắc xin QuimiHib dành cho trẻ em từ 2 tháng tuổi đến 15 tuổi.','Sau khi tiêm vắc xin phòng các bệnh do Hib, trẻ hay gặp những phản ứng nhẹ, không kéo dài và không cần điều trị đặc biệt. Đó là sự đáp ứng miễn dịch của cơ thể, cụ thể như sau:\nTại chỗ tiêm: đỏ, sưng, đau và có thể ngứa tại vị trí tiêm\nToàn thân: Sốt nhẹ, quấy khóc, biếng ăn, buồn nôn, nôn , tiêu chảy\nCác triệu chứng nhẹ và tự khỏi trong 1-3 ngày','Các bệnh do HIB','https://vnvc.vn/wp-content/uploads/2021/02/vac-xin-quimi-hib.jpg',385000),(1,'2025-04-23 16:25:19.465903','2025-04-23 16:25:19.465903','vac-xin-rotarix','Vắc xin Rotarix','Rotarix là vắc xin sống, giảm độc lực được chỉ định cho trẻ từ 6 tuần tuổi phòng viêm dạ dày – ruột do Rotavirus tuýp huyết thanh G1 và không phải G1. Mặc dù trong thành phần chỉ có 1 tuýp G1P tuy nhiên vắc xin có khả năng bảo vệ chéo tất cả các tuýp G1 và không phải G1 (G2, G3, G4, G9).','Vắc xin Rotarix được nghiên cứu và phát triển bởi tập đoàn hàng đầu thế giới về dược phẩm và chế phẩm sinh học – GlaxoSmithKline (Bỉ).','Chỉ dùng đường uống.\nVắc xin Rotarix có khả năng bám dính rất tốt vì vậy sau khi uống nếu trẻ có nôn trớ thì cũng không cần uống liều khác. Tuy nhiên nếu xác định rằng đã bị nôn trớ phần lớn vắc xin thì có thể uống lại.','Không dùng vắc xin Rotarix cho trẻ đã quá mẫn cảm ở lần uống đầu tiên hoặc với bất kỳ thành phần nào của vắc xin.\nKhông dùng cho trẻ có dị tật bẩm sinh về đường tiêu hóa vì có thể dẫn đến lồng ruột (như túi thừa Meckel).','Nên tạm hoãn việc dùng vắc xin nếu trẻ đang bị sốt hoặc rối loạn tiêu hóa và bị nôn trớ. Tuy nhiên nếu trẻ bị cảm lạnh thì vẫn có thể dùng bình thường.\nĐối với trẻ vừa uống vắc xin thì cần lưu ý giữ vệ sinh cá nhân như: rửa tay sau khi thay tã…\nChưa có dữ liệu về độ an toàn và hiệu lực của vắc xin đối với những trẻ mắc bệnh đường tiêu hóa. Nên thận trọng và hỏi ý kiến bác sĩ khi sử dụng cho các đối tượng này vì vắc xin có thể làm bệnh của trẻ trầm trọng hơn.\nChưa có dữ liệu nghiên cứu lâm sàng trên trẻ mắc bệnh suy giảm miễn dịch tiên phát hoặc thứ phát (bao gồm cả trẻ nhiễm HIV dương tính).\nCũng như các vắc xin khác, đáp ứng miễn dịch có thể không đạt được ở tất cả các trẻ uống vắc xin. Rotarix không ngừa được các trường hợp viêm dạ dày ruột mà không phải do Rotavirus.','Vắc xin đông khô được bảo quản ở nhiệt độ 2-8 độ C, tránh ánh sáng.\nDung môi hoàn nguyên có thể bảo quản ở 2-8 độ C hoặc ở nhiệt độ phòng (<37 độ C).\nSau khi hoàn nguyên, vắc xin được sử dụng ngay hoặc bảo quản trong tủ lạnh từ 2-8 độ C trong vòng 24 giờ. Sau 24 giờ phải loại bỏ vắc xin đã hoàn nguyên.','Vắc xin Rotarix được chỉ định chủng ngừa cho trẻ từ 6 tuần tuổi phòng tránh nguy cơ nhiễm virus Rota – nguyên nhân gây tiêu chảy cấp ở trẻ nhỏ.','Vắc xin Rotarix có độ an toàn cao. Tuy nhiên, sau khi uống vắc xin, trẻ hay gặp những phản ứng nhẹ, không kéo dài và không cần điều trị đặc biệt. Đó là sự đáp ứng miễn dịch của cơ thể. Cụ thể như sau:\nToàn thân: rối loạn tiêu hóa và thường tự khỏi sau vài ngày.\nNếu đi ngoài phân nước nhiều lần, nôn nhiều, có dấu hiệu mất nước nên khám lại ngay tại cơ sở y tế.','Tiêu chảy','https://vnvc.vn/wp-content/uploads/2017/04/vac-xin-rotarix.jpg',825000),(1,'2025-04-23 16:25:19.466900','2025-04-23 16:25:19.466900','vac-xin-rotateq','Vắc xin Rotateq','Rotateq là vắc xin sống giảm độc lực phòng ngừa Rotavirus, ngũ giá, dùng đường uống được chỉ định cho trẻ từ 7,5 tuần tuổi phòng viêm dạ dày – ruột do Rotavirus ở trẻ nhỏ gây ra bởi các tuýp vi-rút G1, G2, G3, G4 và các tuýp có chứa P1A (ví dụ như G9).','Vắc xin Rotateq được nghiên cứu và phát triển bởi tập đoàn hàng đầu thế giới về dược phẩm và chế phẩm sinh học Meck Sharp and Dohme (MSD) – Mỹ. ','Chỉ dùng đường uống. Không được tiêm.\nNếu trẻ bị nôn trớ hoặc nhổ ra thì không được uống liều thay thế vì chưa có nghiên cứu lâm sàng cho việc uống thay thế. Cứ dùng liều tiếp theo trong lịch uống vắc xin.\nVắc xin được đóng trong tuýp định liều có thể vặn nắp và cho uống luôn, không được pha loãng bằng nước hoặc sữa.','Không dùng vắc xin cho trẻ khi có dị ứng với bất kỳ thành phần nào trong vắc xin.\nKhông dùng liều tiếp theo nếu trẻ có biểu hiện mẫn cảm với lần uống vắc xin Rotateq trước.\nKhông dùng vắc xin Rotateq cho trẻ suy giảm miễn dịch kết hợp trầm trọng, vì đã có báo cáo về trường hợp viêm dạ dày ruột khi dùng vắc xin ở trẻ suy giảm miễn dịch kết hợp trầm trọng.','Đối với những trẻ đang có bệnh dạ dày ruột tiến triển, tiêu chảy mạn tính hoặc chậm phát triển, có bệnh lý bẩm sinh như lồng ruột thì việc cân nhắc giữa lợi ích và nguy cơ phải được bác sĩ đánh giá.\nCó thể tạm hoãn việc sử dụng vắc xin Rotateq nếu trẻ đang sốt hoặc nhiễm trùng cấp tính. Tuy nhiên tình trạng sốt và nhiễm trùng ở thể nhẹ không phải là chống chỉ định của Rotateq.\nCũng như các vắc xin khác, việc phòng ngừa bằng Rotateq không đảm bảo phòng tránh bệnh hoàn toàn.\nRotateq đã được chứng minh hiệu quả khi dùng cho trẻ từ 6 tuần đến 32 tuần tuổi. Không có dữ liệu lâm sàng về tính hiệu quả và độ an toàn khi dùng cho trẻ dưới 6 tuần tuổi.','Vắc xin Rotateq được bảo quản ở nhiệt độ từ 2 độ C đến 8 độ C. Sau khi lấy ra khỏi tủ lạnh, vắc xin cần được sử dụng ngay. Khi bảo quản ở nhiệt độ 25 độ C, vắc xin Rotateq có thể sử dụng trong vòng 48 giờ. Sau 48 giờ vắc xin cần phải loại bỏ theo quy định.','Vắc xin Rotateq được chỉ định chủng ngừa cho trẻ từ 6 tuần tuổi phòng tránh nguy cơ nhiễm virus Rota – nguyên nhân gây tiêu chảy cấp ở trẻ nhỏ.','Sau khi uống vắc xin phòng bệnh tiêu chảy do Rotavirus, trẻ hay gặp những phản ứng nhẹ, không kéo dài và không cần điều trị đặc biệt, đó là sự đáp ứng miễn dịch của cơ thể. Cụ thể như sau:\nToàn thân: rối loạn tiêu hóa và thường tự khỏi sau vài ngày.\nNếu đi ngoài phân nước nhiều lần, nôn nhiều, có dấu hiệu mất nước nên khám lại ngay tại cơ sở y tế.','Tiêu chảy','https://vnvc.vn/wp-content/uploads/2021/02/vac-xin-RotaTeq.jpg',665000),(1,'2025-04-23 16:25:19.445696','2025-04-23 16:25:19.445696','vac-xin-shingrix','Vắc xin Shingrix','Vắc xin Shingrix là sinh phẩm y tế được chỉ định để phòng bệnh zona thần kinh (Herpes Zoster) hay còn gọi là giời leo và các biến chứng liên quan đến Herpes Zoster, như đau dây thần kinh sau khi mắc zona (PHN). Vắc xin Shingrix được chỉ định sử dụng để tiêm ngừa cho người lớn từ 50 tuổi trở lên và người từ 18 tuổi trở lên có nguy cơ mắc zona thần kinh.','Vắc xin Shingrix là vắc xin tái tổ hợp được bào chế ở dạng hỗn dịch tiêm, được cung cấp dưới dạng lọ đơn liều chứa thành phần kháng nguyên glycoprotein E (gE) của VZV đông khô để được hoàn nguyên bằng lọ đi kèm thành phần hỗn dịch bổ trợ AS01.','Vắc xin Shingrix được chỉ định tiêm bắp, tốt nhất tại vùng cơ delta của cánh tay.','Chống chỉ định tiêm vắc xin Shingrix cho các đối tượng có tiền sử phản ứng dị ứng nghiêm trọng như sốc phản vệ với bất kỳ thành phần nào của vắc xin Shingrix.','1. Trên phụ nữ có thai','Vắc xin được bảo quản ở nhiệt độ từ 2 –  8°C. Sau khi pha (hoàn nguyên), sử dụng Shingrix ngay lập tức. Nếu không thể sử dụng ngay, sản phần đã hoàn nguyên cần bảo quản trong tủ bảo quản chuyên dụng từ 2 – 8°C và sử dụng trong vòng 6 giờ tại phòng tiêm. Loại bỏ vắc xin đã hoàn nguyên nếu không sử dụng trong vòng 6 giờ.','Người lớn từ 50 tuổi trở lên;\nNgười lớn từ 18 tuổi trở lên đang hoặc sẽ có hệ miễn dịch yếu do bệnh tật hoặc do điều trị… là những người có nguy cơ cao mắc Zona thần kinh.','','Zona thần kinh','https://vnvc.vn/wp-content/uploads/2023/11/vacxin-shingrix.jpg',3890000),(1,'2025-04-23 16:25:19.471903','2025-04-23 16:25:19.471903','vac-xin-tetraxim','Vắc xin Tetraxim','Vắc xin 4 trong 1 Tetraxim (Pháp) được chỉ định để phòng ngừa các bệnh ho gà, bạch hầu, uốn ván, bại liệt cho trẻ từ 2 tháng tuổi trở lên đến 13 tuổi tùy theo mỗi quốc gia.','Vắc xin Tetraxim do tập đoàn hàng đầu thế giới về dược phẩm và chế phẩm sinh học Sanofi Pasteur (Pháp) sản xuất.','Tiêm bắp ở trẻ nhũ nhi và tiêm vùng cơ delta ở trẻ 2 tháng tuổi đến 13 tuổi.','Trẻ bị dị ứng với một trong các thành phần của vắc xin.\nNếu trẻ bị bệnh não tiến triển (thương tổn ở não).\nNếu trẻ từng bị bệnh não (tổn thương ở não) trong vòng 7 ngày sau khi tiêm liều vắc xin ho gà (ho gà vô bào hay toàn tế bào).\nNếu trẻ bị sốt hay bị bệnh cấp tính (phải hoãn việc tiêm ngừa lại).','Bảo đảm rằng không tiêm vắc xin vào lòng mạch máu cũng như không tiêm trong da.\nTrẻ có tiền sử dị ứng, đặc biệt là phản ứng dị ứng sau khi tiêm Tetraxim hoặc đang được điều trị bằng thuốc ức chế miễn dịch hoặc bị suy giảm miễn dịch.\nĐã từng có những triệu chứng sau đây mà được cho rằng có liên quan đến vắc xin:','Vắc xin được bảo quản ở nhiệt độ từ 2 đến 8 độ C. Không được để đông băng.','Vắc xin 4 trong 1 Tetraxim (Pháp) được chỉ định tiêm cho trẻ từ 2 tháng tuổi trở lên đến 13 tuổi (tùy theo khuyến cáo chính thức của từng quốc gia).','Sau tiêm vắc xin 4 trong 1 có biểu hiện sốt không?\nSau khi tiêm 4 trong 1, trẻ hay gặp những phản ứng nhẹ, không kéo dài và không cần điều trị đặc biệt. Đó là sự đáp ứng miễn dịch của cơ thể, cụ thể như sau:\nTại chỗ tiêm: đỏ, sưng (có thể hơn 5cm) hoặc lan ra toàn bộ chi bên tiêm. Xảy ra trong vòng 24 – 72 giờ sau khi tiêm vắc xin và tự khỏi trong vòng 3-5 ngày.\nToàn thân: sốt, tiêu chảy, kém ăn, quấy khóc.','Bạch hầu, ho gà, uốn ván, bại liệt','https://vnvc.vn/wp-content/uploads/2021/02/vac-xin-tetraxim.jpg',645000),(1,'2025-04-23 16:25:19.456067','2025-04-23 16:25:19.456067','vac-xin-uon-van-bach-hau-hap-phu-td-viet-nam','Vắc xin Uốn ván, bạch hầu hấp phụ','Vắc xin uốn ván – bạch hầu hấp phụ (Td) được chỉ định cho trẻ em lứa tuổi lớn (từ 7 tuổi trở lên) và người lớn nhằm gây miễn dịch, phòng các bệnh uốn ván và bạch hầu.','Là vắc xin được sản xuất bởi Viện vắc xin và sinh phẩm y tế Nha Trang IVAC (Việt Nam).','Vắc xin uốn ván – bạch hầu hấp phụ (Td) được chỉ định tiêm bắp sâu. Không được tiêm dưới da hoặc tĩnh mạch.\nLắc tan đều trước khi dùng.\nLiều tiêm 0,5 ml.','Tiền sử quá mẫn với thành phần của vắc xin. Có biểu hiện dị ứng với kháng nguyên bạch hầu và uốn ván ở những lần tiêm trước.\nTạm hoãn tiêm vắc xin uốn ván – bạch hầu hấp phụ (Td) trong những trường hợp có bệnh nhiễm trùng cấp tính, sốt chưa rõ nguyên nhân.\nKhông tiêm bắp cho người có rối loạn chảy máu như Hemophilia hoặc giảm tiểu cầu.','Đối tượng đang sốt cao cấp tính (hoãn tiêm cho đến khi trẻ hết sốt).\nThăm khám trước khi tiêm để loại trừ những trường hợp chống chỉ định, bảo đảm an toàn và hạn chế các tác dụng bất lợi của vắc xin trong lúc tiêm chủng.\nKhông tiêm quá liều vắc xin.\nKhông tiêm vắc xin vào mạch máu, tránh sốc phản vệ.\nĐôi khi tại chỗ tiêm xuất hiện nốt cứng kéo dài 2 – 3 tuần rồi tự khỏi.\nNếu tiêm kết hợp với vắc xin khác hoặc huyết thanh miễn dịch thì tiêm vắc xin Td khác vị trí.\nNếu tiêm nhầm vắc xin vào dưới da thì phản ứng phụ sẽ rất rầm rộ do vắc xin chứa tá chất nhôm.\nLuôn có sẵn thiết bị và phác đồ phòng sốc phản vệ.\nThăm khám trước khi tiêm để loại trừ những trường hợp chống chỉ định, bảo đảm an toàn và hạn chế các tác dụng bất lợi của vắc xin trong lúc tiêm chủng.','Vắc xin nên được bảo quản ở nhiệt độ từ 2 đến 8 độ C, và không được để đông băng.\nĐể xa tầm tay trẻ em.','Được chỉ định chủng ngừa cho người từ 7 tuổi trở lên tạo đáp ứng kháng thể chống 2 bệnh bạch hầu và uốn ván.\nKhông chống chỉ định cho phụ nữ có thai và đang cho con bú. Cân nhắc sử dụng theo chỉ định của bác sĩ.','Sau khi tiêm vắc xin uốn ván – bạch hầu hấp phụ (Td) có thể gặp những phản ứng nhẹ, không kéo dài và không cần điều trị đặc biệt. Đó là sự đáp ứng miễn dịch của cơ thể, cụ thể như sau:\nTại chỗ tiêm: đau, sưng, quầng đỏ.\nToàn thân: sốt nhẹ, mệt mỏi, khó chịu, đau đầu.','Uốn ván - Bạch hầu','https://vnvc.vn/wp-content/uploads/2020/07/vac-xin-uon-van-bach-hau-hap-phu-td.jpg',205000),(1,'2025-04-23 16:25:19.478410','2025-04-23 16:25:19.478410','vac-xin-varicella','Vắc xin Varicella','Vắc xin Varicella tạo miễn dịch dịch chủ động phòng bệnh thủy đậu do virus Varicella Zoster gây ra.','Vắc xin Varicella được nghiên cứu và sản xuất bởi Green Cross – Hàn Quốc.','Vắc xin phải được sử dụng ngay không quá 30 phút sau khi hoàn nguyên với nước hồi chỉnh cung cấp.\nTiêm dưới da. Liều đơn 0.5ml','Quá mẫn với bất kỳ thành phần nào của vắc xin.\nKhông dùng vắc xin cho đối tượng đang sốt hoặc suy dinh dưỡng.\nBệnh tim mạch, rối loạn chức năng gan, thận.\nCó tiền sử quá mẫn với kanamycin và Erythromycin.\nCó tiền sử co giật trong vòng 1 năm trước khi tiêm vắc xin.\nSuy giảm miễn dịch tế bào.\nCó thai hoặc 2 tháng trước khi định có thai.\nĐã tiêm phòng vắc xin sống khác trong vòng 1 tháng gần đây (Sởi, quai bị, rubella, lao, bại liệt).\nSuy giảm miễn dịch tiên phát hoặc mắc phải như AIDS hoặc các biểu hiện lâm sàng của nhiễm virus gây suy giảm miễn dịch ở người.\nTrẻ em dưới 12 tháng tuổi.\nBệnh nhân mắc bệnh bạch cầu tủy cấp, bệnh bạch cầu tế bào lympho T hoặc u lympho ác tính.\nBệnh nhân bị ức chế mạnh hệ thống miễn dịch do xạ trị hoặc giai đoạn tấn công trong điều trị bệnh bạch cầu.','Điều trị liệu pháp phù hợp bằng epinephrine ngay khi phản ứng quá mẫn xảy ra.\nKhoảng thời gian để có hiệu quả bảo vệ sau khi tiêm vắc xin Varicella chưa được biết rõ. Tuy nhiên sau khi tiêm vắc xin cần tránh tiếp xúc với người có nguy cơ mắc bệnh cao trong vòng 6 tuần. Các đối tượng có nguy cơ cao đó là các đối tượng suy giảm miễn dịch, phụ nữ có thai không có tiền sử mắc bệnh hoặc xét nghiệm không thấy sự nhiễm bệnh trước đó.\nCần thận trọng đối với các đối tượng phụ nữ cho con bú dù chưa rõ virus thủy đậu có thể bài tiết qua sữa mẹ hay không.\nTrong trường hợp đối tượng điều trị bằng 6-mercaptopurine, phải ngừng thuốc ít nhất 1 tuần trước khi tiêm vắc xin và sử dụng lại ít nhất 1 tuần sau đó.\nTrong trường hợp khẩn cấp (phải tạo miễn dịch chủ động bằng cách tiêm immunoglobulin Varicella – zoster), tiêm phòng vắc xin cần được tiến hành trừ khi có triệu chứng suy giảm miễn dịch. Trong trường hợp khẩn cấp này vắc xin cần phải được tiêm trong vòng 72 giờ sau khi phơi nhiễm với virus Varicella.','Vắc xin được bảo quản ở nhiệt độ từ 2 độ C đến 8 độ C. Tránh ánh sáng trực tiếp.','Vắc xin Varicella là vắc xin dạng đông khô của virus thủy đậu (varicella) sống giảm độc lực, được chỉ định phòng thủy đậu cho trẻ từ 12 tháng tuổi trở lên và người lớn.','Sau khi tiêm vắc xin thủy đậu về thì bé có sốt không?\nSau khi tiêm vắc xin phòng bệnh thủy đậu, người tiêm hay gặp những phản ứng nhẹ, không kéo dài và không cần điều trị đặc biệt. Đó là sự đáp ứng miễn dịch của cơ thể. Cụ thể như sau:\nTại chỗ tiêm: phát ban dạng thủy đậu, đau, đỏ, sưng.\nToàn thân: sốt\nLưu ý: Cần tránh dùng chế phẩm chứa Salicylate (Aspirin hoặc các chế phẩm bôi, dán giảm đau) trong ít nhất 6 tuần sau khi tiêm.','Thủy đậu','https://vnvc.vn/wp-content/uploads/2021/02/vac-xin-varicella-1.jpg',700000),(1,'2025-04-23 16:25:19.456067','2025-04-23 16:25:19.456067','vac-xin-vat','Vắc xin uốn ván hấp phụ','Vắc xin uốn ván hấp phụ (TT) giúp tạo miễn dịch chủ động phòng bệnh uốn ván cho người lớn và trẻ em. ','Vắc xin uốn ván hấp phụ (TT) được nghiên cứu và sản xuất bởi Viện vắc xin và sinh phẩm y tế Nha Trang IVAC – Việt Nam.','Vắc xin uốn ván hấp phụ (TT) được chỉ định tiêm bắp sâu, liều tiêm 0,5ml.\nKhông tiêm tĩnh mạch trong bất cứ trường hợp nào.\nLắc tan đều trước khi tiêm.','Không tiêm cho người dị ứng, quá mẫn với bất kỳ thành phần nào của vắc xin.\nKhông tiêm cho đối tượng có các biểu hiện dị ứng ở lần tiêm vắc xin trước.\nKhông dùng cho người có các dấu hiệu, triệu chứng thần kinh sau khi tiêm các liều trước đó.\nHoãn tiêm với các trường hợp sốt cao hoặc đang mắc các bệnh cấp tính.','Đáp ứng miễn dịch của vắc xin uốn ván hấp phụ (TT) có thể bị giảm nếu đang dùng các liệu pháp ức chế miễn dịch.\nNếu tiêm nhầm vắc xin uốn ván hấp phụ (TT) dưới da thì các phản ứng phụ sẽ rất rầm rộ do vắc xin có chứa muối nhôm.\nKhông tiêm quá liều.\nVắc xin không chống chỉ định cho đối tượng phụ nữ đang cho con bú.\nCũng giống như tất cả các loại vắc xin khác phải chuẩn bị đầy đủ các phương tiện y tế và thuốc cấp cứu để đề phòng phản ứng phản vệ sau khi tiêm.','Vắc xin được bảo quản ở nhiệt độ từ 2 đến 8 độ C. Không được để đông đá vắc xin. Loại bỏ vắc xin nếu bị đông đá.','Chỉ định phòng bệnh Uốn ván cho người lớn và trẻ em. Đặc biệt là các đối tượng có nguy cơ cao như:\nPhụ nữ có thai.\nCông nhân vệ sinh môi trường, cống rãnh, nước thải.\nNgười thường xuyên làm việc tại chuồng trại chăn nuôi gia súc, gia cầm.\nNgười làm vườn, người làm việc ở các trang trại, nông trường.\nCông nhân xây dựng các công trình.\nBộ đội và thanh niên xung phong.','Sau khi tiêm vắc xin phòng uốn ván hấp phụ (TT), người tiêm hay gặp những phản ứng nhẹ, không kéo dài và không cần điều trị đặc biệt. Đó là sự đáp ứng miễn dịch của cơ thể, cụ thể như sau:\nTại chỗ tiêm: đau, quầng đỏ, nốt cứng hay sưng xuất hiện trong vòng 48 giờ sau khi tiêm và kéo dài trong 1-2 ngày. Tuy nhiên các triệu chứng này thường nhẹ và tự mất đi.\nToàn thân: sốt, đau đầu, đổ mồ hôi, ớn lạnh, đau cơ, đau khớp.','Uốn ván - Bạch hầu','https://vnvc.vn/wp-content/uploads/2021/02/vac-xin-uon-van-hap-phu-tt.jpg',205000),(1,'2025-04-23 16:25:19.460770','2025-04-23 16:25:19.460770','varilrix-vac-xin-phong-benh-thuy-dau','Vắc xin Varilrix','Vắc xin Varilrix (Bỉ) là vắc xin sống giảm độc lực phòng bệnh thủy đậu do virus Varicella Zoster cho trẻ từ 9 tháng tuổi và người lớn chưa có miễn dịch.','Vắc xin Varilrix được nghiên cứu và phát triển bởi tập đoàn hàng đầu thế giới về dược phẩm và chế phẩm sinh học Glaxosmithkline (GSK) – Bỉ.','Vắc xin Varilrix được chỉ định tiêm dưới da ở vùng cơ delta hoặc vùng má ngoài đùi với liều 0.5ml.','Hoãn tiêm vắc xin Varilrix với những người đang sốt cao cấp tính.\nChống chỉ định tiêm cho những người suy giảm miễn dịch dịch thể hoặc tế nào nghiêm trọng như:','Người được tiêm chủng có thể bị ngất xỉu sau hoặc thậm chí trước khi tiêm. Do đó, nên lựa chọn địa điểm thích hợp khi tiêm để tránh bị thương do ngất xỉu.\nPhải để cho cồn và các chất sát khuẩn khác bay hơi hết trước khi tiêm vắc xin do chúng có thể làm bất hoạt các virus giảm độc lực có trong vắc xin.\nCó thể đạt được tác dụng bảo vệ phòng thủy đậu (tuy còn hạn chế) bằng việc tiêm chủng trong vòng 72 giờ sau khi tiếp xúc với thủy đậu tự nhiên.\nKhông được tiêm Varilrix vào tĩnh mạch hoặc trong da.\nVarilrix có thể tiêm cùng lúc với bất kỳ vắc xin nào khác. Các vắc xin dạng tiêm khác nhau nên tiêm ở những vị trí khác nhau.\nCác vắc xin bất hoạt có thể được dùng vào bất kỳ thời gian nào khi dùng Varilrix.\nVắc xin Varilrix có thể tiêm cùng với các vắc xin sống dạng tiêm khác trong cùng buổi tiêm chủng. Nếu không thể tiêm cùng buổi tiêm chủng thì các loại này phải tiêm cách nhau ít nhất 1 tháng.\nBệnh nhân có nguy cơ cao: Không sử dụng Varilrix cùng lúc với vắc xin sống giảm độc lực khác. Các vắc xin bất hoạt có thể được dùng vào bất kỳ thời gian nào khi dùng Varilrix miễn là không có chống chỉ định đặc biệt nào. Tuy nhiên, các vắc xin khác nhau nên tiêm ở những vị trí khác nhau.','Vắc xin Varilrix được bảo quản ở nhiệt độ từ 2 độ C đến 8 độ C.','Vắc xin Varilrix được chỉ định cho trẻ em từ 9 tháng tuổi và người lớn chưa có miễn dịch phòng bệnh thủy đậu.','Sau khi tiêm vắc xin thủy đậu về bé có sốt không?\nVắc xin Varilrix là vắc xin có độ an toàn cao. Tuy nhiên, sau khi tiêm vắc xin phòng thủy đậu, người được tiêm hay gặp những phản ứng nhẹ, không kéo dài và không cần điều trị đặc biệt. Đó là sự đáp ứng miễn dịch của cơ thể. Cụ thể:\nTại chỗ tiêm: phát ban dạng thủy đậu, đau, đỏ, sưng,..\nToàn thân: sốt.\nLưu ý: Cần tránh dùng chế phẩm chứa Salicylate (Aspirin hoặc các chế phẩm bôi, dán giảm đau) trong ít nhất 6 tuần sau khi tiêm.','Thủy đậu','https://vnvc.vn/wp-content/uploads/2021/01/vac-xin-varilrix.jpg',1085000),(1,'2025-04-23 16:25:19.477410','2025-04-23 16:25:19.477410','varivax-vac-xin-phong-thuy-dau','Vắc xin Varivax','Vắc xin Varivax tạo miễn dịch chủ động phòng bệnh Thủy đậu do virus Varicella Zoster gây ra.','Vắc xin Varivax được nghiên cứu và phát triển bởi tập đoàn hàng đầu thế giới Merck Sharp and Dohm (Mỹ).','Vắc xin Varivax được chỉ định tiêm dưới da. Liều đơn 0.5ml','Mẫn cảm với bất kỳ thành phần nào của vắc xin, bao gồm cả: gelatin, neomycin.\nNgười đang mắc các bệnh bạch, loạn sản máu, các bệnh u lympho, hoặc các khối u ác tính ảnh hưởng đến hệ bạch huyết, tủy xương.\nNgười đang điều trị bằng các thuốc ức chế miễn dịch (bao gồm corticoid liều cao). Hoặc đang mắc bệnh suy giảm miễn dịch mắc phải (AIDS).\nNgười đã có miễn dịch do mắc phải.\nNgười đang mắc các bệnh lý tiến triển, sốt cao trên 38 độ C. Tuy nhiên không có chống chỉ định cho trường hợp sốt nhẹ.\nNgười mắc bệnh lao thể hoạt động chưa được điều trị.','Cũng như các vắc xin khác; cần có hộp chống sốc đầy đủ trước khi tiêm.\nChưa có bằng chứng về tính an toàn và hiệu quả của Varivax trên trẻ nhỏ và người trẻ tuổi đã bị nhiễm virus gây suy giảm miễn dịch ở người.\nChưa có nghiên cứu về tính an toàn của Varivax trên trẻ <12 tháng tuổi.\nNgười được tiêm chủng nên tránh tiếp xúc với các đối tượng có nguy cơ nhiễm bệnh như: người bị suy giảm miễn dịch, phụ nữ có thai nhưng chưa tiêm phòng thủy đậu; người chăm sóc trẻ mà chưa có miễn dịch do mắc phải hay do tiêm phòng…\nChưa có nghiên cứu về việc tác động của Varivax trên sự phát triển của thai kỳ vì vậy phụ nữ phải tránh mang thai ít nhất 3 tháng sau khi tiêm.\nCũng chưa rõ vắc xin có bài tiết qua sữa mẹ hay không nên cần thận trọng khi sử dụng vắc xin cho bà mẹ đang cho con bú.','Vắc xin được bảo quản ở nhiệt độ từ 2 độ C đến 8 độ C.','Vắc xin Varivax là vắc xin dạng đông khô của virus thủy đậu (varicella) sống giảm độc lực, được chỉ định phòng thủy đậu cho các đối tượng từ 12 tháng tuổi trở lên.','Sau khi tiêm vắc xin thủy đậu về thì bé có sốt không?\nSau khi tiêm vắc xin phòng bệnh thủy đậu, người tiêm hay gặp những phản ứng nhẹ, không kéo dài và không cần điều trị đặc biệt. Đó là sự đáp ứng miễn dịch của cơ thể. Cụ thể như sau:\nTại chỗ tiêm: phát ban dạng thủy đậu, đau, đỏ, sưng.\nToàn thân: sốt\nLưu ý: Cần tránh dùng chế phẩm chứa Salicylate (Aspirin hoặc các chế phẩm bôi, dán giảm đau) trong ít nhất 6 tuần sau khi tiêm.','Thủy đậu','https://vnvc.vn/wp-content/uploads/2017/04/vac-xin-varivax.jpg',1085000),(1,'2025-04-23 16:25:19.459773','2025-04-23 16:25:19.459773','vaxigrip-tetra','Vắc xin Vaxigrip Tetra','Vắc xin cúm Tứ giá Vaxigrip Tetra phòng được 4 chủng tuýp virus cúm gồm: 2 chủng cúm A (H1N1, H3N2) và 2 chủng cúm B (Yamagata, Victoria).','Vắc xin Vaxigrip Tetra được nghiên cứu và phát triển bởi tập đoàn hàng đầu thế giới về dược phẩm và chế phẩm sinh học Sanofi Pasteur (Pháp).','Tiêm bắp hoặc tiêm dưới da.','Quá mẫn cảm với các hoạt chất, với bất kỳ tá dược liệt kê trong mục “thành phần” hoặc bất kỳ chất nào có thể có trong thành phần dù với một lượng rất nhỏ còn sót lại (vết) như trứng (ovalbumin, protein của gà), neomycin, formaldehyde và octoxynol-9.\nHoãn tiêm vắc xin với những người bị sốt vừa hay sốt cao hay bị bệnh cấp tính.','Không được tiêm Vaxigrip Tetra vào tĩnh mạch.\nThận trọng khi sử dụng cho người bị suy giảm miễn dịch, suy giảm tiểu cầu hoặc bị rối loạn chảy máu.','Vắc xin Vaxigrip Tetra được bảo quản ở nhiệt độ 2-8 độ C. Không để đông băng và tránh ánh sáng.','Vắc xin Vaxigrip Tetra 0.5ml của Pháp phòng cúm mùa, được chỉ định cho trẻ từ 6 tháng tuổi trở lên và người lớn.','Vắc xin Vaxigrip là vắc xin có độ an toàn cao. Sau khi tiêm vắc xin cúm, người được tiêm thường gặp những phản ứng nhẹ, không kéo dài và không cần điều trị đặc biệt. Đó là sự đáp ứng miễn dịch của cơ thể. Cụ thể như sau:\nTại chỗ tiêm: đau, đỏ, sưng\nToàn thân: sốt,mệt mỏi, đau đầu','Cúm','https://vnvc.vn/wp-content/uploads/2021/07/vaccine-vaxigrip-tetra.jpg',356000),(1,'2025-04-23 16:25:19.458768','2025-04-23 16:25:19.458768','verorab-vac-xin-phong-dai','Vắc xin Verorab','Vắc xin Verorab có tác dụng tạo miễn dịch chủ động phòng bệnh dại cho cả người lớn và trẻ em, sau khi tiếp xúc hoặc bị con vật nghi bị dại cắn.','Vắc xin Verorab là vắc xin phòng dại cho trẻ em và người lớn, do tập đoàn hàng đầu thế giới về dược phẩm và chế phẩm sinh học Sanofi Pasteur (Pháp) sản xuất.','Tiêm bắp: với liều 0.5ml vắc xin đã hoàn nguyên, ở người lớn vào vùng cơ Delta ở cánh tay, trẻ nhỏ tiêm ở mặt trước – bên đùi. Không tiêm ở vùng mông.\nTiêm trong da: với liều 0.1ml vắc xin đã hoàn nguyên (bằng 1/5 liều tiêm bắp).','Không được tiêm trong da ở những trường hợp sau: đang điều trị dài ngày bằng các thuốc ức chế miễn dịch (bao gồm cả corticoid), và thuốc Chloroquin; người bị khiếm khuyết miễn dịch; trẻ em hoặc người có vết cắn nặng phần đầu, cổ, hay đến khám trễ sau khi bị vết thương.','Người dị ứng với neomycin. Không tiêm cùng vị trí hay chung bơm tiêm vắc xin và immunoglobulin.\nKhông được tiêm vắc xin vào trong lòng mạch.\nPhụ nữ có thai: hiện chưa có các bằng chứng Verorab gây ảnh hưởng đến thai nhi. Chính vì thế, nếu thai phụ bị chó dại cắn, cần đến ngay các cơ sở y tế để được khám, tư vấn và tiêm vắc xin phòng dại kịp thời. Đây là sự lựa chọn duy nhất để phòng bệnh dại phát cơn và gây nguy hiểm đến tính mạng mẹ bầu.\nPhụ nữ cho con bú: bệnh dại là bệnh chết người vì vậy không có hạn chế nào trên phụ nữ cho con bú.\nSử dụng ở trẻ em: bệnh dại là bệnh chết người, không có giới hạn tuổi tác và được sử dụng cho trẻ em ở mọi lứa tuổi','Vắc xin được bảo quản ở nhiệt độ từ 2 đến 8 độ C.','Vắc xin Verorab (Pháp) phòng bệnh dại được chỉ định tiêm cho trẻ em và người lớn ở mọi lứa tuổi.','Tiêm vắc xin dại về có sốt hay có triệu chứng gì không?\nSau khi tiêm vắc xin phòng vắc xin dại, người tiêm hay gặp những phản ứng nhẹ, không kéo dài và không cần điều trị đặc biệt. Đó là sự đáp ứng miễn dịch của cơ thể, cụ thể như sau:\nTại chỗ tiêm: đau, quầng đỏ, sưng, ngứa và nốt cứng.\nToàn thân: sốt, đau đầu, chóng mặt, mệt mỏi.\nLưu ý: Khi có phơi nhiễm (bị súc vật liếm, cào, cắn,…) phải sơ cứu và rửa sạch vết thương với thật nhiều nước và xà phòng. Sau đó rửa lại thật kỹ bằng nước sạch. Tiếp tục rửa vết thương bằng cồn Iod. Đưa nạn nhân tới trung tâm tiêm chủng. Tùy vào mức độ của tiếp xúc mà bác sĩ có thể chỉ định tiêm thêm globulin miễn dịch.\nNên tiêm thêm vắc xin uốn ván ở tất cả các trường hợp có phơi nhiễm.','Dại','https://vnvc.vn/wp-content/uploads/2017/04/vaccine-verorab.jpg',370000);
/*!40000 ALTER TABLE `vaccines_vaccine` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `vaccines_vaccine_cates`
--

DROP TABLE IF EXISTS `vaccines_vaccine_cates`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!50503 SET character_set_client = utf8mb4 */;
CREATE TABLE `vaccines_vaccine_cates` (
  `id` bigint NOT NULL AUTO_INCREMENT,
  `vaccine_id` varchar(255) NOT NULL,
  `category_id` bigint NOT NULL,
  PRIMARY KEY (`id`),
  UNIQUE KEY `vaccines_vaccine_cates_vaccine_id_category_id_fc7a6b0c_uniq` (`vaccine_id`,`category_id`),
  KEY `vaccines_vaccine_cat_category_id_1bd6a360_fk_vaccines_` (`category_id`),
  CONSTRAINT `vaccines_vaccine_cat_category_id_1bd6a360_fk_vaccines_` FOREIGN KEY (`category_id`) REFERENCES `vaccines_category` (`id`),
  CONSTRAINT `vaccines_vaccine_cat_vaccine_id_1294f8b1_fk_vaccines_` FOREIGN KEY (`vaccine_id`) REFERENCES `vaccines_vaccine` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=150 DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `vaccines_vaccine_cates`
--

LOCK TABLES `vaccines_vaccine_cates` WRITE;
/*!40000 ALTER TABLE `vaccines_vaccine_cates` DISABLE KEYS */;
INSERT INTO `vaccines_vaccine_cates` VALUES (20,'avaxim-vac-xin-phong-viem-gan',8),(69,'avaxim-vac-xin-phong-viem-gan',29),(23,'bcg-vac-xin-phong-lao',10),(58,'bcg-vac-xin-phong-lao',28),(12,'boostrix',5),(100,'boostrix',32),(111,'boostrix',33),(125,'boostrix',34),(6,'engerix-b-vac-xin-phong-viem-gan-b',2),(29,'engerix-b-vac-xin-phong-viem-gan-b',13),(60,'engerix-b-vac-xin-phong-viem-gan-b',28),(120,'engerix-b-vac-xin-phong-viem-gan-b',33),(148,'engerix-b-vac-xin-phong-viem-gan-b',35),(25,'gardasil-vac-xin-phong-ung-thu-co-tu-cung',11),(98,'gardasil-vac-xin-phong-ung-thu-co-tu-cung',32),(43,'gcflu-quadrivalent',19),(92,'gcflu-quadrivalent',31),(107,'gcflu-quadrivalent',32),(146,'gcflu-quadrivalent',35),(5,'heberbiovac-hb',2),(28,'heberbiovac-hb',13),(59,'heberbiovac-hb',28),(64,'heberbiovac-hb',29),(75,'heberbiovac-hb',30),(115,'heberbiovac-hb',33),(141,'heberbiovac-hb',35),(45,'hexaxim-vac-xin-6-trong-1',21),(136,'hexaxim-vac-xin-6-trong-1',35),(54,'huyet-thanh-uon-van-sat',25),(15,'imojev-vac-xin-phong-viem-nao-nhat-ban-moi',6),(68,'imojev-vac-xin-phong-viem-nao-nhat-ban-moi',29),(89,'imojev-vac-xin-phong-viem-nao-nhat-ban-moi',31),(46,'infanrix-vac-xin-6-trong-1',21),(139,'infanrix-vac-xin-6-trong-1',35),(41,'influvac-tetra',19),(85,'influvac-tetra',31),(104,'influvac-tetra',32),(129,'influvac-tetra',34),(16,'jevax-vac-xin-phong-viem-nao-nhat-ban-b',6),(74,'jevax-vac-xin-phong-viem-nao-nhat-ban-b',29),(94,'jevax-vac-xin-phong-viem-nao-nhat-ban-b',31),(35,'menactra-vac-xin-nao-mo-cau-nhom-acy-va-w-135-polysaccharide-cong-hop-giai-doc-bach-hau',16),(62,'menactra-vac-xin-nao-mo-cau-nhom-acy-va-w-135-polysaccharide-cong-hop-giai-doc-bach-hau',29),(82,'menactra-vac-xin-nao-mo-cau-nhom-acy-va-w-135-polysaccharide-cong-hop-giai-doc-bach-hau',31),(96,'menactra-vac-xin-nao-mo-cau-nhom-acy-va-w-135-polysaccharide-cong-hop-giai-doc-bach-hau',32),(124,'menactra-vac-xin-nao-mo-cau-nhom-acy-va-w-135-polysaccharide-cong-hop-giai-doc-bach-hau',34),(52,'mmr-ii-vac-xin-phong-3-benh-soi-quai-bi-rubella',24),(67,'mmr-ii-vac-xin-phong-3-benh-soi-quai-bi-rubella',29),(87,'mmr-ii-vac-xin-phong-3-benh-soi-quai-bi-rubella',31),(106,'mmr-ii-vac-xin-phong-3-benh-soi-quai-bi-rubella',32),(117,'mmr-ii-vac-xin-phong-3-benh-soi-quai-bi-rubella',33),(132,'mmr-ii-vac-xin-phong-3-benh-soi-quai-bi-rubella',34),(33,'morcvax-vac-xin-phong-benh-ta',15),(78,'morcvax-vac-xin-phong-benh-ta',30),(91,'morcvax-vac-xin-phong-benh-ta',31),(2,'pentaxim-vac-xin-5-trong-1',1),(140,'pentaxim-vac-xin-5-trong-1',35),(18,'prevenar-13-vac-xin-phong-benh-viem-phoi-viem-mang-nao-viem-tai-giua-nhiem-khuan-huyet-phe-cau-khuan',7),(81,'prevenar-13-vac-xin-phong-benh-viem-phoi-viem-mang-nao-viem-tai-giua-nhiem-khuan-huyet-phe-cau-khuan',31),(95,'prevenar-13-vac-xin-phong-benh-viem-phoi-viem-mang-nao-viem-tai-giua-nhiem-khuan-huyet-phe-cau-khuan',32),(123,'prevenar-13-vac-xin-phong-benh-viem-phoi-viem-mang-nao-viem-tai-giua-nhiem-khuan-huyet-phe-cau-khuan',34),(135,'prevenar-13-vac-xin-phong-benh-viem-phoi-viem-mang-nao-viem-tai-giua-nhiem-khuan-huyet-phe-cau-khuan',35),(11,'rotavin-m1-vac-xin-phong-benh-tieu-chay-cap-rotavirus',4),(144,'rotavin-m1-vac-xin-phong-benh-tieu-chay-cap-rotavirus',35),(44,'stamaril-vac-xin-phong-benh-sot-vang',20),(19,'synflorix-vac-xin-phong-viem-nao-viem-phoi-nhiem-khuan-huyet-viem-tai-giua-h-influenzae-khong-dinh-tuyp',7),(83,'synflorix-vac-xin-phong-viem-nao-viem-phoi-nhiem-khuan-huyet-viem-tai-giua-h-influenzae-khong-dinh-tuyp',31),(99,'synflorix-vac-xin-phong-viem-nao-viem-phoi-nhiem-khuan-huyet-viem-tai-giua-h-influenzae-khong-dinh-tuyp',32),(137,'synflorix-vac-xin-phong-viem-nao-viem-phoi-nhiem-khuan-huyet-viem-tai-giua-h-influenzae-khong-dinh-tuyp',35),(22,'twinrix-vac-xin-phong-viem-gan-ab',9),(71,'twinrix-vac-xin-phong-viem-gan-ab',29),(90,'twinrix-vac-xin-phong-viem-gan-ab',31),(31,'typhim-vi-vac-xin-phong-thuong-han',14),(77,'typhim-vi-vac-xin-phong-thuong-han',30),(32,'typhoid-vi-polysaccharide-vi-vac-xin-phong-benh-thuong-han',14),(80,'typhoid-vi-polysaccharide-vi-vac-xin-phong-benh-thuong-han',30),(36,'va-mengoc-bc-vac-xin-phong-viem-mang-nao-nao-mo-cau-b-c',16),(145,'va-mengoc-bc-vac-xin-phong-viem-mang-nao-nao-mo-cau-b-c',35),(3,'vac-xin-5-trong-1-infanrix-ipv-hib',1),(147,'vac-xin-5-trong-1-infanrix-ipv-hib',35),(38,'vac-xin-abhayrab',18),(13,'vac-xin-adacel',5),(101,'vac-xin-adacel',32),(112,'vac-xin-adacel',33),(126,'vac-xin-adacel',34),(34,'vac-xin-bexsero',16),(7,'vac-xin-euvax-b',2),(30,'vac-xin-euvax-b',13),(61,'vac-xin-euvax-b',28),(121,'vac-xin-euvax-b',33),(149,'vac-xin-euvax-b',35),(24,'vac-xin-gardasil-9',11),(97,'vac-xin-gardasil-9',32),(4,'vac-xin-gene-hbvax',2),(27,'vac-xin-gene-hbvax',13),(21,'vac-xin-havax',8),(70,'vac-xin-havax',29),(42,'vac-xin-ivacflu-s',19),(131,'vac-xin-ivacflu-s',34),(14,'vac-xin-jeev',6),(53,'vac-xin-mmr',24),(79,'vac-xin-mmr',30),(93,'vac-xin-mmr',31),(110,'vac-xin-mmr',32),(47,'vac-xin-mrvac',22),(50,'vac-xin-mrvac',24),(48,'vac-xin-mvvac',22),(66,'vac-xin-mvvac',29),(17,'vac-xin-pneumovax-23',7),(51,'vac-xin-priorix',24),(65,'vac-xin-priorix',29),(76,'vac-xin-priorix',30),(86,'vac-xin-priorix',31),(105,'vac-xin-priorix',32),(116,'vac-xin-priorix',33),(130,'vac-xin-priorix',34),(37,'vac-xin-quimi-hib',17),(9,'vac-xin-rotarix',4),(142,'vac-xin-rotarix',35),(10,'vac-xin-rotateq',4),(143,'vac-xin-rotateq',35),(122,'vac-xin-shingrix',34),(8,'vac-xin-tetraxim',3),(88,'vac-xin-tetraxim',31),(49,'vac-xin-uon-van-bach-hau-hap-phu-td-viet-nam',23),(57,'vac-xin-varicella',26),(73,'vac-xin-varicella',29),(109,'vac-xin-varicella',32),(119,'vac-xin-varicella',33),(134,'vac-xin-varicella',34),(26,'vac-xin-vat',12),(113,'vac-xin-vat',33),(55,'varilrix-vac-xin-phong-benh-thuy-dau',26),(63,'varilrix-vac-xin-phong-benh-thuy-dau',29),(103,'varilrix-vac-xin-phong-benh-thuy-dau',32),(114,'varilrix-vac-xin-phong-benh-thuy-dau',33),(128,'varilrix-vac-xin-phong-benh-thuy-dau',34),(56,'varivax-vac-xin-phong-thuy-dau',26),(72,'varivax-vac-xin-phong-thuy-dau',29),(108,'varivax-vac-xin-phong-thuy-dau',32),(118,'varivax-vac-xin-phong-thuy-dau',33),(133,'varivax-vac-xin-phong-thuy-dau',34),(40,'vaxigrip-tetra',19),(84,'vaxigrip-tetra',31),(102,'vaxigrip-tetra',32),(127,'vaxigrip-tetra',34),(138,'vaxigrip-tetra',35),(39,'verorab-vac-xin-phong-dai',18);
/*!40000 ALTER TABLE `vaccines_vaccine_cates` ENABLE KEYS */;
UNLOCK TABLES;
/*!40103 SET TIME_ZONE=@OLD_TIME_ZONE */;

/*!40101 SET SQL_MODE=@OLD_SQL_MODE */;
/*!40014 SET FOREIGN_KEY_CHECKS=@OLD_FOREIGN_KEY_CHECKS */;
/*!40014 SET UNIQUE_CHECKS=@OLD_UNIQUE_CHECKS */;
/*!40101 SET CHARACTER_SET_CLIENT=@OLD_CHARACTER_SET_CLIENT */;
/*!40101 SET CHARACTER_SET_RESULTS=@OLD_CHARACTER_SET_RESULTS */;
/*!40101 SET COLLATION_CONNECTION=@OLD_COLLATION_CONNECTION */;
/*!40111 SET SQL_NOTES=@OLD_SQL_NOTES */;

-- Dump completed on 2025-04-24 17:27:40
