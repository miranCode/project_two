package org.zerock.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import org.zerock.dto.PowerDTO;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.time.LocalDate;
import java.time.Month;
import java.util.ArrayList;
import java.util.List;

@Service
public class ApiServiceImpl implements ApiService {

    @Autowired
    private RestTemplate restTemplate;  // RestTemplate 
    
    @Autowired
    private ObjectMapper objectMapper;  // Jackson ObjectMapper

    @Override
    public List<PowerDTO> getPower() {
        List<PowerDTO> responses = new ArrayList<>();

        LocalDate startDate = LocalDate.of(2021, 1, 1);  
        LocalDate endDate = LocalDate.of(2024, 10, 1);   

        LocalDate currentDate = startDate;

        while (!currentDate.isAfter(endDate)) {
            List<PowerDTO> monthlyData = callApiForMonth(currentDate.getYear(), currentDate.getMonthValue());
            responses.addAll(monthlyData);

            currentDate = currentDate.plusMonths(1);
        }

        return responses;
    }

    private List<PowerDTO> callApiForMonth(int year, int month) {
        // API URL
        String url = "https://bigdata.kepco.co.kr/openapi/v1/powerUsage/contractType.do?";

        // UriComponentsBuilder로 요청 URL 생성
        UriComponentsBuilder builder = UriComponentsBuilder.fromHttpUrl(url)
                .queryParam("year", year)
                .queryParam("month", String.format("%02d", month))
                .queryParam("apiKey", "3b0at94Q3P4z4zZd5A5tdV74uS9ikUglNPJX1E4a")
                .queryParam("returnType", "json");

        String requestUrl = builder.toUriString();
        System.out.println("Request URL: " + requestUrl); 

        // API 호출
        String response = restTemplate.getForObject(requestUrl, String.class);
        System.out.println("Response: " + response);  

        // JSON 응답을 PowerDTO 리스트로 변환
        List<PowerDTO> dataList = new ArrayList<>();
        try {
            JsonNode rootNode = objectMapper.readTree(response);
            JsonNode dataNode = rootNode.get("totData"); // "totData" 배열 가져오기
            System.out.println(">>>>>>>>>>>>>>"+ rootNode);
            System.out.println(">>>>>>>>>>>>>>"+ dataNode);
            // "data" 배열을 PowerDTO 객체로 변환하여 리스트에 추가
            if (dataNode.isArray()) {
                for (JsonNode node : dataNode) {
                    PowerDTO powerUsageData = objectMapper.treeToValue(node, PowerDTO.class);
                    dataList.add(powerUsageData);
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }

        return dataList;
    }
}
