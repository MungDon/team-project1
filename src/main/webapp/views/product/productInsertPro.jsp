<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% 
	int status = (int)request.getAttribute("uploadStatus");

	if(status == 1){%>
		<script>
			alert("등록되었습니다");
			location.href="main.jsp";
		</script>	
<%	}
%>
