package com.pjt.deal.service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pjt.deal.dao.ChatDAO;
import com.pjt.deal.dto.ChatDTO;

@Service
public class ChatService {

protected final Logger logger = LoggerFactory.getLogger(ChatService.class);
	
	@Autowired
	ChatDAO chatDAO;
	
	@Transactional
	public int chatSubmit(ChatDTO chatDTO) throws Exception{
		
		logger.debug("==================== chatSubmit START ====================");
		int result = 0;
		result = chatDAO.chatSubmit(chatDTO);
		logger.debug("==================== chatSubmit END ====================");
		return result;
	}
	
	@Transactional
	public HashMap<String, Object> chatList(HashMap<String,Object> map) throws Exception{
		logger.debug("==================== chatList START ====================");
		int time=0;
		String ap="";
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		chatDAO.readChat(map);
		List<ChatDTO> list = chatDAO.getChatListByRecent(map);
		for(int i=0;i<list.size();i++) {
			time = Integer.parseInt(list.get(i).getChatTIme().substring(11,13));
			ap = "오전";
			if(time > 12) {
				ap = "오후";
				time -= 12;
			}
			list.get(i).setChatTIme(list.get(i).getChatTIme().substring(0,11) + " " + ap + " " + time + ":" + list.get(i).getChatTIme().substring(14,16) + "");
		}
		String lastID = chatDAO.getLastChatID(map);
		resultMap.put("list", list);
		resultMap.put("lastID", lastID);
		logger.debug("==================== chatList END ====================");
		return  resultMap;
	}
	
	@Transactional
	public int chatUnRead(String userID) throws Exception{
		logger.debug("==================== chatUnRead START ====================");
		int result = 0;
		result = chatDAO.getAllUnReadChat(userID);
		logger.debug("==================== chatUnRead END ====================");
		return result;
	}
	
	@Transactional
	public HashMap<String, Object> chatBox(String userID) throws Exception{
		logger.debug("==================== getBox START ====================");
		int time=0;
		String ap="";
		HashMap<String,Object> map = new HashMap<String,Object>();
		HashMap<String, Object> resultMap = new HashMap<String, Object>();
		//int UnRead = 0;
		List<ChatDTO> list = chatDAO.getBox(userID);
		for(int i=0;i<list.size();i++) {
			ChatDTO x = list.get(i);
			for(int j=0;j<list.size();j++) {
				ChatDTO y = list.get(j);
				if(x.getFromID().equals(y.getToID()) && x.getToID().equals(y.getFromID()) && x.getGoodsID() == y.getGoodsID()){
					if(x.getChatID() < y.getChatID()) {
//						if(y.getChatRead()==0) {
//							y.setUnRead(UnRead += 1);
//						}
						list.remove(x);
						i--;
						break;
					}else {
//						UnRead=0;
//						if(x.getChatRead()==0) {
//							x.setUnRead(UnRead += 1);
//						}
						list.remove(y);
					}
				}
			}
		}
		for(int i=0;i<list.size();i++) {
			time = Integer.parseInt(list.get(i).getChatTIme().substring(11,13));
			ap = "오전";
			if(time > 12) {
				ap = "오후";
				time -= 12;
			}
			list.get(i).setChatTIme(list.get(i).getChatTIme().substring(0,11) + " " + ap + " " + time + ":" + list.get(i).getChatTIme().substring(14,16) + "");
		}
//		List<ChatDTO> unRead = new ArrayList<ChatDTO>();
//		for(int i=0; i <list.size(); i++) {
//			map.put("goodsID",  list.get(i).getGoodsID());
//			map.put("userID",userID);
//			unRead.addAll(i, chatDAO.getUnRead(map));
//		}
		resultMap.put("list", list);
		//resultMap.put("unReadList", unRead);
		logger.debug("==================== getBox END ====================");
		return resultMap;
	}
	@Transactional
	public ChatDTO getUnRead(HttpServletRequest request) throws Exception{
		logger.debug("==================== getUnRead START ====================");
		int goodsID = Integer.parseInt(request.getParameter("goodsID"));
		String fromID = request.getParameter("fromID");
		String toID = request.getParameter("toID");
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("fromID",fromID);
		map.put("toID",toID);
		map.put("goodsID",goodsID);
		ChatDTO list = chatDAO.getUnRead(map);
		logger.debug("==================== getUnRead END ====================");
		return list;
	}
}
