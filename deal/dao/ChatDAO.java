package com.pjt.deal.dao;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.pjt.deal.dto.ChatDTO;

@Repository
public class ChatDAO {

	@Resource(name = "sqlSession")
    private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.pjt.deal.mainMapper";
	
	public String getLastChatID(HashMap<String,Object> map) throws Exception {

		return sqlSession.selectOne(NAMESPACE + ".getLastChatID", map);
	}
	
	public List<ChatDTO> getChatListByRecent(HashMap<String,Object> map) throws Exception {

		return sqlSession.selectList(NAMESPACE + ".getChatListByRecent", map);
	}
	
	public int chatSubmit(ChatDTO chatDTO) throws Exception {

		return sqlSession.insert(NAMESPACE + ".chatSubmit", chatDTO);
	}
	
	public void readChat(HashMap<String,Object> map) throws Exception{
		sqlSession.update(NAMESPACE + ".readChat", map);
	}
	public int getAllUnReadChat(String userID) throws Exception{
		return sqlSession.selectOne(NAMESPACE + ".getAllUnReadChat", userID);
	}
	
	public List<ChatDTO> getBox(String userID) throws Exception {
		return sqlSession.selectList(NAMESPACE + ".getBox", userID);
	}
	public ChatDTO getUnRead(HashMap<String,Object> map) throws Exception {
		return sqlSession.selectOne(NAMESPACE + ".getUnRead", map);
	}
	
}
