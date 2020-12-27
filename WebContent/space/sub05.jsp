<%@page import="util.PagingUtil"%>
<%@page import="java.util.HashMap"%>
<%@page import="model.BoardDAO"%>
<%@page import="java.util.Map"%>
<%@page import="model.BoardDTO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
BoardDAO dao = new BoardDAO();
 
Map<String, Object> param = new HashMap<String, Object>();
param.put("notice", "F");
String queryStr = "";

String searchColumn = request.getParameter("searchColumn");
String searchWord = request.getParameter("searchWord");
if(searchWord!=null){
	param.put("Column", searchColumn);
	param.put("Word", searchWord);
	
	queryStr += "searchColumn="+searchColumn
			+"&searchWord="+searchWord+"&";
}
String sortColumn = request.getParameter("sortColumn");
if(sortColumn!=null){
	param.put("Sort", sortColumn);
	queryStr += "&sortColumn="+sortColumn+"&";
}
int totalRecordCount = dao.getTotalFileRecordCountSearch(param);// join O
 
/*********** 페이지처리를 위한 코드 추가 start ************/
//한페이지에 출력할 레코드의 갯수 : 10
int pageSize = Integer.parseInt(application.getInitParameter("PAGE_SIZE"));
//한 블럭당 출력할 페이지의 갯수 : 5
int blockPage = Integer.parseInt(application.getInitParameter("BLOCK_PAGE"));

int totalPage = (int)Math.ceil((double)totalRecordCount/pageSize);
//System.out.println(totalPage);

int nowPage = (request.getParameter("nowPage")==null ||
	request.getParameter("nowPage").equals("")) ?
			1 : Integer.parseInt(request.getParameter("nowPage"));

//한페이지에 출력할 게시물의 범위를 결정한다. MariaDB에서는 limit를 사용하므로
//계산식이 조금 달라지게 된다.
int start = (nowPage-1)*pageSize;
int end = pageSize;
//게시물의 범위를 Map컬렉션에 저장하고 DAO로 전달한다.
param.put("start", start);
param.put("end", end);

List<BoardDTO> lists = dao.selectFileListPageSearch(param);
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
						<img src="../images/space/sub05_title.gif" alt="정보자료실"
							class="con_title" />
						<p class="location">
							<img src="../images/center/house.gif" />&nbsp;&nbsp;열린공간&nbsp;>&nbsp;정보자료실
						<p>
					</div>
					<div>

						<div class="row text-right" style="margin-bottom:20px;
		padding-right:50px;">
<!-- 검색부분 -->
<form class="form-inline">	
	<div class="form-group">
		<select name="searchColumn" class="form-control">
			<option value="title" 
			<%=(searchColumn!=null && searchColumn.equals("title")) ?
					"selected":""%>>제목</option>
			<option value="content" 
			<%=(searchColumn!=null && searchColumn.equals("content")) ?
					"selected":""%>>내용</option>
			<option value="name"
			<%=(searchColumn!=null && searchColumn.equals("name")) ?
					"selected":""%>>작성자</option>
		</select>
	</div>
	<div class="input-group">
		<input type="text" name="searchWord"  class="form-control"/>
		<div class="input-group-btn">
			<button type="submit" class="btn btn-default" style="height: 34px">
				<i class="glyphicon glyphicon-search"></i>
			</button>
		</div>
	</div>
</form>	
</div>
						<div class="row">
	<!-- 게시판리스트부분 -->
	<table class="table table-bordered table-hover">
	<colgroup>
		<col width="80px"/>
		<col width="*"/>
		<col width="120px"/>
		<col width="120px"/>
		<col width="80px"/>
		<col width="50px"/>
	</colgroup>
	
	<thead>
	<tr class="info">
		<th class="text-center">번호</th>
		<th class="text-left">제목</th>
		<th class="text-center">작성자</th>
		<th class="text-center">작성일</th>
		<th class="text-center">조회수</th>
		<th class="text-center">첨부</th>
	</tr>
	</thead>
	
	<tbody>
	<%
/*
List컬렉션에 입력된 데이터가 없을때 true를 반환
*/
if(lists.isEmpty()){
	//게시물이 없는경우
%>
	<tr>
		<td colspan="5" align="center">
			등록된 게시물이 없습니다.
		</td>
	</tr>
<%
}
else{
	int vNum = 0;//게시물의 가상번호로 사용할 변수
	int countNum = 0;
	
	for(BoardDTO dto : lists){
		vNum = totalRecordCount - (((nowPage-1) * pageSize) + countNum++);

%>
				<!-- 리스트반복 -->
				<tr>
					<td class="text-center"><%=vNum %></td>
					<td class="text-left">
						<a href="sub05_view.jsp?num=<%=dto.getNum()%>&nowPage=<%=nowPage %>&<%=queryStr%>">
							<%=dto.getTitle() %>
						</a>
					</td>
					<td class="text-center"><%=dto.getName() %></td>
					<td class="text-center"><%=dto.getPostdate() %></td>
					<td class="text-center"><%=dto.getVisitcount() %></td>
 					<td class="text-center">
 						<i class="glyphicon glyphicon-download-alt" style="font-size:20px"></i> 
					</td> 
				</tr>
				<!-- 리스트반복 -->
<% } 
}
%>
	</tbody>
	</table>
</div>
						<div class="row text-right" style="">
							<!-- 각종 버튼 부분 -->
							<!-- <button type="reset" class="btn">Reset</button> -->

							<button type="button" class="btn btn-default"
								onclick="location.href='sub05_write.jsp';">글쓰기</button>

							<!-- <button type="button" class="btn btn-primary">수정하기</button>
	<button type="button" class="btn btn-success">삭제하기</button>
	<button type="button" class="btn btn-info">답글쓰기</button>
	<button type="button" class="btn btn-warning">리스트보기</button>
	<button type="submit" class="btn btn-danger">전송하기</button> -->
						</div>
						<div class="row text-center">
							<!-- 페이지번호 부분 -->
							<ul class="pagination pager">
		<%=PagingUtil.pagingBS4(totalRecordCount, 
					pageSize, blockPage, nowPage, "sub05.jsp?"+queryStr) %>
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
