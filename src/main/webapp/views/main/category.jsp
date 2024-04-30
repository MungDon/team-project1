<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.category.CategoryDTO" %>
<%@ page import="java.util.List" %>
<%@page import="project.bean.product.ProductDAO"%>
<style>
	.category{
		height : 50px;
		text-align : center;
		width : 1000px;
		border-style: hidden;
		border-collapse: collapse;
	}
	.table{
		height : 50px;
		border : 1px solid #ddd;
		border-radius : 50px;	
	}
</style>
<%  	
	ProductDAO dao = ProductDAO.getInstance();	
	List<CategoryDTO> list = dao.loadCategory();   

%>

<div class="table">
<table class="category">
	<tr class="tr">
		<td class="td1">
		<a href="main.jsp">전체상품</a>
		</td>
		<% 
			for(CategoryDTO dto : list){
			int categoryProductCnt = dao.categoryProductCount(dto.getCategory_num());
		%>
		<td class="td2">
			<a href="categoryMain.jsp?category_num=<%=dto.getCategory_num() %>"><%=dto.getCategory_name() %>(<%=categoryProductCnt %>)</a>
		<%	} %>
		</td>

	</tr>
</table>
</div>
