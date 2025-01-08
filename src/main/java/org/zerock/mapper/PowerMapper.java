package org.zerock.mapper;

import java.util.List;

import org.zerock.dto.PowerDTO;

public interface PowerMapper {
	
	public int insertPower(PowerDTO pdto);
	public int selectPower(PowerDTO pdto);
	public List<PowerDTO> selectList(PowerDTO pdto);
	public List<PowerDTO> selectCitytList(PowerDTO pdto);
	public List<PowerDTO> selectMetroList(PowerDTO pdto);
	public List<PowerDTO> selectMetro(PowerDTO pdto);
	public List<PowerDTO> selectCity(PowerDTO pdto);
	public List<PowerDTO> selectCntr(PowerDTO pdto);

}
