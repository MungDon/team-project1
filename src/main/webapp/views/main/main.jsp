<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.product.ProductDAO" %>
<%@ page import="project.bean.product.ProductDTO" %>
<%@ page import="project.bean.img.ImgDTO" %>
<%@ page import="java.util.List" %>
<style>
	a {
  	text-decoration-line: none;
  	color: #888;
  	}
	.mainCon{
		width:100%;
		display: flex;
		flex-direction : column;
		justify-content: center;
		align-items: center;
	}
	.main{
		display: flex;
		flex-direction : row;
		justify-content: center;
		align-items: center;
	}
	.mainTable{
		margin-top : 50px;
		margin-left : 110px;
		margin-bottom : 110px;
		display: flex;
		flex-direction : row;
		justify-content: flex-start;
		flex-wrap: wrap;
		width:1000px;
	}
	.count{
		margin-top : 10px;
		width :1000px;
		text-align: left;
	}
	.thumnail{
		border : 1px solid white;
	}
	.thumnail:hover{
		opacity:0.5;
	}
</style>
<jsp:include page="header.jsp"/>
<div class="mainCon">
<jsp:include page="category.jsp" />

<%
	int snum =0;
	String svendor="";

	
	if(session.getAttribute("snum")!=null){
		snum = (int)session.getAttribute("snum");
	}
	if(session.getAttribute("svendor")!=null){
		 svendor = (String)session.getAttribute("svendor");
	}
	ProductDAO dao = ProductDAO.getInstance();
	// 페이징
	int pageSize = 10;
	
	String pageNum = request.getParameter("pageNum");
	if( pageNum == null ){
		pageNum = "1";
	}
	int currentPage = Integer.parseInt(pageNum);
	int startRow = ( currentPage - 1 ) * pageSize + 1;
	int endRow = currentPage * pageSize;
	int productCount = dao.productCount();
	// 검색어 
	String keyWord ="";
	if(request.getParameter("keyWord")!=null){
		 keyWord = request.getParameter("keyWord");
	}	
	
	// 상품 목록
		List<ProductDTO> list = dao.productList(startRow,endRow, keyWord);
	
%>
<div class="count" >
		<%if(snum!=0 && svendor.equals("2")){ %>
	<button type="button" onclick="goProductForm()">상품등록</button>
		<%} %>
	<p>전체 상품 <b style="color:skyblue"><%=productCount %></b>개</p>
	<hr color="darkgray">
</div>
<div class="main">		
<%if(productCount!=0){ %>
<div class="mainTable">
	<%for (ProductDTO dto : list){ %>
<table style="margin: 50px;">
	
	<tr>
		<% for(ImgDTO img : dto.getImages()){ %>
		<td>
			<div class="thumnail">
				<a href="../product/productContent.jsp?product_num=<%=dto.getProduct_num()%>&pageNum=<%=pageNum%>&category_num=<%=dto.getCategory_num()%>"><img src="../upload/<%=img.getImg_name()%>" width="200" height="200" alt="썸네일"/></a>
			</div>
		</td>
<%		   }%>
	</tr>
	<tr>
		<td><%=dto.getProduct_name() %></td>
	</tr>
	<tr>
		<td><b><%=dto.getPrice() %>원</b></td>
	</tr>
</table>

	<%}%>
	</div>
	<%}else{%>
	<h1>준비된 상품이 없습니다.</h1>
	<%}


	if( productCount > 0 ){
		int pageCount = productCount / pageSize +( productCount % pageSize == 0 ? 0 : 1 );
		int startPage = (int)((currentPage-1)/10) * 10 +1;
		int pageBlock = 10;
		
		int endPage = startPage + pageBlock -1;
		if( endPage > pageCount ){
			endPage = pageCount;
		}%>
</div>	
	<%	if( startPage > 10 ){ %>
			<a href="../main/main.jsp?pageNum=<%=startPage-10 %>">[이전]</a>
<% 		}
		for( int i = startPage; i <= endPage; i++ ){ %>
			<a href="../main/main.jsp?pageNum=<%=i%>">[<%=i %>]</a>
<%		}
		if( endPage < pageCount){ %>
			<a href="../main/main.jsp?pageNum=<%=startPage+10 %>">[다음]</a>
<%		}
	}
	
%>
</div>
<script>
	function goProductForm(){ 
		location.href="../product/productInsertForm.jsp";
	}
</script>	