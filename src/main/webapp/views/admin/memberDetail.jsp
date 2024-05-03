<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="project.bean.admin.AdminDAO"%>
<%@ page import="java.util.List"%>
<%@ page import="project.bean.member.MemberDTO"%>
<%@ page import="java.lang.reflect.Field"%>
<style>
	.main{
		display: flex;
		align-items: center;
		justify-content: center;
	}
	.detailTableBox{
		border : 1px solid #000;
		display: flex;
		align-items: center;
		justify-content: center;
		width : 1000px;
		height : 700px;
		
	}
	.detailTable{
		border : 1px solid #000;
		text-align: center;
	}
</style>
<% 
	int member_num = Integer.parseInt(request.getParameter("member_num"));
	String vendor="";	
	String del ="";
	AdminDAO dao = AdminDAO.getInstance();
	MemberDTO dto = dao.memberDetail(member_num);
	
	Field[] fields = dto.getClass().getDeclaredFields();
	for (Field field : fields) {
         field.setAccessible(true); // private 필드에 접근하기 위해 접근 가능하도록 설정
         Object value = field.get(dto); // 해당 필드의 값을 가져옴
		if(value == null){
			switch(field.getName()){
				case "email":
					dto.setEmail("없음");
					break;
				case "phone" : 
					dto.setPhone("없음");
					break;
				case "birth":
					dto.setBirth("없음");
			}
		}
	}
    
    switch(dto.getVendor()){
		case "0":
			vendor = "판매자 가입 승인대기";
			break;
		case "1" : 
			vendor = "일반회원";
			break;
		case "2" : 
			vendor = "판매자 회원";
			break;
	}
    
    switch(dto.getDel()){
    	case "1" :
    		del = "가입";
    		break;
    	case "2" :
    		del="탈퇴";
    		break;
    }
	%>
<div class="main">
<div class="detailTableBox">
<table class="detailTable">
	<tr>
		<th>회원번호</th>
		<td><%=dto.getMember_num() %></td>
		<th>ID</th>
		<td><%=dto.getId() %></td>
	</tr>
	<tr>
		<th>회원권한</th>
		<td><%=vendor %></td>
		<th>사업자번호</th>
		<td><%=dto.getBusiness_number() %></td>
	</tr>
	<tr>
		<th>사업장 명</th>
		<td><%=dto.getBusiness_name() %></td>
		<th>회원명</th>
		<td><%=dto.getName() %></td>
	</tr>
	<tr>
		<th>이메일</th>
		<td><%=dto.getEmail() %></td>
		<th>핸드폰</th>
		<td><%=dto.getCellphone() %></td>
	</tr>
	<tr>
		<th>전화번호</th>
		<td><%=dto.getPhone() %></td>
		<th>성별</th>
		<td><%=dto.getGender()%></td>
	</tr>
	<tr>
		<th>생일</th>
		<td><%=dto.getBirth() %></td>
		<th>등급</th>
		<td><%=dto.getGender() %></td>
	</tr>
	<tr>
		<th>가입일자</th>
		<td><%=dto.getReg() %></td>
		<th>탈퇴여부</th>
		<td><%=del%></td>
	</tr>

</table>
</div>
</div>