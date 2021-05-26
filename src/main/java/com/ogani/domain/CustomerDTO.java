package com.ogani.domain;

import java.util.Date;

import lombok.Data;

@Data
public class CustomerDTO {

	private int cust_no;
	private String cust_id;
	private String cust_password;
	private String cust_name;
	private String cust_phone;
	private String cust_address;
	private String cust_email;
	private int cust_enabled;
	private Date cust_regdate;
	private Date cust_lastlogin;

}