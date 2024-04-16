<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import ="java.io.File" %>
<%@ page import ="com.oreilly.servlet.MultipartRequest" %>
<%@ page import ="com.oreilly.servlet.multipart.DefaultFileRenamePolicy"%>

<% request.setCharacterEncoding("UTF-8"); %>

<%
	String filePath = request.getRealPath("views/upload");// 업로드할 실제 폴더 경로
	int max = 1024*1024*20;
%>