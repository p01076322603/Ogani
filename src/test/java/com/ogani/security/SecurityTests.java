package com.ogani.security;

import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.sql.DataSource;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import com.ogani.config.RootConfig;
import com.ogani.config.security.SecurityConfig;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration(classes = { RootConfig.class, SecurityConfig.class })
public class SecurityTests {

	@Autowired
	private PasswordEncoder passwordEncoder;
	
	@Autowired
	private DataSource dataSource;
	
	// 하드코딩으로 회원 10명 생성 (테이블 제약조건 무시) // 
	@Test
	public void testInsertCustomer() {
		
		String sql = "INSERT INTO customer(cust_no, cust_id, cust_password, cust_enabled) "
				   + "VALUES(?, ?, ?, ?)";
		
		for (int i = 0; i < 10; i++) {
			
			Connection conn = null;
			PreparedStatement pstmt = null;
			
			try {
				conn = dataSource.getConnection();
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, i);
				pstmt.setString(2, "user" + i);
				pstmt.setString(3, passwordEncoder.encode("user" + i));
				pstmt.setInt(4, 1);
				pstmt.executeUpdate();
				
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				if (pstmt != null) { try { pstmt.close(); } catch (Exception e) {} }
				if (conn != null) { try { conn.close(); } catch (Exception e) {} }
			}
		}
	}
	
	@Test
	public void testEncode() {
		String str = "member";
		
		String enstr = passwordEncoder.encode(str);
		log.info(enstr);
	}
}
