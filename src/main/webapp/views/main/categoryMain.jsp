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
		margin-left : 110px;
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
</style>  
<jsp:include page="header.jsp"/>
<div class="mainCon">
 <jsp:include page="category.jsp" />

	<%	
	// 로그인세션 및 권한세션 가져오기
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

	// 카테고리 번호 가져오기
	int category_num = 0; 
	if(request.getParameter("category_num") != null){
		category_num = Integer.parseInt(request.getParameter("category_num"));
	}
	
	// 카테고리별 등록 상품 수 가져오기
	int categoryProductCnt = dao.categoryProductCount(category_num);
	
	// 카테고리 총 개수 가져오기(없는 카테고리 번호를 주소창에 쳤을때 오동작 방지)
	int categoryCount = dao.categoryCount();
	
	// 카테고리별 목록 보여주기
	List<ProductDTO> list = dao.CateProductList(category_num,startRow, endRow);

	// 주소창에 없는 카테고리번호를 적었을때 오동작 방지
	if(category_num > categoryCount || category_num == 0){%>
		<script>
			alert("잘못된 접근입니다");
			history.go(-1);
		</script>
		
<%	}
%>
<div class="count" >
	<%if(snum!=0 && svendor.equals("2")){ %>
	<button type="button" onclick="goProductForm()">상품등록</button>
			<%} %>
	<p>전체 상품 <b style="color:skyblue"><%=categoryProductCnt %></b>개</p>
</div>
<div class="main">
	<%if(categoryProductCnt!=0){ %>
<div class="mainTable">
		<%for (ProductDTO dto : list){ %>
<table style="border : 1px solid darkgray;border-collapse: collapse; margin-left: 10px;">
	<tr>
		<% for(ImgDTO img : dto.getImages()){ %>
		<td>
			<%if(img.getImg_name()!=null){ %>
				<a href="../product/productContent.jsp?product_num=<%=dto.getProduct_num()%>&pageNum=<%=pageNum%>"><img src="../upload/<%=img.getImg_name()%>" width="200" height="200"/></a>
			<%}else{%>
			<p>썸네일 이미지가 없어요</p>
		 <%	} %>
		</td>
		<% } %>
	</tr>
	<tr>
		<td><%=dto.getProduct_name() %></td>
	</tr>
	<tr>
		<td><b><%=dto.getPrice() %>원</b></td>
	</tr>
</table>
	<%	} %>
</div>
	<%}else{%>
	<h1>준비된 상품이 없습니다.</h1>
	<%}
	 
		if( categoryProductCnt > 0 ){
			int pageCount = categoryProductCnt / pageSize +( categoryProductCnt % pageSize == 0 ? 0 : 1 );
			int startPage = (int)((currentPage-1)/10) * 10 +1;
			
			int pageBlock = 10;
			
			int endPage = startPage + pageBlock -1;
			if( endPage > pageCount ){
				endPage = pageCount;
			} %>
</div>
<% 			if( startPage > 10 ){ %>
			<a href="../main/categoryMain.jsp?category_num=<%=category_num %>&pageNum=<%=startPage-10 %>">[이전]</a>
<% 		}
		for( int i = startPage; i <= endPage; i++ ){ %>
			<a href="../main/categoryMain.jsp?category_num=<%=category_num %>&pageNum=<%=i%>">[<%=i %>]</a>
<%		}
		if( endPage < pageCount){ %>
			<a href="../main/categoryMain.jsp?category_num=<%=category_num %>&pageNum=<%=startPage+10 %>">[다음]</a>
<%		}
	}
	
%>
</div>
<script>
	function goProductForm(){
		location.href="../product/productInsertForm.jsp";
	}
</script>	
