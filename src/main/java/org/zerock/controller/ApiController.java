package org.zerock.controller;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.zerock.dto.PowerDTO;
import org.zerock.service.ApiService;

import com.fasterxml.jackson.databind.ObjectMapper;

import java.util.ArrayList;
import java.util.List;

@Controller
public class ApiController {

    @Autowired
    private ApiService apiService;
    
    @GetMapping("/getApi")
    public String getApi() {
    	return "api/getApi";
    }
    
    @GetMapping("/getList")
    public String getList(PowerDTO pdto, Model model) {
    	try {
    		List<PowerDTO> responses = apiService.getList(pdto);
    		
            model.addAttribute("apiData", responses);
            model.addAttribute("apiDataSize", responses.size());
    	}catch (Exception e) {
    		e.printStackTrace(); // 예외를 로그로 출력
		}
    	return "api/getList";
    }
    
    @GetMapping("/getDataPage")
    public String getDataPage(@RequestParam(value = "type", required = false) String type, Model model, PowerDTO pdto) {
        // "type" 값을 모델에 추가하여 JSP에서 사용
    	
    	List<PowerDTO> metroName = apiService.getMetro(pdto);
    	List<PowerDTO> cityName = apiService.getCity(pdto);
    	System.out.println(cityName);
    	List<PowerDTO> cntrName = apiService.getCntr(pdto);
    	
        model.addAttribute("metroName", metroName);  
        model.addAttribute("cityName", cityName);  
        model.addAttribute("cntrName", cntrName);  
        
        return "api/getData";  // getData.jsp 페이지로 이동
    }


    @GetMapping("/getData")
    public ResponseEntity<List<PowerDTO>> getData(@RequestParam(value = "type", required = false) String type, PowerDTO pdto) {
        // "type" 값을 사용하여 데이터를 필터링할 수 있음
    	List<PowerDTO> apiData = null;
    	
    	if(type.equals("전체")) {
    		apiData = apiService.getList(pdto);  // 서비스에서 데이터 가져오기 (필터링된 데이터)
    	}else if (type.equals("시군구")) {
    		apiData = apiService.getCityList(pdto);  // 서비스에서 데이터 가져오기 (필터링된 데이터)
		}else if (type.equals("시도")) {
			apiData = apiService.getMetroList(pdto);  // 서비스에서 데이터 가져오기 (필터링된 데이터)
		}else {
			apiData = apiService.getList(pdto);  // 서비스에서 데이터 가져오기 (필터링된 데이터)
		}
        
        return ResponseEntity.ok(apiData);  // JSON 형식으로 응답 반환
    }

    @GetMapping("/getHome")
    public String getPowerUsageForPeriod(
        @RequestParam(value = "startYear", required = false) Integer startYear,
        @RequestParam(value = "startMonth", required = false) Integer startMonth,
        @RequestParam(value = "endYear", required = false) Integer endYear,
        @RequestParam(value = "endMonth", required = false) Integer endMonth,
        Model model) {
    	
    	System.out.println(startYear + "." + startMonth + "~" + endYear + "." + endMonth);
    	
    	try {
    		
    		List<PowerDTO> responses = apiService.getPower(startYear, startMonth, endYear, endMonth);
            
            model.addAttribute("apiData", responses);
            
    		return "home";
		} catch (Exception e) {
			e.printStackTrace(); // 예외를 로그로 출력
			return "home";
		}
    }
}
