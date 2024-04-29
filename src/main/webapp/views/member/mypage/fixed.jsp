<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.mypage.MypageDAO" %>

<% request.setCharacterEncoding("UTF-8"); %>

<STYLE>
	TABLE {
		font-size:16px;
		border-collapse:collapse;
	}
	TD,TH {
		padding:10px;
	}	
	A {
		text-decoration: none;
		color: inherit;
	}
	.modal {
	    display: none;
		position: fixed; 
	    z-index: 1000;
	    left: 5.5%;
	    top: -13%;
	    width: 100%;
	    height: 100%;
	}
	.modal-content {
	    background-color: white;
	    margin: 15% auto;
	    padding: 20px;
	    border: 1px solid gray;
	    width: 100%;
	    max-width: 500px;
	}
	.close {
	    color: darkgray;
	    float: right;
	    font-size: 28px;
	    font-weight: bold;
	}
</STYLE>

<SCRIPT>
	// 모달 보이기
	function showModal() {
	    var modal = document.getElementById('benefitsModal');
	    modal.style.display = 'block';
	}
	
	// 모달 닫기
	function closeModal() {
	    var modal = document.getElementById('benefitsModal');
	    modal.style.display = 'none';
	}
</SCRIPT>

<%
	int snum = (int)session.getAttribute("snum");
	String svendor = (String)session.getAttribute("svendor");

	MypageDAO dao = MypageDAO.getInstance();
	
	String grade = dao.grade(snum);
%>

<%	if(svendor.equals("1")) { 
%>
	<DIV style="float:left; width:20%; height:100%; margin:30px;">
	<TABLE>
		<TR>
			<TD>
				<DIV style="font-size:35px; font-weight: bold;">마이페이지</DIV> <br />
				<HR width="100%">
			</TD>
		<TR>
		<TR>
			<TD>
				<DIV style="font-size:25px; font-weight: bold;">나의쇼핑</DIV> <br />
				<A href="/project/views/member/mypage/orders.jsp">주문목록/배송조회</A> <br />
				<A href="/project/views/member/mypage/cancellation.jsp"">취소/반품/교환 내역</A> <br />
				<A href="/project/views/member/mypage/interest.jsp">관심상품</A> <br /><br />
			</TD>
		</TR>
		<TR>
			<TD>
				<DIV style="font-size:25px; font-weight: bold;">나의 활동</DIV> <br />
				<A href="#">나의 1:1 문의</A> <br />
				<A href="#">나의 상품 문의</A> <br />
				<A href="#">나의 상품 후기</A> <br /><br />
			</TD>
		</TR>
		<TR>
			<TD>
				<DIV style="font-size:25px; font-weight: bold;">나의 정보</DIV> <br />
				<A href="/project/views/member/pwCheck.jsp">회원 정보 변경</A> <br />
				<A href="/project/views/member/deleteForm.jsp">회원 탈퇴</A> <br />
				<A href="/project/views/member/delivery/list.jsp">배송지 목록</A>
			</TD>
		</TR>
	</TABLE>
	</DIV>
	
	<DIV>
		<DIV style="display:inline-block; border:2px solid lightgray; padding:15px; width:750px; margin-top:30px;">
			<DIV style="font-size:35px; display: flex; align-items:center;">
	<%	if(grade.equals("BRONZE")) {
	%>
				<IMG width="100px" height="120px" style=display:inline-block;margin:0 auto; 
					src="/project/views/images/bronze.png" />&nbsp;
	<%	}else if(grade.equals("SILVER")){
	%>
				<IMG width="100px" height="120px" style=display:inline-block;margin:0 auto; 
					src="/project/views/images/silver.png" />&nbsp;
	<%	}else if(grade.equals("GOLD")) {
	%>
				<IMG width="100px" height="120px" style=display:inline-block;margin:0 auto; 
					src="/project/views/images/gold.png" />&nbsp;
	<%}
	%>			
				<B>양정모</B>&nbsp;님은&nbsp;<B>브론즈 등급</B>&nbsp;입니다.
			</DIV>
			<DIV style="display:inline-block; font-size:20px;">
				<FONT color="gray"><B>50,000원 추가 구매시 등급 업!&nbsp;</B></FONT>
			</DIV>
			<DIV style="display:inline-block; font-size:17px;">
				<A href="#" onclick="showModal()">등급혜택보기</A>
				<DIV id="benefitsModal" class="modal">
					<DIV class="modal-content">
						<SPAN class="close" onclick="closeModal()">&times;</SPAN>
						<TABLE border="1">
							<TR>
								<TD colspan="2"><b>등급혜택안내</b></TD>
							</TR>
							<TR>
	<%	if(grade.equals("BRONZE")) {
								
	%>	
								<TD><B>회원등급</B></TD>
								<TD>브론즈등급</TD>
							</TR>
							<TR>
								<TD><B>추가적립</B></TD>
								<TD>1원 이상 구매 시 구매 금액 당 0.5% 추가 적립</TD>
	<%	}else if(grade.equals("SILVER")) {
	%>
								<TD><B>회원등급</B></TD>
								<TD>실버등급</TD>
							</TR>
							<TR>
								<TD><B>추가적립</B></TD>
								<TD>1원 이상 구매 시 구매 금액 당 5% 추가 적립</TD>							
	<%	}else if(grade.equals("GOLD")) {
	%>
								<TD><B>회원등급</B></TD>
								<TD>실버등급</TD>
							</TR>
							<TR>
								<TD><B>추가적립</B></TD>
								<TD>1원 이상 구매 시 구매 금액 당 10% 추가 적립</TD>							
	<%	}
	%>
							</TR>
						</TABLE>
					</DIV>
				</DIV>
			</DIV>
		</DIV>
	</DIV>
	<br />
	<br />
<%	}else {
%>	
	<DIV style="float:left; width:20%; height:100%; margin:30px;">
	<TABLE>
		<TR>
			<TD>
				<DIV style="font-size:35px; font-weight: bold;">마이페이지</DIV> <br />
				<HR width="100%">
			</TD>
		<TR>
		<TR>
			<TD>
				<DIV style="font-size:25px; font-weight: bold;">나의 판매</DIV> <br />
				<A href="/project/views/member/mypage/registration.jsp">판매물품 등록 현황</A> <br />
				<A href="/project/views/member/mypage/sales.jsp">판매 매출 조회</A> <br />
				<A href="/project/views/member/mypage/wholeSales.jsp">전체 판매 주문 현황</A> <br /><br />
			</TD>
		</TR>
		<TR>
			<TD>
				<DIV style="font-size:25px; font-weight: bold;">나의 활동</DIV> <br />
				<A href="#">나의 1:1 문의</A> <br />
				<A href="#">나의 판매 문의</A> <br /><br />
			</TD>
		</TR>
		<TR>
			<TD>
				<DIV style="font-size:25px; font-weight: bold;">나의 정보</DIV> <br />
				<A href="/project/views/member/pwCheck.jsp">회원 정보 변경</A> <br />
				<A href="/project/views/member/deleteForm.jsp">회원 탈퇴</A> <br />		
			</TD>
		</TR>
	</TABLE>
	</DIV>
	
	<DIV>
		<DIV style="display:inline-block; border:2px solid lightgray; padding:15px; width:750px; margin-top:30px;">
			<DIV style="font-size:35px; display: flex; align-items:center;"">
	<%	if(grade.equals("BRONZE")) {
	%>
				<IMG width="100px" height="120px" style=display:inline-block;margin:0 auto; 
					src="/project/views/images/bronze.png" />&nbsp;
	<%	}else if(grade.equals("SILVER")){
	%>
				<IMG width="100px" height="120px" style=display:inline-block;margin:0 auto; 
					src="/project/views/images/silver.png" />&nbsp;
	<%	}else if(grade.equals("GOLD")) {
	%>
				<IMG width="100px" height="120px" style=display:inline-block;margin:0 auto; 
					src="/project/views/images/gold.png" />&nbsp;
	<%}
	%>			
				<B>양정모</B>&nbsp;님은&nbsp;<B>브론즈 등급</B>&nbsp;입니다.
			</DIV>
			<DIV style="display:inline-block; font-size:20px;">
				<FONT color="gray"><B>판매물품 10개 등록시 등급업!&nbsp;</B></FONT>
			</DIV>
			<DIV style="display:inline-block; font-size:17px;">
				<A href="#" onclick="showModal()">등급혜택보기</A>
				<DIV id="benefitsModal" class="modal">
					<DIV class="modal-content">
						<SPAN class="close" onclick="closeModal()">&times;</SPAN>
						<TABLE border="1">
							<TR>
								<TD colspan="2"><b>등급혜택안내</b></TD>
							</TR>
							<TR>
	<%	if(grade.equals("BRONZE")) {
								
	%>	
								<TD><B>회원등급</B></TD>
								<TD>브론즈등급</TD>
							</TR>
							<TR>
								<TD><B>추가적립</B></TD>
								<TD>판매 물품 정산시 수수료 0% 감면</TD>
	<%	}else if(grade.equals("SILVER")) {
	%>
								<TD><B>회원등급</B></TD>
								<TD>실버등급</TD>
							</TR>
							<TR>
								<TD><B>추가적립</B></TD>
								<TD>판매 물품 정산시 수수료 5% 감면</TD>							
	<%	}else if(grade.equals("GOLD")) {
	%>
								<TD><B>회원등급</B></TD>
								<TD>실버등급</TD>
							</TR>
							<TR>
								<TD><B>추가적립</B></TD>
								<TD>판매 물품 정산시 수수료 10% 감면</TD>							
	<%	}
	%>
							</TR>
						</TABLE>
					</DIV>
				</DIV>
			</DIV>
		</DIV>
	</DIV>
	<br />
	<br />
<%	}
%>


