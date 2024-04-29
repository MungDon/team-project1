<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.category.CategoryDTO" %>
<%@ page import="java.util.List" %>
<%@page import="project.bean.product.ProductDAO"%> 
<style>
	.headerTable{
		width : 100%;
		border-collapse: collapse;
		text-align: center;
	}
	tr{
		border-bottom: 1px solid darkgray;
	}
</style>

<% 
	int snum = 0;
	if(session.getAttribute("snum")!=null){
		snum = (int)session.getAttribute("snum");
	}
	ProductDAO dao = ProductDAO.getInstance();	
	List<CategoryDTO> list = dao.loadCategory();   
%>

<table class="headerTable">
	<tr>
		<td>
			<a href="../main/main.jsp"><img src="../images/COOL.png" width="100" height="100"></a>
		</td>
		<td>
		    <div class="dropDown">
		        <button class="dropDown-btn">전체상품</button>
		        <div class="subMenu">
		        <%for(CategoryDTO dto : list){ %>
		            <a href="categoryMain.jsp?category_num=<%=dto.getCategory_num() %>"><%=dto.getCategory_name() %></a>
		        <%} %>
		        </div>
    		</div>
		</td>	
		<td >
			<form action="main.jsp" method="get">
				<input type="text" name="keyWord" placeholder="상품명을 검색하세요 ex)대대포막걸리">
				<input type="submit" value="검색"/>
			</form>
		</td>	
		<td>
		<% if(snum!=0){%>
			<a href="../member/logout.jsp">로그아웃</a>
		<%}else{%>
			<a href="../member/loginSelect.jsp">로그인</a>
		<%} %>		
			<a href="../member/mypage/main.jsp"><img src="../images/myinfo.png"></a>
			<a href="#"><img src="../images/cart.png"></a>
		</td>	
	
			
		
	</tr>
	
</table>
<br>
<br>
<br>