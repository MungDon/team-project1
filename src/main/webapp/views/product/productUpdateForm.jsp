<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.product.ProductDAO"%>
<%@ page import="project.bean.product.ProductDTO" %>
<%@ page import="project.bean.category.CategoryDTO" %>
<%@ page import="project.bean.img.ImgDTO" %>
<%@ page import="java.util.List" %>
<% 
	int i = 0;
	int product_num = Integer.parseInt(request.getParameter("product_num"));
	
	ProductDAO dao = ProductDAO.getInstance();	
	List<CategoryDTO> list = dao.loadCategorys();   
	
	List<ProductDTO> updateData = dao.updateForm(product_num);
	for(ProductDTO data : updateData){
%>
<div class="main">
	<form action="<%=request.getContextPath() %>/productUpdate" method="post" enctype="multipart/form-data">
		<%--상품번호 히든 --%>
		<input type="hidden" name="product_num" value="<%=product_num %>"/>
		
		<%--이미지삭제 예약 리스트 히든 --%>
		<div id="deleteListHidden"></div>
		
		<%--상품카테고리 --%>
		<select name="category_num">
			<option value="<%=data.getCategory_num()%>" selected><%=data.getCategory_name() %></option>
			<% for(CategoryDTO dto : list){ %>
			<option value="<%=dto.getCategory_num()%>"><%=dto.getCategory_name() %></option>
			<%} %>
		</select>
		
		<%--상품정보 --%>
		상품명<input type="text" name="product_name" value="<%=data.getProduct_name()%>"><br/>
		상품 설명<textarea name="product_info"><%=data.getProduct_info() %></textarea><br/>
		상품 가격<input type="number" name="price" value="<%=data.getPrice()%>">원<br/>
		
		<%--상품배송비 --%>
		배송비 유무 및 배송비 수정<br/>
		<% if(data.getHas_delivery_fee().equals("있음")){ %>
		<input type="radio" name="has_delivery_fee" onclick="showInputBox()" value="있음" checked>있음
		<input type="radio" name="has_delivery_fee" onclick="closeInputBox()" value="없음">없음
			<div id="d_price" style="display : block">
			배송비 <input type="number" name="delivery_price" value="<%=data.getDelivery_price()%>">원
		</div><br>
		
	
		<%}else{%>
		<input type="radio" name="has_delivery_fee" onclick="showInputBox()" value="있음" >있음
		<input type="radio" name="has_delivery_fee" onclick="closeInputBox()" value="없음"checked>없음
		<div id="d_price" style="display : none">
			배송비 <input type="number" name="delivery_price" value="0">원
		</div><br>
		<%}%>
		
		<br>
		<br>
		
		<%--상품재고 --%>
		현재 상품 재고<%=data.getStock()%>개<br>
		<input type="hidden" name="stock" value="<%=data.getStock()%>"/>
		추가 재고 
		<input type="number" name="first_stock" value="0"/><br>

		<%--상품 이미지 --%>
		<h2>현재이미지</h2>
		<div>
		<% if(data.getImages()!=null){
				for(ImgDTO img : data.getImages()){ 
				%>
			<img src="../upload/<%=img.getImg_name()%>" width="200" height="200"/>
			<input type="button"  value="삭제예약" onclick="deleteImg(<%=img.getImg_num()%>)">
			<input type="button"  value="삭제예약취소" onclick="deleteCencel(<%=img.getImg_num()%>)"><br/>
			
			 <%} 
		   }%>

		<h2>수정할 이미지</h2>
		대표 이미지<input type="file" name="thumbnail"><br/>
		상품 이미지<input type="file" name="img" multiple><br/>
		상품 설명 이미지<input type="file" name="textImg" multiple><br/>
		</div><br/>

		<input type="submit" value="상품 수정"><br/>
	</form>
</div>
<%	} %>
<script>
	let deletelist = [];
	let deleteHidden = document.getElementById("deleteListHidden");
	console.log(deletelist);
	
	function deleteImg(imgSid){
		deletelist.push(imgSid);
	}
	
	function deleteCencel(imgSid){
		let index = deletelist.indexof(imgSid);
		
		if(index !== -1){
			deletelist.splice(index, 1);
		}
	}
	
	deletelist.forEach(function(imgSid){
	    let input = document.createElement("input");
	    input.type = "hidden";
	    input.name = "delete[]";
	    input.value = deletelist;
	    deleteHidden.appendChild(input);
	});
	


	function showInputBox(){
		document.getElementById("d_price").style.display="block";
	}
	function closeInputBox(){
		document.getElementById("d_price").style.display="none";
	}
	
</script>	