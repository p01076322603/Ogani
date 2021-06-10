package com.ogani.util;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;

@WebFilter(urlPatterns = "/*")
public class RequestFilter implements Filter { 
	@Override public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
			throws IOException, ServletException { 
		RereadableRequestWrapper rereadableRequestWrapper = new RereadableRequestWrapper((HttpServletRequest) request); 
		chain.doFilter(rereadableRequestWrapper, response); 
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
	}

	@Override
	public void destroy() {
	} 
}