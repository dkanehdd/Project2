<%@page import="model.MemberDAO"%>
<%@page import="model.MemberDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="../member/isLogin.jsp"%>
<%
int nowPage = (request.getParameter("nowPage") == null || request.getParameter("nowPage").equals(""))
	? 1
	: Integer.parseInt(request.getParameter("nowPage"));
String id = session.getAttribute("USER_ID").toString();
MemberDAO dao = new MemberDAO();
MemberDTO dto = dao.getMemberDTO(id);
dao.close();
%>
<%@ include file="../include/global_head.jsp"%>
<script>
	/*연습문제] 글쓰기 폼에 빈값이 있는경우 서버로 전송되지 않도록 
	아래 validate()함수를 완성하시오. 모든값이 입력되었다면 WriteProc.jsp로
	submit되어야 한다.
	 */
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
		if (!fm.attachedfile.value) {
			alert("첨부파일을 등록해주세요");
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

						<form enctype="multipart/form-data" onsubmit="return checkValidate(this);" action="PWriteProc.jsp"
						method="post">
							<table class="table table-bordered">
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
									<tr>
										<th class="text-center" style="vertical-align: middle;">이메일</th>
										<td><input type="text" class="form-control"
											style="width: 400px;" value="<%=dto.getEmail() %>" readonly="readonly"/></td>
									</tr>
<!-- 									<tr> -->
<!-- 										<th class="text-center" style="vertical-align: middle;">패스워드</th> -->
<!-- 										<td><input type="text" class="form-control" -->
<!-- 											style="width: 200px;" /></td> -->
<!-- 									</tr> -->
									<tr>
										<th class="text-center" style="vertical-align: middle;">제목</th>
										<td><input type="text" name="title" class="form-control" /></td>
									</tr>
									<tr>
										<th class="text-center" style="vertical-align: middle;">내용</th>
										<td><textarea rows="10" name="content" class="form-control"></textarea>
										</td>
									</tr>
									<tr>
										<th class="text-center" style="vertical-align: middle;">첨부파일</th>
										<td><input type="file"  name="attachedfile" class="form-control" /></td>
									</tr>
								</tbody>
							</table>

							<div class="row text-right" style="">
								<!-- 각종 버튼 부분 -->

								<button type="submit" class="btn btn-danger">전송하기</button>
								<!-- 	<button type="reset" class="btn">Reset</button> -->
								<button type="button" class="btn btn-warning"
									onclick="location.href='sub04.jsp?nowPage=<%=nowPage%>';">리스트보기</button>
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