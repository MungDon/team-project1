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
    
	vendor = MemberVendor.getNameByVendor(dto.getVendor());
	del = MemberStatus.getNameByStatus(dto.getDel()); 
	%>
<div class="main">
<div class="detailTableBox">
<form action="memberUpdatePro.jsp" method="post">
	<table class="detailTable">
		<tr>
			<th>회원번호</th>
				<td><input type="hidden" name="member_num" value="<%=dto.getMember_num() %>"></td>
			<th>ID</th>
			<td><input type="text" name="id" value="<%=dto.getId() %>"></td>
		</tr>
		<tr>
			<th>회원권한</th>
			<td>
			
				<select name="vendor">
					<option value="<%=dto.getVendor()%>" selected><%=dto.getVendor()%></option>	
					<option value="0">판매자 승인대기</option>	
					<option value="1">일반회원</option>	
					<option value="2">판매자</option>	
				</select>
			</td>
			<th>사업자번호</th>
			<td><%=dto.getBusiness_number()%></td>
		</tr>
		<tr>
			<th>사업장 명</th>
			<td><%=dto.getBusiness_name() %></td>
			<th>회원명</th>
			<td><input type="text" name="name" value="<%=dto.getName() %>"></td>
		</tr>
		<tr>
			<th>이메일</th>
			<td><%=dto.getEmail() %></td>
			<th>핸드폰</th>
			<td><%=dto.getCellphone() %></td>
		</tr>
		<tr>
			<th>전화번호</th>
			<td><%=dto.getPhone()%></td>
			<th>성별</th>
			<td><%=dto.getGender()%></td>
		</tr>
		<tr>
			<th>생일</th>
			<td><%=dto.getBirth()%></td>
			<th>등급</th>
			<td>
				<select name="grade">
					<option value="<%=dto.getGrade()%>"selected><%=dto.getGrade()%></option>			
					<option value="BRONZE">BRONZE</option>			
					<option value="SILVER">SILVER</option>			
					<option value="GOLD">GOLD</option>			
				</select>
			</td>
		</tr>
		<tr>
			<th>가입일자</th>
			<td><%=dto.getReg() %></td>
			<th>탈퇴여부</th>
			<td>
				<%=del%>
				<button type="button" onclick="deleteMember(<%=member_num%>)">강제탈퇴</button>
			</td>
		</tr>
	</table>
<button type="submit">수정완료</button>
<button type="button" onclick="location.href='memberDetail.jsp?member_num=<%=member_num%>'">취소</button>
</form>
</div>

</div>
<script>
	function deleteMember(member_num){
		if(!confirm("회원을 탈퇴시키겠습니까?")){
			return false;
		}
		location.href="memberDeletePro.jsp?member_num="+member_num;
	}

</script>