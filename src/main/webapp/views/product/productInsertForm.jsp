<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.product.ProductDAO"%>
<%@ page import="project.bean.category.CategoryDTO" %>
<%@ page import="java.util.List" %>
    <link rel="stylesheet" href="../css/proInsertForm.css">

	<% 
		int snum = 0;
		if(session.getAttribute("snum") != null){
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

<% 
	ProductDAO dao = ProductDAO.getInstance();	
	List<CategoryDTO> list = dao.loadCategory();   
%>
<div class="main">
	<form action="<%=request.getContextPath() %>/productAdd" method="post" enctype="multipart/form-data">
		<input type="hidden" name="member_num" value="6"/>
		<input type="hidden" name="first_stock" value="0"/>
		
		
		<div class="productAdd">
		<h2>상품 정보입력</h2>
			<table>
				<tr style="border-top:2px solid black">
					<th>카테고리</th>
					<td>
						<select class="insert" name="category_num">
							<% for(CategoryDTO dto : list){ %>
							<option value="<%=dto.getCategory_num()%>"><%=dto.getCategory_name() %></option>
							<%} %>
						</select>
					</td>
				</tr>
				<tr>
					<th>상품명</th>
					<td>
						<input class="input" type="text" name="product_name">
					</td>
				</tr>	
				<tr>
					<th>상품 설명</th>
					<td><textarea name="product_info"></textarea></td>
				</tr>
				<tr>
					<th>상품 가격</th>
					<td><input class="insert" type="number" name="price">원</td>
				</tr>
				<tr>
					<th>배송비 유무 </th>
					<td>
						<input type="radio" name="has_delivery_fee" onclick="showInputBox()" value="있음">있음
						<input type="radio" name="has_delivery_fee" onclick="closeInputBox()" value="없음">없음
						<div id="d_price" style="display : none">
							배송비 <input class="insert" type="number" name="delivery_price" value="0">원
						</div>
					</td>
				</tr>
				<tr style="border-bottom:2px solid black">
					<th>상품 재고</th>
					<td><input class="insert" type="number" name="stock">개</td>
				</tr>
			</table>
		</div>
		<div class="imgAdd">
			<h4>[대표 이미지]</h4>
			<input type="file" name="thumbnail">
			<br>
			<br>
			<div id="productImgDragZone">
				<p>클릭하거나 상품이미지를 드래그 & 드롭 해주세요</p>
				<input id="productImgInput" type="file" name="img" style="display:none" multiple><br/>
			</div>
			<div id="productImgPreview" ></div>
			상품이미지 업로드파일 수 :<span id="productImgCount"></span>개
			
			<br>
			<br>
			
			<h4>[상품 설명 이미지]</h4>
			<div id="textImgDragZone">
				<p>클릭하거나 상품설명이미지를 드래그 & 드롭 해주세요</p>
				<input id="textImgInput"  type="file" name="textImg" style="display:none"  multiple><br/>
			</div>
			
			<div id="textImgPreview"></div>
			상품설명이미지 업로드파일 수 :<span id="textImgCount"></span>개
		<br>
		<br>
		<input class="submit" type="submit" value="상품 등록"><br/>
		<button class="cancel" type="button" onclick="location.href='../main/main.jsp'">취소</button>
		</div>
	</form>
</div>
<script type="text/javascript" src="/project/views/js/dragAndDrop.js"></script>
<script type="text/javascript" src="/project/views/js/dragAndDrop2.js"></script>
<script>
	function showInputBox(){
		document.getElementById("d_price").style.display="block";
	}
	function closeInputBox(){
		document.getElementById("d_price").style.display="none";
	}
</script>	