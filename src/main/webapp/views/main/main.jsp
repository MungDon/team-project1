<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.product.ProductDAO" %>
<%@ page import="project.bean.product.ProductDTO" %>
<%@ page import="project.bean.img.ImgDTO" %>
<%@ page import="java.util.List" %>
<jsp:include page="header.jsp"/>


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
	// 검색어 
	String keyWord ="";
	if(request.getParameter("keyWord")!=null){
		 keyWord = request.getParameter("keyWord");
	}	
	
	
	// 상품 목록
		List<ProductDTO> list = dao.productList(startRow,endRow, keyWord);
	
%>
<h3>총 상품수는 <%=productCount %>개 입니다.</h3>

<center>
	<%for (ProductDTO dto : list){ %>
<table>
	
	<tr>
		<% for(ImgDTO img : dto.getImages()){ %>
		<td>
			<a href="../product/productUpdateForm.jsp?product_num=<%=dto.getProduct_num()%>">수정</a>
			<button type="button" id="deleteBtn" value="<%=dto.getProduct_num()%>">삭제</button>
			<a href="../product/productContent.jsp?product_num=<%=dto.getProduct_num()%>&pageNum=<%=pageNum%>"><img src="../upload/<%=img.getImg_name()%>" width="200" height="200" alt="썸네일"/></a>
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
<script>
	let deleteBtn = document.getElementById("deleteBtn");
	
	deleteBtn.addEventListener("click", () =>{ 
		let deleteValue = deleteBtn.value;
		if(confirm(deleteValue +"번 상품을 삭제하시겠습니까?")){
			location.href="../product/productDeletePro.jsp?product_num="+deleteValue;
		}else{
		alert("삭제가 취소되었습니다.");
		}
	});
</script>