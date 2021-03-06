<%@page import="util.JavascriptUtil"%>
<%@page import="model.BoardDTO"%>
<%@page import="model.BoardDAO"%>
<%@page import="model.MemberDAO"%>
<%@page import="model.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../member/isLogin.jsp"%>
<%
String num = request.getParameter("num");
BoardDAO dao = new BoardDAO();
int nowPage = (request.getParameter("nowPage")==null ||
request.getParameter("nowPage").equals("")) ?
		1 : Integer.parseInt(request.getParameter("nowPage"));
//본인이 작성한 게시물이므로 조회수 증가는 의미 없엉.

//일련번호에 해당하는 게시물을 DTO객체로 반환함.
BoardDTO dto = dao.selectView(num);
dao.close();
//본인확인 후 작성자가 아니면 뒤로보내기
if(!session.getAttribute("USER_ID").toString().equals(dto.getId())){
	JavascriptUtil.jsAlertBack("작성자 본인만 수정 가능합니다.", out);
	return;
}
%>
<%@ include file="../include/global_head.jsp"%>
<script>
	function checkValidate(fm) {
		if (!fm.title.value) {
			alert("제목을 입력하세요");
			fm.title.focus();
			return false;
		}
		if (!fm.content.value) {
			alert("내용을 입력하세요");
			fm.content.focus();
			return false;
		}
	}
</script>

<body>
	<center>
		<div id="wrap">
			<%@ include file="../include/top.jsp"%>

			<img src="../images/space/sub_image.jpg" id="main_visual" />

			<div class="contents_box">
				<div class="left_contents">
					<%@ include file="../include/space_leftmenu.jsp"%>
				</div>
				<div class="right_contents">
					<div class="top_title">
						<img src="../images/space/sub04_title.gif" alt="사진게시판"
							class="con_title" />
						<p class="location">
							<img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;사진게시판
						<p>
					</div>
					<div>

						<form enctype="multipart/form-data" onsubmit="return checkValidate(this);" action="editProc.jsp"
						method="post">
							<table class="table table-bordered">
							<input type="hidden" name="num" value="<%=num%>"/>
							<input type="hidden" name="originalfile" value="<%=dto.getAttachedfile() %>"/>
							<input type="hidden" name="flag" value="<%=dto.getFlag()%>"/>
								<colgroup>
									<col width="20%" />
									<col width="*" />
								</colgroup>
								<tbody>
									<tr>
										<th class="text-center" style="vertical-align: middle;">작성자</th>
										<td><input type="text" class="form-control"
											style="width: 100px;" value="<%=dto.getName() %>" readonly="readonly"/></td>
									</tr>
<!-- 									<tr> -->
<!-- 										<th class="text-center" style="vertical-align: middle;">아이디</th> -->
<!-- 										<td><input type="text" class="form-control" -->
<%-- 											style="width: 400px;" value="<%=dto.getId() %>" readonly="readonly"/></td> --%>
<!-- 									</tr> -->
<!-- 									<tr> -->
<!-- 										<th class="text-center" style="vertical-align: middle;">패스워드</th> -->
<!-- 										<td><input type="text" class="form-control" -->
<!-- 											style="width: 200px;" /></td> -->
<!-- 									</tr> -->
									<tr>
										<th class="text-center" style="vertical-align: middle;">제목</th>
										<td><input type="text" name="title" class="form-control" value="<%=dto.getTitle()%>"/></td>
									</tr>
									<tr>
										<th class="text-center" style="vertical-align: middle;">내용</th>
										<td><textarea rows="10" name="content" class="form-control"><%=dto.getContent().replace("\r\n", "<br/>") %></textarea>
										</td>
									</tr>
									<tr>
										<th class="text-center" style="vertical-align: middle;">원본파일</th>
										<td><%=dto.getAttachedfile()%></td>
										
									</tr>
									<tr>
										<th class="text-center" style="vertical-align: middle;">첨부파일</th>
										<td><input type="file" name="attachedfile" class="form-control" /></td>
									</tr>
								</tbody>
							</table>

							<div class="row text-right" style="">
								<!-- 각종 버튼 부분 -->

								<button type="submit" class="btn btn-danger">전송하기</button>
								<!-- 	<button type="reset" class="btn">Reset</button> -->
								<button type="button" class="btn btn-warning"
									onclick="location.href='sub01_list.jsp?flag=<%=dto.getFlag()%>';">리스트보기</button>
							</div>
						</form>

					</div>
				</div>
			</div>
			<%@ include file="../include/quick.jsp"%>
		</div>

		<%@ include file="../include/footer.jsp"%>
	</center>
</body>
</html>