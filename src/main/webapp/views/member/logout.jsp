<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<%
	// 쿠키 삭제
	Cookie[] cookies = request.getCookies();
	for( Cookie c : cookies ){
		if( c.getName().equals("cid")){
			c.setMaxAge(0);
			response.addCookie(c);
		}
	}
	
	// 세션 삭제
	session.invalidate();
%>
	<SCRIPT>
		alert("로그아웃 되셨습니다.");
		window.location="../main/main.jsp";
	</SCRIPT>
