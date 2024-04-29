<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<STYLE>
	TABLE {
	border:1px solid lightgray; 
	width:300px; 
	height:300px; 
	padding:30px
	}
	TD {
		padding:10px;
	}
	INPUT {
		font-size:16px;
		padding:5px;
	}
</STYLE>

<% request.setCharacterEncoding("UTF-8"); %>

<DIV style="font-size:35px; font-weight: bold;">아이디 찾기</DIV> <br />

<FORM action="findIdPro.jsp" method="post">

<TABLE>
	<TR>
		<TD colspan="2" style="font-size:25px;" >회원 아이디찾기</TD>
	</TR>
	<TR>
		<TD colspan="2"></TD>
	</TR>
	<TR>
		<TD><INPUT type="text" name="name" placeholder="이름" /></TD>
		<TD rowspan="2">
			<INPUT type="submit" value="아이디 찾기" />
		</TD>
	</TR>
	<TR>
		<TD><INPUT type="text" name="cellphone" placeholder="가입휴대폰번호" /></TD>
	</TR>
	<TR align="center">
		<TD colspan="2">
		<INPUT type="button" value="비밀번호 찾기" onclick="window.location='findPw.jsp'" />
		<INPUT type="button" value="로그인하기" onclick="window.location='loginSelect.jsp'" />		
		</TD>
</TABLE>

</FORM>