package com.pjt.deal.dao;

import java.util.HashMap;
import java.util.List;

import javax.annotation.Resource;

import org.apache.ibatis.session.SqlSession;
import org.springframework.stereotype.Repository;

import com.pjt.deal.dto.GoodsDTO;

@Repository
public class GoodsDAO {

	@Resource(name = "sqlSession")
    private SqlSession sqlSession;
	
	private static final String NAMESPACE = "com.pjt.deal.mainMapper";
	
	public int setGoods(GoodsDTO goodsDTO) throws Exception {
		return sqlSession.insert(NAMESPACE + ".setGoods", goodsDTO);
	}
	public List<GoodsDTO> getNewGoodsList() throws Exception{
		return sqlSession.selectList(NAMESPACE + ".getNewGoodsList");
	}
	public List<GoodsDTO> getAllNewGoodsList() throws Exception{
		return sqlSession.selectList(NAMESPACE + ".getAllNewGoodsList");
	}
	public GoodsDTO getGoods(HashMap<String,Object> map) throws Exception{
		return sqlSession.selectOne(NAMESPACE + ".getGoods", map);
	}
	public List<GoodsDTO> getMyGoods(String userID) throws Exception{
		return sqlSession.selectList(NAMESPACE + ".getMyGoods", userID);
	}
	public int deleteGoods(int goodsID) throws Exception{
		return sqlSession.update(NAMESPACE + ".deleteGoods", goodsID);
	}
	public GoodsDTO getModifyGoods(int goodsID) throws Exception{
		return sqlSession.selectOne(NAMESPACE + ".getModifyGoods", goodsID);
	}
	public int modifyGoods(GoodsDTO goodsDTO) throws Exception{
		return sqlSession.update(NAMESPACE + ".modifyGoods", goodsDTO);
	}
	public List<GoodsDTO> getSearchGoodsName(String goodsNAME) throws Exception{
		return sqlSession.selectList(NAMESPACE + ".getSearchGoodsName", goodsNAME);
	}
	public List<GoodsDTO> getDetailSearchGoods(HashMap<String,Object> map) throws Exception{
		return sqlSession.selectList(NAMESPACE + ".getDetailSearchGoods", map);
	}
	public List<GoodsDTO> getDetailSearchGoods2(HashMap<String,Object> map) throws Exception{
		return sqlSession.selectList(NAMESPACE + ".getDetailSearchGoods2", map);
	}
	public int getHit(HashMap<String,Object> map) throws Exception{
		return sqlSession.selectOne(NAMESPACE + ".getHit", map);
	}
	public int addHit(HashMap<String,Object> map) throws Exception{
		return sqlSession.insert(NAMESPACE + ".addHit", map);
	}
	public int modifyHit(HashMap<String,Object> map) throws Exception{
		return sqlSession.update(NAMESPACE + ".modifyHit", map);
	}
	public int getJjim(HashMap<String,Object> map) throws Exception{
		return sqlSession.selectOne(NAMESPACE + ".getJjim", map);
	}
	public int addJjim(HashMap<String,Object> map) throws Exception{
		return sqlSession.insert(NAMESPACE + ".addJjim", map);
	}
	public int modifyJjim(HashMap<String,Object> map) throws Exception{
		return sqlSession.update(NAMESPACE + ".modifyJjim", map);
	}
	public int completeGoods(int goodsID) throws Exception{
		return sqlSession.update(NAMESPACE + ".completeGoods", goodsID);
	}
	public int deleteBox(int goodsID) throws Exception{
		return sqlSession.update(NAMESPACE + ".deleteBox", goodsID);
	}
	public int cancelBox(int goodsID) throws Exception{
		return sqlSession.update(NAMESPACE + ".cancelBox", goodsID);
	}
	public List<GoodsDTO> getJjimList(String userID) throws Exception{
		return sqlSession.selectList(NAMESPACE + ".getJjimList", userID);
	}
	public int deleteJjim(HashMap<String,Object> map) throws Exception{
		return sqlSession.delete(NAMESPACE + ".deleteJjim", map);
	}
	public List<GoodsDTO> getJjimGoodsList() throws Exception{
		return sqlSession.selectList(NAMESPACE + ".getJjimGoodsList");
	}
	public List<GoodsDTO> getAllJjimGoodsList() throws Exception{
		return sqlSession.selectList(NAMESPACE + ".getAllJjimGoodsList");
	}
	public GoodsDTO getChatGoods(int goodsID) throws Exception{
		return sqlSession.selectOne(NAMESPACE + ".getChatGoods",goodsID); 
	}
}
