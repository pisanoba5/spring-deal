package com.pjt.deal.controller;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import com.pjt.deal.commond.FileUtills;
import com.pjt.deal.dto.ChatDTO;
import com.pjt.deal.dto.GoodsDTO;
import com.pjt.deal.dto.UserDTO;
import com.pjt.deal.service.ChatService;
import com.pjt.deal.service.CityService;
import com.pjt.deal.service.GoodsService;
import com.pjt.deal.service.UserService;


@Controller
public class MainController {

	@Autowired
	UserService userService;
	@Autowired
	ChatService chatService;
	@Autowired
	CityService cityService;
	@Autowired
	GoodsService goodsService;
	@Autowired
	FileUtills fileUtill;
	
	private static final Logger logger = LoggerFactory.getLogger(MainController.class);
	
	
	@RequestMapping(value = "/index")
	public String index(){
		return "/index";
	}
	
	@RequestMapping(value="/joinCheck")
	public String joinCheck() {
		return "/";
	}
	
	@RequestMapping(value="/join")
	public String join() {
		return "join/join";
	}
	
	@RequestMapping(value="/chat")
	public String chat() {
		return "/chat";
	}
	
	@RequestMapping(value="/login")
	public String login() {
		return "/login";
	}
	
	@RequestMapping(value="/find")
	public String find() {
		return "/find";
	}
	
	@RequestMapping(value="/box")
	public String box() {
		return "/box";
	}
	
	@RequestMapping(value="/detail")
	public String detail() {
		return "/detail";
	}
	
	@RequestMapping(value="/ginsert")
	public String ginsert() {
		return "/ginsert";
	}
	@RequestMapping(value="/gmodify")
	public String gmodify() {
		return "/gmodify";
	}

	/* ???????????? ????????? ?????????????????? */
	
	//???????????????
	@RequestMapping(value="/userLogin")
	public String userLogin(HttpServletRequest request ,HttpSession session) throws Exception {
		String userID;
		String userPassword;
		int result;
		userID = (String)request.getParameter("userID");
		userPassword = (String)request.getParameter("userPassword");
		if(userID == null || userID.equals("") || userPassword == null || userPassword.equals("")) {
			session.setAttribute("messageType", "?????? ?????????");
			session.setAttribute("messageContent", "???????????? ??????????????????.");
			return "redirect:/login";
		}
		result = userService.userLogin(userID, userPassword);
		UserDTO dto = userService.getUser(userID);
		if(result == 1) {
			System.out.println(dto.getUserImg());
			session.setAttribute("userID",dto.getUserID());
			session.setAttribute("userImg",dto.getUserImg());
			session.setAttribute("messageType", "?????? ?????????");
			session.setAttribute("messageContent", "????????? ???????????????.");
			return "redirect:/index";
		}else if(result == 2){
			session.setAttribute("messageType", "?????? ?????????");
			session.setAttribute("messageContent", "??????????????? ????????????.");
			return "redirect:/login";
		}else {
			session.setAttribute("messageType", "?????? ?????????");
			session.setAttribute("messageContent", "?????? ????????? ?????????.");
			return "redirect:/index";
		}
		
	}
	//????????????
	@RequestMapping(value="logoutAction")
	public String logoutAction(HttpSession session) {
		session.invalidate();
		return "redirect:/index";
	}
	//????????????
	@RequestMapping(value="/userRegister")
	public String userRegister(HttpServletRequest request, HttpSession session) throws Exception {
		MultipartHttpServletRequest multi = (MultipartHttpServletRequest) request;
		String fileName = fileUtill.fileUpload(request);
        UserDTO dto = new UserDTO();
        dto.setUserID(request.getParameter("userID"));
        dto.setUserPassword(request.getParameter("userPassword"));
        dto.setUserName(request.getParameter("userName"));
        dto.setUserPostCode(request.getParameter("userPostCode"));
        dto.setUserAddress(request.getParameter("userAddress"));
        dto.setUserDetailAddress(request.getParameter("userDetailAddress"));
        dto.setUserExtraAddress(request.getParameter("userExtraAddress"));
        dto.setUserPhone1(request.getParameter("userPhone1"));
        dto.setUserPhone2(request.getParameter("userPhone2"));
        dto.setUserPhone3(request.getParameter("userPhone3"));
        dto.setUserAge(Integer.parseInt(request.getParameter("userAge")));
        dto.setUserGender(request.getParameter("userGender"));
        dto.setUserImg(fileName);
		int result = 0;
		result = userService.userRegister(dto);
		if(result == 1) {
			session.setAttribute("userID",dto.getUserID());
			session.setAttribute("messageType", "?????? ?????????");
			session.setAttribute("messageContent", "??????????????? ?????????????????????.");
			return "/index";
		}else {
			session.setAttribute("messageType", "?????? ?????????");
			session.setAttribute("messageContent", "??????????????? ?????? ???????????????.");
			return "redirect:/index";
		}
		
	}
	//?????????????????????
	@RequestMapping(value="/userRegisterCheck")
	@ResponseBody
	public int userRegisterCheck(HttpServletRequest request, HttpSession session) throws Exception {
		return userService.userRegisterCheck(request.getParameter("userID"));
	}	
	//?????????????????????
	@RequestMapping(value="/modify")
	 public String modify(HttpSession session, Model model) throws Exception{
		 String userID = (String)session.getAttribute("userID");
		 UserDTO info = userService.getUser(userID);
		 model.addAttribute("info", info);
		 return "/modify";
	 }
	//????????????????????????
	 @RequestMapping(value="/setModify")
	 public String setModify(HttpServletRequest request, HttpSession session) throws Exception{
	    MultipartHttpServletRequest multi = (MultipartHttpServletRequest) request;
	    String fileName = fileUtill.fileUpload(request);
	    UserDTO dto = new UserDTO();
	    dto.setUserID(request.getParameter("userID"));
	    dto.setUserPassword(request.getParameter("userPassword"));
	    dto.setUserImg(fileName);
		int result = userService.setModify(dto);
		if(result == 1) {
			session.setAttribute("messageType", "?????? ?????????");
			session.setAttribute("messageContent", "??????????????? ?????????????????????.");
			return "redirect:/login";
		}else{
			session.setAttribute("messageType", "?????? ?????????");
			session.setAttribute("messagefContent", "?????????????????? ????????? ?????????????????????.");
			return "redirect:/login";
		}
	 }
	
	/* ?????? ???????????? */
	
	//?????????????????????
	@RequestMapping(value="/userChatList")
	@ResponseBody
	public HashMap<String, Object> userChatList(HttpServletRequest request) throws Exception{
		HashMap<String, Object> map = new HashMap<String, Object>();
		String fromID = request.getParameter("fromID");
		String toID = request.getParameter("toID");
		String goodsID = request.getParameter("goodsID");
		String chatID = request.getParameter("chatID");
		map.put("fromID", fromID);
		map.put("toID", toID);
		map.put("goodsID", goodsID);
		map.put("chatID", chatID);
		return chatService.chatList(map);
	}
	//???????????????
	@RequestMapping(value="/chatSubmit")
	@ResponseBody
	public int chatSubmit(ChatDTO chatDTO) throws Exception{
		return chatService.chatSubmit(chatDTO);
	}
	//????????? ??????????????????
	@RequestMapping(value="/chatUnRead")
	@ResponseBody
	public int chatUnRead(HttpServletRequest request) throws Exception{
		
		return chatService.chatUnRead(request.getParameter("userID"));
	}
	//??????????????????
	@RequestMapping(value="/chatBox")
	@ResponseBody
	public HashMap<String, Object> chatBox(String userID) throws Exception{
		return chatService.chatBox(userID);
	}
	//??????????????? ????????? ????????????
	@RequestMapping(value="/getChatGoods")
	@ResponseBody
	public HashMap<String,Object> getUser(HttpServletRequest request) throws Exception{
		HashMap<String,Object> map = new HashMap<String,Object>();
		GoodsDTO list =  goodsService.getChatGoods(request);
		map.put("list",list);
		return map;
	}
	//????????? ????????? ????????????
	@RequestMapping(value="/getUnRead")
	@ResponseBody
	public HashMap<String,Object> getUnRead(HttpServletRequest request) throws Exception{
		HashMap<String,Object> map = new HashMap<String,Object>();
		ChatDTO list = chatService.getUnRead(request);
		map.put("list",list);
		return map;
	}
		
	/* ?????????????????? */
	
	//?????????????????????
	@RequestMapping(value="/getCity")
	@ResponseBody
	public HashMap<String, Object> getCity(HttpServletRequest request) throws Exception{
		String city = request.getParameter("city1");
		return cityService.getCity(city);
	}
	//??????????????????
	@RequestMapping(value="/setGoods")
	public String setGoods(HttpSession session,HttpServletRequest request) throws Exception{
		MultipartHttpServletRequest multi = (MultipartHttpServletRequest) request;
        List<MultipartFile> file = multi.getFiles("goodsIMG");
        for(int i=0; i<file.size(); i++) {
        	if(file.get(i) == null || file.get(i).isEmpty()) {
        		session.setAttribute("messageType", "?????? ?????????");
				session.setAttribute("messageContent", "???????????? ??????????????????.");
				return "/ginsert";
        	}
        }
		ArrayList<String> fileName = fileUtill.MultifileUpload(request);
        GoodsDTO dto = new GoodsDTO();
        dto.setCity1(request.getParameter("city1"));
        dto.setCity2(request.getParameter("city2"));
        dto.setGoodsCATE(request.getParameter("goodsCATE"));
        dto.setGoodsCONTENT(request.getParameter("goodsCONTENT"));
        dto.setGoodsNAME(request.getParameter("goodsNAME"));
        dto.setGoodsPRICE(request.getParameter("goodsPRICE"));
        dto.setUserID(request.getParameter("userID"));
        
        if(fileName.size() == 1) {
        	dto.setGoodsIMG1(fileName.get(0));
        }else if(fileName.size() == 2) {
        	dto.setGoodsIMG1(fileName.get(0));
        	dto.setGoodsIMG2(fileName.get(1));
        }else {
        	dto.setGoodsIMG1(fileName.get(0));
        	dto.setGoodsIMG2(fileName.get(1));
        	dto.setGoodsIMG3(fileName.get(2));
        }
		int result = goodsService.setGoods(dto);
		if(result == 1) {
			session.setAttribute("messageType", "?????? ?????????");
			session.setAttribute("messageContent", "????????? ?????????????????????.");
			return "redirect:/index";
		}else {
			session.setAttribute("messageType", "?????? ?????????");
			session.setAttribute("messageContent", "???????????????????????? ????????? ?????????????????????.");
			return "redirect:/index";
		}
	}
	//?????????????????????
	@RequestMapping(value="/getNewGoodsList")
	@ResponseBody
	public HashMap<String,Object> getNewGoodsList() throws Exception{
		return goodsService.getNewGoodsList();
	}
	//???????????????????????????
	@RequestMapping(value="/getAllNewGoodsList")
	public String getAllNewGoodsList(Model model) throws Exception{
		List<GoodsDTO> dto = goodsService.getAllNewGoodsList();
		model.addAttribute("info", dto);
		return "/searchgoods";
	}
	//????????????????????????
	@RequestMapping(value="/getGoods")
	@ResponseBody
	public HashMap<String,Object> getGoods(HttpServletRequest request) throws Exception{
		HashMap<String,Object> map = new HashMap<String,Object>();
		GoodsDTO list = goodsService.getGoods(request);
		map.put("list", list);
		return map;
	}
	//?????? ????????? ???????????????
	@RequestMapping(value="/getMyGoods")
	@ResponseBody
	public HashMap<String,Object> getMyGoods(HttpServletRequest request) throws Exception{
		String userID = request.getParameter("userID");
		return goodsService.getMyGoods(userID);
	}
	//??????????????? ???????????????
	@RequestMapping(value="/completeGoods")
	@ResponseBody
	public int completeGoods(HttpServletRequest request) throws Exception{
		int goodsID = Integer.parseInt(request.getParameter("goodsID"));	
		return goodsService.completeGoods(goodsID);
	}
	//??????????????? ????????????
	@RequestMapping(value="/deleteBox")
	@ResponseBody
	public int deleteBox(HttpServletRequest request) throws Exception{
		int goodsID = Integer.parseInt(request.getParameter("goodsID"));	
		return goodsService.deleteBox(goodsID);
	}
	//??????????????? ????????????
	@RequestMapping(value="/cancelBox")
	@ResponseBody
	public int cancelBox(HttpServletRequest request) throws Exception{
		int goodsID = Integer.parseInt(request.getParameter("goodsID"));	
		return goodsService.cancelBox(goodsID);
	}
	//???????????????????????????
	@RequestMapping(value="/modifyGoodsPage")
	public String modifyGoodsPage(HttpServletRequest request,HttpSession session, Model model) throws Exception{
		String userID = request.getParameter("userID");
		String userPassword = request.getParameter("userPassword");
		int goodsID = Integer.parseInt(request.getParameter("goodsID"));
		int result = 0;
		result = userService.userLogin(userID, userPassword);
		if(result != 1) {
			session.setAttribute("messageType", "?????? ?????????");
			session.setAttribute("messageContent", "??????????????? ????????????.");
			return "redirect:/index";
		};
		model.addAttribute("info", goodsService.getModifyGoods(goodsID));
		return "/gmodify";
	}
	//????????????????????????
	@RequestMapping(value="/modifyGoods")
	public String modifyGoods(HttpServletRequest request, HttpSession session) throws Exception{
		MultipartHttpServletRequest multi = (MultipartHttpServletRequest) request;
        List<MultipartFile> file = multi.getFiles("goodsIMG");
        for(int i=0; i<file.size(); i++) {
        	if(file.get(i) == null || file.get(i).isEmpty()) {
        		session.setAttribute("messageType", "?????? ?????????");
				session.setAttribute("messageContent", "???????????? ??????????????????.");
				return "/gmodify";
        	}
        }
		ArrayList<String> fileName = fileUtill.MultifileUpload(request);
        GoodsDTO dto = new GoodsDTO();
        dto.setGoodsID(Integer.parseInt(request.getParameter("goodsID")));
        dto.setCity1(request.getParameter("city1"));
        dto.setCity2(request.getParameter("city2"));
        dto.setGoodsCATE(request.getParameter("goodsCATE"));
        dto.setGoodsCONTENT(request.getParameter("goodsCONTENT"));
        dto.setGoodsNAME(request.getParameter("goodsNAME"));
        dto.setGoodsPRICE(request.getParameter("goodsPRICE"));
        dto.setUserID(request.getParameter("userID"));
        
        if(fileName.size() == 1) {
        	dto.setGoodsIMG1(fileName.get(0));
        }else if(fileName.size() == 2) {
        	dto.setGoodsIMG1(fileName.get(0));
        	dto.setGoodsIMG2(fileName.get(1));
        }else {
        	dto.setGoodsIMG1(fileName.get(0));
        	dto.setGoodsIMG2(fileName.get(1));
        	dto.setGoodsIMG3(fileName.get(2));
        }
		int result = 0;
		result = goodsService.modifyGoods(dto);
		if(result == 1) {
			session.setAttribute("messageType", "?????? ?????????");
			session.setAttribute("messageContent", "??????????????? ?????????????????????.");
			return "redirect:/index";
		}else{
			session.setAttribute("messageType", "?????? ?????????");
			session.setAttribute("messageContent", "?????????????????? ????????? ?????????????????????.");
			return "redirect:/index";
		}
	}
	//??????????????????
	@RequestMapping(value="/deleteGoods")
	@ResponseBody
	public int deleteGoods(HttpServletRequest request, HttpSession session) throws Exception{
		int goodsID = Integer.parseInt(request.getParameter("goodsID"));
		int result = goodsService.deleteGoods(goodsID);
		if(result == 1) {
			return 1;
		}else {
			return 0;
		}
	}
	//??????????????????
	@RequestMapping(value="/search", method=RequestMethod.GET)
	public String SearchGoods(HttpServletRequest request, Model model) throws Exception{
		List<GoodsDTO> list = goodsService.getSearchGoodsName(request.getParameter("goodsNAME"));
		model.addAttribute("info", list);
		return "/searchgoods";
	}
	//?????????????????????
	@RequestMapping(value="/detailsearch", method=RequestMethod.GET)
	public String detailsearch(HttpServletRequest request, Model model) throws Exception{
		String[] cate = request.getParameterValues("goodsCATE");
		String goodsPRICE = request.getParameter("goodsPRICE");
		String city1 = request.getParameter("city1");
		String city2 = request.getParameter("city2");
		System.out.println(city2);
		 HashMap<String,Object> map = new HashMap<String,Object>();
		 if(city2.equals("??????")) {
			 map.put("cate",cate);
			 map.put("city1", city1);
			 map.put("goodsPRICE", goodsPRICE);
			List<GoodsDTO> list = goodsService.getDetailSearchGoods2(map);
			 model.addAttribute("info", list);
			return "/searchgoods";
		}else {
			 map.put("cate",cate);
			 map.put("city1", city1);
			 map.put("city2", city2);
			 map.put("goodsPRICE", goodsPRICE);
			List<GoodsDTO> list = goodsService.getDetailSearchGoods(map);
			 model.addAttribute("info", list);
			return "/searchgoods";
		}
	}
	//??????????????????(????????????????????? ?????? ????????? ???????????? ????????????.)
 	@RequestMapping(value="/getJjimGoodsList")
	@ResponseBody
	public HashMap<String,Object> getJjimGoodsList() throws Exception{
		return goodsService.getJjimGoodsList();
	}
 	//?????????????????????????????????
	@RequestMapping(value="/getAllJjimGoodsList")
	public String getAllJjimGoodsList(Model model) throws Exception{
		List<GoodsDTO> dto = goodsService.getAllJjimGoodsList();
		model.addAttribute("info", dto);
		return "/searchgoods";
	}
	//???????????????
	@RequestMapping(value="/addHit")
	@ResponseBody
	public int addHit(HttpServletRequest request) throws Exception{
		String userID = request.getParameter("userID");
		int goodsID = Integer.parseInt(request.getParameter("goodsID"));
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("userID",userID);
		map.put("goodsID", goodsID);
		int result = goodsService.addHit(map);
		return result;
	}
	//?????????
	@RequestMapping(value="/addJjim")
	@ResponseBody
	public int addJjim(HttpServletRequest request) throws Exception{
		String userID = request.getParameter("userID");
		int goodsID = Integer.parseInt(request.getParameter("goodsID"));
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("userID",userID);
		map.put("goodsID", goodsID);
		int result = goodsService.addJjim(map);
		return result;
	}
	//??????????????????
	@RequestMapping(value="/getJjimList")
	@ResponseBody
	public HashMap<String,Object> getJjimList(HttpServletRequest request) throws Exception{	
		return goodsService.getJjimList(request.getParameter("userID"));
	}
	//???????????????
	@RequestMapping(value="/deleteJjim")
	@ResponseBody
	public int deleteJjim(HttpServletRequest request) throws Exception{	
		String userID = request.getParameter("userID");
		int goodsID = Integer.parseInt(request.getParameter("goodsID"));
		HashMap<String,Object> map = new HashMap<String,Object>();
		map.put("userID",userID);
		map.put("goodsID", goodsID);
		return goodsService.deleteJjim(map);
	}

}
