CREATE TABLE addresses (
address_id integer NOT NULL,
user_id integer NOT NULL,
type character varying(16) DEFAULT ''::character varying NOT NULL,
archived boolean DEFAULT false NOT NULL,
first_name character varying(255) DEFAULT ''::character varying NOT NULL,
last_name character varying(255) DEFAULT ''::character varying NOT NULL,
company character varying(255) DEFAULT ''::character varying NOT NULL,
street_address character varying(255) DEFAULT ''::character varying NOT NULL,
street_address_2 character varying(255) DEFAULT ''::character varying NOT NULL,
zip character varying(255) DEFAULT ''::character varying NOT NULL,
city character varying(255) DEFAULT ''::character varying NOT NULL,
phone character varying(32) DEFAULT ''::character varying NOT NULL,
state_code character(6) DEFAULT ''::bpchar NOT NULL,
country_code character(2) DEFAULT ''::bpchar NOT NULL,
created timestamp without time zone NOT NULL,
modified timestamp without time zone NOT NULL
);
 
 
CREATE SEQUENCE addresses_address_id_seq
START WITH 1
INCREMENT BY 1
NO MAXVALUE
NO MINVALUE
CACHE 1;
 
 
ALTER SEQUENCE addresses_address_id_seq OWNED BY addresses.address_id;
 
SELECT pg_catalog.setval('addresses_address_id_seq', 1, false);
 
 
CREATE TABLE cart_products (
cart integer NOT NULL,
sku character varying(32) NOT NULL,
cart_position integer NOT NULL,
quantity integer DEFAULT 1 NOT NULL,
when_added timestamp without time zone NOT NULL
);
 
 
CREATE TABLE carts (
code integer NOT NULL,
name character varying(255) DEFAULT ''::character varying NOT NULL,
user_id integer DEFAULT 0 NOT NULL,
session_id character varying(255) DEFAULT ''::character varying NOT NULL,
created timestamp without time zone NOT NULL,
last_modified timestamp without time zone NOT NULL,
type character varying(32) DEFAULT ''::character varying NOT NULL,
approved boolean,
status character varying(32) DEFAULT ''::character varying NOT NULL
);
 
 
CREATE SEQUENCE carts_code_seq
START WITH 1
INCREMENT BY 1
NO MAXVALUE
NO MINVALUE
CACHE 1;
 
 
ALTER SEQUENCE carts_code_seq OWNED BY carts.code;
 
 
SELECT pg_catalog.setval('carts_code_seq', 1, false);
 
 
CREATE TABLE group_pricing (
code integer NOT NULL,
sku character varying(32) NOT NULL,
quantity integer DEFAULT 0 NOT NULL,
role_id integer DEFAULT 0 NOT NULL,
price numeric(10,2) DEFAULT 0 NOT NULL
);
 
 
CREATE SEQUENCE group_pricing_code_seq
START WITH 1
INCREMENT BY 1
NO MAXVALUE
NO MINVALUE
CACHE 1;
 
ALTER SEQUENCE group_pricing_code_seq OWNED BY group_pricing.code;
 
 
SELECT pg_catalog.setval('group_pricing_code_seq', 1, false);
 
 
CREATE TABLE inventory (
sku character varying(32) NOT NULL,
quantity integer DEFAULT 0 NOT NULL,
in_stock boolean DEFAULT true NOT NULL
);
 
 
CREATE TABLE media (
code integer NOT NULL,
file character varying(255) DEFAULT ''::character varying NOT NULL,
uri character varying(255) DEFAULT ''::character varying NOT NULL,
mime_type character varying(255) DEFAULT ''::character varying NOT NULL,
label character varying(255) DEFAULT ''::character varying NOT NULL,
author integer DEFAULT 0 NOT NULL,
created timestamp without time zone NOT NULL,
modified timestamp without time zone NOT NULL,
active boolean DEFAULT true NOT NULL
);
 
 
CREATE SEQUENCE media_code_seq
START WITH 1
INCREMENT BY 1
NO MAXVALUE
NO MINVALUE
CACHE 1;
 
 
ALTER SEQUENCE media_code_seq OWNED BY media.code;
 
 
SELECT pg_catalog.setval('media_code_seq', 1, false);
 
 
CREATE TABLE media_display (
code integer NOT NULL,
media integer NOT NULL,
sku character varying(32) NOT NULL,
type integer NOT NULL
);
 
 
CREATE SEQUENCE media_display_code_seq
START WITH 1
INCREMENT BY 1
NO MAXVALUE
NO MINVALUE
CACHE 1;
 
 
ALTER SEQUENCE media_display_code_seq OWNED BY media_display.code;
 
SELECT pg_catalog.setval('media_display_code_seq', 1, false);
 
CREATE TABLE media_products (
code integer NOT NULL,
media integer NOT NULL,
sku character varying(32) NOT NULL
);
 
 
CREATE SEQUENCE media_products_code_seq
START WITH 1
INCREMENT BY 1
NO MAXVALUE
NO MINVALUE
CACHE 1;
 
 
ALTER SEQUENCE media_products_code_seq OWNED BY media_products.code;
 
 
 
SELECT pg_catalog.setval('media_products_code_seq', 1, false);
 
 
 
CREATE TABLE media_types (
code integer NOT NULL,
type character varying(32) NOT NULL,
scope character varying(32) NOT NULL
);
 
 
 
 
CREATE SEQUENCE media_types_code_seq
START WITH 1
INCREMENT BY 1
NO MAXVALUE
NO MINVALUE
CACHE 1;
 
 
 
 
ALTER SEQUENCE media_types_code_seq OWNED BY media_types.code;
 
 
 
SELECT pg_catalog.setval('media_types_code_seq', 3, true);
 
 
 
CREATE TABLE merchandising_attributes (
code integer NOT NULL,
merchandising integer DEFAULT 0 NOT NULL,
name character varying(32) NOT NULL,
value text DEFAULT ''::text NOT NULL
);
 
 
 
 
CREATE SEQUENCE merchandising_attributes_code_seq
START WITH 1
INCREMENT BY 1
NO MAXVALUE
NO MINVALUE
CACHE 1;
 
 
 
 
ALTER SEQUENCE merchandising_attributes_code_seq OWNED BY merchandising_attributes.code;
 
 
 
SELECT pg_catalog.setval('merchandising_attributes_code_seq', 1, false);
 
 
 
CREATE TABLE merchandising_products (
code integer NOT NULL,
sku character varying(32),
sku_related character varying(32),
type character varying(32) DEFAULT ''::character varying NOT NULL
);
 
 
 
 
CREATE SEQUENCE merchandising_products_code_seq
START WITH 1
INCREMENT BY 1
NO MAXVALUE
NO MINVALUE
CACHE 1;
 
 
 
 
ALTER SEQUENCE merchandising_products_code_seq OWNED BY merchandising_products.code;
 
 
 
SELECT pg_catalog.setval('merchandising_products_code_seq', 1, false);
 
 
 
CREATE TABLE navigation (
code integer NOT NULL,
uri character varying(255) DEFAULT ''::character varying NOT NULL,
type character varying(32) DEFAULT ''::character varying NOT NULL,
scope character varying(32) DEFAULT ''::character varying NOT NULL,
name character varying(255) DEFAULT ''::character varying NOT NULL,
description text DEFAULT ''::text NOT NULL,
template character varying(255) DEFAULT ''::character varying NOT NULL,
text_language character varying(8) DEFAULT ''::character varying NOT NULL,
alias integer DEFAULT 0 NOT NULL,
parent integer DEFAULT 0 NOT NULL,
priority integer DEFAULT 0 NOT NULL,
product_count integer DEFAULT 0 NOT NULL,
active boolean DEFAULT true NOT NULL,
entered timestamp without time zone DEFAULT now()
);
 
 
 
 
CREATE SEQUENCE navigation_code_seq
START WITH 1
INCREMENT BY 1
NO MAXVALUE
NO MINVALUE
CACHE 1;
 
 
 
 
ALTER SEQUENCE navigation_code_seq OWNED BY navigation.code;
 
 
 
SELECT pg_catalog.setval('navigation_code_seq', 1, false);
 
 
 
CREATE TABLE navigation_products (
sku character varying(32) NOT NULL,
navigation integer NOT NULL,
type character varying(16) DEFAULT ''::character varying NOT NULL
);
 
 
 
 
CREATE TABLE orderlines (
code integer NOT NULL,
order_number character varying(24) NOT NULL,
order_position integer DEFAULT 0 NOT NULL,
sku character varying(32) NOT NULL,
name character varying(255) DEFAULT ''::character varying NOT NULL,
short_description character varying(500) DEFAULT ''::character varying NOT NULL,
description text DEFAULT ''::text NOT NULL,
weight numeric DEFAULT 0.0 NOT NULL,
quantity integer,
shipping_method character varying(255) DEFAULT ''::character varying NOT NULL,
shipping_code character varying(255) DEFAULT ''::character varying NOT NULL,
price numeric(10,2) DEFAULT 0 NOT NULL,
subtotal numeric(11,2) DEFAULT 0 NOT NULL,
shipping numeric(11,2) DEFAULT 0 NOT NULL,
handling numeric(11,2) DEFAULT 0 NOT NULL,
salestax numeric(11,2) DEFAULT 0 NOT NULL,
status character varying(24) DEFAULT ''::character varying NOT NULL
);
 
 
 
 
CREATE SEQUENCE orderlines_code_seq
START WITH 1
INCREMENT BY 1
NO MAXVALUE
NO MINVALUE
CACHE 1;
 
 
 
 
ALTER SEQUENCE orderlines_code_seq OWNED BY orderlines.code;
 
 
 
SELECT pg_catalog.setval('orderlines_code_seq', 1, false);
 
 
 
CREATE TABLE orderlines_shipping (
orderlines_code integer NOT NULL,
shipping_address integer NOT NULL
);
 
 
 
 
CREATE TABLE orders (
code integer NOT NULL,
order_number character varying(24) NOT NULL,
order_date timestamp without time zone,
user_id integer DEFAULT 0 NOT NULL,
email character varying(255) DEFAULT ''::character varying NOT NULL,
billing_address integer NOT NULL,
weight numeric DEFAULT 0.0 NOT NULL,
payment_method character varying(255) DEFAULT ''::character varying NOT NULL,
payment_code character varying(255) DEFAULT ''::character varying NOT NULL,
payment_status character varying(255) DEFAULT ''::character varying NOT NULL,
shipping_method character varying(255) DEFAULT ''::character varying NOT NULL,
shipping_code character varying(255) DEFAULT ''::character varying NOT NULL,
subtotal numeric(11,2) DEFAULT 0 NOT NULL,
shipping numeric(11,2) DEFAULT 0 NOT NULL,
handling numeric(11,2) DEFAULT 0 NOT NULL,
salestax numeric(11,2) DEFAULT 0 NOT NULL,
total_cost numeric(11,2) DEFAULT 0 NOT NULL,
status character varying(24) DEFAULT ''::character varying NOT NULL
);
 
 
 
 
CREATE SEQUENCE orders_code_seq
START WITH 1
INCREMENT BY 1
NO MAXVALUE
NO MINVALUE
CACHE 1;
 
 
 
 
ALTER SEQUENCE orders_code_seq OWNED BY orders.code;
 
 
 
SELECT pg_catalog.setval('orders_code_seq', 1, false);
 
 
 
CREATE TABLE payment_orders (
code integer NOT NULL,
payment_mode character varying(32) DEFAULT ''::character varying NOT NULL,
payment_action character varying(32) DEFAULT ''::character varying NOT NULL,
payment_id character varying(32) DEFAULT ''::character varying NOT NULL,
auth_code character varying(255) DEFAULT ''::character varying NOT NULL,
session_id character varying(255) DEFAULT ''::character varying NOT NULL,
order_number character varying(24) NOT NULL,
amount numeric(11,2) DEFAULT 0 NOT NULL,
status character varying(32) DEFAULT ''::character varying NOT NULL,
payment_session_id character varying(255) DEFAULT ''::character varying NOT NULL,
payment_error_code character varying(32) DEFAULT ''::character varying NOT NULL,
payment_error_message text DEFAULT ''::text NOT NULL,
created timestamp without time zone,
last_modified timestamp without time zone
);
 
 
 
 
CREATE SEQUENCE payment_orders_code_seq
START WITH 1
INCREMENT BY 1
NO MAXVALUE
NO MINVALUE
CACHE 1;
 
 
 
 
ALTER SEQUENCE payment_orders_code_seq OWNED BY payment_orders.code;
 
 
 
SELECT pg_catalog.setval('payment_orders_code_seq', 1, false);
 
 
 
CREATE TABLE permissions (
role_id integer NOT NULL,
perm character varying(255) DEFAULT ''::character varying NOT NULL
);
 
 
 
 
CREATE TABLE product_attributes (
code integer NOT NULL,
sku character varying(32) NOT NULL,
name character varying(32) NOT NULL,
value text DEFAULT ''::text NOT NULL,
original_sku character varying(32) DEFAULT ''::character varying NOT NULL
);
 
 
 
 
CREATE SEQUENCE product_attributes_code_seq
START WITH 1
INCREMENT BY 1
NO MAXVALUE
NO MINVALUE
CACHE 1;
 
 
 
 
ALTER SEQUENCE product_attributes_code_seq OWNED BY product_attributes.code;
 
 
 
SELECT pg_catalog.setval('product_attributes_code_seq', 1, false);
 
 
 
CREATE TABLE product_classes (
sku_class character varying(32) NOT NULL,
manufacturer character varying(128) DEFAULT ''::character varying NOT NULL,
name character varying(255) DEFAULT ''::character varying NOT NULL,
short_description character varying(255) DEFAULT ''::character varying NOT NULL,
uri character varying(500) DEFAULT ''::character varying NOT NULL,
active boolean DEFAULT true NOT NULL
);
 
 
 
 
CREATE TABLE products (
sku character varying(32) NOT NULL,
sku_class character varying(32) NOT NULL,
name character varying(255) DEFAULT ''::character varying NOT NULL,
short_description character varying(500) DEFAULT ''::character varying NOT NULL,
description text DEFAULT ''::text NOT NULL,
price numeric(10,2) DEFAULT 0 NOT NULL,
uri character varying(255) DEFAULT ''::character varying NOT NULL,
weight numeric DEFAULT 0.0 NOT NULL,
priority integer DEFAULT 0 NOT NULL,
gtin character varying(32) DEFAULT ''::character varying NOT NULL,
canonical_sku character varying(32) DEFAULT ''::character varying NOT NULL,
active boolean DEFAULT true NOT NULL
);
 
 
 
 
CREATE TABLE products_x_attributes (
sku character varying(32) NOT NULL,
attribute integer NOT NULL
);
 
 
 
 
CREATE TABLE roles (
role_id integer NOT NULL,
name character varying(32) NOT NULL,
label character varying(255) NOT NULL
);
 
 
 
 
CREATE SEQUENCE roles_role_id_seq
START WITH 1
INCREMENT BY 1
NO MAXVALUE
NO MINVALUE
CACHE 1;
 
 
 
 
ALTER SEQUENCE roles_role_id_seq OWNED BY roles.role_id;
 
 
 
SELECT pg_catalog.setval('roles_role_id_seq', 1, false);
 
 
 
CREATE TABLE sessions (
code character varying(255) NOT NULL,
session_data text NOT NULL,
session_hash text NOT NULL,
created timestamp without time zone NOT NULL,
modified timestamp without time zone DEFAULT now() NOT NULL
);
 
 
 
 
CREATE TABLE settings (
code integer NOT NULL,
scope character varying(32) NOT NULL,
site character varying(32) DEFAULT ''::character varying NOT NULL,
name character varying(32) NOT NULL,
value text NOT NULL,
category character varying(32) DEFAULT ''::character varying NOT NULL
);
 
 
 
 
CREATE SEQUENCE settings_code_seq
START WITH 1
INCREMENT BY 1
NO MAXVALUE
NO MINVALUE
CACHE 1;
 
 
 
 
ALTER SEQUENCE settings_code_seq OWNED BY settings.code;
 
 
 
SELECT pg_catalog.setval('settings_code_seq', 1, false);
 
 
 
CREATE TABLE user_attributes (
code integer NOT NULL,
user_id integer NOT NULL,
name character varying(32) NOT NULL,
value text DEFAULT ''::text NOT NULL
);
 
 
 
 
CREATE SEQUENCE user_attributes_code_seq
START WITH 1
INCREMENT BY 1
NO MAXVALUE
NO MINVALUE
CACHE 1;
 
 
 
 
ALTER SEQUENCE user_attributes_code_seq OWNED BY user_attributes.code;
 
 
 
SELECT pg_catalog.setval('user_attributes_code_seq', 1, false);
 
 
 
CREATE TABLE user_roles (
user_id integer DEFAULT 0 NOT NULL,
role_id integer DEFAULT 0 NOT NULL
);
 
 
 
 
CREATE TABLE users (
user_id integer NOT NULL,
username character varying(255) NOT NULL,
email character varying(255) DEFAULT ''::character varying NOT NULL,
password character varying(255) DEFAULT ''::character varying NOT NULL,
first_name character varying(255) DEFAULT ''::character varying NOT NULL,
last_name character varying(255) DEFAULT ''::character varying NOT NULL,
last_login timestamp without time zone NOT NULL,
created timestamp without time zone NOT NULL,
modified timestamp without time zone NOT NULL,
active boolean DEFAULT true NOT NULL
);
 
 
 
 
CREATE SEQUENCE users_user_id_seq
START WITH 1
INCREMENT BY 1
NO MAXVALUE
NO MINVALUE
CACHE 1;
 
 
 
 
ALTER SEQUENCE users_user_id_seq OWNED BY users.user_id;
 
 
 
SELECT pg_catalog.setval('users_user_id_seq', 1, false);
 
 
 
ALTER TABLE ONLY addresses ALTER COLUMN address_id SET DEFAULT nextval('addresses_address_id_seq'::regclass);
 
 
 
ALTER TABLE ONLY carts ALTER COLUMN code SET DEFAULT nextval('carts_code_seq'::regclass);
 
 
 
ALTER TABLE ONLY group_pricing ALTER COLUMN code SET DEFAULT nextval('group_pricing_code_seq'::regclass);
 
 
 
ALTER TABLE ONLY media ALTER COLUMN code SET DEFAULT nextval('media_code_seq'::regclass);
 
 
 
ALTER TABLE ONLY media_display ALTER COLUMN code SET DEFAULT nextval('media_display_code_seq'::regclass);
 
 
 
ALTER TABLE ONLY media_products ALTER COLUMN code SET DEFAULT nextval('media_products_code_seq'::regclass);
 
 
 
ALTER TABLE ONLY media_types ALTER COLUMN code SET DEFAULT nextval('media_types_code_seq'::regclass);
 
 
 
ALTER TABLE ONLY merchandising_attributes ALTER COLUMN code SET DEFAULT nextval('merchandising_attributes_code_seq'::regclass);
 
 
 
ALTER TABLE ONLY merchandising_products ALTER COLUMN code SET DEFAULT nextval('merchandising_products_code_seq'::regclass);
 
 
 
ALTER TABLE ONLY navigation ALTER COLUMN code SET DEFAULT nextval('navigation_code_seq'::regclass);
 
 
 
ALTER TABLE ONLY orderlines ALTER COLUMN code SET DEFAULT nextval('orderlines_code_seq'::regclass);
 
 
 
ALTER TABLE ONLY orders ALTER COLUMN code SET DEFAULT nextval('orders_code_seq'::regclass);
 
 
 
ALTER TABLE ONLY payment_orders ALTER COLUMN code SET DEFAULT nextval('payment_orders_code_seq'::regclass);
 
 
 
ALTER TABLE ONLY product_attributes ALTER COLUMN code SET DEFAULT nextval('product_attributes_code_seq'::regclass);
 
 
 
ALTER TABLE ONLY roles ALTER COLUMN role_id SET DEFAULT nextval('roles_role_id_seq'::regclass);
 
 
 
ALTER TABLE ONLY settings ALTER COLUMN code SET DEFAULT nextval('settings_code_seq'::regclass);
 
 
 
ALTER TABLE ONLY user_attributes ALTER COLUMN code SET DEFAULT nextval('user_attributes_code_seq'::regclass);
 
 
 
ALTER TABLE ONLY users ALTER COLUMN user_id SET DEFAULT nextval('users_user_id_seq'::regclass);
 
 
 
COPY media_types (code, type, scope) FROM stdin;
1 detail store
2 thumb store
3 cart store
\.
 
 
 
 
COPY permissions (role_id, perm) FROM stdin;
1 anonymous
2 authenticated
\.
 
 
 
COPY roles (role_id, name, label) FROM stdin;
1 anonymous Anonymous Users
2 authenticated Authenticated Users
\.
 
 
 
ALTER TABLE ONLY addresses
ADD CONSTRAINT addresses_pkey PRIMARY KEY (address_id);
 
 
 
ALTER TABLE ONLY carts
ADD CONSTRAINT carts_pkey PRIMARY KEY (code);
 
 
 
ALTER TABLE ONLY group_pricing
ADD CONSTRAINT group_pricing_pkey PRIMARY KEY (code);
 
 
 
ALTER TABLE ONLY inventory
ADD CONSTRAINT inventory_pkey PRIMARY KEY (sku);
 
 
 
ALTER TABLE ONLY media_display
ADD CONSTRAINT media_display_pkey PRIMARY KEY (code);
 
 
 
ALTER TABLE ONLY media
ADD CONSTRAINT media_pkey PRIMARY KEY (code);
 
 
 
ALTER TABLE ONLY media_products
ADD CONSTRAINT media_products_pkey PRIMARY KEY (code);
 
 
 
ALTER TABLE ONLY media_types
ADD CONSTRAINT media_types_pkey PRIMARY KEY (code);
 
 
 
ALTER TABLE ONLY media_types
ADD CONSTRAINT media_types_type_key UNIQUE (type, scope);
 
 
 
ALTER TABLE ONLY merchandising_attributes
ADD CONSTRAINT merchandising_attributes_pkey PRIMARY KEY (code);
 
 
 
ALTER TABLE ONLY merchandising_products
ADD CONSTRAINT merchandising_products_pkey PRIMARY KEY (code);
 
 
 
ALTER TABLE ONLY navigation
ADD CONSTRAINT navigation_pkey PRIMARY KEY (code);
 
 
 
ALTER TABLE ONLY navigation_products
ADD CONSTRAINT navigation_products_pkey PRIMARY KEY (sku, navigation);
 
 
 
ALTER TABLE ONLY navigation
ADD CONSTRAINT navigation_uri_key UNIQUE (uri);
 
 
 
ALTER TABLE ONLY orderlines
ADD CONSTRAINT orderlines_pkey PRIMARY KEY (code);
 
 
 
ALTER TABLE ONLY orderlines_shipping
ADD CONSTRAINT orderlines_shipping_pkey PRIMARY KEY (orderlines_code, shipping_address);
 
 
 
ALTER TABLE ONLY orders
ADD CONSTRAINT orders_order_number_key UNIQUE (order_number);
 
 
 
ALTER TABLE ONLY orders
ADD CONSTRAINT orders_pkey PRIMARY KEY (code);
 
 
 
ALTER TABLE ONLY payment_orders
ADD CONSTRAINT payment_orders_pkey PRIMARY KEY (code);
 
 
 
ALTER TABLE ONLY product_attributes
ADD CONSTRAINT product_attributes_pkey PRIMARY KEY (code);
 
 
 
ALTER TABLE ONLY product_classes
ADD CONSTRAINT product_classes_pkey PRIMARY KEY (sku_class);
 
 
 
ALTER TABLE ONLY products
ADD CONSTRAINT products_pkey PRIMARY KEY (sku);
 
 
 
ALTER TABLE ONLY products_x_attributes
ADD CONSTRAINT products_x_attributes_pkey PRIMARY KEY (sku, attribute);
 
 
 
ALTER TABLE ONLY roles
ADD CONSTRAINT roles_pkey PRIMARY KEY (role_id);
 
 
 
ALTER TABLE ONLY sessions
ADD CONSTRAINT sessions_pkey PRIMARY KEY (code);
 
 
 
ALTER TABLE ONLY settings
ADD CONSTRAINT settings_pkey PRIMARY KEY (code);
 
 
 
ALTER TABLE ONLY user_attributes
ADD CONSTRAINT user_attributes_pkey PRIMARY KEY (code);
 
 
 
ALTER TABLE ONLY user_roles
ADD CONSTRAINT user_roles_pkey PRIMARY KEY (user_id, role_id);
 
 
 
ALTER TABLE ONLY users
ADD CONSTRAINT users_pkey PRIMARY KEY (user_id);
 
 
 
CREATE INDEX cart_products_cart_sku_ix ON cart_products USING btree (cart, sku);
 
 
 
CREATE INDEX group_pricing_sku_ix ON group_pricing USING btree (sku);
 
 
 
CREATE INDEX media_display_sku_ix ON media_display USING btree (sku);
 
 
 
CREATE INDEX media_products_sku_ix ON media_products USING btree (sku);
 
 
 
CREATE INDEX orderlines_order_number_ix ON orderlines USING btree (order_number);
 
 
 
CREATE INDEX payment_orders_order_number_ix ON payment_orders USING btree (order_number);
 
 
 
CREATE INDEX product_attributes_sku_ix ON product_attributes USING btree (sku);
 
 
 
CREATE INDEX settings_scope_ix ON settings USING btree (scope);
 
 
 
CREATE INDEX user_attributes_user_id ON user_attributes USING btree (user_id);
 
 
 
ALTER TABLE ONLY addresses
ADD CONSTRAINT addresses_users_fk FOREIGN KEY (user_id) REFERENCES users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;
 
 
 
ALTER TABLE ONLY cart_products
ADD CONSTRAINT cart_products_carts_fk FOREIGN KEY (cart) REFERENCES carts(code) ON UPDATE CASCADE ON DELETE CASCADE;
 
 
 
ALTER TABLE ONLY cart_products
ADD CONSTRAINT cart_products_products_fk FOREIGN KEY (sku) REFERENCES products(sku) ON UPDATE CASCADE ON DELETE CASCADE;
 
 
 
ALTER TABLE ONLY group_pricing
ADD CONSTRAINT group_pricing_products_fk FOREIGN KEY (sku) REFERENCES products(sku) ON UPDATE CASCADE ON DELETE CASCADE;
 
 
 
ALTER TABLE ONLY group_pricing
ADD CONSTRAINT group_pricing_roles_fk FOREIGN KEY (role_id) REFERENCES roles(role_id) ON UPDATE CASCADE ON DELETE CASCADE;
 
 
 
ALTER TABLE ONLY inventory
ADD CONSTRAINT inventory_products_fk FOREIGN KEY (sku) REFERENCES products(sku) ON UPDATE CASCADE ON DELETE CASCADE;
 
 
 
ALTER TABLE ONLY media_display
ADD CONSTRAINT media_display_products_fk FOREIGN KEY (sku) REFERENCES products(sku) ON UPDATE CASCADE ON DELETE CASCADE;
 
 
 
ALTER TABLE ONLY media_products
ADD CONSTRAINT media_products_products_fk FOREIGN KEY (sku) REFERENCES products(sku) ON UPDATE CASCADE ON DELETE CASCADE;
 
 
 
ALTER TABLE ONLY merchandising_products
ADD CONSTRAINT merchandising_products_products_fk FOREIGN KEY (sku) REFERENCES products(sku) ON UPDATE CASCADE ON DELETE CASCADE;
 
 
 
ALTER TABLE ONLY merchandising_products
ADD CONSTRAINT merchandising_products_related_products_fk FOREIGN KEY (sku_related) REFERENCES products(sku) ON UPDATE CASCADE ON DELETE CASCADE;
 
 
 
ALTER TABLE ONLY navigation_products
ADD CONSTRAINT navigation_products_products_fk FOREIGN KEY (sku) REFERENCES products(sku) ON UPDATE CASCADE ON DELETE CASCADE;
 
 
 
ALTER TABLE ONLY orderlines
ADD CONSTRAINT orderlines_orders_fk FOREIGN KEY (order_number) REFERENCES orders(order_number) ON UPDATE CASCADE ON DELETE CASCADE;
 
 
 
ALTER TABLE ONLY orderlines
ADD CONSTRAINT orderlines_products_fk FOREIGN KEY (sku) REFERENCES products(sku) ON UPDATE CASCADE ON DELETE CASCADE;
 
 
 
ALTER TABLE ONLY orderlines_shipping
ADD CONSTRAINT orderlines_shipping_addresses_fk FOREIGN KEY (shipping_address) REFERENCES addresses(address_id) ON UPDATE CASCADE ON DELETE CASCADE;
 
 
 
ALTER TABLE ONLY orderlines_shipping
ADD CONSTRAINT orderlines_shipping_orderlines_fk FOREIGN KEY (orderlines_code) REFERENCES orderlines(code) ON UPDATE CASCADE ON DELETE CASCADE;
 
 
 
ALTER TABLE ONLY orders
ADD CONSTRAINT orders_billing_address_fk FOREIGN KEY (billing_address) REFERENCES addresses(address_id) ON UPDATE CASCADE ON DELETE CASCADE;
 
 
 
ALTER TABLE ONLY payment_orders
ADD CONSTRAINT payment_orders_fk FOREIGN KEY (order_number) REFERENCES orders(order_number) ON UPDATE CASCADE ON DELETE CASCADE;
 
 
 
ALTER TABLE ONLY permissions
ADD CONSTRAINT permissions_roles_fk FOREIGN KEY (role_id) REFERENCES roles(role_id) ON UPDATE CASCADE ON DELETE CASCADE;
 
 
 
ALTER TABLE ONLY product_attributes
ADD CONSTRAINT product_attributes_products_fk FOREIGN KEY (sku) REFERENCES products(sku) ON UPDATE CASCADE ON DELETE CASCADE;
 
 
 
ALTER TABLE ONLY products
ADD CONSTRAINT products_product_classes_fk FOREIGN KEY (sku_class) REFERENCES product_classes(sku_class) ON UPDATE CASCADE ON DELETE CASCADE;
 
 
 
ALTER TABLE ONLY products_x_attributes
ADD CONSTRAINT products_x_attributes_product_attributes_fk FOREIGN KEY (attribute) REFERENCES product_attributes(code) ON UPDATE CASCADE ON DELETE CASCADE;
 
 
 
ALTER TABLE ONLY products_x_attributes
ADD CONSTRAINT products_x_attributes_products_fk FOREIGN KEY (sku) REFERENCES products(sku) ON UPDATE CASCADE ON DELETE CASCADE;
 
 
 
ALTER TABLE ONLY user_attributes
ADD CONSTRAINT user_attributes_users_fk FOREIGN KEY (user_id) REFERENCES users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;
 
 
 
ALTER TABLE ONLY user_roles
ADD CONSTRAINT user_roles_roles_fk FOREIGN KEY (role_id) REFERENCES roles(role_id) ON UPDATE CASCADE ON DELETE CASCADE;
 
 
 
ALTER TABLE ONLY user_roles
ADD CONSTRAINT user_roles_users_fk FOREIGN KEY (user_id) REFERENCES users(user_id) ON UPDATE CASCADE ON DELETE CASCADE;
