<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.product.ProductDAO" %>
<%@ page import="project.bean.product.ProductDTO" %>
<%@ page import="project.bean.img.ImgDTO" %>
<%@ page import="java.util.List" %>

<h1>메인</h1>

<% 
	ProductDAO dao = ProductDAO.getInstance();
	List<ProductDTO> list = dao.productList();
	
%>
<button type="button" onclick="goProductForm()">상품등록</button>
<table>
	<%for (ProductDTO dto : list){ %>
	<tr>
		<% for(ImgDTO img : dto.getImages()){ 
		%>
		<td>
			<img src="../upload/<%=img.getImg_name()%>" width="200" height="200"/>
		</td>
		<% } %>
	</tr>
	<tr>
		<td><%=dto.getProduct_name() %></td>
	</tr>
	<tr>
		<td><%=dto.getPrice() %>원</td>
	</tr>
	<%} %>
</table>

<script>
	function goProductForm(){
		location.href="../product/productInsertForm.jsp";
	}
</script>