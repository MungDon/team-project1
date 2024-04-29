<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.member.MemberDAO" %>
<jsp:include page="mypage/fixed.jsp" />

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="dto" class="project.bean.member.MemberDTO" />
<jsp:setProperty name="dto" property="*" />

<STYLE>
	TABLE {
		font-size:16px;
		border-collapse:collapse;
	}
	TD {
		padding:10px;
	}
	INPUT {
		font-size:16px;
	}
</STYLE>

<%
	int snum = (int)session.getAttribute("snum");
	String svendor = (String)session.getAttribute("svendor");
	String pw = request.getParameter("pw");	//pwCheck에서 입력받은 비밀번호
	
	MemberDAO dao = MemberDAO.getInstance();
	boolean result = dao.pwCheck(dto.getPw());	//비밀번호가 일치하는지 확인
	
	String maskedPw = dao.maskedPw(dto.getPw());	//비밀번호 자리만큼 *로 표시된 것
	
	dto = dao.memberInfo(snum);			//member_num에 해당하는 회원정보

	if(result==false) {	//비밀번호가 일치하지 않을 때
%>
	<SCRIPT>
		alert("비밀번호를 확인하세요.");
		window.location="pwCheck.jsp";
	</SCRIPT>
<%	}else {	//비밀번호가 일치할 때
%>
	<DIV style="font-size:35px; font-weight: bold;">회원정보</DIV> <br />
	<HR>
	<DIV style="display: inline; font-size:25px; font-weight: bold;">기본정보 </DIV>
	<UL style="display: inline-block; list-style-type: square;">
        <LI>표시는 반드시 입력하셔야 하는 항목입니다.</LI>
	</UL>

	<FORM action="updateForm.jsp" method="post">
		<INPUT type="hidden" name="member_num" value="<%=snum %>" />
		<INPUT type="hidden" name="pw" value="<%=pw %>" />
		<TABLE border="1">
			<TR>
				<TD><UL style="display: inline-block; list-style-type: square;"><LI>아이디</LI></UL></TD>
				<TD>
					<%=dto.getId() %>
				</TD>
<%		if (svendor.equals("2")){	//판매자 회원일 때만 표시
%>
		    <TR>
				<TD><UL style="display: inline-block; list-style-type: square;"><LI>사업자 등록번호</LI></UL></TD>
		    	<TD><%= (dto.getBusiness_number() == null) ? "" : dto.getBusiness_number() %></TD>
			</TR>
			<TR>
				<TD><UL style="display: inline-block; list-style-type: square;"><LI>사업자명</LI></UL></TD>
				<TD><%= (dto.getBusiness_name() == null) ? "" : dto.getBusiness_name() %></TD>
			</TR>	
<%		}
%>
			<TR>
				<TD><UL style="display: inline-block; list-style-type: square;"><LI>비밀번호</LI></UL></TD>
				<TD><B><%=maskedPw %></B></TD>
			</TR>
			
			<TR>
				<TD><UL style="display: inline-block; list-style-type: square;"><LI>이름</LI></UL></TD>
				<TD><%=dto.getName() %></TD>
			</TR>
			<TR>
				<TD><UL style="display: inline-block; list-style-type: none;"><LI>이메일</LI></UL></TD>
				<TD><%= (dto.getEmail() == null) ? "" : dto.getEmail() %></TD>
			</TR>
			<TR>
				<TD><UL style="display: inline-block; list-style-type: square;"><LI>휴대폰번호</LI></UL></TD>
				<TD><%=dto.getCellphone() %>
				</TD>
			</TR>
			<TR>
				<TD><UL style="display: inline-block; list-style-type: none;"><LI>전화번호</LI></UL></TD>
				<TD><%= (dto.getPhone() == null) ? "" : dto.getPhone() %>

		</TABLE>
		<br /><br />
		
		<DIV style="display: inline; font-size:25px; font-weight: bold;">부가정보 </DIV>
		<TABLE border="1">
			<TR>
				<TD><UL style="display: inline-block; list-style-type: square;"><LI>성별</LI></UL></TD>
				<TD><%=dto.getGender() %> 
			</TR>
			<TR>
				<TD><UL style="display: inline-block; list-style-type: square;"><LI>생일</LI></UL></TD>
				<TD><%=dto.getBirth() %>
			</TR>
			
		</TABLE><br />
			<DIV style="margin:auto 480px;">
			<INPUT type="button" value="취소" onclick="window.location='pwCheck.jsp'" />
			<INPUT type="submit" value="수정하기" />
			</DIV>
	</FORM>
<%	}
%>