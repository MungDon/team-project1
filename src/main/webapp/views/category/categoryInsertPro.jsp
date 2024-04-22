<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.category.CategoryDAO" %>
<%@ page import="java.util.List" %>
<%@ page import="project.bean.category.CategoryDTO" %>
<% request.setCharacterEncoding("UTF-8"); %>

<%
	int count = Integer.parseInt(request.getParameter("count"));
    CategoryDAO dao = CategoryDAO.getInstance(); 
	int result = 0;
	
	for(int i = 0; i <= count; i++){
		String names = "category_name["+i+"]";
		String categorys = request.getParameter(names);
		if(categorys == null|| categorys.trim().isEmpty()){
			continue;
		}else{
			CategoryDTO dto = new CategoryDTO();
			dto.setCategory_name(categorys);
			result = dao.categoryAdd(dto);
		}
	}
	if(result == 1){%>
		<script>
			alert("카테고리 등록완");
			location.href="../main/adminMain.jsp";
		</script>	
<%	}else{%>
		<script>
			alert("카테고리 등록실패");
		</script>	
<%	}%>
	
    	
	



