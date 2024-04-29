<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.product.ProductDAO" %>
<%@ page import="project.bean.product.ProductDTO" %>
<%@ page import="project.bean.img.ImgDTO" %>
<%@ page import="java.util.List" %>

<jsp:include page="header.jsp"/>

<jsp:include page="category.jsp" />
<style>
	.main{
		display: flex;
		flex-direction : row;
		justify-content: center;
		align-items: center;
	}
</style>
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
<h3>총 상품수는 <%=productCount %>개 입니다.</h3>
		<%if(snum!=0 && svendor.equals("2")){ %>
<button type="button" onclick="goProductForm()">상품등록</button>
		<%} %>
<div class="main">		
	<%for (ProductDTO dto : list){ %>
<table style="border : 1px solid darkgray;border-collapse: collapse; margin-left: 10px;">
	
	<tr>
		<% for(ImgDTO img : dto.getImages()){ %>
		<td>
			<a href="../product/productContent.jsp?product_num=<%=dto.getProduct_num()%>&pageNum=<%=pageNum%>&category_num=<%=dto.getCategory_num()%>"><img src="../upload/<%=img.getImg_name()%>" width="200" height="200" alt="썸네일"/></a>
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
<center>
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
</center>

<script>
	function goProductForm(){
		location.href="../product/productInsertForm.jsp";
	}
</script>	