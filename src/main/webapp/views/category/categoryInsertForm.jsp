<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <style>
    	.main{
    		display : flex;
    		align-items : center;
    		justify-content : center;
    	}
    	.box{
    		display : flex;
    		align-items : center;
    		justify-content : center;
    		width: 700px;
    		height: 700px;
    	}
    	.box > form{
    		display : flex;
    		align-items : center;
    		justify-content : center;
    		flex-direction: column;
    	}
    </style>
<jsp:include page="../admin/adminHeader.jsp"></jsp:include>




<div class="main">
	<div class="box">
	<form action="categoryInsertPro.jsp" method="post">
		<input type="hidden" name="count" id="count" value="0"/>
		<div id="pulsCategory">
			<div class="category">
				<h1>카테코리 명</h1> <input type="text" name="category_name[0]" id="category_name[0]"/>
				<button type="button" onclick="inputAdd()">카테고리 추가</button>
			</div>
		</div>
		<br>
		<br>
		<input type="submit" value="등록하기"/>
	</form>
	</div>
</div>
<script>
	let count = 1;
	
	function inputAdd() {
	    let html ="";
	    html += '<div class="category">';
	    html += '<input type="text" name="category_name[' + count + ']" id="category_name[' + count + ']" />';
	    html += ' <button type="button" onclick="remove(this)">제거</button>';
	    html += '</div>';
	    count++;
	    document.getElementById("pulsCategory").insertAdjacentHTML('beforeend', html);
	    document.getElementById("count").value = count;
	}
	
	function remove(button) {
	    let parent = button.parentNode; 
	    parent.parentNode.removeChild(parent); 
	}
</script>