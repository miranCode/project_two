package org.zerock.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.zerock.dto.PowerDTO;
import org.zerock.service.ApiService;

@Controller
public class ApiController {

    @Autowired
    private ApiService apiService;  

    @GetMapping("/getApi")
    public String getPowerUsageForPeriod(Model model) {
        try {
            
            List<PowerDTO> responses = apiService.getPower();

            model.addAttribute("apiData", responses);

            return "home";  
        } catch (Exception e) {
            System.out.println("Error: " + e.getMessage()); 
            e.printStackTrace(); 
            
            model.addAttribute("error", "API 연결 에러."); 
            return "home";  
        }
    }
}
