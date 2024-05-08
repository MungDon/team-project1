<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="project.bean.contact.FaqDAO"%>
<%@ page import="project.bean.contact.FaqDTO"%>
<link rel="stylesheet" href="/project/views/css/c_style.css">
<jsp:include page="../main/header.jsp"/>
<%

	int num = Integer.parseInt(request.getParameter("faq_num"));
	String pageNum = request.getParameter("pageNum");
	
	FaqDAO dao = FaqDAO.getInstance();
	FaqDTO dto = dao.faqUpdateForm(num);
	
	int snum=0;
	if(session.getAttribute("snum") != null ){
		snum = (int)session.getAttribute("snum");
	}%>
	
<div id="contents">
	<div class="sub_content">
		<div class="board_zone_sec">
			<div class="board_zone_tit">
				<h2>자주 찾는 질문 삭제</h2>
			</div>
			<div class=board_zone_cont>
				<div class="board_zone_view">
					<div class="board_view_tit">
						<strong>[<%=dto.getCategory() %>]</strong>					
					</div>
					<div class="board_view_info">
						<span class="view_info_day">
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
									</div>
								</div>
							</div>
							<%-- 답변창 --%>
							<div class="view_answer_box">
								<strong class="view_answer_tit">A.</strong>
									<div class="view_answer_info">
										<span class="view_info_id"></span>
									</div>
									<div class="seem_cont">
										<div style="margin: 10px 0 10px 0">
											<p><%=dto.getAnswer() %></p>
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
				<div class="btn_center_box">
					<form action="faqDeletePro.jsp?faq_num=<%=num%>">
						<input type="hidden" name="faq_num" value="<%=num %>"/>
						<button type="submit" class="btn_update">
							<strong>삭제</strong>
						</button>
					</form>
				</div>
				<div class="btn_right_box">
				<button type="submit" class="btn_write" onclick="history.back()">
					<strong>이전</strong>
				</button>
			</div>