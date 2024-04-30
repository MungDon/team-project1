<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.product.ProductDAO" %>
<%@ page import="project.bean.product.ProductDTO" %>
<%@ page import="project.bean.member.MemberDAO" %>
<%@ page import="project.bean.member.MemberDTO" %>
<%@ page import="java.text.DecimalFormat" %>
<%@ page import="java.util.List" %>
<%@ page import="project.bean.img.ImgDTO" %>
<style>
	.btn_submit{
	 	background-image: url('../images/구매하기.PNG');
	    background-position:  0px 0px;
	    background-repeat: no-repeat;
	    width: 178px;
	    height: 60px;
	    border: 0px;
		cursor:pointer;
		outline: 0;
	}
	
	a {
    	text-decoration: none;
	}

	
</style>

<%
	int snum = 0; 
	int product_num = Integer.parseInt(request.getParameter("product_num"));
	int category_num = Integer.parseInt(request.getParameter("category_num"));
	
	ProductDAO productDao = ProductDAO.getInstance();
	ProductDTO dto = productDao.productContent(product_num);
	
	DecimalFormat formatter = new DecimalFormat("#,###");
	String fmPrice = formatter.format(dto.getPrice());
	
	List<ProductDTO> list = productDao.thumbnail(product_num);
	
	if(session.getAttribute("snum")!=null){
		snum = (int)session.getAttribute("snum");
	}
	MemberDAO memberDao = MemberDAO.getInstance();
	MemberDTO memberDto = memberDao.memberInfo(snum);

	int price = dto.getPrice();
%>


<TABLE align="center" cellpadding="3" cellspacing="14">
	<FORM action="../orders/orderForm.jsp?product_num=<%= dto.getProduct_num()%>&category_num=<%= category_num %>" method="post">
		<TR>
			<TD rowspan="10">
<%
	for (ProductDTO productDTO : list) {
		for (ImgDTO thumb : productDTO.getImages()) {
%>
			<img src="/project/views/upload/<%= thumb.getImg_name() %>" width="600" height="600" onclick="clickImg()"	/>
			<input type="hidden" name="img_num" value="<%= thumb.getImg_num() %>">
<script>
	function clickImg() {
		window.open("../upload/<%= thumb.getImg_name() %>", 'popup', 'width=600, height=800, resizable=yes');
	}
</script>
<%
		}
	}
%>	
			</TD>
			<TD colspan="2" width="70"><font size="6">
				<B><%= dto.getProduct_name() %></B></font>
			</TD>
<!-- 			<TD>QR코드 / 공유</TD> -->
		</TR>
		<TR>
			<TD colspan="2">
				<HR width="600" size="2" color="black"	/>
			</TD>
		</TR>
		<TR>
			<TD width="120">짧은설명</TD>
			<TD><%= dto.getProduct_info() %></TD>
		</TR>
		<TR>
			<TD>판매가</TD>
			<TD><font color="#6799FF"><B><%= fmPrice %>원</B></font></TD>
		</TR>
		<TR>
			<TD>구매제한</TD>
<%
	if (dto.getStock() > 0) {			// 팔 수 있는 남은 재고가 있다면
%>
			<TD>옵션당 최소 1개</TD>
<%
	}else {
%>
			<TD>품절</TD>
<%
	}
%>
		</TR>
		<TR>
			<TD>배송비</TD>
			<TD><%= dto.getDelivery_price() %>원 / 주문시결제(선결제)</TD>
		</TR>
		<TR>
			<TD>상품코드</TD>
			<TD><%= dto.getProduct_num() %></TD>
		</TR>
		<TR>
			<TD>제조사</TD>							<%-- 제조사 -> 브랜드 로 통일 --%>
			<TD><%= memberDto.getBusiness_name() %></TD>
		</TR>
		<TR>
			<TD>원산지</TD>
			<TD>국내산</TD>
		</TR>
		<TR>
			<TD>상품재고</TD>
			<TD><%= dto.getStock() %>개</TD>
		</TR>
		
		<TR>
			<TD align="center" rowspan="4">
<%
		list = productDao.productImages(product_num);
		for (ProductDTO productDTO : list) {
			for (ImgDTO imgs : productDTO.getImages()) {
				
%>
				<img src="/project/views/upload/<%= imgs.getImg_name() %>" width="120" height="100" onclick="clickImgs('<%= imgs.getImg_name() %>')"	/>
	<script>
	    function clickImgs(imgName) {
	        window.open("../upload/" + imgName, 'popup', 'width=600, height=800, resizable=yes');
	    }
	</script>
<%
			}
		}
%>
			</TD>											<%-- 재고 초과하면 alert --%>
			<TD colspan="2" bgcolor="EEEEEE" >
				<span style="float:left; width:55%;"><font size="2"><B><%= dto.getProduct_name() %></B></font></span>
				<span id="total1" style="float:right; "><B><%= fmPrice %>원</B></span>
				<span style="float:right; width:15%;">
					<input type="number" id="count" name="count" value="1" min="1" max="<%= dto.getStock() %>" style="width:50px; height:30px;" oninput="updateTotal()"	/>
					<input type="hidden" name="count" value="count">
				</span>
				<script>
					function updateTotal(){
						let price = <%= dto.getPrice() %>;		 
						let count = document.getElementById("count").value;
						let total1 = price * count;
						let total2 = price * count;
						let total3 = price * count;
						let fmTotal = total1.toLocaleString();
						document.getElementById("total1").textContent = fmTotal + "원";
						document.getElementById("total2").textContent = fmTotal + "원";
						document.getElementById("total3").textContent = fmTotal + "원";
					}
				</script>
			</TD>
		</TR>
		<TR>
			<TD></TD>
			<TD align="right">
				<font size="2">총 상품금액 &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; <span id="total2"><B><%= fmPrice %>원</B></span></font>
			</TD>
		</TR>
		<TR>
			<TD colspan="2">
				<HR width="100%"	/>
			</TD>
		</TR>
		<TR>
			<TD align="right" colspan="2" ><B>총 합계금액 &nbsp;&nbsp; <font color="#6799FF" size="5"><span id="total3"><%= fmPrice %>원</span></font></B></TD>
		</TR>
		<TR height="30"></TR>			<!-- 위아래 여백을 주기위함 -->
		<TR>
			<TD colspan="3">
				<span style="float:right;">
					<input type="submit" value="" class="btn_submit">	<%-- 구매하기 --%>
				</span>
				<A href="#">
					<span style="float:right;">
						<img src="../images/장바구니.PNG" width="171" onclick="window.location='orderList.jsp'"	/>
						&nbsp;
					</span>
				</A>
				<A href="#">
					<span style="float:right;">
						<img src="../images/찜하기.PNG"	width="168"	onclick="window.location='orderList.jsp'"	/>
						&nbsp;
					</span>
				</A>
			</TD>
		</TR>
	</FORM>
</TABLE>


<HR width="100%" size="1";	/>
<TABLE align="center">
	<TR>
		<TD>
			<A href="#info">상품상세정보</A>
		</TD>
		<TD>
			<A href="#delivery">배송안내</A>
		</TD>
		<TD>
			<A href="#trade">교환 및 반품안내</A>
		</TD>
		<TD>
			<A href="#review">상품후기</A>
		</TD>
		<TD>
			<A href="#qna">상품문의</A>
		</TD>
	</TR>
</TABLE>
<HR width="100%" size="1";	/>
<A name="info"></A>
<CENTER><B>판매자 상품 내용</B></CENTER>
<%
	list = productDao.textImages(product_num);
	for (ProductDTO productDTO : list) {
		for (ImgDTO textImg : productDTO.getImages()) {
%>
			<div align="center">
				<img src="/project/views/upload/<%= textImg.getImg_name() %>" width="850"	/>
			</div>
<%
		}
	}
%>

<TABLE align="center">
	<TR>
		<TD colspan="4">
			<FONT size="4"><B>관련상품</B></FONT>
		</TD>		<%-- 메인 상단 게시물 몇개 보여줄 예정 --%>
	</TR>
	<TR>
<%
	list = productDao.connImg(product_num, category_num);
	for (ProductDTO productDTO : list) {
%>
		<TD>
<%
			for (ImgDTO connImg : productDTO.getImages()) {
%>
			<A href="#">
				<img src="../upload/<%= connImg.getImg_name() %>" width="240" height="240" onclick="window.location='productContent.jsp?product_num=<%= productDTO.getProduct_num() %>&category_num=<%= category_num %>'"	/>
			</A>
			&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;
		</TD>
<%
			}
	}
%>
	</TR>
	<TR>
<%
	for (ProductDTO productDTO : list) {
%>
		<TD>
			<div style="width:250;">
				<A href="productContent.jsp?product_num=<%= productDTO.getProduct_num() %>&category_num=<%= category_num %>">
					<font size="3"><%= productDTO.getProduct_name() %></font>
				</A>
			</div>
		</TD>
<%
	}
%>
	</TR>
	<TR>
<%
	for (ProductDTO productDTO : list) {
		fmPrice = formatter.format(productDTO.getPrice());
%>
		<TD>
			<div><font size="4"><b><%= fmPrice %>원</b></font></div>
		</TD>
<%
	}
%>
	</TR>

</TABLE>

<HR width="100%" size="1";	/>
<TABLE align="center">
	<TR>
		<TD>
			<A href="#info">상품상세정보</A>
		</TD>
		<TD>
			<A href="#delivery">배송안내</A>
		</TD>
		<TD>
			<A href="#trade">교환 및 반품안내</A>
		</TD>
		<TD>
			<A href="#review">상품후기</A>
		</TD>
		<TD>
			<A href="#qna">상품문의</A>
		</TD>
	</TR>
</TABLE>
<HR width="100%" size="1";	/>
<A name="delivery"></A>

<TABLE align="center" width="80%" cellspacing="0" cellpadding="3">
	<TR>
		<TD>
			<br /><br /><br /><br />
			<DIV style="padding:1"><B>배송안내</B></DIV>
		</TD>
	</TR>
	<TR>
		<TD>
			<DIV style="font-size:12;">- 배송비 : 기본배송료는 3,000원 입니다. (도서,산간,오지 일부지역은 배송비가 추가될 수 있습니다.) 30,000원 이상 구매시 무료배송입니다.</DIV>
		</TD>
	</TR>
	<TR>
		<TD>
			<DIV style="font-size:12;">- 본 상품의 평균 배송일은 2일 입니다.(입금 확인 후) 설치 상품의 경우 다소 늦어질 수 있습니다. [배송예정일은 주문시점(주문순서)에 따른 유동성이 발생하므로 평균 배송일과는 차이가 발생할 수 있습니다.]</DIV>
		</TD>
	</TR>
	<TR>
		<TD>
			<DIV style="font-size:12;">- 본 상품의 배송 가능일은 2일 입니다. 배송 가능일이란 본 상품을 주문하신 고객님들께 상품 배송이 가능한 기간을 의미합니다. (단, 연휴 및 공휴일은 기간 계산시 제외하며 현금 주문일 경우 입금일 기준 입니다.)</DIV>
			<br /><br />
		</TD>
	</TR>
</TABLE>

<HR width="100%" size="1";	/>
	
<TABLE align="center">
	<TR>
		<TD>
			<A href="#info">상품상세정보</A>
		</TD>
		<TD>
			<A href="#delivery">배송안내</A>
		</TD>
		<TD>
			<A href="#trade">교환 및 반품안내</A>
		</TD>
		<TD>
			<A href="#review">상품후기</A>
		</TD>
		<TD>
			<A href="#qna">상품문의</A>
		</TD>
	</TR>
</TABLE>
<HR width="100%" size="1";	/>
<A name="trade"></A>

<TABLE align="center" width="80%" cellspacing="0" cellpadding="3">
	<TR>
		<TD>
			<br /><br /><br /><br />
			<DIV style="padding:1"><B>교환 및 반품안내</B></DIV>
		</TD>
	</TR>

	<TR>
		<TD>
			<DIV style="font-size:12;">- 상품 택(tag)제거 또는 개봉으로 상품 가치 훼손 시에는 상품수령후 7일 이내라도 교환 및 반품이 불가능합니다.</DIV>
		</TD>
	</TR>
	<TR>
		<TD>
			<DIV style="font-size:12;">- 저단가 상품, 일부 특가 상품은 고객 변심에 의한 교환, 반품은 고객께서 배송비를 부담하셔야 합니다. (제품의 하자, 배송오류는 제외)</DIV>
		</TD>
	</TR>
	<TR>
		<TD>
			<DIV style="font-size:12;">- 일부 상품은 신모델 출시, 부품가격 변동 등 제조사 사정으로 가격이 변동될 수 있습니다.</DIV>
		</TD>
	</TR>
	<TR>
		<TD>
			<DIV style="font-size:12;">- 신발의 경우, 실외에서 착화하였거나 사용흔적이 있는 경우에는 교환/반품 기간내라도 교환 및 반품이 불가능 합니다.</DIV>
		</TD>
	</TR>
	<TR>
		<TD>
			<DIV style="font-size:12;">- 수제화 중 개별 주문제작상품(굽높이, 발볼, 사이즈 변경)의 경우에는 제작완료, 인수 후에는 교환/반품 기간내라도 교환 및 반품이 불가능 합니다.</DIV>
		</TD>
	</TR>
	<TR>
		<TD>
			<DIV style="font-size:12;">- 수입, 명품 제품의 경우, 제품 및 본 상품의 박스 훼손, 분실 등으로 인한 상품 가치 훼손 시 교환 및 반품이 불가능 하오니, 양해 바랍니다.</DIV>
		</TD>
	</TR>
	<TR>
		<TD>
			<DIV style="font-size:12;">- 일부 특가 상품의 경우, 인수 후에는 제품 하자나 오배송의 경우를 제외한 고객님의 단순변심에 의한 교환, 반품이 불가능할 수 있사오니, 각 상품의 상데정보를 꼭 참조하십시오.</DIV>
		</TD>
	</TR>
	<TR>
		<TD>
			<br /><br />
			<DIV style="padding:1"><B>환불안내</B></DIV>
		</TD>
	</TR>
	<TR>
		<TD>
			<DIV style="font-size:12;">- 상품 청약철회 가능기간은 상품 수령일로 부터 7일 이내 입니다.</DIV>
		</TD>
	</TR>
	
	<TR>
		<TD>
			<br /><br /><br /><br />
			<DIV style="padding:1"><B>AS안내</B></DIV>
		</TD>
	</TR>
	<TR>
		<TD>
			<DIV style="font-size:12;">- 소비자 분쟁해결 기준(공정거래위원회 고시)에 따라 피해를 보상받을 수 있습니다.</DIV>
		</TD>
	</TR>
	<TR>
		<TD>
			<DIV style="font-size:12;">- 교환 및 환불은 고객센터에 문의하시기 바랍니다.</DIV>
			<br /><br />
		</TD>
	</TR>
</TABLE>

<HR width="100%" size="1";	/>
<TABLE align="center">
	<TR>
		<TD>
			<A href="#info">상품상세정보</A>
		</TD>
		<TD>
			<A href="#delivery">배송안내</A>
		</TD>
		<TD>
			<A href="#trade">교환 및 반품안내</A>
		</TD>
		<TD>
			<A href="#review">상품후기</A>
		</TD>
		<TD>
			<A href="#qna">상품문의</A>
		</TD>
	</TR>
</TABLE>
<HR width="100%" size="1";	/>

<A name="review"></A>
--------------------상품후기--------------------


<HR width="100%" size="1";	/>
<TABLE align="center">
	<TR>
		<TD>
			<A href="#info">상품상세정보</A>
		</TD>
		<TD>
			<A href="#delivery">배송안내</A>
		</TD>
		<TD>
			<A href="#trade">교환 및 반품안내</A>
		</TD>
		<TD>
			<A href="#review">상품후기</A>
		</TD>
		<TD>
			<A href="#qna">상품문의</A>
		</TD>
	</TR>
</TABLE>
<HR width="100%" size="1";	/>

<A name="qna"></A>
-------------------상품문의-------------------
<%--
	<TR>
		<TD align="center">
			<img src="../images/갓파1.jpg" width="240" height="230"	/>
		</TD>
		<TD align="center">
			<img src="../images/갓파3.jpg" width="240" height="230"	/>
		</TD>
		<TD align="center">
			<img src="../images/갓파5.jpg" width="240" height="230"	/>
		</TD>
		<TD align="center">
			<img src="../images/ppak.jpg" width="240" height="230"	/>
		</TD>
	</TR>
--%>
</TABLE>