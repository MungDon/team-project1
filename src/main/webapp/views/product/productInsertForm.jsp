<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.product.ProductDAO"%>
<%@ page import="project.bean.category.CategoryDTO" %>
<%@ page import="java.util.List" %>
    <link rel="stylesheet" href="../css/proInsertForm.css">
<%-- 	
	<% 
		int snum = 0;
		if(!session.getAttribute("snum").equals(null)){
			snum = (int)session.getAttribute("snum"); // 판매자 세션
		}
		String svendor = (String)session.getAttribute("svendor");
	
		if(snum == 0||!(svendor.equals("2"))){%>
		<script>
			alert("로그인해주세요");
			location.href="../member/loginFormV.jsp "
		</script>	
	<%	}
	%>
--%>
<% 
	ProductDAO dao = ProductDAO.getInstance();	
	List<CategoryDTO> list = dao.loadCategorys();   
%>
<div class="main">
	<form action="<%=request.getContextPath() %>/productAdd" method="post" enctype="multipart/form-data">
		<input type="hidden" name="member_num" value="1"/>
		<input type="hidden" name="first_stock" value="0"/>
		<select name="category_num">
			<% for(CategoryDTO dto : list){ %>
			<option value="<%=dto.getCategory_num()%>"><%=dto.getCategory_name() %></option>
			<%} %>
		</select>
		상품명<input type="text" name="product_name"><br/>
		상품 설명<textarea name="product_info"></textarea><br/>
		상품 가격<input type="number" name="price">원<br/>
		배송비 유무 <br/>
		<input type="radio" name="has_delivery_fee" onclick="showInputBox()" value="있음">있음
		<input type="radio" name="has_delivery_fee" onclick="closeInputBox()" value="없음">없음
		<div id="d_price" style="display : none">
			배송비 <input type="number" name="delivery_price" value="0">원
		</div><br>
		상품 재고<input type="number" name="stock">개<br>
		대표 이미지<input type="file" name="thumbnail">
		상품 이미지<input type="file" name="img" multiple><br/>
		상품 설명 이미지<input type="file" name="textImg" multiple><br/>
		<input type="submit" value="상품 등록"><br/>
	</form>
</div>
<script>
	function showInputBox(){
		document.getElementById("d_price").style.display="block";
	}
	function closeInputBox(){
		document.getElementById("d_price").style.display="none";
	}
</script>	