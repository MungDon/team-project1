<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.member.MemberDAO" %>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="dto" class="project.bean.member.MemberDTO" />
<jsp:setProperty name="dto" property="*" />

<STYLE>
	TABLE {
	border:1px solid lightgray; 
	width:300px; 
	height:300px; 
	padding:30px
	}
	TD{
		padding:10px;
	}
	INPUT{
		font-size:16px;
		padding:5px;
	}
</STYLE>


<SCRIPT>
	function pwCheck() {
		if(document.changePw.pw.value!=document.changePw.pw2.value) {
			alert("새로운 비밀번호가 일치하지 않습니다.")
			document.changePw.pw2.focus();
			return false;
		}
	}

</SCRIPT>

<%
	MemberDAO dao = MemberDAO.getInstance();

	boolean result = dao.checkMem(dto);
	
	if(result == true) {
%>
	<DIV style="font-size:35px; font-weight: bold;">비밀번호 찾기</DIV> <br />

	<FORM action="findPwPro.jsp" name="changePw" method="post" onsubmit="return pwCheck()">
	
	<INPUT type="hidden" name="id" value="<%=dto.getId() %>" />
	<INPUT type="hidden" name="cellphone" value="<%=dto.getCellphone() %>" />
	
	<TABLE style="border:1px solid lightgray;">
		<TR>
			<TD colspan="2" style="font-size:25px;" >비밀번호 변경</TD>
		</TR>
		<TR>
			<TD colspan="2">새로운 비밀번호를 등록해 주세요.</TD>
		</TR>
		<TR>
			<TD colspan="2"><INPUT type="password" class="textbox" name="pw" placeholder="새 비밀번호" /></TD>
		</TR>
		<TR>
			<TD colspan="2"><INPUT type="password"  class="textbox"name="pw2" placeholder="새 비밀번호 확인" /></TD>
		</TR>
		<TR align="center">
			<TD colspan="2"><INPUT type="submit" value="확인"/></TD>
		</TR>
	</TABLE>		
	</FORM>
<%	}else {
%>
	<SCRIPT>
		alert("아이디와 핸드폰 번호를 확인해 주세요.");
		history.go(-1);
	</SCRIPT>
<%	}
%>