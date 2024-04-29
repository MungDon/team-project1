<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<jsp:include page="mypage/fixed.jsp" />

<STYLE>
	INPUT {
		font-size:16px;
		padding:5px;
	}
</STYLE>

<DIV style="font-size:35px; font-weight: bold;">회원탈퇴</DIV> <br />
<HR>
<br /><br />

<%
	int snum = (int)session.getAttribute("snum"); 
	String svendor = (String)session.getAttribute("svendor");
%>

<DIV style="font-size:25px; font-weight: bold;">01. 회원탈퇴 안내</DIV><br />
<DIV style="font-size:16px; display:inline-block; width:700px; border:1px solid lightgray; padding:10px;">
	술마켓 탈퇴 안내<br /><br />
	
	1. 회원 탈퇴시 회원님의 정보는 상품 반품 및 A/S를 위해 전자상거래 등에서의 소비자 보호에 관한 법률에 의거한 고객정보 보호정책에따라 관리됩니다. <br />
	2. 탈퇴 시 회원님께서 보유하셨던 마일리지는 삭제됩니다.
</DIV><br /><br /><br />

<DIV style="font-size:25px; font-weight: bold;">02. 회원탈퇴 하기</DIV><br />

<FORM action="deletePro.jsp" method="post">
	비밀번호	<INPUT type="password" name="pw" />
			<INPUT type="submit" value="탈퇴하기" />
</FORM>