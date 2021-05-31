package com.ogani.domain;

import java.util.Date;

import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;
import lombok.ToString;

@Getter @Setter @ToString
@NoArgsConstructor
@AllArgsConstructor
@Builder
public class AdminDTO {

	private int admin_no;
	private String admin_id;
	private String admin_password;
	private String admin_name;
	private String admin_phone;
	private String admin_email;
	private String admin_image;
	private String admin_role;
	private int admin_enabled;
	private Date admin_lastlogin;
}
