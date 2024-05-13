<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.contact.ProductQnaDAO"%>
<%@ page import="project.bean.contact.ProductQnaDTO"%>
<%@ page import="project.bean.member.MemberDAO" %>
<%@ page import="project.bean.member.MemberDTO" %>
<link rel="stylesheet" href="/project/views/css/c_style.css">
<jsp:include page="../main/header.jsp"/>
<%
	int num = Integer.parseInt(request.getParameter("num"));
	String pageNum = request.getParameter("pageNum");
	ProductQnaDAO dao = ProductQnaDAO.getInstance();
	ProductQnaDTO dto = dao.content(num);  
	
	String svendor="";
	String bName="";
	if (session.getAttribute("svendor") != null) {
		svendor = (String)session.getAttribute("svendor");
		if(svendor=="2"){
			MemberDAO daom = MemberDAO.getInstance();
			MemberDTO dtom = daom.memberInfo(Integer.parseInt(svendor));
			bName = dtom.getBusiness_name();
		}
	}
	
%>
<div id="contents">
	<div class="sub_content">
		<div class="board_zone_sec">
			<div class="board_zone_tit">
				<h2>상품문의 답글작성</h2>
			</div>
			<div class=board_zone_cont>
				<div class="board_zone_view">
					<div class="board_view_tit">
						<strong><%=dto.getTitle() %></strong>
					</div>
					<div class="board_view_info">
						<span class="view_info_id">						
							<%=dto.getMember_name() %>
						</span>
						<span class="view_info_day">
							<%=dto.getReg() %>
						</span>
						<span class="view_info_hits">
							조회수 : <%=dto.getReadCount() %>
						</span>
					</div>
					<div class="board_view_content">
						<div class="view_goods_select"></div>
						<div class="board_view_qa">
						<%-- 질문창 --%>
							<div class="view_question_box">
								<strong class="view_question_tit">Q.</strong>
								<div class="seem_cont">
									<div style="margin: 10px 0 10px 0">
										<p><%=dto.getQuestion() %></p>
											<%	if(dto.getImg() !=null){%>
											<img src="/project/views/upload/<%=dto.getImg() %>"/>
											<%	}%>
									</div>
								</div>
							</div>
							<%-- 답변창 --%>							
							<div class="view_answer_box">
								<strong class="view_answer_tit">A.</strong>
								<div class="view_answer_info">
									<strong>답변입니다.</strong>
									<span class="view_info_id"><%=bName %></span>
								</div>
								<div class="seem_cont">
									<div style="margin: 10px 0 10px 0">
										<form action="productQnaAnswerPro.jsp?num=<%=num %>&pageNum=<%=pageNum %>" method="post">
											<textarea name="answer" cols="75" rows="10"></textarea>
											<div class="btn_center_box">
												<button type="button" class="btn_before" onclick="history.back()">
													<strong>이전</strong>
												</button>
												<button type="submit" class="btn_write_ok">
													<strong>작성 / 수정</strong>
												</button>
											</div>			
										</form>
									</div>
								</div>
							</div>
						</div>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>