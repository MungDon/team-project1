<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.member.MemberDAO" %>

<% request.setCharacterEncoding("UTF-8"); %>

<jsp:useBean id="dto" class="project.bean.member.MemberDTO" />
<jsp:setProperty name="dto" property="*" />

<%
	MemberDAO dao = MemberDAO.getInstance();
	boolean result = dao.loginCheck(dto);
	
	if(dto.getSave_id()!=null && dto.getSave_id().equals("1")) {
		Cookie coo = new Cookie ("cid", dto.getId());
		
		coo.setMaxAge(60*60*24*2);
		
		response.addCookie(coo);
	}
	
	if(result==true) {
		session.setAttribute("sid", dto.getId());
		session.setAttribute("snum", dto.getMember_num());
		session.setAttribute("svendor", dto.getVendor());
%>
		<SCRIPT>
			alert("로그인 되셨습니다.");
			window.location="../main/main.jsp"
		</SCRIPT>
<%	}else {
%>	
		<SCRIPT>
			alert("아이디와 비밀번호를 확인해 주세요.");
			history.go(-1);
		</SCRIPT>		
<%	}
%>
