<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.contact.ProductQnaDAO"%>
<%@ page import="project.bean.contact.ProductQnaDTO"%>
<link rel="stylesheet" href="/project/views/css/c_style.css">
<jsp:include page="../main/header.jsp"/>
<%
	int snum=0;
	String pageNum = "";
	int num = Integer.parseInt(request.getParameter("num"));
	
	if(session.getAttribute("snum") != null) {
	    snum = (int) session.getAttribute("snum");
	}
	
	if(request.getParameter("pageNum")!=null){
		pageNum = request.getParameter("pageNum");
	}
	
	ProductQnaDAO dao = ProductQnaDAO.getInstance();
	ProductQnaDTO dto = dao.content(num);
%>
<div id="contents">
	<div class="sub_content">
		<div class="content">
			<div class="board_zone_sec">
				<div class="board_zone_tit"><h2>상품문의글 삭제</h2></div>
				<div class="board_view_tit">
					<strong><%=dto.getTitle()%></strong>
				</div>
<form action="productQnaDeletePro.jsp?num=<%=num %>&pageNum=<%= pageNum %>" method="post">

	<div class="board_write_box">
		<table class="board_write_table">

			<tr>
				<th scope="row">비밀번호</th>
				<td><input type="password" name="password"/></td>
			</tr>			
		</table>
				<div class="btn_center_box">
					<button class="btn_before" onclick="window.location='productQnaList.jsp?pageNum=<%=pageNum%>'">
						<strong>이전</strong>
					</button>
					<button type="submit" class="btn_update">
						<strong>삭제</strong>
					</button>
				</div>
	</div>	 
</form>
			</div>
		</div>
	</div>
</div>
<button onclick="window.location='qnaList.jsp?pageNum=<%=pageNum%>'">목록으로</button>