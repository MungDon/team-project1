<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<style>

@import url("https://cdn.jsdelivr.net/gh/orioncactus/pretendard@v1.3.9/dist/web/variable/pretendardvariable.min.css");

.dropdown{
  position : relative;
  display : inline-block;
}

.dropbtn_icon{
  font-family : 'Material Icons';
}
.dropbtn{
  border-style : none;
  border-radius : 4px;
  background-color: white;
  font-weight: 400;
  color : rgb(37, 37, 37);
  padding : 12px;
  width :300px;
  text-align: left;
  cursor : pointer;
  font-size : 25px;
  padding-left : 50px;
}
.dropdown-content{
  display : none;
  position : absolute;
  z-index : 1; /*다른 요소들보다 앞에 배치*/
  font-weight: 400;
  background-color: #f9f9f9;
  min-width : 200px;
}

.dropdown-content a{
  display : block;
  text-decoration : none;
  color : rgb(37, 37, 37);
  font-size: 12px;
  padding : 12px 20px;
}

.dropdown-content a:hover{
  background-color : #ececec
}

.dropdown:hover .dropdown-content {
  display: block;
}
.headerTable {
	width: 100%;
	height : 100px;
	border-collapse: collapse;
	text-align: center;
}

.h_tr {
	border-bottom: 1px solid #ddd;
}
form{
	display : flex;
	justify-content :center;
	align-items : center;
	height: 100px;
	
}
.search > .text{
	width: 230px;
	margin-right:5px;
}
.search > input:focus{
	outline:none;
}

.search > input {	
	
	height : 35px;
	border-style: none;
} 
.search{
	margin-top: 20px;
	display : flex;
	flex-direction: row;
	align-items : center;
	justify-content : center; 
	width: 300px;
	height : 50px;
	border : 1px solid #ddd;
	border-radius: 70px;
}
.search >.submit{
	background-color: white;
}
</style>

<%
	int snum = 0;
	if (session.getAttribute("snum") != null) {
		snum = (int) session.getAttribute("snum");
	}
%>

<table class="headerTable">
	<tr class="h_tr">
		<td>
			<a href="../main/adminMain.jsp"><img src="../images/admin2.png" width="250" height="250"></a>
		</td>
		<td>
			
			<div class="dropdown">
				<button  class="dropbtn" type="button" onclick="location.href='../admin/allMemberList.jsp'">전체 회원관리</button>
			<div class="dropdown-content">
				<a href="../admin/sellerJoinList.jsp">판매자 가입 승인대기 목록</a>
			</div>
			</div>
		</td>
		<td>
			<button  class="dropbtn" type="button" onclick="location.href='../category/categoryInsertForm.jsp'">카테고리등록</button>
		</td>

		<td>
			<form id="searchForm" action="main.jsp" method="get">
				<div class="search">
					<input type="text" class="text" name="keyWord" placeholder="상품명을 검색하세요 ex)대대포막걸리">
					<div>	
						<img id="searchIcon" src="../images/search.png" width="30" height="25" >
					</div>
				</div>	
			</form>
		</td>
	</tr>

</table>
<br>
<br>
<br>

<script>
	const searchIcon = document.getElementById("searchIcon");
	
	searchIcon.addEventListener("click", () => {
		document.getElementById("searchForm").submit();
	});
	

</script>