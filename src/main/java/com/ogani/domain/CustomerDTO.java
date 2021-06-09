package com.ogani.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

@Data @Builder
@AllArgsConstructor
@NoArgsConstructor
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
	private int cust_mailing;
	private String cust_authkey;
	private int cust_authstatus;
	
}
