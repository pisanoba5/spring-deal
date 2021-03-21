package com.pjt.deal.service;

import java.util.HashMap;
import java.util.List;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pjt.deal.dao.CityDAO;
import com.pjt.deal.dto.CityDTO;

@Service
public class CityService {
protected final Logger logger = LoggerFactory.getLogger(CityService.class);
	
	@Autowired
	CityDAO cityDAO;
	
	@Transactional
	public HashMap<String, Object> getCity(String city) throws Exception{
		
		logger.debug("==================== getCity START ====================");
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		List<CityDTO> list = cityDAO.getCity(city);
		resultMap.put("list", list);
		logger.debug("==================== getCity END ====================");
		return resultMap;
	}
}
