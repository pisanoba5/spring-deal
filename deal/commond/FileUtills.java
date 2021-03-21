package com.pjt.deal.commond;

import java.io.File;
import java.io.FileOutputStream;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import org.springframework.stereotype.Component;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

@Component
public class FileUtills {

		public ArrayList<String> MultifileUpload(HttpServletRequest request) throws Exception {
			MultipartHttpServletRequest multi = (MultipartHttpServletRequest) request;
	        List<MultipartFile> file = multi.getFiles("goodsIMG");
	        ArrayList<String> fileName = new ArrayList<String>();
	        String path;
	        for(int i=0; i < file.size(); i++) {
	        if(file.get(i)!=null){
	            System.out.println("파라미터명" + file.get(i).getName());
	            System.out.println("파일크기" + file.get(i).getSize());
	            System.out.println("파일 존재" + file.get(i).isEmpty());
	            System.out.println("오리지날 파일 이름" + file.get(i).getOriginalFilename());
	            System.out.println(file.get(i).getOriginalFilename());
	            fileName.add(file.get(i).getOriginalFilename());
	           
	            path = request.getSession().getServletContext().getRealPath("/")+"resources/img/";
	            InputStream inputStream = null;
	            OutputStream outputStream = null; 
	            String organizedfilePath="";
	            try {
	                if (file.get(i).getSize() > 0) {
	                    inputStream = file.get(i).getInputStream();
	                    File realUploadDir = new File(path); 
	                    if (!realUploadDir.exists()) {
	                        realUploadDir.mkdirs();//폴더생성.
	                    } 
	                    organizedfilePath = path + file.get(i).getOriginalFilename();
	                    System.out.println(organizedfilePath);//파일이 저장된경로 + 파일 명
	                    outputStream = new FileOutputStream(organizedfilePath);
	                    int readByte = 0;
	                    byte[] buffer = new byte[8192];
	
	                    while ((readByte = inputStream.read(buffer, 0, 8120)) != -1) {
	                        outputStream.write(buffer, 0, readByte); //파일 생성 !   
	                    }
	                }
	            } catch (Exception e) {
	                // TODO: handle exception
	                e.printStackTrace();
	            } finally {
	                outputStream.close();
	                inputStream.close();
	            }
        	}
        }
        return fileName;
	}
		public String fileUpload(HttpServletRequest request) throws Exception {
			MultipartHttpServletRequest multi = (MultipartHttpServletRequest) request;
	        MultipartFile file = multi.getFile("userImg");
	        String fileName;
	        String path;
	        if(file.getSize() == 0) {
	        	System.out.println("test");
	        	return fileName = "default.jsp";
	        }
	            System.out.println("파라미터명" + file.getName());
	            System.out.println("파일크기" + file.getSize());
	            System.out.println("파일 존재" + file.isEmpty());
	            System.out.println("오리지날 파일 이름" + file.getOriginalFilename());
	            System.out.println(file.getOriginalFilename());
	            fileName = file.getOriginalFilename();
	           
	            path = request.getSession().getServletContext().getRealPath("/")+"resources/img/";
	            System.out.println(path);
	            InputStream inputStream = null;
	            OutputStream outputStream = null; 
	            String organizedfilePath="";
	            try {
	                    inputStream = file.getInputStream();
	                    File realUploadDir = new File(path); 
	                    if (!realUploadDir.exists()) {
	                        realUploadDir.mkdirs();//폴더생성.
	                    } 
	                    organizedfilePath = path + file.getOriginalFilename();
	                    System.out.println(organizedfilePath);//파일이 저장된경로 + 파일 명
	                    outputStream = new FileOutputStream(organizedfilePath);
	                    int readByte = 0;
	                    byte[] buffer = new byte[8192];
	
	                    while ((readByte = inputStream.read(buffer, 0, 8120)) != -1) {
	                        outputStream.write(buffer, 0, readByte); //파일 생성 !   
	                    }
	                
	            } catch (Exception e) {
	                // TODO: handle exception
	                e.printStackTrace();
	            } finally {
	                outputStream.close();
	                inputStream.close();
	            }
        return fileName;
	}
}
