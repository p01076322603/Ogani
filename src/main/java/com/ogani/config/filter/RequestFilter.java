package com.ogani.config.filter;

import java.io.IOException;

import javax.servlet.Filter;
import javax.servlet.FilterChain;
import javax.servlet.FilterConfig;
import javax.servlet.ServletException;
import javax.servlet.ServletRequest;
import javax.servlet.ServletResponse;
import javax.servlet.annotation.WebFilter;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.web.util.ContentCachingRequestWrapper;
import org.springframework.web.util.ContentCachingResponseWrapper;

@WebFilter(urlPatterns = "/*")
public class RequestFilter implements Filter { 
	@Override public void doFilter(ServletRequest request, ServletResponse response, FilterChain chain) 
			throws IOException, ServletException { 
		ContentCachingRequestWrapper requestWrapper = new ContentCachingRequestWrapper((HttpServletRequest) request);
		ContentCachingResponseWrapper responseWrapper = new ContentCachingResponseWrapper((HttpServletResponse) response);
		requestWrapper.setCharacterEncoding("UTF-8");
		responseWrapper.setCharacterEncoding("UTF-8");
		chain.doFilter(requestWrapper, responseWrapper);
		responseWrapper.copyBodyToResponse();
	}

	@Override
	public void init(FilterConfig filterConfig) throws ServletException {
	}

	@Override
	public void destroy() {
	} 
}