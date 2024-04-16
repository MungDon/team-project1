<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <link rel="stylesheet" href="../css/proInsertForm.css">
<div class="main">
	<form action="productInsertPro.jsp" method="post" enctype="multipart/form-data">
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
		구매 제한 수량<input type="number" name="buy_limit">개<br/>
		제조사<input type="text" name="brand"><br/>
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