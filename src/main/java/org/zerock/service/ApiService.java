package org.zerock.service;

import java.util.List;

import org.zerock.dto.PowerDTO;

public interface ApiService {
		
    
	List<PowerDTO> getPower(int startYear, int startMonth, int endYear, int enaMonth);
	
	String listType(String type); 

	List<PowerDTO> getList(PowerDTO pdto);
	
	List<PowerDTO> getCityList(PowerDTO pdto);
	
	List<PowerDTO> getMetroList(PowerDTO pdto);
	
	List<PowerDTO> getMetro(PowerDTO pdto);
	
	List<PowerDTO> getCity(PowerDTO pdto);
	
	List<PowerDTO> getCntr(PowerDTO pdto);
	
	 
}
