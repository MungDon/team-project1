<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.admin.AdminDAO"%>
<%@ page import="project.bean.product.ProductDTO"%>
<%@ page import="project.bean.img.ImgDTO"%>
<jsp:include page="../admin/adminHeader.jsp"/>

<%
	AdminDAO dao = AdminDAO.getInstance();
	if(request.getParameter("product_num")!=null){
		int product_num = Integer.parseInt(request.getParameter("product_num"));
		ProductDTO dto = dao.productDetail(product_num);%>

<table>
	<tr>
		<th>상품번호</th>
		<td><%=dto.getProduct_num() %></td>
		<th>상품명</th>
		<td><%=dto.getProduct_name() %></td> 
	</tr>
	<tr>
		<th>카테고리</th>
		<td><%=dto.getCategory_name() %></td>
		<th>상품 가격</th>
		<td><%=dto.getPrice() %></td>
	</tr>
	<tr>
		<th>상품 설명</th>
		<td colspan="3"><%=dto.getProduct_info() %></td>
	</tr>
	<tr>
		<th>상품 최초 재고</th>
		<td><%=dto.getFirst_stock() %></td>
		<th>상품 현재 재고</th>
		<td><%=dto.getStock() %></td>
	</tr>
	<tr>
		<th>배송비 유무 여부</th>
		<td><%=dto.getHas_delivery_fee()%></td>
		<th>배송비</th>
		<td><%=dto.getDelivery_price()%></td>
	</tr>
	<tr>
		<th>상품 등록 일시</th>
		<td><%=dto.getCreated_date() %></td>
		<th>상품 수정 일시</th>
		<td><%=dto.getModified_date() %></td>
	</tr>
</table>	
<h2>현재 등록된 이미지</h2>
<div class="imgBox">
<%		for(ImgDTO img : dto.getImages()){ %>
			<div class="img">
				<img src="../upload/<%=img.getImg_name()%>" width="200" height="200" id="<%=img.getImg_num()%>"/>
			</div>
<%		} %>  
</div>
<button type="button" onclick="adminProductUpdateForm.jsp?product_num=<%=product_num%>">수정하기</button>
<button type="button" onclick="deleteProduct(<%=product_num%>)">삭제하기</button>

<script>
	function deleteProduct(product_num){
		if(!confirm("해당 상품을 삭제하시겠습니까?")){
			return false;
		}
		location.href="../product/productDeletePro.jsp?product_num=<%=product_num%>&ad=1";
	}
</script>


		
		
		
		
		
		
<%	}else{ %>
		<script>
			alert("상품 시퀀스 번호가 없습니다 코드확인 요망");
			location.href="allProductList.jsp";
		</script>	
<%	}
%>
