package com.pjt.deal.service;

import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import com.pjt.deal.dao.GoodsDAO;
import com.pjt.deal.dto.GoodsDTO;

@Service
public class GoodsService {
	
	protected final Logger logger = LoggerFactory.getLogger(GoodsService.class);
	
	@Autowired
	GoodsDAO goodsDAO;
	
	@Transactional
	public int setGoods(GoodsDTO goodsDTO) throws Exception{
		logger.debug("==================== setGoods START ====================");
		int result = goodsDAO.setGoods(goodsDTO);
		logger.debug("==================== setGoods END ====================");
		return result;
	}
	@Transactional
	public HashMap<String, Object> getNewGoodsList() throws Exception{
		logger.debug("==================== getNewGoodsList START ====================");
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<GoodsDTO> list = goodsDAO.getNewGoodsList();
		map.put("list",list);
		logger.debug("==================== getNewGoodsList END ====================");
		return map;
	}
	@Transactional
	public List<GoodsDTO> getAllNewGoodsList() throws Exception{
		logger.debug("==================== getAllNewGoodsList START ====================");
		List<GoodsDTO> list = goodsDAO.getAllNewGoodsList();
		logger.debug("==================== getAllNewGoodsList END ====================");
		return list;
	}
	@Transactional
	public GoodsDTO getGoods(HttpServletRequest request) throws Exception{
		logger.debug("==================== getGoods START ====================");
		HashMap<String, Object> map = new HashMap<String, Object>();
		int goodsID = Integer.parseInt(request.getParameter("goodsID"));
		String userID = request.getParameter("userID");
		map.put("goodsID",goodsID);
		map.put("userID",userID);
		GoodsDTO list = goodsDAO.getGoods(map);
		logger.debug("==================== getGoods END ====================");
		return list;
	}
	@Transactional
	public HashMap<String, Object> getMyGoods(String userID) throws Exception{
		logger.debug("==================== getMyGoods START ====================");
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<GoodsDTO> list = goodsDAO.getMyGoods(userID);
		map.put("list",list);
		logger.debug("==================== getMyGoods END ====================");
		return map;
	}
	@Transactional
	public GoodsDTO getModifyGoods(int goodsID) throws Exception{
		logger.debug("==================== getModifyGoods START ====================");
		GoodsDTO list = goodsDAO.getModifyGoods(goodsID);
		logger.debug("==================== getModifyGoods END ====================");
		return list;
	}
	@Transactional
	public int modifyGoods(GoodsDTO goodsDTO) throws Exception{
		logger.debug("==================== ModifyGoods START ====================");
		int result = goodsDAO.modifyGoods(goodsDTO);
		logger.debug("==================== ModifyGoods END ====================");
		return result;
	}
	@Transactional
	public int deleteGoods(int goodsID) throws Exception{
		logger.debug("==================== deleteGoods START ====================");
		int result = goodsDAO.deleteGoods(goodsID);
		logger.debug("==================== deleteGoods END ====================");
		return result;
	}
	@Transactional
	public List<GoodsDTO> getSearchGoodsName(String goodsID) throws Exception{
		logger.debug("==================== getSearchGoods START ====================");
		List<GoodsDTO> list = goodsDAO.getSearchGoodsName(goodsID);
		logger.debug("==================== getSearchGoods END ====================");
		return list;
	}
	@Transactional
	public List<GoodsDTO> getDetailSearchGoods(HashMap<String,Object> map) throws Exception{
		logger.debug("==================== getDetailSearchGoods START ====================");
		List<GoodsDTO> list = goodsDAO.getDetailSearchGoods(map);
		logger.debug("==================== getDetailSearchGoods END ====================");
		return list;
	}
	@Transactional
	public List<GoodsDTO> getDetailSearchGoods2(HashMap<String,Object> map) throws Exception{
		logger.debug("==================== getDetailSearchGoods START ====================");
		List<GoodsDTO> list = goodsDAO.getDetailSearchGoods2(map);
		logger.debug("==================== getDetailSearchGoods END ====================");
		return list;
	}
	@Transactional
	public int addHit(HashMap<String,Object> map) throws Exception{
		logger.debug("==================== addHit START ====================");
		int result = goodsDAO.getHit(map);
		logger.debug("==================== addHit END ====================");
		if(result == 0) {
			goodsDAO.addHit(map);
			return goodsDAO.modifyHit(map);
		}else {
			return 0;
		}
	}
	@Transactional
	public int addJjim(HashMap<String,Object> map) throws Exception{
		logger.debug("==================== addJjim START ====================");
		int result = goodsDAO.getJjim(map);
		logger.debug("==================== addJjim END ====================");
		if(result == 0) {
			goodsDAO.addJjim(map);
			return goodsDAO.modifyJjim(map);
		}else {
			return 0;
		}
	}
	@Transactional
	public int completeGoods(int goodsID) throws Exception{
		logger.debug("==================== completeGoods START ====================");
		int result = goodsDAO.completeGoods(goodsID);
		logger.debug("==================== completeGoods END ====================");
		return result;
	}
	@Transactional
	public int deleteBox(int goodsID) throws Exception{
		logger.debug("==================== deleteBox START ====================");
		int result = goodsDAO.deleteBox(goodsID);
		logger.debug("==================== deleteBox END ====================");
		return result;
	}
	@Transactional
	public int cancelBox(int goodsID) throws Exception{
		logger.debug("==================== cancelBox START ====================");
		int result = goodsDAO.cancelBox(goodsID);
		logger.debug("==================== cancelBox END ====================");
		return result;
	}
	@Transactional
	public HashMap<String, Object> getJjimList(String userID) throws Exception{
		logger.debug("==================== getJjimList START ====================");
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<GoodsDTO> list = goodsDAO.getJjimList(userID);
		map.put("list", list);
		logger.debug("==================== getJjimList END ====================");
		return map;
	}
	@Transactional
	public int deleteJjim(HashMap<String,Object> map) throws Exception{
		logger.debug("==================== deleteJjim START ====================");
		logger.debug("==================== deleteJjim END ====================");
		return goodsDAO.deleteJjim(map);
	}
	@Transactional
	public HashMap<String, Object> getJjimGoodsList() throws Exception{
		logger.debug("==================== getJjimGoodsList START ====================");
		HashMap<String, Object> map = new HashMap<String, Object>();
		List<GoodsDTO> list = goodsDAO.getJjimGoodsList();
		map.put("list",list);
		logger.debug("==================== getJjimGoodsList END ====================");
		return map;
	}
	@Transactional
	public List<GoodsDTO> getAllJjimGoodsList() throws Exception{
		logger.debug("==================== getAllJjimGoodsList START ====================");
		List<GoodsDTO> list = goodsDAO.getAllJjimGoodsList();
		logger.debug("==================== getAllJjimGoodsList END ====================");
		return list;
	}
	@Transactional
	public GoodsDTO getChatGoods(HttpServletRequest request) throws Exception{
		logger.debug("==================== getChatGoods START ====================");
		int goodsID = Integer.parseInt(request.getParameter("goodsID"));
		GoodsDTO list = goodsDAO.getChatGoods(goodsID);
		logger.debug("==================== getChatGoods END ====================");
		return list;
	}
}
