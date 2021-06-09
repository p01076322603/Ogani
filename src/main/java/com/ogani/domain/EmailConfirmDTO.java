package com.ogani.domain;

import lombok.Getter;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
public class EmailConfirmDTO {

	private String cust_id;
	private String cust_email;
	private String cust_authkey;
}
