package com.ogani.config.aspect;

import java.util.Arrays;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.util.ContentCachingRequestWrapper;
import org.springframework.web.util.ContentCachingResponseWrapper;

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

@Slf4j
@Aspect
@Component
public class LoggingAspect {

	@Pointcut("within(com.ogani.controller..*)")
	public void onRequest() {
	}
	
	@Around("com.ogani.config.aspect.LoggingAspect.onRequest()")
	public Object requestLogging(ProceedingJoinPoint joinPoint) throws Throwable {
		
		ObjectMapper objectMapper = new ObjectMapper();
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		HttpServletResponse response = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getResponse();
	
		ContentCachingRequestWrapper cachingRequest = (ContentCachingRequestWrapper) request;
		ContentCachingResponseWrapper cachingResponse = (ContentCachingResponseWrapper) response;
		
		try {
			return joinPoint.proceed(joinPoint.getArgs());
		} finally {
			log.debug("Request: {} {}", joinPoint.getSignature().getName(), cachingRequest.getMethod());
			
			// REQUEST
			if (cachingRequest.getContentType() != null && cachingRequest.getContentType().contains("application/json")) {
				if (cachingRequest.getContentAsByteArray() != null && cachingRequest.getContentAsByteArray().length != 0){
	                log.debug("Request Body : {}", objectMapper.readTree(cachingRequest.getContentAsByteArray()));
	            }
	        
			} else if (cachingRequest.getContentType() != null && cachingRequest.getContentType().contains("text/plain")) {
				log.debug("Request Body : {}", new String(cachingRequest.getContentAsByteArray()));
			
			} else if (cachingRequest.getParameterMap().size() > 0) {
				log.debug("Request : {}", paramMapToString(request.getParameterMap()));
			}

			// RESPONSE
			if (cachingResponse.getContentType() != null && cachingResponse.getContentType().contains("application/json")) {
	        	if (cachingResponse.getContentAsByteArray() != null && cachingResponse.getContentAsByteArray().length != 0) {
	                log.debug("Response Body : {}", objectMapper.readTree(cachingResponse.getContentAsByteArray()));
	            }
	        
			} else if (cachingResponse.getContentType() != null && cachingResponse.getContentType().contains("text/plain")) {
				log.debug("Request Body : {}", new String(cachingResponse.getContentAsByteArray()));
			}
		}
	}
	
	private Object paramMapToString(Map<String, String[]> paramMap) {
		return paramMap.entrySet().stream()
				.map(entry -> String.format("%s: %s", entry.getKey(), Arrays.toString(entry.getValue())))
				.collect(Collectors.joining(", "));
	}
	
}