<%@page import="model.BoardDTO"%>
<%@page import="model.BoardDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%
String queryStr="";
String searchColumn = request.getParameter("searchColumn");
String searchWord = request.getParameter("searchWord");
if(searchWord!=null&&!searchWord.equals("")){
	queryStr += "searchColumn="+searchColumn
			+"&searchWord="+searchWord;
}
String nowPage = request.getParameter("nowPage")==null?"1":request.getParameter("nowPage");
queryStr += "&nowPage="+nowPage;
String sortColumn = request.getParameter("sortColumn");
if(sortColumn!=null){
	queryStr += "&sortColumn="+sortColumn+"&";
}
//파라미터로 전송된 게시물의 일련번호를 받음
String num = request.getParameter("num");

BoardDAO dao = new BoardDAO();
//조회수를 업데이트하여 visitcount컬럼을 1증가시킴
dao.updateVisitCount(num); 

//일련번호에 해당하는 게시물을 DTO객체로 반환함.
BoardDTO dto = dao.selectView(num);

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
					<img src="../images/space/sub03_title.gif" alt="자유게시판" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;자유게시판<p>
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
			<%=dto.getPostdate() %>
		</td>
	</tr>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">이메일</th>
		<td>
			<%=dto.getEmail() %>
		</td>
		<th class="text-center" 
			style="vertical-align:middle;">조회수</th>
		<td>
			<%=dto.getVisitcount() %>
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
			<%=dto.getContent().replace("\r\n", "<br/>") %> 
		</td>
	</tr>
	<%if(dto.getAttachedfile()!=null){ %>
	<tr>
		<th class="text-center" 
			style="vertical-align:middle;">첨부파일</th>
		<td colspan="3">
			<%=dto.getAttachedfile()%> 
		</td>
	</tr>
	<%} %>
</tbody>
</table>

<div class="row text-center" style="">
	<!-- 각종 버튼 부분 -->
	<%
	if(session.getAttribute("USER_ID")!=null &&
		session.getAttribute("USER_ID").toString().equals(dto.getId())){
	%>
	<button type="button" class="btn btn-info p-1 ml-3" onclick="location.href='sub03_edit.jsp?num=<%=num%>'">수정하기</button>
	<button type="button" class="btn btn-danger mr-auto" onclick="location.href='deleteProc.jsp?num=<%=num%>&flag=<%=dto.getFlag()%>'">삭제하기</button>	
	<%}%>
	<button type="button" class="btn btn-warning ml-auto mr-3" 
					onclick="location.href='sub01_list.jsp?<%=queryStr%>&flag=<%=dto.getFlag()%>';">리스트보기</button>
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