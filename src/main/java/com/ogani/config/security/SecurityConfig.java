package com.ogani.config.security;

import javax.sql.DataSource;

import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.authentication.AuthenticationProvider;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.core.userdetails.UserDetailsService;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.web.authentication.AuthenticationFailureHandler;
import org.springframework.security.web.authentication.AuthenticationSuccessHandler;

import lombok.RequiredArgsConstructor;

@Configuration
@EnableWebSecurity
@RequiredArgsConstructor
public class SecurityConfig extends WebSecurityConfigurerAdapter {
	
	private final DataSource dataSource;

	@Bean
	public PasswordEncoder passwordEncoder() { return new BCryptPasswordEncoder(); }

	@Bean
	public UserDetailsService customUserService() { return new CustomUserDetailsService(); }
	
	@Bean
	public AuthenticationFailureHandler CustomFailureHandler() { return new CustomFailureHandler(); }

	@Bean
	public AuthenticationSuccessHandler CustomSuccessHandler() { return new CustomSuccessHandler(); }
	
    @Bean
    public AuthenticationProvider authenticationProvider() { return new CustomAuthenticationProvider(); }
	
	@Override
	protected void configure(AuthenticationManagerBuilder auth) throws Exception {
		
		auth.authenticationProvider(authenticationProvider());
		auth.userDetailsService(customUserService()).passwordEncoder(passwordEncoder());
		auth.jdbcAuthentication().dataSource(dataSource).passwordEncoder(passwordEncoder())
    	.usersByUsernameQuery("SELECT cust_id, cust_password, cust_enabled "
			        		+ "FROM customer "
			        		+ "WHERE cust_id = ?")
    	.authoritiesByUsernameQuery("SELECT cust_id, cust_auth "
				        		  + "FROM customer "
				        		  + "WHERE cust_id = ?");
	}
	
	@Override
	protected void configure(HttpSecurity http) throws Exception {

		http.authorizeRequests()
				.antMatchers("/blog").access("hasRole('USER')")
				.antMatchers("/contact").access("hasRole('ADMIN')");

		http.formLogin()
				.loginPage("/login").failureHandler(CustomFailureHandler())
									.successHandler(CustomSuccessHandler());
		
		http.logout()
				.logoutUrl("/logout").invalidateHttpSession(true).deleteCookies("remember-me", "JSESSION_ID");
				
	}
}
