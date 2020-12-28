<%@page import="util.PagingUtil"%>
<%@page import="model.PhotoDTO"%>
<%@page import="java.util.List"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="model.PhotoDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
PhotoDAO dao = new PhotoDAO();

Map<String, Object> param = new HashMap<String, Object>();
String queryStr = "";

String searchColumn = request.getParameter("searchColumn");
String searchWord = request.getParameter("searchWord");
if (searchWord != null) {
	param.put("Column", searchColumn);
	param.put("Word", searchWord);

	queryStr += "searchColumn=" + searchColumn + "&searchWord=" + searchWord + "&";
}
int totalRecordCount = dao.getTotalRecordCountSearch(param);// join O

/*********** 페이지처리를 위한 코드 추가 start ************/
//한페이지에 출력할 레코드의 갯수 : 10
int pageSize = Integer.parseInt(application.getInitParameter("PHOTO_PAGE_SIZE"));
//한 블럭당 출력할 페이지의 갯수 : 5
int blockPage = Integer.parseInt(application.getInitParameter("BLOCK_PAGE"));

// int totalPage = (int)Math.ceil((double)totalRecordCount/pageSize);
//System.out.println(totalPage);

int nowPage = (request.getParameter("nowPage") == null || request.getParameter("nowPage").equals("")) ? 1
		: Integer.parseInt(request.getParameter("nowPage"));

//한페이지에 출력할 게시물의 범위를 결정한다. MariaDB에서는 limit를 사용하므로
//계산식이 조금 달라지게 된다.
int start = (nowPage - 1) * pageSize;
int end = pageSize;
//게시물의 범위를 Map컬렉션에 저장하고 DAO로 전달한다.
param.put("start", start);
param.put("end", end);

List<PhotoDTO> lists = dao.selectListPageSearch(param);
//DB자원해제
dao.close();
%>
<%@ include file="../include/global_head.jsp"%>


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
						<div class="row text-right"
							style="margin-bottom: 20px; padding-right: 50px;">
							<!-- 검색부분 -->
							<form class="form-inline">
								<div class="form-group">
									<select name="searchColumn" class="form-control">
										<option value="title"
											<%=(searchColumn != null && searchColumn.equals("title")) ? "selected" : ""%>>제목</option>
										<option value="content"
											<%=(searchColumn != null && searchColumn.equals("content")) ? "selected" : ""%>>내용</option>
										<option value="name"
											<%=(searchColumn != null && searchColumn.equals("name")) ? "selected" : ""%>>작성자</option>
									</select>
								</div>
								<div class="input-group">
									<input type="text" name="searchWord" class="form-control" />
									<div class="input-group-btn">
										<button type="submit" class="btn btn-default"
											style="height: 34px">
											<i class="glyphicon glyphicon-search"></i>
										</button>
									</div>
								</div>
							</form>
						</div>
						<div class="row">
						<table>
							<%
								/*
							List컬렉션에 입력된 데이터가 없을때 true를 반환
							*/
							if (lists.isEmpty()) {
								//게시물이 없는경우
							%>
							<tr>
								<td colspan="5" align="center">등록된 게시물이 없습니다.</td>
							</tr>
							<%
								} else {
							int vNum = 0;//게시물의 가상번호로 사용할 변수
							int countNum = 0;

							for (PhotoDTO dto : lists) {
							%>
							<!-- 리스트반복 -->
							<div class="thumbnail col-md-3"
								style="border: 0; padding: 10px;">
								<a href="sub04_view.jsp?num=<%=dto.getNum()%>&nowPage=<%=nowPage%>&<%=queryStr%>"><img
									src="/Project2/images/upload/<%=dto.getAttachedfile()%>"
									alt="<%=dto.getAttachedfile()%>" style="width: 95%; height: 200px;">
									<div class="caption">
										<p><%=dto.getTitle()%></p>
										<%=dto.getName() %>
										<p><span class="glyphicon glyphicon-time"></span> <%=dto.getPostdate()%>&nbsp;&nbsp;
										<span class="glyphicon glyphicon-eye-open"></span> <%=dto.getVisitcount()%></p>
									</div>
								</a>
							</div>
							<!-- 리스트반복 -->
							<%
								}
							}
							%>
							</table>
							</div>
							<div class="row text-right" style="position: ;">
							<!-- 각종 버튼 부분 -->
							<!-- <button type="reset" class="btn">Reset</button> -->

							<button type="button" class="btn btn-info"
								onclick="location.href='sub04_write.jsp';">글쓰기</button>

							<!-- <button type="button" class="btn btn-primary">수정하기</button>
	<button type="button" class="btn btn-success">삭제하기</button>
	<button type="button" class="btn btn-info">답글쓰기</button>
	<button type="button" class="btn btn-warning">리스트보기</button>
	<button type="submit" class="btn btn-danger">전송하기</button> -->
						</div>
						<div class="row text-center">
							<!-- 페이지번호 부분 -->
							<ul class="pagination pager">
								<%=PagingUtil.pagingBS4(totalRecordCount, pageSize, blockPage, nowPage, "sub04.jsp?" + queryStr)%>
							</ul>
						</div>	
						
					</div>
				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp"%>
		</div>


		<%@ include file="../include/footer.jsp"%>
	</center>
</body>
</html>
