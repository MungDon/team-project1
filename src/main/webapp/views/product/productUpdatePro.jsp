<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<% 
	int result = (int)request.getAttribute("result");

	if(result == 1){%>
		<script>
			alert("수정되었습니다");
			location.href="/project/views/main/main.jsp";
		</script>	
<%	}
%>
