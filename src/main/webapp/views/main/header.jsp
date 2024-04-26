<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.category.CategoryDTO" %>
<%@ page import="java.util.List" %>
<%@page import="project.bean.product.ProductDAO"%> 
<style>
	.headerTable{
		width : 100%;
	}
	.headerTable,tr,td{
		
		border : 1px solid black;
		border-collapse: collapse;
		text-align: center;
	}
</style>
<% 
	ProductDAO dao = ProductDAO.getInstance();	
	List<CategoryDTO> list = dao.loadCategorys();   
%>

<table class="headerTable">
	<tr>
		<td>
			<a href="../mypage/main.jsp"><img src="../images/COOL.png" width="100" height="100"></a>
		</td>
		<td><a href="../main/main.jsp">전체 상품</a></td>	
		<td >
			<form action="main.jsp" method="get">
				<input type="text" name="keyWord" placeholder="상품명을 검색하세요 ex)대대포막걸리">
				<input type="submit" value="검색"/>
			</form>
		</td>	
		<td>
			<a href="../mypage/main.jsp"><img src="../images/myinfo.png"></a>
			<a href="#"><img src="../images/cart.png"></a>
		</td>	
	
			
		
	</tr>
	
</table>
<br>
<br>
<br>