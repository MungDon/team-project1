<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.product.ProductDAO"%>
<%@ page import="project.bean.product.ProductDTO" %>
<%@ page import="project.bean.category.CategoryDTO" %>
<%@ page import="java.util.List" %>
<% 
	int product_num = Integer.parseInt(request.getParameter("product_num"));
	
	ProductDAO dao = ProductDAO.getInstance();	
	List<CategoryDTO> list = dao.loadCategorys();   
	
	List<ProductDTO> updateData = dao.updateForm(product_num);
	for(ProductDTO data : updateData){
%>
<div class="main">
	<form action="<%=request.getContextPath() %>/productUpdate" method="post" enctype="multipart/form-data">
		<input type="hidden" name="member_num" value="1"/>
		<input type="hidden" name="product_num" value="<%=product_num %>"/>
		<select name="category_num">
			<option value="<%=data.getCategory_num()%>" selected><%=data.getCategory_name() %></option>
			<% for(CategoryDTO dto : list){ %>
			<option value="<%=dto.getCategory_num()%>"><%=dto.getCategory_name() %></option>
			<%} %>
		</select>
		상품명<input type="text" name="product_name" value="<%=data.getProduct_name()%>"><br/>
		상품 설명<textarea name="product_info"><%=data.getProduct_info() %></textarea><br/>
		상품 가격<input type="number" name="price" value="<%=data.getPrice()%>">원<br/>
		배송비 유무 <br/>
		<input type="radio" name="has_delivery_fee" onclick="showInputBox()" value="있음">있음
		<input type="radio" name="has_delivery_fee" onclick="closeInputBox()" value="없음">없음
		<div id="d_price" style="display : none">
			배송비 <input type="number" name="delivery_price" value="0">원
		</div><br>
		상품 재고<input type="number" name="stock" value="<%=data.getStock()%>">개<br>
		대표 이미지<input type="file" name="thumbnail">
		상품 이미지<input type="file" name="img" multiple><br/>
		상품 설명 이미지<input type="file" name="textImg" multiple><br/>
		<input type="submit" value="상품 수정"><br/>
	</form>
</div>
<%	} %>
<script>
	function showInputBox(){
		document.getElementById("d_price").style.display="block";
	}
	function closeInputBox(){
		document.getElementById("d_price").style.display="none";
	}
</script>	