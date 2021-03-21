package com.pjt.deal.service;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pjt.deal.dao.UserDAO;
import com.pjt.deal.dto.UserDTO;

@Service
public class UserService {
	
	protected final Logger logger = LoggerFactory.getLogger(UserService.class);
	
	@Autowired
	UserDAO userDAO;
	
	@Transactional
	public int userLogin(String userID, String userPassword) throws Exception{
		
		logger.debug("==================== login START ====================");
		UserDTO dto = userDAO.join(userID);
		logger.debug("==================== login END ====================");
		System.out.println(dto.getUserID());
		System.out.println(dto.getUserPassword());
		if(dto.getUserID() != null || dto.getUserID().equals("")) {
			if(dto.getUserPassword().equals(userPassword)) {
				return 1; // 로그인 성공
			}
			    return 2; // 비밀번호 실패
		}else {
			return 0; // 없는 아이디
		}
		
	}
	@Transactional
	public int userRegisterCheck(String userID) throws Exception{
		
		logger.debug("==================== registerCheck START ====================");
		int result = 0;
		result = userDAO.userRegisterCheck(userID);
		logger.debug("==================== registerCheck END ====================");
		if(result == 1) {
			return 0; //존재하는 아이디
		}else {
			return 1; //회원가입 가능한 아이디
		}
	}
	@Transactional
	public int userRegister(UserDTO userDTO) throws Exception{
		logger.debug("==================== register START ====================");
		logger.debug("==================== register END ====================");
		return userDAO.userRegister(userDTO);	
	}
	@Transactional
	public UserDTO getUser(String userID) throws Exception{
		logger.debug("==================== getUser START ====================");
		logger.debug("==================== getUser END ====================");
		return userDAO.getUser(userID);	
	}
	@Transactional
	public int setModify(UserDTO userDTO) throws Exception{
		logger.debug("==================== setModify START ====================");
		int result = userDAO.setModify(userDTO);
		logger.debug("==================== setModify END ====================");
		return result;
	}
}
