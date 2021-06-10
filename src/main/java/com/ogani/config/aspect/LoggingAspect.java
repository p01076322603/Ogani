package com.ogani.config.aspect;

import java.util.Arrays;
import java.util.Map;
import java.util.stream.Collectors;

import javax.servlet.http.HttpServletRequest;

import org.apache.commons.io.IOUtils;
import org.aspectj.lang.ProceedingJoinPoint;
import org.aspectj.lang.annotation.Around;
import org.aspectj.lang.annotation.Aspect;
import org.aspectj.lang.annotation.Pointcut;
import org.springframework.stereotype.Component;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

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
		
		HttpServletRequest request = ((ServletRequestAttributes) RequestContextHolder.currentRequestAttributes()).getRequest();
		try {
			return joinPoint.proceed(joinPoint.getArgs());
		} finally {
			log.debug("Request: {} {}", joinPoint.getSignature().getName(), request.getMethod());
			
			boolean jsonParam = (request.getContentType() != null && (request.getContentType().equals("application/json") ||
																	  request.getContentType().equals("text/plain"))) ? true : false;
			
			if (jsonParam && IOUtils.toString(request.getReader()).length() > 0) {
				log.debug("Body: {}", IOUtils.toString(request.getReader()));
			}
			
			if (!jsonParam && request.getParameterMap().size() > 0)  {
				log.debug("Parameter: {}", paramMapToString(request.getParameterMap()));
			}
	
		}
		
	}

	private Object paramMapToString(Map<String, String[]> paramMap) {
		return paramMap.entrySet().stream()
				.map(entry -> String.format("%s: %s", entry.getKey(), Arrays.toString(entry.getValue())))
				.collect(Collectors.joining(", "));
	}
	
}