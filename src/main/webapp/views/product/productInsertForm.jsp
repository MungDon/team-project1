<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <link rel="stylesheet" href="../css/proInsertForm.css">
<%-- 	<% 
		int snum = 0;
		if(!session.getAttribute("snum").equals(null)){
			snum = (int)session.getAttribute("snum"); // 판매자 세션
		}
		String svendor = (String)session.getAttribute("svendor");
	
		if(snum == 0){%>
		<script>
			alert("로그인해주세요");
			location.href="../member/loginFormV.jsp "
		</script>	
		
	<%	}else if(!svendor.equals("2")){%>
		<script>
			alert("판매자 권한이 없습니다");
			location.href="../member/loginFormV.jsp "
		</script>	
			
	<%	}
	%>
--%>
<div class="main">
	<form action="<%=request.getContextPath() %>/productAdd" method="post" enctype="multipart/form-data">
		<input type="hidden" name="member_num" value="1"/>
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