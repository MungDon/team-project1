<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.category.CategoryDTO" %>
<%@ page import="java.util.List" %>
<%@page import="project.bean.product.ProductDAO"%>
<style>
	.category{
		text-align : center;
		width : 1000px;
	}
	.category,.tr,.td1,.td2{
		border: 1px solid darkgray;
		border-collapse: collapse;
	}
</style>
<% 
	ProductDAO dao = ProductDAO.getInstance();	
	List<CategoryDTO> list = dao.loadCategory();   
%>

<center>
<table class="category">
	<tr class="tr">
		<td class="td1">
		<a href="main.jsp">전체상품</a>
		</td>
		<% 
			for(CategoryDTO dto : list){
		%>
		<td class="td2">
			<a href="categoryMain.jsp?category_num=<%=dto.getCategory_num() %>"><%=dto.getCategory_name() %></a>
		<%	} %>
		</td>

	</tr>
</table>
</center>
