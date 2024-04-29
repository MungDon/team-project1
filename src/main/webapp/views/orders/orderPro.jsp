<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<% request.setCharacterEncoding("UTF-8"); %>
<%@ page import="project.bean.orders.OrdersDAO" %>
<%@ page import="project.bean.delivery.DeliveryDAO" %>
<%@ page import="project.bean.member.MemberDAO" %>
<%@ page import="java.text.DecimalFormat" %>
<jsp:useBean id="ordersDto" class="project.bean.orders.OrdersDTO"		/>
<jsp:useBean id="deliveryDto" class="project.bean.delivery.DeliveryDTO"	/>
<jsp:useBean id="memberDto" class="project.bean.member.MemberDTO"	/>
<jsp:setProperty name="ordersDto" property="*"							/>
<jsp:setProperty name="deliveryDto" property="*"						/>
<jsp:setProperty name="memberDto" property="*"						/>


<%
	int snum = (int)session.getAttribute("snum");
	int delivery_num = Integer.parseInt(request.getParameter("delivery_num"));
	int img_num = Integer.parseInt(request.getParameter("img_num"));
	// img_num 넘기는거까지 성공하고 껐음
	int product_num = Integer.parseInt(request.getParameter("product_num"));
	int count = Integer.parseInt(request.getParameter("count"));
	String orders_name = request.getParameter("orders_name");
	String receiver_name = request.getParameter("receiver_name");
// 	String name = request.getParameter("receiver_name");	// 이런식으론 값 안들어감
	String phone = request.getParameter("phone");

	String cellphone = request.getParameter("cellphone");
	String email = request.getParameter("email");
	String address1 = request.getParameter("address1");
	String address2 = request.getParameter("address2");
	String address3 = request.getParameter("address3");
	int final_price = Integer.parseInt(request.getParameter("final_price"));
	String payment_option = request.getParameter("payment_option");
	String deliveryInsert = request.getParameter("deliveryInsert");
	String memberUpdate = request.getParameter("memberUpdate");
// 	String default_address = request.getParameter("default_address");	// DeliveryDAO - deliveryInsert 에서 체크시 기본값1로 설정
	String delivery_name = request.getParameter("delivery_name");
	String name = request.getParameter("name");
	DecimalFormat formatter = new DecimalFormat("#,###");
	String fmFinalPrice = formatter.format(final_price);
	
	// deliveryInsert - 1 조건문 걸기
	// memberUpdate - 1 조건문 걸기
	OrdersDAO ordersDao = OrdersDAO.getInstance();
	DeliveryDAO deliveryDao = DeliveryDAO.getInstance();
	MemberDAO memberDao = MemberDAO.getInstance();
	if (deliveryInsert != null) {
		deliveryDao.deliveryInsert(deliveryDto, snum);
	}
	if (memberUpdate != null) {
		memberDao.memberUpdate(memberDto, snum);
	}
	
	int result = ordersDao.orderInsert(ordersDto, snum);
	if (result == 1) {
%>
	<script>
		alert("<%= result %>건의 주문이 완료되었습니다.");
	</script>
<CENTER>
<%
		switch (payment_option) {
			case "1":
%>
				<H1><font color="#F15F5F">신용카드</font></H1>
<%
				break;
			case "2":
%>
				<H1><font color="#6B66FF">계좌이체</font></H1>
<%
				break;
			case "3":
%>
				<H1><font color="#476600">가상계좌</font></H1>
<%
				break;
			case "4":
%>
				<H1><font color="#CC723D">카카오페이</font></H1>
<%
				break;
		}
%>
				<HR width="100%"	/>
				<H2><font size="6" color="#002266"><%= fmFinalPrice %></font>원 결제 -완-</H2>
<%
	}
%>
</CENTER>

<%-- 
<% 
	String deliveryInsert = request.getParameter("deliveryInsert");		// 값이 넘어오면 1
	String deliveryUpdate = request.getParameter("deliveryUpdate");		// 값이 넘어오면 1
	int delivery_num = Integer.parseInt(request.getParameter("delivery_num"));
	OrdersDAO dao = OrdersDAO.getInstance();
	int result = dao.orderInsert(dto);
	
	if (result == 1) {
	}
%>
--%>
