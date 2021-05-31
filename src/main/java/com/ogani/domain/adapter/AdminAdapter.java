package com.ogani.domain.adapter;

import java.io.Serializable;
import java.util.Collections;

import org.springframework.security.core.SpringSecurityCoreVersion;
import org.springframework.security.core.authority.SimpleGrantedAuthority;
import org.springframework.security.core.userdetails.User;

import com.ogani.domain.AdminDTO;

import lombok.Getter;

@Getter
public class AdminAdapter extends User implements Serializable {
	private static final long serialVersionUID = SpringSecurityCoreVersion.SERIAL_VERSION_UID;
	private AdminDTO admin; 
	
	public AdminAdapter(AdminDTO admin) {
		super(admin.getAdmin_id(), admin.getAdmin_password(), Collections.singletonList(new SimpleGrantedAuthority(admin.getAdmin_role())));
		this.admin = admin;
	}
	
}