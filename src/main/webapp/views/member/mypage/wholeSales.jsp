<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.mypage.MypageDAO" %>
<%@ page import="project.bean.mypage.MypageWrapper" %>
<%@ page import="project.bean.img.ImgDTO" %>
<%@ page import="project.bean.member.MemberDTO" %>
<%@ page import="project.bean.product.ProductDTO" %>
<%@ page import="project.bean.orders.OrdersDTO" %>
<%@ page import="java.util.ArrayList" %>

<jsp:include page="fixed.jsp" />

<% request.setCharacterEncoding("UTF-8"); %>

<STYLE>
	TABLE {
		font-size:16px;
		border-collapse:collapse;
	}
	TD,TH {
		padding:10px;
	}
</STYLE>

<%
	int snum = (int)session.getAttribute("snum");
	String svendor = (String)session.getAttribute("svendor");
	
	MypageDAO dao = MypageDAO.getInstance();
	
	int pageSize = 5;
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage-1)*pageSize+1;
	int endRow = currentPage*pageSize;
	
	int wholeSales_count = dao.wholeSales_count(snum);
	
	ArrayList<MypageWrapper> listV = dao.wholeSales(snum, startRow, endRow );
%>

<DIV style="font-size:25px; font-weight:bold"> 전체 판매 주문 현황</DIV> <br />

<TABLE border="1" width="780px">
	<TR>
		<TD colspan="5"> 판매물품 등록현황 내역 총 <%=wholeSales_count %> 건 </TD>
	</TR>
	<TR>
		<TH>상품명</TH>
		<TH>상품금액</TH>
		<TH>주문수량</TH>
		<TH>판매금액</TH>
		<TH>구매자</TH>
	</TR>
	
<%	if(wholeSales_count==0) {
%>
		<TR>
			<TD colspan="5"> 조회내역이 없습니다. </TD>
	
<%	}else {
		for(MypageWrapper wrapper : listV) {
			
			ImgDTO imgDTO = wrapper.getImgDTO();
			MemberDTO memberDTO = wrapper.getMemberDTO();
			ProductDTO productDTO = wrapper.getProductDTO();
			OrdersDTO ordersDTO = wrapper.getOrdersDTO();
			
			int price = productDTO.getPrice();
			int count = ordersDTO.getCount();
			int sales_price = price * count;
%>	
			<TR>
				<TD>
					<DIV style="display:flex; align-items:center;">
						<IMG width="50px" height="50px" style="display:inline-block;margin:0 auto;" 
							src="../upload/<%=imgDTO.getImg_name()%>" />
						<%=productDTO.getProduct_name() %>
					</DIV>
				</TD>
				<TD><%=productDTO.getPrice() %></TD>
				<TD><%=ordersDTO.getCount() %></TD>
				<TD><%=sales_price %></TD>
				<TD><%=memberDTO.getId() %></TD>
			</TR>
<%		}		
	}
%>
</TABLE>
	
<CENTER>
<%
	int pageCount = wholeSales_count/pageSize + (wholeSales_count%pageSize==0?0:1);
	int pageBlock = 5;
	int startPage = (int)((currentPage-1)/pageBlock)*pageBlock+1;
	int endPage = startPage + pageBlock - 1;
	if(endPage > pageCount) {
		endPage = pageCount;
	}
	if(startPage > pageBlock) {
%>
	<A href = "wholeSales.jsp?pageNum=<%=startPage - pageBlock %>">[이전]</A>		
<%	}
	for (int i=startPage; i<=endPage; i++) {
%>
	<A href = "wholeSales.jsp?pageNum=<%=i %>">[<%=i %>]</A>	
<%	}
	if(endPage < pageCount) {
%>
	<A href = "wholeSales.jsp?pageNum=<%=startPage + pageBlock %>">[다음]</A>
<%	}
%>
</CENTER>