package com.pjt.deal.dto;

public class ChatDTO extends GoodsDTO{
	int chatID;
	String fromID;
	String toID;
	String chatContent;
	String chatTIme;
	int chatRead;
	int goodsID;
	int unRead;
	String userImg; // 프로필 사진 받을 변수
	
	public int getChatID() {
		return chatID;
	}
	public void setChatID(int chatID) {
		this.chatID = chatID;
	}
	public String getFromID() {
		return fromID;
	}
	public void setFromID(String fromID) {
		this.fromID = fromID;
	}
	public String getToID() {
		return toID;
	}
	public void setToID(String toID) {
		this.toID = toID;
	}
	public String getChatContent() {
		return chatContent;
	}
	public void setChatContent(String chatContent) {
		this.chatContent = chatContent;
	}
	public String getChatTIme() {
		return chatTIme;
	}
	public void setChatTIme(String chatTIme) {
		this.chatTIme = chatTIme;
	}
	public int getGoodsID() {
		return goodsID;
	}
	public void setGoodsID(int goodsID) {
		this.goodsID = goodsID;
	}
	public int getUnRead() {
		return unRead;
	}
	public void setUnRead(int unRead) {
		this.unRead = unRead;
	}
	public String getUserImg() {
		return userImg;
	}
	public void setUserImg(String userImg) {
		this.userImg = userImg;
	}
	public int getChatRead() {
		return chatRead;
	}
	public void setChatRead(int chatRead) {
		this.chatRead = chatRead;
	}
}
