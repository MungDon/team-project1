<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.product.ProductDAO" %>
<%@ page import="project.bean.product.ProductDTO" %>
<%@ page import="project.bean.img.ImgDTO" %>
<%@ page import="java.util.List" %>    
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
	
	int category_num = 0; 
	if(request.getParameter("category_num") != null){
		category_num = Integer.parseInt(request.getParameter("category_num"));
	}
	
	List<ProductDTO> list = dao.CateProductList(category_num,startRow, endRow);%>
<h3>총 상품수는 <%=productCount %>개 입니다.</h3>
<center>
<table>
		<%for (ProductDTO dto : list){ %>
	<tr>
		<% for(ImgDTO img : dto.getImages()){ %>
		<td>
			<%if(img.getImg_name()!=null){ %>
			<a href="../product/productUpdateForm.jsp?product_num=<%=dto.getProduct_num()%>">수정</a>
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


	<%	} 
		 
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
