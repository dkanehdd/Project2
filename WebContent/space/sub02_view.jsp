<%@page import="model.CalenderDTO"%>
<%@page import="model.CalenderDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%
//파라미터로 전송된 게시물의 일련번호를 받음
String num = request.getParameter("num");

CalenderDAO dao = new CalenderDAO();
//조회수를 업데이트하여 visitcount컬럼을 1증가시킴

//일련번호에 해당하는 게시물을 DTO객체로 반환함.
CalenderDTO dto = dao.selectView(num); 
 
dao.close();
%>

 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/space/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/space_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/space/sub02_title.gif" alt="프로그램일정" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;프로그램일정<p>
				</div>
				<div>

<form enctype="multipart/form-data">
<table class="table table-bordered">
<colgroup>
	<col width="20%"/>
	<col width="30%"/>
	<col width="20%"/>
	<col width="*"/>
</colgroup>
<tbody>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">작성자</th>
		<td>
			<%=dto.getName() %>
		</td>
		<th class="text-center" 
			style="vertical-align:middle;">작성일</th>
		<td>
			<%=dto.getPdate() %>
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">제목</th>
		<td colspan="3">
			<%=dto.getTitle() %>
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">내용</th>
		<td colspan="3">
			<%=dto.getContents().replace("\r\n", "<br/>") %> 
		</td>
	</tr>
	
</tbody>
</table>

<div class="row text-center" style="">
	<!-- 각종 버튼 부분 -->
<!-- 	<button type="button" class="btn btn-primary">수정하기</button> -->
<!-- 	<button type="button" class="btn btn-success">삭제하기</button>	 -->
	<button type="button" class="btn btn-warning" 
					onclick="location.href='sub01.jsp';">리스트보기</button>
</div>
</form> 

				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>


	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>