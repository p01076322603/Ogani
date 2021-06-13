CREATE USER ogani IDENTIFIED BY 1234;
GRANT CONNECT, RESOURCE, CREATE VIEW TO ogani;

DROP TABLE customer;
CREATE TABLE customer (
	cust_no	        NUMBER(10)	      NOT NULL,
	cust_id	        VARCHAR2(20)	  NOT NULL UNIQUE,
	cust_password	VARCHAR2(100)	  NOT NULL,
	cust_name	    VARCHAR2(20 CHAR) NULL,
	cust_phone	    VARCHAR2(13)	  NOT NULL,
	cust_address	VARCHAR2(255)	  NULL,
	cust_email	    VARCHAR2(255)	  NOT NULL,
	cust_enabled	NUMBER(1)	      DEFAULT '1' NOT NULL,
	cust_regdate	DATE	          DEFAULT SYSDATE NOT NULL,
	cust_lastlogin	DATE	          NULL,
	cust_mailing	NUMBER(1)	      DEFAULT '0' NOT NULL
);

ALTER TABLE customer ADD cust_authkey VARCHAR2(50);
ALTER TABLE customer ADD cust_authstatus NUMBER(1) DEFAULT '0';

ALTER TABLE customer ADD CONSTRAINT customer_cust_no_PK 
PRIMARY KEY(cust_no);

DROP TABLE product;
CREATE TABLE product (
	prod_no	        NUMBER(10)		NOT NULL,
	cate_no	        NUMBER(5)		NOT NULL,
	prod_name	    VARCHAR2(50)	UNIQUE NOT NULL,
	prod_price	    NUMBER(10)	   	NOT NULL,
	prod_content	VARCHAR2(4000)	NOT NULL,
	prod_regdate	DATE		    DEFAULT SYSDATE NOT NULL,
	prod_stock	    NUMBER(10)		DEFAULT '0' NOT NULL,
	prod_salecount	NUMBER(10)		DEFAULT '0' NOT NULL,
	prod_display	NUMBER(1)		DEFAULT '1' NOT NULL 
);

ALTER TABLE product ADD CONSTRAINT product_prod_no_PK 
PRIMARY KEY(prod_no);

DROP TABLE product_category;
CREATE TABLE product_category (
	cate_no	      NUMBER(5)	   NOT NULL,
	cate_parentno NUMBER(5)	   NULL,
	cate_name	  VARCHAR2(50) UNIQUE NOT NULL
);

ALTER TABLE product_category ADD CONSTRAINT product_category_cate_no_PK 
PRIMARY KEY(cate_no);
ALTER TABLE product ADD CONSTRAINT product_cate_no_FK 
FOREIGN KEY(cate_no) REFERENCES product_category(cate_no);
ALTER TABLE product_category ADD CONSTRAINT product_cate_parentno_FK 
FOREIGN KEY(cate_parentno) REFERENCES product_category(cate_no);

DROP TABLE product_image;
CREATE TABLE product_image (
	prod_image_uuid	VARCHAR2(40) NOT NULL,
	prod_no	        NUMBER(10)   NOT NULL,
	prod_image_url	VARCHAR(255) NOT NULL,
	prod_image_name	VARCHAR(255) NOT NULL
);

ALTER TABLE product_image ADD CONSTRAINT prod_image_uuid_PK 
PRIMARY KEY(prod_image_uuid);
ALTER TABLE product_image ADD CONSTRAINT product_image_prod_no_FK
FOREIGN KEY(prod_no) REFERENCES product(prod_no);

DROP TABLE cart;
CREATE TABLE cart (
	cart_no 	  NUMBER(10) NOT NULL,
	cust_no	      NUMBER(10) NOT NULL,
	prod_no	      NUMBER(10) NOT NULL,
	cart_quantity NUMBER(10) NOT NULL
);

ALTER TABLE cart ADD CONSTRAINT cart_cart_no_PK
PRIMARY KEY(cart_no);
ALTER TABLE cart ADD CONSTRAINT cart_cust_no_FK
FOREIGN KEY(cust_no) REFERENCES customer(cust_no);
ALTER TABLE cart ADD CONSTRAINT cart_prod_no_FK
FOREIGN KEY(prod_no) REFERENCES product(prod_no);

DROP TABLE admin_info;
CREATE TABLE admin_info (
    admin_no        NUMBER(10)        NOT NULL,
	admin_id	    VARCHAR2(20)	  UNIQUE NOT NULL,
	admin_password	VARCHAR2(100)	  NOT NULL,
	admin_name	    VARCHAR2(20 CHAR) NOT NULL,
	admin_phone	    VARCHAR2(13)	  UNIQUE NOT NULL,
	admin_email	    VARCHAR2(255)	  UNIQUE NOT NULL,
	admin_image	    VARCHAR2(255)	  DEFAULT 'admin-default.jpg' NOT NULL,
	admin_role	    VARCHAR2(20)	  DEFAULT 'ROLE_ADMIN' NOT NULL,
	admin_enabled	NUMBER(1)		  DEFAULT '1' NOT NULL,
	admin_lastlogin	DATE		      DEFAULT SYSDATE NOT NULL
);

ALTER TABLE admin_info ADD CONSTRAINT admin_no_PK 
PRIMARY KEY(admin_no);

DROP TABLE order_info;
CREATE TABLE order_info (
	order_uid	        VARCHAR2(30)	  	NOT NULL,
	cust_no 	        NUMBER(10)		    NOT NULL,
    order_imp_uid       VARCHAR2(30)        UNIQUE NOT NULL,
	order_name	        VARCHAR2(255)		NOT NULL,
	order_regdate	    DATE		        DEFAULT SYSDATE NOT NULL,
	order_price 	    NUMBER(10)		    NOT NULL,
	order_card_approval NUMBER(10)		    NOT NULL,
	order_buyer	        VARCHAR2(20 CHAR)	NOT NULL,
	order_email	        VARCHAR2(255)		NOT NULL,
	order_postcode	    NUMBER(10)		    NOT NULL,
	order_address	    VARCHAR2(255)		NOT NULL,
	order_phone	        VARCHAR2(13)		NOT NULL,
	order_request	    VARCHAR2(4000)   	NULL
);

ALTER TABLE order_info ADD CONSTRAINT order_uid_PK 
PRIMARY KEY(order_uid);
ALTER TABLE order_info ADD CONSTRAINT order_cust_no_FK 
FOREIGN KEY(cust_no) REFERENCES customer(cust_no);

DROP TABLE order_detail;
CREATE TABLE order_detail (
	order_detail_no	        NUMBER(10)	  NOT NULL,
	prod_no	                NUMBER(10)	  NOT NULL,
	order_uid	            VARCHAR2(30)  NOT NULL,
	order_detail_quantity   NUMBER(10)	  NOT NULL
);

ALTER TABLE order_detail ADD order_detail_shipstatus NUMBER(1) DEFAULT '0';

ALTER TABLE order_detail ADD CONSTRAINT order_detail_no_PK 
PRIMARY KEY(order_detail_no);
ALTER TABLE order_detail ADD CONSTRAINT order_detail_order_uid_PK 
FOREIGN KEY(order_uid) REFERENCES order_info(order_uid);
ALTER TABLE order_detail ADD CONSTRAINT order_detail_prod_no_FK 
FOREIGN KEY(prod_no) REFERENCES product(prod_no);

DROP SEQUENCE seq_customer;
CREATE SEQUENCE seq_customer
START WITH 1
INCREMENT BY 1
NOCYCLE;

DROP SEQUENCE seq_product;
CREATE SEQUENCE seq_product
START WITH 1
INCREMENT BY 1
NOCYCLE;

DROP SEQUENCE seq_product_category;
CREATE SEQUENCE seq_product_category
START WITH 1
INCREMENT BY 1
NOCYCLE;

DROP SEQUENCE seq_cart;
CREATE SEQUENCE seq_cart
START WITH 1
INCREMENT BY 1
NOCYCLE;

DROP SEQUENCE seq_admin_info;
CREATE SEQUENCE seq_admin_info
START WITH 1
INCREMENT BY 1
NOCYCLE;

DROP SEQUENCE seq_order_detail;
CREATE SEQUENCE seq_order_detail
START WITH 1
INCREMENT BY 1
NOCYCLE;

INSERT INTO admin_info(admin_no, admin_id, admin_password, admin_name, admin_phone, admin_email)
VALUES(seq_admin_info.NEXTVAL, 'admin', '$2a$10$PDCTt4tZiIF9th8wYy71tOvQyiCLCR20gtPV2hR9/paHSePOxODCO', 'admin', '010-1234-5678', 'admin@email.com');