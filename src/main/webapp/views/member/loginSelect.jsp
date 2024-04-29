<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<STYLE>
	INPUT {
		font-size:16px;
		padding:5px;
	}
</STYLE>

<% request.setCharacterEncoding("UTF-8"); %>

<DIV style="font-size:35px; font-weight: bold;">로그인</DIV> <br />
<INPUT type="button" value="일반회원 로그인" onclick="window.location='loginForm.jsp'" />
<INPUT type="button" value="판매회원 로그인" onclick="window.location='loginFormV.jsp'" />
