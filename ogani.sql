CREATE USER ogani IDENTIFIED BY 1234;
GRANT CONNECT, RESOURCE, CREATE VIEW TO ogani;

DROP TABLE customer;

CREATE TABLE customer(	
    cust_no NUMBER(10,0) NOT NULL, 
	cust_id VARCHAR2(20), 
	cust_password VARCHAR2(100), 
	cust_name VARCHAR2(20 CHAR), 
	cust_phone VARCHAR2(13), 
	cust_address VARCHAR2(255), 
	cust_email VARCHAR2(255), 
	cust_enabled NUMBER(1),
	cust_regdate DATE,
    cust_lastlogin DATE,
    cust_auth VARCHAR2(10)
   );

SELECT * FROM customer;