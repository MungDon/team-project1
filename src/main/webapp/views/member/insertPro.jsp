<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.member.MemberDAO" %>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="dto" class="project.bean.member.MemberDTO" />
<jsp:setProperty name="dto" property="*" />

<DIV style="display: inline; font-size:35px; font-weight: bold;">회원가입</DIV>
<DIV style="display: inline; font-size:15px; font-weight: bold;">
	01약관동의>02정보입력><FONT color	= skyblue>03가입완료</FONT></DIV>
<HR>

<%
	MemberDAO dao = MemberDAO.getInstance();
	int result = dao.insertPro(dto);
	if(result==1){
%>
	<H1>회원 가입이 완료되었습니다.</H1>
	<DIV><B><%=dto.getId() %></B>님 회원가입을 축하합니다.</DIV></br>
<%		if(dto.getVendor().equals("1")) {
%>
		<INPUT type="button" value="메인으로 가기" onclick="window.location='main.jsp'" />
		<INPUT type="button" value="로그인" onclick="window.location='loginForm.jsp'" />
<%		
		}else {
%>
		<INPUT type="button" value="메인으로 가기" onclick="window.location='main.jsp'" />
		<INPUT type="button" value="판매회원 로그인" onclick="window.location='loginFormV.jsp'" />
<% 		}
	}
%>
