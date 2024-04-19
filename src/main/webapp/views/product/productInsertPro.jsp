<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%  int status = (int)request.getAttribute("uploadStatus"); 
	System.out.println(status);
	if(status == 1){%>
		<script>
			alert("등록되었습니다");
			location.href="../main/main.jsp";
		</script>
	<% }else{%>
		<script>
			alert("등록에 실패하였습니다");
			location.href="productInsertForm.jsp";
		</script>
<% 	}
%>