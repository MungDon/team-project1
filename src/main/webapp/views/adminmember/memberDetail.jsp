<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="project.bean.admin.AdminDAO"%>
<%@ page import="java.util.List"%>
<%@ page import="project.bean.member.MemberDTO"%>
<%@ page import="java.lang.reflect.Field"%>
<%@ page import="project.bean.enums.MemberVendor" %>
<%@ page import="project.bean.enums.MemberStatus" %>
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
		border-collapse: collapse;
		font-size: 25px;
		width : 1000px;
		height : 700px;
		border : 1px solid #000;
		text-align: center;
	}
</style>
<jsp:include page="../admin/adminHeader.jsp"></jsp:include>
<% 
	AdminDAO dao = AdminDAO.getInstance();
	String vendor="";	
	String del ="";
	int member_num = 0;
	
	if(request.getParameter("member_num")!=null){
		member_num = Integer.parseInt(request.getParameter("member_num"));
	}else{%>
		<script>
			alert("회원 시퀀스가 없습니다 코드 확인 요망");
			location.href="allMemberList.jsp";
		</script>
		
<%	}
		
	
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
    
	vendor = MemberVendor.getNameByVendor(dto.getVendor());
	del = MemberStatus.getNameByStatus(dto.getDel());
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
<button type="button" onclick="location.href='memberUpdateForm.jsp?member_num=<%=member_num%>'">수정</button>
<<<<<<< HEAD:src/main/webapp/views/adminmember/memberDetail.jsp
<%if(del.equals("가입")){ %>	
	<button type="button" onclick="deleteMember(<%=member_num%>)">강제탈퇴</button>
<%}else{ %>
	<button type="button" onclick="restore(<%=member_num%>)">회원복구</button>
<%} %>
=======
<button type="button" onclick="deleteMember(<%=member_num%>)">강제탈퇴</button>
>>>>>>> 985aa94e13d847cb082451a7180777d1ca208f91:src/main/webapp/views/admin/memberDetail.jsp
</div>
<script>
	function deleteMember(member_num){
		if(!confirm("회원을 탈퇴시키겠습니까?")){
			return false;
		}
<<<<<<< HEAD:src/main/webapp/views/adminmember/memberDetail.jsp
		location.href="memberDeletePro.jsp?del=2&member_num="+member_num;
	}
	function restore(member_num){
		if(!confirm("회원을 복구시키겠습니까?")){
			return false;			
		}
		location.href="memberRestorePro.jsp?del=1&member_num="+member_num";
		
	}
=======
		location.href="memberDeletePro.jsp";
	}

>>>>>>> 985aa94e13d847cb082451a7180777d1ca208f91:src/main/webapp/views/admin/memberDetail.jsp
</script>