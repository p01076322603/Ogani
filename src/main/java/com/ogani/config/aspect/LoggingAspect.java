package com.ogani.config.aspect;

import java.util.Arrays;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;
import org.springframework.web.util.ContentCachingRequestWrapper;

import com.fasterxml.jackson.databind.ObjectMapper;

import lombok.extern.slf4j.Slf4j;

// TODO: RESPONSE도 로깅하기

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
		
		HttpServletRequest req = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		ContentCachingRequestWrapper request = (ContentCachingRequestWrapper) req;
		
		try {
			return joinPoint.proceed(joinPoint.getArgs());
		} finally {
			log.debug("Request: {} {}", joinPoint.getSignature().getName(), request.getMethod());
			
			// REQUEST
			if (request.getContentType() != null && request.getContentType().contains("application/json")) {
				if (request.getContentAsByteArray() != null && request.getContentAsByteArray().length != 0){
	                log.debug("Request Body: {}", objectMapper.readTree(request.getContentAsByteArray()));
	            }
	        
			} else if (request.getContentType() != null && request.getContentType().contains("text/plain")) {
				log.debug("Request Body: {}", new String(request.getContentAsByteArray()));
			
			} else if (request.getParameterMap().size() > 0) {
				log.debug("Request Param: {}", paramMapToString(request.getParameterMap()));
			}
		}
	}
	
	private Object paramMapToString(Map<String, String[]> paramMap) {
		return paramMap.entrySet().stream()
				.map(entry -> String.format("%s: %s", entry.getKey(), Arrays.toString(entry.getValue())))
				.collect(Collectors.joining(", "));
	}
	
}