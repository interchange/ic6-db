 
DROP TABLE IF EXISTS `addresses`;
 
CREATE TABLE `addresses` (
`address_id` bigint(20) unsigned NOT NULL auto_increment,
`user_id` bigint(20) unsigned NOT NULL,
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
PRIMARY KEY (`address_id`),
UNIQUE KEY `address_id` (`address_id`),
KEY `addresses_users_fk` (`user_id`),
CONSTRAINT `addresses_users_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
 
--
-- Table structure for table `cart_products`
--
 
DROP TABLE IF EXISTS `cart_products`;
CREATE TABLE `cart_products` (
`cart` bigint(20) unsigned NOT NULL,
`sku` varchar(32) NOT NULL,
`cart_position` int(11) NOT NULL,
`quantity` int(11) NOT NULL default '1',
`when_added` datetime NOT NULL,
KEY `cart_products_products_fk` (`sku`),
KEY `cart` (`cart`,`sku`),
CONSTRAINT `cart_products_carts_fk` FOREIGN KEY (`cart`) REFERENCES `carts` (`code`) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT `cart_products_products_fk` FOREIGN KEY (`sku`) REFERENCES `products` (`sku`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
 
--
-- Table structure for table `carts`
--
 
DROP TABLE IF EXISTS `carts`;
CREATE TABLE `carts` (
`code` bigint(20) unsigned NOT NULL auto_increment,
`name` varchar(255) NOT NULL default '',
`user_id` int(11) NOT NULL default '0',
`session_id` varchar(255) NOT NULL default '',
`created` datetime NOT NULL,
`last_modified` datetime NOT NULL,
`type` varchar(32) NOT NULL default '',
`approved` tinyint(1) default NULL,
`status` varchar(32) NOT NULL default '',
PRIMARY KEY (`code`),
UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
 
--
-- Table structure for table `group_pricing`
--
 
DROP TABLE IF EXISTS `group_pricing`;
CREATE TABLE `group_pricing` (
`code` bigint(20) unsigned NOT NULL auto_increment,
`sku` varchar(32) NOT NULL,
`quantity` int(11) NOT NULL default '0',
`role_id` bigint(20) unsigned NOT NULL default '0',
`price` decimal(10,2) NOT NULL default '0.00',
PRIMARY KEY (`code`),
UNIQUE KEY `code` (`code`),
KEY `group_pricing_roles_fk` (`role_id`),
KEY `sku` (`sku`),
CONSTRAINT `group_pricing_products_fk` FOREIGN KEY (`sku`) REFERENCES `products` (`sku`) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT `group_pricing_roles_fk` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
 
--
-- Table structure for table `inventory`
--
 
DROP TABLE IF EXISTS `inventory`;
CREATE TABLE `inventory` (
`sku` varchar(32) NOT NULL,
`quantity` int(11) NOT NULL default '0',
`in_stock` tinyint(1) NOT NULL default '1',
PRIMARY KEY (`sku`),
CONSTRAINT `inventory_products_fk` FOREIGN KEY (`sku`) REFERENCES `products` (`sku`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
 
--
-- Table structure for table `media`
--
 
DROP TABLE IF EXISTS `media`;
CREATE TABLE `media` (
`code` bigint(20) unsigned NOT NULL auto_increment,
`file` varchar(255) NOT NULL default '',
`uri` varchar(255) NOT NULL default '',
`mime_type` varchar(255) NOT NULL default '',
`label` varchar(255) NOT NULL default '',
`author` int(11) NOT NULL default '0',
`created` datetime NOT NULL,
`modified` datetime NOT NULL,
`active` tinyint(1) NOT NULL default '1',
PRIMARY KEY (`code`),
UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
 
--
-- Table structure for table `media_display`
--
 
DROP TABLE IF EXISTS `media_display`;
CREATE TABLE `media_display` (
`code` bigint(20) unsigned NOT NULL auto_increment,
`media` int(11) NOT NULL,
`sku` varchar(32) NOT NULL,
`type` int(11) NOT NULL,
PRIMARY KEY (`code`),
UNIQUE KEY `code` (`code`),
KEY `sku` (`sku`),
CONSTRAINT `media_display_products_fk` FOREIGN KEY (`sku`) REFERENCES `products` (`sku`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
 
--
-- Table structure for table `media_products`
--
 
DROP TABLE IF EXISTS `media_products`;
CREATE TABLE `media_products` (
`code` bigint(20) unsigned NOT NULL auto_increment,
`media` int(11) NOT NULL,
`sku` varchar(32) NOT NULL,
PRIMARY KEY (`code`),
UNIQUE KEY `code` (`code`),
KEY `sku` (`sku`),
CONSTRAINT `media_products_products_fk` FOREIGN KEY (`sku`) REFERENCES `products` (`sku`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
 
--
-- Table structure for table `media_types`
--
 
DROP TABLE IF EXISTS `media_types`;
CREATE TABLE `media_types` (
`code` bigint(20) unsigned NOT NULL auto_increment,
`type` varchar(32) NOT NULL,
`scope` varchar(32) NOT NULL,
PRIMARY KEY (`code`),
UNIQUE KEY `code` (`code`),
UNIQUE KEY `type` (`type`,`scope`)
) ENGINE=InnoDB AUTO_INCREMENT=4 DEFAULT CHARSET=latin1;
 
--
-- Table structure for table `merchandising_attributes`
--
 
DROP TABLE IF EXISTS `merchandising_attributes`;
CREATE TABLE `merchandising_attributes` (
`code` bigint(20) unsigned NOT NULL auto_increment,
`merchandising` int(11) NOT NULL default '0',
`name` varchar(32) NOT NULL,
`value` text NOT NULL,
PRIMARY KEY (`code`),
UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
 
--
-- Table structure for table `merchandising_products`
--
 
DROP TABLE IF EXISTS `merchandising_products`;
CREATE TABLE `merchandising_products` (
`code` bigint(20) unsigned NOT NULL auto_increment,
`sku` varchar(32) default NULL,
`sku_related` varchar(32) default NULL,
`type` varchar(32) NOT NULL default '',
PRIMARY KEY (`code`),
UNIQUE KEY `code` (`code`),
KEY `merchandising_products_products_fk` (`sku`),
KEY `merchandising_products_related_products_fk` (`sku_related`),
CONSTRAINT `merchandising_products_products_fk` FOREIGN KEY (`sku`) REFERENCES `products` (`sku`) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT `merchandising_products_related_products_fk` FOREIGN KEY (`sku_related`) REFERENCES `products` (`sku`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
 
--
-- Table structure for table `navigation`
--
 
DROP TABLE IF EXISTS `navigation`;
CREATE TABLE `navigation` (
`code` bigint(20) unsigned NOT NULL auto_increment,
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
PRIMARY KEY (`code`),
UNIQUE KEY `code` (`code`),
UNIQUE KEY `uri` (`uri`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
 
--
-- Table structure for table `navigation_products`
--
 
DROP TABLE IF EXISTS `navigation_products`;
CREATE TABLE `navigation_products` (
`sku` varchar(32) NOT NULL,
`navigation` int(11) NOT NULL,
`type` varchar(16) NOT NULL default '',
KEY `sku` (`sku`,`navigation`),
CONSTRAINT `navigation_products_products_fk` FOREIGN KEY (`sku`) REFERENCES `products` (`sku`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
 
--
-- Table structure for table `orderlines`
--
 
DROP TABLE IF EXISTS `orderlines`;
CREATE TABLE `orderlines` (
`code` bigint(20) unsigned NOT NULL auto_increment,
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
PRIMARY KEY (`code`),
UNIQUE KEY `code` (`code`),
KEY `orderlines_products_fk` (`sku`),
KEY `order_number` (`order_number`),
CONSTRAINT `orderlines_orders_fk` FOREIGN KEY (`order_number`) REFERENCES `orders` (`order_number`) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT `orderlines_products_fk` FOREIGN KEY (`sku`) REFERENCES `products` (`sku`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
 
--
-- Table structure for table `orderlines_shipping`
--
 
DROP TABLE IF EXISTS `orderlines_shipping`;
CREATE TABLE `orderlines_shipping` (
`orderlines_code` bigint(20) unsigned NOT NULL,
`shipping_address` bigint(20) unsigned NOT NULL,
PRIMARY KEY (`orderlines_code`,`shipping_address`),
KEY `orderlines_shipping_addresses_fk` (`shipping_address`),
CONSTRAINT `orderlines_shipping_orderlines_fk` FOREIGN KEY (`orderlines_code`) REFERENCES `orderlines` (`code`) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT `orderlines_shipping_addresses_fk` FOREIGN KEY (`shipping_address`) REFERENCES `addresses` (`address_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
 
--
-- Table structure for table `orders`
--
 
DROP TABLE IF EXISTS `orders`;
CREATE TABLE `orders` (
`code` bigint(20) unsigned NOT NULL auto_increment,
`order_number` varchar(24) NOT NULL,
`order_date` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
`user_id` int(11) NOT NULL default '0',
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
PRIMARY KEY (`code`),
UNIQUE KEY `code` (`code`),
KEY `orders_billing_address_fk` (`billing_address`),
KEY `order_number` (`order_number`),
CONSTRAINT `orders_billing_address_fk` FOREIGN KEY (`billing_address`) REFERENCES `addresses` (`address_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
 
--
-- Table structure for table `payment_orders`
--
 
DROP TABLE IF EXISTS `payment_orders`;
CREATE TABLE `payment_orders` (
`code` bigint(20) unsigned NOT NULL auto_increment,
`payment_mode` varchar(32) NOT NULL default '',
`payment_action` varchar(32) NOT NULL default '',
`payment_id` varchar(32) NOT NULL default '',
`auth_code` varchar(255) NOT NULL default '',
`session_id` varchar(255) NOT NULL default '',
`order_number` varchar(24) NOT NULL,
`amount` decimal(11,2) NOT NULL default '0.00',
`status` varchar(32) NOT NULL default '',
`payment_session_id` varchar(255) NOT NULL default '',
`payment_error_code` varchar(32) NOT NULL default '',
`payment_error_message` text NOT NULL,
`created` datetime default NULL,
`last_modified` datetime default NULL,
PRIMARY KEY (`code`),
UNIQUE KEY `code` (`code`),
KEY `order_number` (`order_number`),
CONSTRAINT `payment_orders_fk` FOREIGN KEY (`order_number`) REFERENCES `orders` (`order_number`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
 
--
-- Table structure for table `permissions`
--
 
DROP TABLE IF EXISTS `permissions`;
CREATE TABLE `permissions` (
`role_id` bigint(20) unsigned NOT NULL,
`perm` varchar(255) NOT NULL default '',
KEY `permissions_roles_fk` (`role_id`),
CONSTRAINT `permissions_roles_fk` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
 
--
-- Dumping data for table `permissions`
--
 
INSERT INTO `permissions` VALUES (1,'anonymous'),(2,'authenticated');
 
--
-- Table structure for table `product_attributes`
--
 
DROP TABLE IF EXISTS `product_attributes`;
CREATE TABLE `product_attributes` (
`code` bigint(20) unsigned NOT NULL auto_increment,
`name` varchar(32) NOT NULL,
`value` text NOT NULL,
`original_sku` varchar(32) NOT NULL default '',
PRIMARY KEY (`code`),
UNIQUE KEY `code` (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
 
--
-- Table structure for table `product_classes`
--
 
DROP TABLE IF EXISTS `product_classes`;
CREATE TABLE `product_classes` (
`sku_class` varchar(32) NOT NULL,
`manufacturer` varchar(128) NOT NULL default '',
`name` varchar(255) NOT NULL default '',
`short_description` varchar(255) NOT NULL default '',
`uri` varchar(500) NOT NULL default '',
`active` tinyint(1) NOT NULL default '1',
PRIMARY KEY (`sku_class`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
 
--
-- Table structure for table `products`
--
 
DROP TABLE IF EXISTS `products`;
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
PRIMARY KEY (`sku`),
KEY `products_product_classes_fk` (`sku_class`),
CONSTRAINT `products_product_classes_fk` FOREIGN KEY (`sku_class`) REFERENCES `product_classes` (`sku_class`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
 
--
-- Table structure for table `products_x_attributes`
--
 
DROP TABLE IF EXISTS `products_x_attributes`;
CREATE TABLE `products_x_attributes` (
`sku` varchar(32) NOT NULL,
`attribute` bigint(20) unsigned NOT NULL,
PRIMARY KEY (`sku`,`attribute`),
KEY `products_x_attributes_product_attributes_fk` (`attribute`),
CONSTRAINT `products_x_attributes_products_fk` FOREIGN KEY (`sku`) REFERENCES `products` (`sku`) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT `products_x_attributes_product_attributes_fk` FOREIGN KEY (`attribute`) REFERENCES `product_attributes` (`code`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
 
--
-- Table structure for table `roles`
--
 
DROP TABLE IF EXISTS `roles`;
CREATE TABLE `roles` (
`role_id` bigint(20) unsigned NOT NULL auto_increment,
`name` varchar(32) NOT NULL,
`label` varchar(255) NOT NULL,
PRIMARY KEY (`role_id`),
UNIQUE KEY `role_id` (`role_id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;
 
--
-- Dumping data for table `roles`
--
 
INSERT INTO `roles` VALUES (1,'anonymous','Anonymous Users'),(2,'authenticated','Authenticated Users');
 
--
-- Table structure for table `sessions`
--
 
DROP TABLE IF EXISTS `sessions`;
CREATE TABLE `sessions` (
`code` varchar(255) NOT NULL,
`session_data` text NOT NULL,
`session_hash` text NOT NULL,
`created` datetime NOT NULL,
`modified` timestamp NOT NULL default CURRENT_TIMESTAMP on update CURRENT_TIMESTAMP,
PRIMARY KEY (`code`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
 
--
-- Table structure for table `settings`
--
 
DROP TABLE IF EXISTS `settings`;
CREATE TABLE `settings` (
`code` bigint(20) unsigned NOT NULL auto_increment,
`scope` varchar(32) NOT NULL,
`site` varchar(32) NOT NULL default '',
`name` varchar(32) NOT NULL,
`value` text NOT NULL,
`category` varchar(32) NOT NULL default '',
PRIMARY KEY (`code`),
UNIQUE KEY `code` (`code`),
KEY `scope` (`scope`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
 
--
-- Table structure for table `user_attributes`
--
 
DROP TABLE IF EXISTS `user_attributes`;
CREATE TABLE `user_attributes` (
`code` bigint(20) unsigned NOT NULL auto_increment,
`user_id` bigint(20) unsigned NOT NULL,
`name` varchar(32) NOT NULL,
`value` text NOT NULL,
PRIMARY KEY (`code`),
UNIQUE KEY `code` (`code`),
KEY `user_id` (`user_id`),
CONSTRAINT `user_attributes_users_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
 
--
-- Table structure for table `user_roles`
--
 
DROP TABLE IF EXISTS `user_roles`;
CREATE TABLE `user_roles` (
`user_id` bigint(20) unsigned NOT NULL default '0',
`role_id` bigint(20) unsigned NOT NULL default '0',
PRIMARY KEY (`user_id`,`role_id`),
KEY `user_roles_roles_fk` (`role_id`),
CONSTRAINT `user_roles_users_fk` FOREIGN KEY (`user_id`) REFERENCES `users` (`user_id`) ON DELETE CASCADE ON UPDATE CASCADE,
CONSTRAINT `user_roles_roles_fk` FOREIGN KEY (`role_id`) REFERENCES `roles` (`role_id`) ON DELETE CASCADE ON UPDATE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
 
--
-- Table structure for table `users`
--
 
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
`user_id` bigint(20) unsigned NOT NULL auto_increment,
`username` varchar(255) NOT NULL,
`email` varchar(255) NOT NULL default '',
`password` varchar(255) NOT NULL default '',
`first_name` varchar(255) NOT NULL default '',
`last_name` varchar(255) NOT NULL default '',
`last_login` datetime NOT NULL,
`created` datetime NOT NULL,
`modified` datetime NOT NULL,
`active` tinyint(1) NOT NULL default '1',
PRIMARY KEY (`user_id`),
UNIQUE KEY `user_id` (`user_id`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;
