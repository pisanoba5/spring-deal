package com.pjt.deal.dao;

import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.pjt.deal.dto.CityDTO;

@Repository
public class CityDAO {

	@Resource(name = "sqlSession")
    private SqlSession sqlSession;
	
private static final String NAMESPACE = "com.pjt.deal.mainMapper";
	
	public List<CityDTO> getCity(String city) throws Exception {
		return sqlSession.selectList(NAMESPACE + ".getCity", city);
	}
}
