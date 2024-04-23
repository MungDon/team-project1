<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.product.ProductDAO" %>
<%@ page import="project.bean.product.ProductDTO" %>
<%@ page import="project.bean.img.ImgDTO" %>
<%@ page import="java.util.List" %>
<h1>헤더 들어갈곳</h1>

<jsp:include page="categorys.jsp" />

<%
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
	
	// 상품 목록
	
	int categoiry_num = 0; 
	if(request.getParameter("category_num") != null){
		categoiry_num = Integer.parseInt(request.getParameter("category_num"));
	}
	if( categoiry_num == 0){// 카테고리가 없음 즉 전체 상품
		
		List<ProductDTO> list = dao.productList(startRow,endRow);
	
%>
<h3>총 상품수는 <%=productCount %>개 입니다.</h3>

<center>
<table>
	<%for (ProductDTO dto : list){ %>
	<tr>
		<% for(ImgDTO img : dto.getImages()){ 
		%>
		<td>
			<a href="../product/productUpdateForm.jsp?product_num=<%=dto.getProduct_num()%>">수정</a>
			<a href="../product/content.jsp?product_num=<%=dto.getProduct_num()%>&pageNum=<%=pageNum%>"><img src="../upload/<%=img.getImg_name()%>" width="200" height="200"/></a>
		</td>
		<% } 
		%>
	</tr>
	<tr>
		<td><%=dto.getProduct_name() %></td>
	</tr>
	<tr>
		<td><b><%=dto.getPrice() %>원</b></td>
	</tr>
</table>

	<%} 
	}else{// 카테고리가 있을때 
		List<ProductDTO> list = dao.CateProductList(categoiry_num,startRow, endRow);%>
<table>
		<%for (ProductDTO dto : list){ %>
	<tr>
		<% for(ImgDTO img : dto.getImages()){ %>
		<td>
	
			<a href="../product/productContent.jsp?product_num=<%=dto.getProduct_num()%>&pageNum=<%=pageNum%>"><img src="../upload/<%=img.getImg_name()%>" width="200" height="200"/></a>
	
		</td>
		<% } %>
	</tr>
	<tr>
		<td><%=dto.getProduct_name() %></td>
	</tr>
	<tr>
		<td><b><%=dto.getPrice() %>원</b></td>
	</tr>
	<%	} 
	}%>
</table><br/>

<% 
	if( productCount > 0 ){
		int pageCount = productCount / pageSize +( productCount % pageSize == 0 ? 0 : 1 );
		int startPage = (int)((currentPage-1)/10) * 10 +1;
		
		int pageBlock = 10;
		
		int endPage = startPage + pageBlock -1;
		if( endPage > pageCount ){
			endPage = pageCount;
		}
		
		if( startPage > 10 ){ %>
			<a href="list.jsp?pageNum=<%=startPage-10 %>">[이전]</a>
<% 		}
		for( int i = startPage; i <= endPage; i++ ){ %>
			<a href="list.jsp?pageNum=<%=i%>">[<%=i %>]</a>
<%		}
		if( endPage < pageCount){ %>
			<a href="list.jsp?pageNum=<%=startPage+10 %>">[다음]</a>
<%		}
	}
%>
</center>
