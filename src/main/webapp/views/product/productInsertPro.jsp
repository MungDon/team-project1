<%@page import="project.bean.product.ImgSave"%>
<%@page import="java.util.Enumeration"%>
<%@page import="project.bean.product.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.io.File" %>
<%@ page import ="com.oreilly.servlet.MultipartRequest" %>
<%@ page import ="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>
<%@ page import ="java.util.List" %>
<%@ page import ="java.io.File" %>
<%@ page import ="project.bean.product.ImgType" %>
<%@ page import ="project.bean.product.ProductDAO" %>
<% request.setCharacterEncoding("UTF-8"); %>
<jsp:useBean id="imgDTO" class="project.bean.product.ImgDTO"/>
<jsp:useBean id="dto" class="project.bean.product.ProductDTO"/>
<jsp:useBean id="saveImg" class="project.bean.product.ImgSave"/>


<%
	ProductDAO dao = ProductDAO.getInstance(); // DAO 객체 

	String filePath = request.getRealPath("views/upload");// 업로드할 실제 폴더 경로
	int max = 1024*1024*20; // 파일크기 설정
	String enc = "UTF-8";	// 인코딩
	DefaultFileRenamePolicy dp = new DefaultFileRenamePolicy();// 같은파일이 있으면 이름 옆에 숫자를 붙임
	MultipartRequest mr = new MultipartRequest(request, filePath,max,enc,dp);
	
	dto.setMember_num(Integer.parseInt(mr.getParameter("member_num")));// 회원 고유번호
	dto.setProduct_name(mr.getParameter("product_name"));
	dto.setProduct_info(mr.getParameter("product_info"));
	dto.setPrice(Integer.parseInt(mr.getParameter("price")));
	dto.setDelivery_price(Integer.parseInt(mr.getParameter("delivery_price")));
	dto.setHas_delivery_fee(mr.getParameter("has_delivery_fee"));
	dto.setBrand(mr.getParameter("brand"));
	dto.setStock(Integer.parseInt(mr.getParameter("stock")));
	
    int product_num = dao.saveProduct(dto);
		
	File thumbnail = mr.getFile("thumbnail");
	if(thumbnail != null){
		String original = mr.getOriginalFileName("thumbnail");
		String sysImgName = mr.getFilesystemName("thumbnail");
		String imgType  = ImgType.thumbnail.name();
		
	    
		saveImg.insertImg(product_num, original, sysImgName, imgType);
	}
	
	Enumeration<String> textImg = mr.getFileNames();
	while(textImg.hasMoreElements()){
		String fileName = textImg.nextElement();
		if(fileName.startsWith("textImg")){
			File textImgFile = mr.getFile(fileName);
			if(textImgFile != null){
				String original = mr.getOriginalFileName(fileName);
				String sysImgName = mr.getFilesystemName(fileName);
				String imgType  = ImgType.textImg.name();
				
				
				saveImg.insertImg(product_num, original, sysImgName, imgType);
				
			}
		}
	}
	Enumeration<String> img = mr.getFileNames();
	while(img.hasMoreElements()){
		String fileName = img.nextElement();
		if(fileName.startsWith("img")){
			File imgFile = mr.getFile(fileName);
			if(imgFile != null){
				String original = mr.getOriginalFileName(fileName);
				String sysImgName = mr.getFilesystemName(fileName);
				String imgType  = ImgType.productImg.name();
				
				saveImg.insertImg(product_num, original, sysImgName, imgType);
			
			   
			}
		}
	}
	
	
	
	
	
%>