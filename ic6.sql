use ic6;

CREATE TABLE product_classes (
    sku_class VARCHAR(32) NOT NULL,
    manufacturer VARCHAR(128) NOT NULL DEFAULT '',
    name VARCHAR(255) NOT NULL DEFAULT '',
    short_description VARCHAR(255) NOT NULL DEFAULT '',
    uri VARCHAR(500) NOT NULL DEFAULT '', -- URL to see "flypage"
    active BOOLEAN NOT NULL DEFAULT TRUE, -- can disable all variants
    primary key(sku_class)
) ENGINE InnoDB;

CREATE TABLE products (
  sku varchar(32) NOT NULL,
  sku_class varchar(32) NOT NULL,
  CONSTRAINT products_product_classes_fk
      FOREIGN KEY (sku_class) REFERENCES product_classes(sku_class)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
  name varchar(255) NOT NULL DEFAULT '',
  short_description varchar(500) NOT NULL DEFAULT '',
  description text NOT NULL DEFAULT '',
  price decimal(10,2) NOT NULL DEFAULT 0,
  uri varchar(255) NOT NULL DEFAULT '',
  weight decimal NOT NULL DEFAULT 0.0,
  priority integer NOT NULL DEFAULT 0,
  gtin varchar(32) NOT NULL DEFAULT '',
  canonical_sku varchar(32) NOT NULL DEFAULT '',
  active boolean NOT NULL DEFAULT TRUE,
  primary key(sku)
) ENGINE InnoDB;

CREATE TABLE product_attributes (
  code serial NOT NULL,
  /*sku varchar(32) NOT NULL,
  CONSTRAINT product_attributes_products_fk
      FOREIGN KEY (sku) REFERENCES products(sku)
      ON DELETE CASCADE
      ON UPDATE CASCADE,*/
  name varchar(32) NOT NULL,
  value text NOT NULL default '',
  original_sku varchar(32) NOT NULL default '',
  primary key(code)
  /*, key product_attributes_sku (sku)*/
) ENGINE InnoDB;

CREATE TABLE products_x_attributes (
  sku varchar(32) NOT NULL,
  CONSTRAINT products_x_attributes_products_fk
      FOREIGN KEY (sku) REFERENCES products(sku)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
  attribute bigint(20) unsigned NOT NULL,
  CONSTRAINT products_x_attributes_product_attributes_fk
      FOREIGN KEY (attribute) REFERENCES product_attributes(code)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
  primary key(sku,attribute)
) ENGINE InnoDB;

CREATE TABLE inventory (
   sku varchar(32) NOT NULL,
   CONSTRAINT inventory_products_fk
      FOREIGN KEY (sku) REFERENCES products(sku)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
   quantity integer NOT NULL DEFAULT 0,
   in_stock boolean NOT NULL DEFAULT TRUE,
   primary key(sku)
) ENGINE InnoDB;

CREATE TABLE navigation (
  code serial NOT NULL,
  uri varchar(255) NOT NULL DEFAULT '',
  type varchar(32) NOT NULL DEFAULT '',
  scope varchar(32) NOT NULL DEFAULT '',
  name varchar(255) NOT NULL DEFAULT '',
  description text NOT NULL DEFAULT '',
  template varchar(255) NOT NULL DEFAULT '',
  text_language varchar(8) NOT NULL DEFAULT '',
  alias integer NOT NULL DEFAULT 0,
  parent integer NOT NULL DEFAULT 0,
  priority integer NOT NULL DEFAULT 0,
  product_count integer NOT NULL DEFAULT 0,
  active boolean NOT NULL default TRUE,
  entered timestamp DEFAULT CURRENT_TIMESTAMP,
  primary key(code),
  UNIQUE(uri)
) ENGINE InnoDB;

CREATE TABLE navigation_products (
  sku varchar(32) NOT NULL,
  CONSTRAINT navigation_products_products_fk
      FOREIGN KEY (sku) REFERENCES products(sku)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
  navigation integer NOT NULL,
  type varchar(16) NOT NULL DEFAULT '',
  key(sku,navigation)
) ENGINE InnoDB;

CREATE TABLE media (
  code serial NOT NULL,
  file varchar(255) NOT NULL DEFAULT '',
  uri varchar(255) NOT NULL DEFAULT '',
  mime_type varchar(255) NOT NULL DEFAULT '',
  label varchar(255) NOT NULL DEFAULT '',
  author integer NOT NULL DEFAULT 0,
  created datetime NOT NULL,
  modified datetime NOT NULL,
  active boolean NOT NULL DEFAULT TRUE,
  primary key(code)
) ENGINE InnoDB;

CREATE TABLE media_types (
  code serial NOT NULL,
  type varchar(32) NOT NULL,
  scope varchar(32) NOT NULL,
  primary key(code),
  unique(type,scope)
) ENGINE InnoDB;

INSERT INTO media_types (type,scope) VALUES ('detail', 'store');
INSERT INTO media_types (type,scope) VALUES ('thumb', 'store');
INSERT INTO media_types (type,scope) VALUES ('cart', 'store');

CREATE TABLE media_products (
  code serial NOT NULL,
  media integer NOT NULL,
  sku varchar(32) NOT NULL,
  CONSTRAINT media_products_products_fk
      FOREIGN KEY (sku) REFERENCES products(sku)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
  primary key(code),
  key(sku)
) ENGINE InnoDB;

CREATE TABLE media_display (
  code serial NOT NULL,
  media integer NOT NULL,
  sku varchar(32) NOT NULL,
  CONSTRAINT media_display_products_fk
      FOREIGN KEY (sku) REFERENCES products(sku)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
  type integer NOT NULL,
  primary key(code),
  key(sku)
) ENGINE InnoDB;

CREATE TABLE merchandising_products (
  code serial NOT NULL,
  sku character varying(32),
  CONSTRAINT merchandising_products_products_fk
      FOREIGN KEY (sku) REFERENCES products(sku)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
  sku_related character varying(32),
  CONSTRAINT merchandising_products_related_products_fk
      FOREIGN KEY (sku_related) REFERENCES products(sku)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
  type character varying(32) NOT NULL DEFAULT '',
  primary key(code)
) ENGINE InnoDB;

CREATE TABLE merchandising_attributes (
  code serial NOT NULL,
  merchandising integer NOT NULL default 0,
  name varchar(32) NOT NULL,
  value text NOT NULL default '',
  primary key(code)
) ENGINE InnoDB;

CREATE TABLE roles (
  role_id serial NOT NULL,
  name varchar(32) NOT NULL,
  label varchar(255) NOT NULL,
  primary key(role_id)
) ENGINE InnoDB;

INSERT INTO roles (role_id,name,label) VALUES (1, 'anonymous', 'Anonymous Users');
INSERT INTO roles (role_id,name,label) VALUES (2, 'authenticated', 'Authenticated Users');

CREATE TABLE group_pricing (
    code serial NOT NULL,
    sku character varying(32) NOT NULL,
    CONSTRAINT group_pricing_products_fk
      FOREIGN KEY (sku) REFERENCES products(sku)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
    quantity integer NOT NULL DEFAULT 0,
    role_id bigint(20) unsigned NOT NULL DEFAULT 0,
    CONSTRAINT group_pricing_roles_fk
      FOREIGN KEY (role_id) REFERENCES roles(role_id)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
    price decimal(10,2) NOT NULL DEFAULT 0,
    primary key(code),
    key(sku)
) ENGINE InnoDB;

CREATE TABLE carts (
  code serial NOT NULL,
  name character varying(255) DEFAULT '' NOT NULL,
  user_id integer DEFAULT 0 NOT NULL,
  session_id character varying(255) DEFAULT '' NOT NULL,
  created datetime NOT NULL,
  last_modified datetime NOT NULL,
  type character varying(32) DEFAULT '' NOT NULL,
  approved boolean,
  status character varying(32) DEFAULT '' NOT NULL,
  primary key(code)
) ENGINE InnoDB;

CREATE TABLE cart_products (
  cart bigint(20) unsigned NOT NULL,
  CONSTRAINT cart_products_carts_fk
      FOREIGN KEY (cart) REFERENCES carts(code)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
  sku character varying(32) NOT NULL,
  CONSTRAINT cart_products_products_fk
      FOREIGN KEY (sku) REFERENCES products(sku)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
  cart_position integer NOT NULL,
  quantity integer DEFAULT 1 NOT NULL,
  when_added datetime NOT NULL,
  key(cart,sku)
) ENGINE InnoDB;

CREATE TABLE users (
  user_id serial,
  username varchar(255) NOT NULL,
  email varchar(255) NOT NULL DEFAULT '',
  password varchar(255) NOT NULL DEFAULT '',
  first_name varchar(255) NOT NULL DEFAULT '',
  last_name varchar(255) NOT NULL DEFAULT '',
  last_login datetime NOT NULL,
  created datetime NOT NULL,
  modified datetime NOT NULL,
  active boolean NOT NULL DEFAULT TRUE,
  primary key(user_id)
) ENGINE InnoDB;

CREATE TABLE user_attributes (
  code serial NOT NULL,
  user_id bigint(20) unsigned NOT NULL,
  CONSTRAINT user_attributes_users_fk
      FOREIGN KEY (user_id) REFERENCES users(user_id)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
  name varchar(32) NOT NULL,
  value text NOT NULL default '',
  primary key(code),
  key(user_id)
) ENGINE InnoDB;

CREATE TABLE user_roles (
  user_id bigint(20) unsigned DEFAULT 0 NOT NULL,
  CONSTRAINT user_roles_users_fk
      FOREIGN KEY (user_id) REFERENCES users(user_id)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
  role_id bigint(20) unsigned DEFAULT 0 NOT NULL,
  CONSTRAINT user_roles_roles_fk
      FOREIGN KEY (role_id) REFERENCES roles(role_id)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
  primary key (user_id, role_id)
) ENGINE InnoDB;

CREATE TABLE permissions (
  role_id bigint(20) unsigned NOT NULL,
  CONSTRAINT permissions_roles_fk
      FOREIGN KEY (role_id) REFERENCES roles(role_id)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
  perm varchar(255) NOT NULL default ''
) ENGINE InnoDB;

INSERT INTO permissions (role_id,perm) VALUES (1,'anonymous');
INSERT INTO permissions (role_id,perm) VALUES (2,'authenticated');

CREATE TABLE addresses (
  address_id serial NOT NULL,
  user_id bigint(20) unsigned NOT NULL,
  CONSTRAINT addresses_users_fk
      FOREIGN KEY (user_id) REFERENCES users(user_id)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
  type varchar(16) NOT NULL DEFAULT '',
  archived boolean NOT NULL DEFAULT FALSE,
  first_name varchar(255) NOT NULL DEFAULT '',
  last_name varchar(255) NOT NULL DEFAULT '',
  company varchar(255) NOT NULL DEFAULT '',
  street_address varchar(255) NOT NULL DEFAULT '',
  street_address_2 varchar(255) NOT NULL DEFAULT '',
  zip varchar(255) NOT NULL DEFAULT '',
  city varchar(255) NOT NULL DEFAULT '',
  phone varchar(32) NOT NULL DEFAULT '',
  state_code char(6) NOT NULL DEFAULT '',
  country_code char(2) NOT NULL DEFAULT '',
  created datetime NOT NULL,
  modified datetime NOT NULL,
  primary key(address_id)
) ENGINE InnoDB;

CREATE TABLE orders (
  code serial NOT NULL,
  order_number varchar(24) NOT NULL,
  order_date timestamp,
  user_id integer NOT NULL DEFAULT 0,
  email varchar(255) NOT NULL DEFAULT '',
  billing_address bigint(20) unsigned NOT NULL,
  CONSTRAINT orders_billing_address_fk
      FOREIGN KEY (billing_address) REFERENCES addresses(address_id)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
  weight decimal NOT NULL DEFAULT 0.0,
  payment_method varchar(255) NOT NULL DEFAULT '',
  payment_code varchar(255) NOT NULL DEFAULT '',
  payment_status varchar(255) NOT NULL DEFAULT '',
  shipping_method varchar(255) NOT NULL DEFAULT '',
  shipping_code varchar(255) NOT NULL DEFAULT '',
  subtotal numeric(11,2) NOT NULL DEFAULT 0,
  shipping numeric(11,2) NOT NULL DEFAULT 0,
  handling numeric(11,2) NOT NULL DEFAULT 0,
  salestax numeric(11,2) NOT NULL DEFAULT 0,
  total_cost numeric(11,2) NOT NULL DEFAULT 0,
  status varchar(24) NOT NULL DEFAULT '',
  primary key (code),
  key(order_number)
) ENGINE InnoDB;

CREATE TABLE orderlines (
  code serial NOT NULL,
  order_number varchar(24) NOT NULL,
  CONSTRAINT orderlines_orders_fk
      FOREIGN KEY (order_number) REFERENCES orders(order_number)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
  order_position integer NOT NULL DEFAULT 0,
  sku varchar(32) NOT NULL,
  CONSTRAINT orderlines_products_fk
      FOREIGN KEY (sku) REFERENCES products(sku)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
  name varchar(255) NOT NULL DEFAULT '',
  short_description varchar(500) NOT NULL DEFAULT '',
  description text NOT NULL DEFAULT '',
  weight decimal NOT NULL DEFAULT 0.0,
  quantity integer,
  shipping_method varchar(255) NOT NULL DEFAULT '',
  shipping_code varchar(255) NOT NULL DEFAULT '',
  price numeric(10,2) NOT NULL DEFAULT 0,
  subtotal numeric(11,2) NOT NULL DEFAULT 0,
  shipping numeric(11,2) NOT NULL DEFAULT 0,
  handling numeric(11,2) NOT NULL DEFAULT 0,
  salestax numeric(11,2) NOT NULL DEFAULT 0,
  status varchar(24) NOT NULL DEFAULT '',
  primary key(code),
  key(order_number)
) ENGINE InnoDB;

CREATE TABLE orderlines_shipping (
  orderlines_code bigint(20) unsigned NOT NULL,
  CONSTRAINT orderlines_shipping_orderlines_fk
      FOREIGN KEY (orderlines_code) REFERENCES orderlines(code)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
  shipping_address bigint(20) unsigned NOT NULL,
  CONSTRAINT orderlines_shipping_addresses_fk
      FOREIGN KEY (shipping_address) REFERENCES addresses(address_id)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
  primary key(orderlines_code, shipping_address)
) ENGINE InnoDB;


CREATE TABLE payment_orders (
  code serial NOT NULL,
  payment_mode varchar(32) NOT NULL default '',
  payment_action varchar(32) NOT NULL default '',
  payment_id varchar(32) NOT NULL default '',
  auth_code varchar(255) NOT NULL default '',
  session_id varchar(255) NOT NULL default '',
  order_number varchar(24) NOT NULL,
  CONSTRAINT payment_orders_fk
      FOREIGN KEY (order_number) REFERENCES orders(order_number)
      ON DELETE CASCADE
      ON UPDATE CASCADE,
  amount numeric(11,2) NOT NULL DEFAULT 0,
  status varchar(32) NOT NULL default '',
  payment_session_id varchar(255) NOT NULL default '',
  payment_error_code varchar(32) NOT NULL default '',
  payment_error_message text NOT NULL default '',
  created datetime default NULL,
  last_modified datetime default NULL,
  primary key(code),
  key(order_number)
) ENGINE InnoDB;

CREATE TABLE settings (
  code serial,
  scope varchar(32) NOT NULL,
  site varchar(32) NOT NULL default '',
  name varchar(32) NOT NULL,
  value text NOT NULL,
  category varchar(32) NOT NULL default '',
  primary key(code),
  key(scope)
) ENGINE InnoDB;

CREATE TABLE sessions (
  code varchar(255) NOT NULL primary key,
  session_data text NOT NULL,
  session_hash text NOT NULL,
  created datetime NOT NULL,
  modified timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
) ENGINE InnoDB;
