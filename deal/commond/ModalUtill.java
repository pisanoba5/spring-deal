package com.pjt.deal.commond;

import org.springframework.beans.factory.annotation.Autowired;

import com.pjt.deal.service.UserService;

public class ModalUtill {
	@Autowired
	UserService userService;

	public int modalCheck(String id, String password) throws Exception {
		String userID = id;
		String userPassword = password;
		int result;
		result = userService.userLogin(userID, userPassword);
		System.out.println(result);
		if(result == 1) {

			return 1;
		}else{

			return 0;
		}	
	}
}
