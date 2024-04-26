<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.product.ProductDAO" %>
<%
	int product_num = Integer.parseInt(request.getParameter("product_num"));

	ProductDAO dao = ProductDAO.getInstance();
	int result = dao.deleteProduct(product_num);
	
	if(result == 1){%>
		<script>
			alert('삭제되었습니다');
			location.href="../main/main.jsp";
		</script>	
<%	}
%>