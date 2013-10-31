-- MySQL dump 10.11
--
-- Host: localhost    Database: ic6
-- ------------------------------------------------------
-- Server version	5.0.95-log

/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;
/*!40103 SET @OLD_TIME_ZONE=@@TIME_ZONE */;
/*!40103 SET TIME_ZONE='+00:00' */;
/*!40014 SET @OLD_UNIQUE_CHECKS=@@UNIQUE_CHECKS, UNIQUE_CHECKS=0 */;
/*!40014 SET @OLD_FOREIGN_KEY_CHECKS=@@FOREIGN_KEY_CHECKS, FOREIGN_KEY_CHECKS=0 */;
/*!40101 SET @OLD_SQL_MODE=@@SQL_MODE, SQL_MODE='NO_AUTO_VALUE_ON_ZERO' */;
/*!40111 SET @OLD_SQL_NOTES=@@SQL_NOTES, SQL_NOTES=0 */;

--
-- Current Database: `ic6`
--

CREATE DATABASE /*!32312 IF NOT EXISTS*/ `ic6` /*!40100 DEFAULT CHARACTER SET latin1 */;

USE `ic6`;

--
-- Table structure for table `addresses`
--

DROP TABLE IF EXISTS `addresses`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `addresses` (
  `addresses_id` bigint(20) unsigned NOT NULL auto_increment,
  `users_id` bigint(20) unsigned NOT NULL,
  `type` varchar(16) NOT NULL default '',
  `archived` tinyint(1) NOT NULL default '0',
  `first_name` varchar(255) NOT NULL default '',
  `last_name` varchar(255) NOT NULL default '',
  `company` varchar(255) NOT NULL default '',
  `street_address` varchar(255) NOT NULL default '',
  `street_address_2` varchar(255) NOT NULL default '',
  `zip` varchar(255) NOT NULL default '',
  `city` varchar(255) NOT NULL default '',
  `phone` varchar(32) NOT NULL default '',
  `state_code` char(6) NOT NULL default '',
  `country_code` char(2) NOT NULL default '',
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  PRIMARY KEY  (`addresses_id`),
  UNIQUE KEY `addresses_id` (`addresses_id`),
  KEY `addresses_users_fk` (`users_id`),
  CONSTRAINT `addresses_users_fk` FOREIGN KEY (`users_id`) REFERENCES `users` (`users_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `addresses`
--

LOCK TABLES `addresses` WRITE;
/*!40000 ALTER TABLE `addresses` DISABLE KEYS */;
/*!40000 ALTER TABLE `addresses` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `cart_products`
--

DROP TABLE IF EXISTS `cart_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `cart_products` (
  `carts_id` bigint(20) unsigned NOT NULL,
  `sku` varchar(32) NOT NULL,
  `cart_position` int(11) NOT NULL,
  `quantity` int(11) NOT NULL default '1',
  `when_added` datetime NOT NULL,
  KEY `cart_products_products_fk` (`sku`),
  KEY `carts_id` (`carts_id`,`sku`),
  CONSTRAINT `cart_products_carts_fk` FOREIGN KEY (`carts_id`) REFERENCES `carts` (`carts_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `cart_products_products_fk` FOREIGN KEY (`sku`) REFERENCES `products` (`sku`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `cart_products`
--

LOCK TABLES `cart_products` WRITE;
/*!40000 ALTER TABLE `cart_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `cart_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `carts`
--

DROP TABLE IF EXISTS `carts`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `carts` (
  `carts_id` bigint(20) unsigned NOT NULL auto_increment,
  `name` varchar(255) NOT NULL default '',
  `users_id` bigint(20) unsigned NOT NULL,
  `sessions_id` varchar(255) NOT NULL,
  `created` datetime NOT NULL,
  `last_modified` datetime NOT NULL,
  `type` varchar(32) NOT NULL default '',
  `approved` tinyint(1) default NULL,
  `status` varchar(32) NOT NULL default '',
  PRIMARY KEY  (`carts_id`),
  UNIQUE KEY `carts_id` (`carts_id`),
  KEY `carts_users_fk` (`users_id`),
  KEY `carts_sessions_fk` (`sessions_id`),
  CONSTRAINT `carts_users_fk` FOREIGN KEY (`users_id`) REFERENCES `users` (`users_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `carts_sessions_fk` FOREIGN KEY (`sessions_id`) REFERENCES `sessions` (`sessions_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `carts`
--

LOCK TABLES `carts` WRITE;
/*!40000 ALTER TABLE `carts` DISABLE KEYS */;
/*!40000 ALTER TABLE `carts` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `group_pricing`
--

DROP TABLE IF EXISTS `group_pricing`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `group_pricing` (
  `group_pricing_id` bigint(20) unsigned NOT NULL auto_increment,
  `sku` varchar(32) NOT NULL,
  `quantity` int(11) NOT NULL default '0',
  `roles_id` bigint(20) unsigned NOT NULL,
  `price` decimal(10,2) NOT NULL default '0.00',
  PRIMARY KEY  (`group_pricing_id`),
  UNIQUE KEY `group_pricing_id` (`group_pricing_id`),
  KEY `group_pricing_roles_fk` (`roles_id`),
  KEY `sku` (`sku`),
  CONSTRAINT `group_pricing_products_fk` FOREIGN KEY (`sku`) REFERENCES `products` (`sku`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `group_pricing_roles_fk` FOREIGN KEY (`roles_id`) REFERENCES `roles` (`roles_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `group_pricing`
--

LOCK TABLES `group_pricing` WRITE;
/*!40000 ALTER TABLE `group_pricing` DISABLE KEYS */;
/*!40000 ALTER TABLE `group_pricing` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `inventory`
--

DROP TABLE IF EXISTS `inventory`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `inventory` (
  `sku` varchar(32) NOT NULL,
  `quantity` int(11) NOT NULL default '0',
  `in_stock` tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (`sku`),
  CONSTRAINT `inventory_products_fk` FOREIGN KEY (`sku`) REFERENCES `products` (`sku`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `inventory`
--

LOCK TABLES `inventory` WRITE;
/*!40000 ALTER TABLE `inventory` DISABLE KEYS */;
/*!40000 ALTER TABLE `inventory` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media`
--

DROP TABLE IF EXISTS `media`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media` (
  `media_id` bigint(20) unsigned NOT NULL auto_increment,
  `file` varchar(255) NOT NULL default '',
  `uri` varchar(255) NOT NULL default '',
  `mime_type` varchar(255) NOT NULL default '',
  `label` varchar(255) NOT NULL default '',
  `author` int(11) NOT NULL default '0',
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `active` tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (`media_id`),
  UNIQUE KEY `media_id` (`media_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media`
--

LOCK TABLES `media` WRITE;
/*!40000 ALTER TABLE `media` DISABLE KEYS */;
/*!40000 ALTER TABLE `media` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_displays`
--

DROP TABLE IF EXISTS `media_displays`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media_displays` (
  `media_displays_id` bigint(20) unsigned NOT NULL auto_increment,
  `media_id` bigint(20) unsigned NOT NULL,
  `sku` varchar(32) NOT NULL,
  `media_types_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`media_displays_id`),
  UNIQUE KEY `media_displays_id` (`media_displays_id`),
  KEY `media_displays_media_fk` (`media_id`),
  KEY `media_displays_media_types_fk` (`media_types_id`),
  KEY `sku` (`sku`),
  CONSTRAINT `media_displays_media_fk` FOREIGN KEY (`media_id`) REFERENCES `media` (`media_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `media_displays_products_fk` FOREIGN KEY (`sku`) REFERENCES `products` (`sku`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `media_displays_media_types_fk` FOREIGN KEY (`media_types_id`) REFERENCES `media_types` (`media_types_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_displays`
--

LOCK TABLES `media_displays` WRITE;
/*!40000 ALTER TABLE `media_displays` DISABLE KEYS */;
/*!40000 ALTER TABLE `media_displays` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_products`
--

DROP TABLE IF EXISTS `media_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media_products` (
  `media_products_id` bigint(20) unsigned NOT NULL auto_increment,
  `media_id` bigint(20) unsigned NOT NULL,
  `sku` varchar(32) NOT NULL,
  PRIMARY KEY  (`media_products_id`),
  UNIQUE KEY `media_products_id` (`media_products_id`),
  KEY `media_products_media_fk` (`media_id`),
  KEY `sku` (`sku`),
  CONSTRAINT `media_products_media_fk` FOREIGN KEY (`media_id`) REFERENCES `media` (`media_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `media_products_products_fk` FOREIGN KEY (`sku`) REFERENCES `products` (`sku`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_products`
--

LOCK TABLES `media_products` WRITE;
/*!40000 ALTER TABLE `media_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `media_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `media_types`
--

DROP TABLE IF EXISTS `media_types`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `media_types` (
  `media_types_id` bigint(20) unsigned NOT NULL auto_increment,
  `type` varchar(32) NOT NULL,
  `scope` varchar(32) NOT NULL,
  PRIMARY KEY  (`media_types_id`),
  UNIQUE KEY `media_types_id` (`media_types_id`),
  UNIQUE KEY `type` (`type`,`scope`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `media_types`
--

LOCK TABLES `media_types` WRITE;
/*!40000 ALTER TABLE `media_types` DISABLE KEYS */;
INSERT INTO `media_types` VALUES (3,'cart','store'),(1,'detail','store'),(2,'thumb','store');
/*!40000 ALTER TABLE `media_types` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `merchandising_attributes`
--

DROP TABLE IF EXISTS `merchandising_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `merchandising_attributes` (
  `merchandising_attributes_id` bigint(20) unsigned NOT NULL auto_increment,
  `merchandising_products_id` bigint(20) unsigned NOT NULL,
  `name` varchar(32) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY  (`merchandising_attributes_id`),
  UNIQUE KEY `merchandising_attributes_id` (`merchandising_attributes_id`),
  KEY `merchandising_attributes_merchandising_products_fk` (`merchandising_products_id`),
  CONSTRAINT `merchandising_attributes_merchandising_products_fk` FOREIGN KEY (`merchandising_products_id`) REFERENCES `merchandising_products` (`merchandising_products_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `merchandising_attributes`
--

LOCK TABLES `merchandising_attributes` WRITE;
/*!40000 ALTER TABLE `merchandising_attributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `merchandising_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `merchandising_products`
--

DROP TABLE IF EXISTS `merchandising_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `merchandising_products` (
  `merchandising_products_id` bigint(20) unsigned NOT NULL auto_increment,
  `sku` varchar(32) default NULL,
  `sku_related` varchar(32) default NULL,
  `type` varchar(32) NOT NULL default '',
  PRIMARY KEY  (`merchandising_products_id`),
  UNIQUE KEY `merchandising_products_id` (`merchandising_products_id`),
  KEY `merchandising_products_products_fk` (`sku`),
  KEY `merchandising_products_related_products_fk` (`sku_related`),
  CONSTRAINT `merchandising_products_products_fk` FOREIGN KEY (`sku`) REFERENCES `products` (`sku`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `merchandising_products_related_products_fk` FOREIGN KEY (`sku_related`) REFERENCES `products` (`sku`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `merchandising_products`
--

LOCK TABLES `merchandising_products` WRITE;
/*!40000 ALTER TABLE `merchandising_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `merchandising_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `navigation`
--

DROP TABLE IF EXISTS `navigation`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `navigation` (
  `navigation_id` bigint(20) unsigned NOT NULL auto_increment,
  `uri` varchar(255) NOT NULL default '',
  `type` varchar(32) NOT NULL default '',
  `scope` varchar(32) NOT NULL default '',
  `name` varchar(255) NOT NULL default '',
  `description` text NOT NULL,
  `template` varchar(255) NOT NULL default '',
  `text_language` varchar(8) NOT NULL default '',
  `alias` int(11) NOT NULL default '0',
  `parent` int(11) NOT NULL default '0',
  `priority` int(11) NOT NULL default '0',
  `product_count` int(11) NOT NULL default '0',
  `active` tinyint(1) NOT NULL default '1',
  `entered` timestamp NOT NULL default CURRENT_TIMESTAMP,
  PRIMARY KEY  (`navigation_id`),
  UNIQUE KEY `navigation_id` (`navigation_id`),
  UNIQUE KEY `uri` (`uri`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `navigation`
--

LOCK TABLES `navigation` WRITE;
/*!40000 ALTER TABLE `navigation` DISABLE KEYS */;
/*!40000 ALTER TABLE `navigation` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `navigation_products`
--

DROP TABLE IF EXISTS `navigation_products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `navigation_products` (
  `sku` varchar(32) NOT NULL,
  `navigation_id` bigint(20) unsigned NOT NULL,
  `type` varchar(16) NOT NULL default '',
  PRIMARY KEY  (`sku`,`navigation_id`),
  KEY `navigation_products_navigation_fk` (`navigation_id`),
  CONSTRAINT `navigation_products_products_fk` FOREIGN KEY (`sku`) REFERENCES `products` (`sku`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `navigation_products_navigation_fk` FOREIGN KEY (`navigation_id`) REFERENCES `navigation` (`navigation_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `navigation_products`
--

LOCK TABLES `navigation_products` WRITE;
/*!40000 ALTER TABLE `navigation_products` DISABLE KEYS */;
/*!40000 ALTER TABLE `navigation_products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderlines`
--

DROP TABLE IF EXISTS `orderlines`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orderlines` (
  `orderlines_id` bigint(20) unsigned NOT NULL auto_increment,
  `order_number` varchar(24) NOT NULL,
  `order_position` int(11) NOT NULL default '0',
  `sku` varchar(32) NOT NULL,
  `name` varchar(255) NOT NULL default '',
  `short_description` varchar(500) NOT NULL default '',
  `description` text NOT NULL,
  `weight` decimal(10,0) NOT NULL default '0',
  `quantity` int(11) default NULL,
  `shipping_method` varchar(255) NOT NULL default '',
  `shipping_code` varchar(255) NOT NULL default '',
  `price` decimal(10,2) NOT NULL default '0.00',
  `subtotal` decimal(11,2) NOT NULL default '0.00',
  `shipping` decimal(11,2) NOT NULL default '0.00',
  `handling` decimal(11,2) NOT NULL default '0.00',
  `salestax` decimal(11,2) NOT NULL default '0.00',
  `status` varchar(24) NOT NULL default '',
  PRIMARY KEY  (`orderlines_id`),
  UNIQUE KEY `orderlines_id` (`orderlines_id`),
  KEY `orderlines_products_fk` (`sku`),
  KEY `order_number` (`order_number`),
  CONSTRAINT `orderlines_orders_fk` FOREIGN KEY (`order_number`) REFERENCES `orders` (`order_number`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `orderlines_products_fk` FOREIGN KEY (`sku`) REFERENCES `products` (`sku`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderlines`
--

LOCK TABLES `orderlines` WRITE;
/*!40000 ALTER TABLE `orderlines` DISABLE KEYS */;
/*!40000 ALTER TABLE `orderlines` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orderlines_shipping`
--

DROP TABLE IF EXISTS `orderlines_shipping`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orderlines_shipping` (
  `orderlines_id` bigint(20) unsigned NOT NULL,
  `addresses_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`orderlines_id`,`addresses_id`),
  KEY `orderlines_shipping_addresses_fk` (`addresses_id`),
  CONSTRAINT `orderlines_shipping_orderlines_fk` FOREIGN KEY (`orderlines_id`) REFERENCES `orderlines` (`orderlines_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `orderlines_shipping_addresses_fk` FOREIGN KEY (`addresses_id`) REFERENCES `addresses` (`addresses_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orderlines_shipping`
--

LOCK TABLES `orderlines_shipping` WRITE;
/*!40000 ALTER TABLE `orderlines_shipping` DISABLE KEYS */;
/*!40000 ALTER TABLE `orderlines_shipping` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `orders`
--

DROP TABLE IF EXISTS `orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `orders` (
  `orders_id` bigint(20) unsigned NOT NULL auto_increment,
  `order_number` varchar(24) NOT NULL,
  `order_date` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  `users_id` bigint(20) unsigned NOT NULL,
  `email` varchar(255) NOT NULL default '',
  `billing_address` bigint(20) unsigned NOT NULL,
  `weight` decimal(10,0) NOT NULL default '0',
  `payment_method` varchar(255) NOT NULL default '',
  `payment_code` varchar(255) NOT NULL default '',
  `payment_status` varchar(255) NOT NULL default '',
  `shipping_method` varchar(255) NOT NULL default '',
  `shipping_code` varchar(255) NOT NULL default '',
  `subtotal` decimal(11,2) NOT NULL default '0.00',
  `shipping` decimal(11,2) NOT NULL default '0.00',
  `handling` decimal(11,2) NOT NULL default '0.00',
  `salestax` decimal(11,2) NOT NULL default '0.00',
  `total_cost` decimal(11,2) NOT NULL default '0.00',
  `status` varchar(24) NOT NULL default '',
  PRIMARY KEY  (`orders_id`),
  UNIQUE KEY `orders_id` (`orders_id`),
  KEY `orders_users_fk` (`users_id`),
  KEY `orders_billing_address_fk` (`billing_address`),
  KEY `order_number` (`order_number`),
  CONSTRAINT `orders_users_fk` FOREIGN KEY (`users_id`) REFERENCES `users` (`users_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `orders_billing_address_fk` FOREIGN KEY (`billing_address`) REFERENCES `addresses` (`addresses_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `orders`
--

LOCK TABLES `orders` WRITE;
/*!40000 ALTER TABLE `orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `payment_orders`
--

DROP TABLE IF EXISTS `payment_orders`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `payment_orders` (
  `payment_orders_id` bigint(20) unsigned NOT NULL auto_increment,
  `payment_mode` varchar(32) NOT NULL default '',
  `payment_action` varchar(32) NOT NULL default '',
  `payment_id` varchar(32) NOT NULL default '',
  `auth_code` varchar(255) NOT NULL default '',
  `sessions_id` varchar(255) NOT NULL,
  `order_number` varchar(24) NOT NULL,
  `amount` decimal(11,2) NOT NULL default '0.00',
  `status` varchar(32) NOT NULL default '',
  `payment_session_id` varchar(255) NOT NULL default '',
  `payment_error_code` varchar(32) NOT NULL default '',
  `payment_error_message` text NOT NULL,
  `created` datetime default NULL,
  `last_modified` datetime default NULL,
  PRIMARY KEY  (`payment_orders_id`),
  UNIQUE KEY `payment_orders_id` (`payment_orders_id`),
  KEY `payment_orders_sessions_fk` (`sessions_id`),
  KEY `order_number` (`order_number`),
  CONSTRAINT `payment_orders_sessions_fk` FOREIGN KEY (`sessions_id`) REFERENCES `sessions` (`sessions_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `payment_orders_fk` FOREIGN KEY (`order_number`) REFERENCES `orders` (`order_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `payment_orders`
--

LOCK TABLES `payment_orders` WRITE;
/*!40000 ALTER TABLE `payment_orders` DISABLE KEYS */;
/*!40000 ALTER TABLE `payment_orders` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `permissions`
--

DROP TABLE IF EXISTS `permissions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `permissions` (
  `roles_id` bigint(20) unsigned NOT NULL,
  `perm` varchar(255) NOT NULL default '',
  KEY `permissions_roles_fk` (`roles_id`),
  CONSTRAINT `permissions_roles_fk` FOREIGN KEY (`roles_id`) REFERENCES `roles` (`roles_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `permissions`
--

LOCK TABLES `permissions` WRITE;
/*!40000 ALTER TABLE `permissions` DISABLE KEYS */;
INSERT INTO `permissions` VALUES (1,'anonymous'),(2,'authenticated');
/*!40000 ALTER TABLE `permissions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_attributes`
--

DROP TABLE IF EXISTS `product_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_attributes` (
  `product_attributes_id` bigint(20) unsigned NOT NULL auto_increment,
  `name` varchar(32) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY  (`product_attributes_id`),
  UNIQUE KEY `product_attributes_id` (`product_attributes_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_attributes`
--

LOCK TABLES `product_attributes` WRITE;
/*!40000 ALTER TABLE `product_attributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `product_classes`
--

DROP TABLE IF EXISTS `product_classes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `product_classes` (
  `sku_class` varchar(32) NOT NULL,
  `manufacturer` varchar(128) NOT NULL default '',
  `name` varchar(255) NOT NULL default '',
  `short_description` varchar(255) NOT NULL default '',
  `uri` varchar(500) NOT NULL default '',
  `active` tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (`sku_class`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `product_classes`
--

LOCK TABLES `product_classes` WRITE;
/*!40000 ALTER TABLE `product_classes` DISABLE KEYS */;
/*!40000 ALTER TABLE `product_classes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products`
--

DROP TABLE IF EXISTS `products`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products` (
  `sku` varchar(32) NOT NULL,
  `sku_class` varchar(32) NOT NULL,
  `name` varchar(255) NOT NULL default '',
  `short_description` varchar(500) NOT NULL default '',
  `description` text NOT NULL,
  `price` decimal(10,2) NOT NULL default '0.00',
  `uri` varchar(255) NOT NULL default '',
  `weight` decimal(10,0) NOT NULL default '0',
  `priority` int(11) NOT NULL default '0',
  `gtin` varchar(32) NOT NULL default '',
  `canonical_sku` varchar(32) NOT NULL default '',
  `active` tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (`sku`),
  KEY `products_product_classes_fk` (`sku_class`),
  CONSTRAINT `products_product_classes_fk` FOREIGN KEY (`sku_class`) REFERENCES `product_classes` (`sku_class`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products`
--

LOCK TABLES `products` WRITE;
/*!40000 ALTER TABLE `products` DISABLE KEYS */;
/*!40000 ALTER TABLE `products` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `products_x_attributes`
--

DROP TABLE IF EXISTS `products_x_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `products_x_attributes` (
  `sku` varchar(32) NOT NULL,
  `product_attributes_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`sku`,`product_attributes_id`),
  KEY `products_x_attributes_product_attributes_fk` (`product_attributes_id`),
  CONSTRAINT `products_x_attributes_products_fk` FOREIGN KEY (`sku`) REFERENCES `products` (`sku`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `products_x_attributes_product_attributes_fk` FOREIGN KEY (`product_attributes_id`) REFERENCES `product_attributes` (`product_attributes_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `products_x_attributes`
--

LOCK TABLES `products_x_attributes` WRITE;
/*!40000 ALTER TABLE `products_x_attributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `products_x_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `roles`
--

DROP TABLE IF EXISTS `roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `roles` (
  `roles_id` bigint(20) unsigned NOT NULL auto_increment,
  `name` varchar(32) NOT NULL,
  `label` varchar(255) NOT NULL,
  PRIMARY KEY  (`roles_id`),
  UNIQUE KEY `roles_id` (`roles_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `roles`
--

LOCK TABLES `roles` WRITE;
/*!40000 ALTER TABLE `roles` DISABLE KEYS */;
INSERT INTO `roles` VALUES (1,'anonymous','Anonymous Users'),(2,'authenticated','Authenticated Users');
/*!40000 ALTER TABLE `roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `sessions`
--

DROP TABLE IF EXISTS `sessions`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `sessions` (
  `sessions_id` varchar(255) NOT NULL,
  `session_data` text NOT NULL,
  `session_hash` text NOT NULL,
  `created` datetime NOT NULL,
  `modified` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
  PRIMARY KEY  (`sessions_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `sessions`
--

LOCK TABLES `sessions` WRITE;
/*!40000 ALTER TABLE `sessions` DISABLE KEYS */;
/*!40000 ALTER TABLE `sessions` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `settings`
--

DROP TABLE IF EXISTS `settings`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `settings` (
  `settings_id` bigint(20) unsigned NOT NULL auto_increment,
  `scope` varchar(32) NOT NULL,
  `site` varchar(32) NOT NULL default '',
  `name` varchar(32) NOT NULL,
  `value` text NOT NULL,
  `category` varchar(32) NOT NULL default '',
  PRIMARY KEY  (`settings_id`),
  UNIQUE KEY `settings_id` (`settings_id`),
  KEY `scope` (`scope`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `settings`
--

LOCK TABLES `settings` WRITE;
/*!40000 ALTER TABLE `settings` DISABLE KEYS */;
/*!40000 ALTER TABLE `settings` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_attributes`
--

DROP TABLE IF EXISTS `user_attributes`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_attributes` (
  `user_attributes_id` bigint(20) unsigned NOT NULL auto_increment,
  `users_id` bigint(20) unsigned NOT NULL,
  `name` varchar(32) NOT NULL,
  `value` text NOT NULL,
  PRIMARY KEY  (`user_attributes_id`),
  UNIQUE KEY `user_attributes_id` (`user_attributes_id`),
  KEY `users_id` (`users_id`),
  CONSTRAINT `user_attributes_users_fk` FOREIGN KEY (`users_id`) REFERENCES `users` (`users_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_attributes`
--

LOCK TABLES `user_attributes` WRITE;
/*!40000 ALTER TABLE `user_attributes` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_attributes` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `user_roles`
--

DROP TABLE IF EXISTS `user_roles`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `user_roles` (
  `users_id` bigint(20) unsigned NOT NULL,
  `roles_id` bigint(20) unsigned NOT NULL,
  PRIMARY KEY  (`users_id`,`roles_id`),
  KEY `user_roles_roles_fk` (`roles_id`),
  CONSTRAINT `user_roles_users_fk` FOREIGN KEY (`users_id`) REFERENCES `users` (`users_id`) ON DELETE CASCADE ON UPDATE CASCADE,
  CONSTRAINT `user_roles_roles_fk` FOREIGN KEY (`roles_id`) REFERENCES `roles` (`roles_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
/*!40101 SET character_set_client = @saved_cs_client */;

--
-- Dumping data for table `user_roles`
--

LOCK TABLES `user_roles` WRITE;
/*!40000 ALTER TABLE `user_roles` DISABLE KEYS */;
/*!40000 ALTER TABLE `user_roles` ENABLE KEYS */;
UNLOCK TABLES;

--
-- Table structure for table `users`
--

DROP TABLE IF EXISTS `users`;
/*!40101 SET @saved_cs_client     = @@character_set_client */;
/*!40101 SET character_set_client = utf8 */;
CREATE TABLE `users` (
  `users_id` bigint(20) unsigned NOT NULL auto_increment,
  `username` varchar(255) NOT NULL,
  `email` varchar(255) NOT NULL default '',
  `password` varchar(255) NOT NULL default '',
  `first_name` varchar(255) NOT NULL default '',
  `last_name` varchar(255) NOT NULL default '',
  `last_login` datetime NOT NULL,
  `created` datetime NOT NULL,
  `modified` datetime NOT NULL,
  `active` tinyint(1) NOT NULL default '1',
  PRIMARY KEY  (`users_id`),
  UNIQUE KEY `users_id` (`users_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
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

-- Dump completed on 2013-10-30 13:57:35
