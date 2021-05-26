package com.ogani.mapper;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringRunner;

import com.ogani.config.RootConfig;
import com.ogani.config.security.SecurityConfig;
import com.ogani.domain.CustomerDTO;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@RunWith(SpringRunner.class)
@ContextConfiguration(classes = { RootConfig.class, SecurityConfig.class })
public class MemberMapperTests {
	
	@Autowired
	private MemberMapper mapper;
	
	@Test
	public void testSelectById() {
		CustomerDTO customer = mapper.selectById("user1");
		log.info("customer = {}", customer);
	}
}
