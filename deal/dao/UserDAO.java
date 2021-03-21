package com.pjt.deal.dao;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.pjt.deal.dto.UserDTO;

@Repository
public class UserDAO {

	@Resource(name = "sqlSession")
    private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.pjt.deal.mainMapper";
	
	public UserDTO join(String userID) throws Exception {
		return sqlSession.selectOne(NAMESPACE + ".join", userID);
	}
	public int userRegisterCheck(String userID) throws Exception {
		return sqlSession.selectOne(NAMESPACE + ".userRegisterCheck", userID);
	}
	public int userRegister(UserDTO userDTO) throws Exception {
		return sqlSession.insert(NAMESPACE + ".userRegister", userDTO);
	}
	public UserDTO getUser(String userID) throws Exception {
		return sqlSession.selectOne(NAMESPACE + ".getUser", userID);
	}
	public int setModify(UserDTO userDTO) throws Exception{
		return sqlSession.update(NAMESPACE + ".setModify", userDTO);
	}
}
