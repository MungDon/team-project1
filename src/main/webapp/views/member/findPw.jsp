<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<% request.setCharacterEncoding("UTF-8"); %>

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


<DIV style="font-size:35px; font-weight: bold;">비밀번호 찾기</DIV> <br />

<FORM action="findPw2.jsp" method="post">

<TABLE>
	<TR>
		<TD colspan="2" style="font-size:25px;" >회원 비밀번호</TD>
	</TR>
	<TR>
		<TD colspan="2">비밀번호를 찾고자하는 아이디와 휴대폰번호를 입력해주세요.</TD>
	</TR>
	<TR>
		<TD><INPUT type="text" name="id" placeholder="아이디" /></TD>
		<TD rowspan="2">
			<INPUT type="submit" value="비밀번호 변경하기" />
		</TD>
	</TR>
	<TR>
		<TD><INPUT type="text" name="cellphone"	 /></TD>
	</TR>
	<TR align="center">
		<TD colspan="2">
		<INPUT type="button" value="아이디 찾기" onclick="window.location='findId.jsp'" />
		<INPUT type="button" value="로그인하기" onclick="window.location='loginSelect.jsp'" />		
		</TD>
	</TR>
</TABLE>
</FORM>