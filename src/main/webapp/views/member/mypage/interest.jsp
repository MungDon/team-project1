<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

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

<SCRIPT>
	var masterCheckbox = document.getElementById("masterCheckbox");	//마스터 체크 박스 변수
	var slaveCheckboxes = document.querySelectorAll(".slaveCheckbox");	//슬레이브 체크 박스 변수
		
	masterCheckbox.addEventListener('change', function() {
    	// 마스터 체크박스의 상태에 따라 슬레이브 체크박스들의 상태를 변경
    	for (var i = 0; i < slaveCheckboxes.length; i++) {
      	slaveCheckboxes[i].checked = masterCheckbox.checked;
    	}
	});
</SCRIPT>

<DIV style="font-size:25px; font-weight:bold"> 관심상품 </DIV> <br />

<TABLE border=1; width="780px">
	<TR>
		<TH><INPUT type="checkbox" id="masterCheckbox" /></TH>
		<TH>상품명</TH>
		<TH>상품금액/수량</TH>
		<TH>합계</TH>
	</TR>
</TABLE>