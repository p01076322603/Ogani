CREATE USER ogani IDENTIFIED BY 1234;
GRANT CONNECT, RESOURCE, CREATE VIEW TO ogani;

DROP TABLE customer;

CREATE TABLE customer (
	cust_no	        NUMBER(10)	        NOT NULL,
	cust_id	        VARCHAR2(20)	    NOT NULL UNIQUE,
	cust_password	VARCHAR2(100)	    NOT NULL,
	cust_name	    VARCHAR2(20 CHAR)	NULL,
	cust_phone	    VARCHAR2(13)	    NOT NULL,
	cust_address	VARCHAR2(255)	    NULL,
	cust_email	    VARCHAR2(255)	    NOT NULL,
	cust_enabled	NUMBER(1)	        DEFAULT '1' NOT NULL,
	cust_regdate	DATE	            DEFAULT SYSDATE NOT NULL,
	cust_lastlogin	DATE	            NULL,
	cust_mailing	NUMBER(1)	        DEFAULT '0' NOT NULL
);

ALTER TABLE customer ADD CONSTRAINT customer_cust_no_PK PRIMARY KEY(cust_no);
CREATE SEQUENCE seq_cust_no
START WITH 1
INCREMENT BY 1
NOCYCLE;