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
	String start = request.getParameter("start");	//조회 시작 날짜
	String end = request.getParameter("end");		//조회 끝나는 날짜
	
	MypageDAO dao = MypageDAO.getInstance();
	
	int request_count = dao.cancellation_count(snum, start, end);
	
	ArrayList<MypageWrapper> list = dao.cancellation(snum, start, end);
%>

<TABLE border="1" width="780px">
	<TR>
		<TD colspan="5"> 취소/반품/교환 내역 총 1 건 </TD>
	</TR>
	<TR>
		<TH>날짜/주문번호</TH>
		<TH>상품명</TH>
		<TH>상품금액/수량</TH>
		<TH>주문상태</TH>
		<TH>리뷰</TH>
	</TR>

<%	if(request_count==0) {
%>
		<TR>
			<TD colspan="5"> 조회내역이 없습니다. </TD>
	
<%	}else {
		for(MypageWrapper wrapper : list) {
			OrdersDTO ordersDTO = wrapper.getOrdersDTO();
			ProductDTO productDTO = wrapper.getProductDTO();
			ImgDTO imgDTO = wrapper.getImgDTO();
				
			//Timestamp형태의 변수를 YYYY-MM-DD 형식으로 변환
			Timestamp timestamp = ordersDTO.getOrders_date();
		    // SimpleDateFormat을 사용하여 포맷 지정
		    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
		    // format 메서드를 사용하여 Timestamp를 문자열로 변환
		    String formattedDate = sdf.format(timestamp);
		    
		    String orders_status = ordersDTO.getOrders_status();
%>	
			<TR>
				<TD>
					<%=formattedDate %> <br />
					<%=ordersDTO.getOrders_num() %>
				</TD>
				<TD>
					<DIV style="display:flex; align-items:center;">
						<IMG width="50px" height="50px" style="display:inline-block;margin:0 auto;" 
							src="../upload/<%=imgDTO.getImg_name()%>" />
						<%=productDTO.getProduct_name() %>
					</DIV>
				</TD>
				<TD>
					<%=productDTO.getPrice() %> <br/>
					<%=ordersDTO.getCount() %>
				</TD>
<%			if(orders_status.equals("0")) {
%>				
				<TD>승인대기</TD>
<% 			}else if(orders_status.equals("2")) {
%>
				<TD>취소완료</TD>	
<%			}else if(orders_status.equals("3")) {
%>	
				<TD>반품완료</TD>
<%			}else if(orders_status.equals("4")) {
%>	
				<TD>교환완료</TD>
<%			}
%>
				<TD><INPUT type="button" onclick="" value="리뷰" /></TD>
			</TR>
<%		}		
	}
%>
</TABLE>