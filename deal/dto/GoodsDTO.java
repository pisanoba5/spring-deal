package com.pjt.deal.dto;

public class GoodsDTO extends UserDTO{

	int goodsID;
	String userID;
	String goodsNAME;
	String city1;
	String city2;
	String goodsCONTENT;
	String goodsPRICE;
	String goodsCATE;
	String goodsIMG1;
	String goodsIMG2;
	String goodsIMG3;
	String goodsTIME;
	int goodsHIT;
	String state;

	public int getGoodsID() {
		return goodsID;
	}
	public void setGoodsID(int goodsID) {
		this.goodsID = goodsID;
	}
	public String getUserID() {
		return userID;
	}
	public void setUserID(String userID) {
		this.userID = userID;
	}
	public String getGoodsNAME() {
		return goodsNAME;
	}
	public void setGoodsNAME(String goodsNAME) {
		this.goodsNAME = goodsNAME;
	}
	public String getCity1() {
		return city1;
	}
	public void setCity1(String city1) {
		this.city1 = city1;
	}
	public String getCity2() {
		return city2;
	}
	public void setCity2(String city2) {
		this.city2 = city2;
	}
	public String getGoodsPRICE() {
		return goodsPRICE;
	}
	public void setGoodsPRICE(String goodsPRICE) {
		this.goodsPRICE = goodsPRICE;
	}
	public String getGoodsCATE() {
		return goodsCATE;
	}
	public void setGoodsCATE(String goodsCATE) {
		this.goodsCATE = goodsCATE;
	}
	public String getGoodsIMG1() {
		return goodsIMG1;
	}
	public void setGoodsIMG1(String goodsIMG1) {
		this.goodsIMG1 = goodsIMG1;
	}
	public String getGoodsIMG2() {
		return goodsIMG2;
	}
	public void setGoodsIMG2(String goodsIMG2) {
		this.goodsIMG2 = goodsIMG2;
	}
	public String getGoodsIMG3() {
		return goodsIMG3;
	}
	public void setGoodsIMG3(String goodsIMG3) {
		this.goodsIMG3 = goodsIMG3;
	}
	public String getGoodsTIME() {
		return goodsTIME;
	}
	public void setGoodsTIME(String goodsTIME) {
		this.goodsTIME = goodsTIME;
	}
	
	public String getGoodsCONTENT() {
		return goodsCONTENT;
	}
	public void setGoodsCONTENT(String goodsCONTENT) {
		this.goodsCONTENT = goodsCONTENT;
	}
	public int getGoodsHIT() {
		return goodsHIT;
	}
	public void setGoodsHIT(int goodsHIT) {
		this.goodsHIT = goodsHIT;
	}
	public String getState() {
		return state;
	}
	public void setState(String state) {
		this.state = state;
	}
}
