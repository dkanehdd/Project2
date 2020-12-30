<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="../include/global_head.jsp" %>


 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/community/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				
				<%@ include file = "../include/community_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/community/sub02_title.gif" alt="보호자 게시판" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;커뮤니티&nbsp;>&nbsp;보호자 게시판<p>
				</div>
				<div>

						<div class="row text-right"
							style="margin-bottom: 20px; padding-right: 50px;">
							<!-- 검색부분 -->
							<form class="form-inline">
							<input type="hidden" name="admin" value="F"/>
								<div class="form-group">
									<select name="searchColumn" class="form-control">
										<option value="title">제목</option>
										<option value="content">내용</option>
										<option value="name">작성자</option>
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
							<!-- 게시판리스트부분 -->
							<table class="table table-bordered">
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
										<th class="text-center">제목</th>
										<th class="text-center">작성자</th>
										<th class="text-center">작성일</th>
										<th class="text-center">조회수</th>
										<th class="text-center">첨부</th>
									</tr>
								</thead>
								<tbody>
									<c:choose>
										<c:when test="${empty lists }">
											<tr>
												<td colspan="6" align="center">등록된 게시물이 없습니다.</td>
											</tr>
										</c:when>
										<c:otherwise>
											<c:forEach items="${lists }" var="row" varStatus="loop">
												<!-- 리스트반복 start -->
												<tr>
													<td class="text-center">${map.totalCount - (((map.nowPage-1)*map.pageSize) + loop.index) }
													</td>
													<td class="text-left"><a
														href="../community/view?num=${row.num }&admin=F&nowPage=${map.nowPage}&searchColumn=${param.searchColumn}&searchWord=${param.searchWord}">
															${row.title } </a></td>
													<td class="text-center">${row.name }</td>
													<td class="text-center">${row.postdate }</td>
													<td class="text-center">${row.visitcount }</td>
												<td class="text-center"><i class="glyphicon glyphicon-download-alt" style="font-size:20px"></i></td>
												</tr>
												<!-- 리스트반복 end -->
											</c:forEach>

										</c:otherwise>
									</c:choose>
								</tbody>
							</table>
						</div>
						<div class="row text-right" style="">
							<!-- 각종 버튼 부분 -->
							<!-- <button type="reset" class="btn">Reset</button> -->

							<button type="button" class="btn btn-default"
								onclick="location.href='../community/write?flag=parents';">글쓰기</button>

							<!-- <button type="button" class="btn btn-primary">수정하기</button>
	<button type="button" class="btn btn-success">삭제하기</button>
	<button type="button" class="btn btn-info">답글쓰기</button>
	<button type="button" class="btn btn-warning">리스트보기</button>
	<button type="submit" class="btn btn-danger">전송하기</button> -->
						</div>
						<div class="row text-center">
							<!-- 페이지번호 부분 -->
							<ul class="pagination pager">
							${map.pagingBS4 }
							</ul>
						</div>
					</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
