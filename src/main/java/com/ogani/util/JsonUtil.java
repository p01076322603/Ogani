package com.ogani.util;

import java.io.BufferedReader;

import javax.servlet.http.HttpServletRequest;

import org.json.JSONObject;

import lombok.extern.slf4j.Slf4j;

@Slf4j
public class JsonUtil {

    public JsonUtil() {
    }
    // json 형식으로 유입된 HttpServletRequest를 string 형태로 return
    public  JSONObject readJSONStringFromRequestBody(HttpServletRequest request){
        StringBuffer json = new StringBuffer();
        String line = null;

        try {
            BufferedReader reader = request.getReader();
            while((line = reader.readLine()) != null) {
                json.append(line);
            }

        }catch(Exception e) {
            log.warn("Error reading JSON string: " + e.toString());
        }

        JSONObject jObj = new JSONObject(json.toString());
        return jObj;
    }
}
