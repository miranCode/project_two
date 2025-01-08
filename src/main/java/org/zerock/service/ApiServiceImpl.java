package org.zerock.service;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.client.RestTemplate;
import org.springframework.web.util.UriComponentsBuilder;

import org.zerock.dto.PowerDTO;
import org.zerock.mapper.PowerMapper;

import com.fasterxml.jackson.databind.JsonNode;
import com.fasterxml.jackson.databind.ObjectMapper;

import java.time.LocalDate;
import java.util.ArrayList;
import java.util.List;

@Service
public class ApiServiceImpl implements ApiService {

    @Autowired
    private RestTemplate restTemplate;  // RestTemplate 
    
    @Autowired
    private ObjectMapper objectMapper;  
    
    @Autowired
    private PowerMapper powerMapper;

    @Override
    public List<PowerDTO> getPower(int startYear, int startMonth, int endYear, int endMonth){
        // 사용자 페이지에서 시작 년월 종료 년월 받고 
    	List<PowerDTO> responses = new ArrayList<>();

        LocalDate startDate = LocalDate.of(startYear, startMonth, 1);
        LocalDate endDate = LocalDate.of(endYear, endMonth, 1);
        System.out.println("시작일" + startDate + "종료일" + endDate);
        // API 호출을 통해 월별 데이터를 가져오기
        while (startDate.isBefore(endDate.plusMonths(1))) {
            List<PowerDTO> monthlyData = callApiForMonth(startDate.getYear(), startDate.getMonthValue());            
            responses.addAll(monthlyData);
            // 여러 데이터를 한 번에 저장
            savePowerData(monthlyData);  
            startDate = startDate.plusMonths(1);
        }
        
        return responses;
    }
    
    // api 로 받아온 데이터가 db에 없으면 저장하고 있으면 저장하지 않음 
    public void savePowerData(List<PowerDTO> monthlyData) {
        for (PowerDTO pdto : monthlyData) {
            int result = getPowerData(pdto);
            if (result == 0) {
                // 데이터가 없으면 저장
                int insertResult = powerMapper.insertPower(pdto);  // 각 PowerDTO 객체를 삽입
                System.out.println("삽입 결과: " + insertResult);  // 삽입 결과 출력
            } else {
                // 데이터가 이미 존재하면 저장하지 않음
                System.out.println("저장안함: 이미 존재하는 데이터입니다. 데이터는 삽입되지 않았습니다.");
            }
        }
    }

    // 기존 데이터 존재 여부 확인 
    public int getPowerData(PowerDTO pdto) {
        return powerMapper.selectPower(pdto);
    }
    
    
    public String listType(String type) {
    	return type;
    }
    
    // 저장된 데이터 출력 
    public List<PowerDTO> getList(PowerDTO pdto) {
    	return powerMapper.selectList(pdto);
    }
    
    public List<PowerDTO> getCityList(PowerDTO pdto) {
    	return powerMapper.selectCitytList(pdto);
    }
    
    public List<PowerDTO> getMetroList(PowerDTO pdto) {
    	return powerMapper.selectMetroList(pdto);
    }
    
    public List<PowerDTO> getMetro(PowerDTO pdto){
    	return powerMapper.selectMetro(pdto);
    }
    
    public List<PowerDTO> getCity(PowerDTO pdto){
    	return powerMapper.selectCity(pdto);
    }
    
    public List<PowerDTO> getCntr(PowerDTO pdto){
    	return powerMapper.selectCntr(pdto);
    }

    // api 연결 
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

        // response를 두 개의 JSON 객체로 나누어 각각 처리
        List<PowerDTO> dataList = new ArrayList<>();

        try {
            // JSON 데이터를 파싱하여 PowerDTO 객체로 변환
            JsonNode rootNode = objectMapper.readTree("[" + response.replace("}{", "},{") + "]");

            // "totData"와 "data"를 가져오기
            JsonNode totDataNode = rootNode.get(0).get("totData");
            JsonNode dataNode = rootNode.get(1).get("data");

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
