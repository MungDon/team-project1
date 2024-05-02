<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.mypage.MypageDAO" %>
<%@ page import="project.bean.mypage.MypageWrapper" %>
<%@ page import="project.bean.orders.OrdersDTO" %>
<%@ page import="project.bean.product.ProductDTO" %>
<%@ page import="project.bean.img.ImgDTO" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.sql.Timestamp" %>
<%@ page import="java.text.SimpleDateFormat" %>
<jsp:include page="/views/main/header.jsp"/>
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
	int snum =0; 
	String svendor ="";
	if(session.getAttribute("snum")!=null){
		snum = (int)session.getAttribute("snum");
	}	

	if(session.getAttribute("svendor")!=null){
		svendor = (String)session.getAttribute("svendor");
	}
	if(snum == 0){%>
		<script>
			alert("로그인 해주세요");
			location.href="../loginSelect.jsp";
		</script>
<%	}
	
	
	MypageDAO dao = MypageDAO.getInstance();
	
	int pageSize = 5;
	String pageNum = request.getParameter("pageNum");
	if(pageNum == null){
		pageNum = "1";
	}
	
	int currentPage = Integer.parseInt(pageNum);
	int startRow = (currentPage-1)*pageSize+1;
	int endRow = currentPage*pageSize;
	
	int orders_count = dao.orders_count_main(snum);
	int reg_count = dao.reg_count_main(snum);
	
	ArrayList<MypageWrapper> list = dao.orders_main(snum, startRow, endRow);
	ArrayList<MypageWrapper> listV = dao.registration_main(snum,startRow, endRow);
%>
	
<%	if(svendor.equals("1")) {	//30일간의 주문/배송현황
%>
		<TABLE border="1" width=780px">
			<TR>
			<TD colspan ="4">
				<DIV style="font-size:25px; display:inline-block;">
					<B>최근 주문 정보</B> 
				</DIV>
				<DIV style="display:inline-block;">
				최근 30일 내에 주문하신 내역입니다.
				</DIV>
			</TD>
			<TD align="center">
				<INPUT type="button" onclick="window.location='orders.jsp'" value="+더보기" />
			</TD>
			</TR>
			<TR>
				<TH>날짜/주문번호</TH>
				<TH>상품명</TH>
				<TH>상품금액/수량</TH>
				<TH>배송상태</TH>
				<TH>리뷰</TH>
			</TR>
<%		if(orders_count==0) {
%>
		<TR>
			<TD colspan="5"> 조회내역이 없습니다. </TD>
	
<%		}else {
			for(MypageWrapper wrapper : list) {
				OrdersDTO ordersDTO = wrapper.getOrdersDTO();
				ProductDTO productDTO = wrapper.getProductDTO();
				ImgDTO imgDTO = wrapper.getImgDTO();
				
				Timestamp timestamp = ordersDTO.getOrders_date();

			    // SimpleDateFormat을 사용하여 포맷 지정
			    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

			    // format 메서드를 사용하여 Timestamp를 문자열로 변환
			    String formattedDate = sdf.format(timestamp);
%>	
				<TR>
					<TD>
						<%=formattedDate %> <br />
						<%=ordersDTO.getOrders_num() %>
					</TD>
					<TD>	
						<DIV style="display:flex; align-items:center;">
							<IMG width="50px" height="50px" style="display:inline-block;margin:0 auto;" 
								src="/project/views/upload/<%=imgDTO.getImg_name()%>" />
							<%=productDTO.getProduct_name() %>
						</DIV>
					<TD>
						<%=productDTO.getPrice() %> <br/>
						<%=ordersDTO.getCount() %>
					</TD>
					<TD><%=ordersDTO.getDelivery_status() %></TD>
					<TD><INPUT type="button" onclick="" value="리뷰" /></TD>
				</TR>
<%			}		
		}
%>	
	</TABLE>
<% 	}else {	//30일 간의 판매등록 현황
%>
		<TABLE border="1" style="border-collapse:collapse; width:750px;">
			<TR>	
				<TD colspan ="4">
					<DIV style="font-size:25px; display:inline-block;">
						<B>최근 판매 등록</B> 
					</DIV>
					<DIV style="display:inline-block;">
					최근 30일 내에 등록하신 내역입니다.
					</DIV>
				</TD>
				<TD align="center">
					<INPUT type="button" onclick="window.location='registration.jsp'" value="+더보기" />
				</TD>
			</TR>
			<TR>
				<TH>등록날짜/등록번호</TH>
				<TH>상품명</TH>
				<TH>상품금액</TH>
				<TH>재고현황</TH>
				<TH>상품수정</TH>
			</TR>
<%		if(reg_count==0) {
%>
			<TR>
				<TD colspan="5"> 조회내역이 없습니다.</TD>
			</TR>
	
<%		}else {
			for(MypageWrapper wrapper : listV) {

				ProductDTO productDTO = wrapper.getProductDTO();
				ImgDTO imgDTO = wrapper.getImgDTO();
				
				Timestamp timestamp = productDTO.getModified_date();

			    // SimpleDateFormat을 사용하여 포맷 지정
			    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

			    // format 메서드를 사용하여 Timestamp를 문자열로 변환
			    String formattedDate = sdf.format(timestamp);
%>	
				<TR>
					<TD>
						<%=formattedDate %> <br />
						<%=productDTO.getProduct_num() %>
					</TD>
					<TD>
						<DIV style="display:flex; align-items:center;">
							<IMG width="50px" height="50px" style="display:inline-block;margin:0 auto;" 
								src="/project/views/upload/<%=imgDTO.getImg_name()%>" />
							<%=productDTO.getProduct_name() %>
						</DIV>
					</TD>
					<TD><%=productDTO.getPrice() %></TD>
					<TD><%=productDTO.getStock() %></TD>
					<TD>
						<INPUT type="button" onclick="window.location='/project/views/product/productUpdateForm.jsp?product_num=<%=productDTO.getProduct_num()%>'" value="수정" />
						<button type="button" id="deleteBtn" value="<%=productDTO.getProduct_num()%>">삭제</button>
					</TD>
				</TR>
<%			}		
		}
%>
		</TABLE>		
<%	}
%>		
	<CENTER>
<%
	int pageCount = 0;
	if(svendor.equals("1"))	{
		pageCount = orders_count/pageSize + (orders_count%pageSize==0?0:1);
	}else {
		pageCount = reg_count/pageSize + (reg_count%pageSize==0?0:1);
	}
	int pageBlock = 5;
	int startPage = (int)((currentPage-1)/pageBlock)*pageBlock+1;
	int endPage = startPage + pageBlock - 1;
	if(endPage > pageCount) {
		endPage = pageCount;
	}
	if(startPage > pageBlock) {
%>
	<A href = "main.jsp?pageNum=<%=startPage - pageBlock %>">[이전]</A>		
<%	}
	for (int i=startPage; i<=endPage; i++) {
%>
	<A href = "main.jsp?pageNum=<%=i %>">[<%=i %>]</A>	
<%	}
	if(endPage < pageCount) {
%>
	<A href = "main.jsp?pageNum=<%=startPage + pageBlock %>">[다음]</A>
<%	}
%>
</CENTER>
<script>
	let deleteBtn = document.getElementById("deleteBtn");
	
	deleteBtn.addEventListener("click", () =>{ 
		let deleteValue = deleteBtn.value;
		if(confirm(deleteValue +"번 상품을 삭제하시겠습니까?")){
			location.href="/project/views/product/productDeletePro.jsp?product_num="+deleteValue;
		}else{
		alert("삭제가 취소되었습니다.");
		}
	});
