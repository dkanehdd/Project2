<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
	//리퀘스트 내장객체를 이용해서 생성된 쿠키를 가져온다.
Cookie[] cookies = request.getCookies();
//쿠키값을 저장할 변수
String save = "";
//생성된 쿠키가 존재한다면 로그인 아이디와 아디디저장에 관련된값이 있는지 확인한다.
if (cookies != null) {
	for (Cookie ck : cookies) {
		if (ck.getName().equals("SaveId")) {
	//아이디저장에 관련된값이 있는지 확인
	save = ck.getValue();
// 	System.out.println("save=" + save);
		}
	}
}
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>마포구립장애인 직업재활센터</title>
<script src="../bootstrap3.3.7/jquery/jquery-3.5.1.js"></script>
<style type="text/css" media="screen">
@import url("../css/common.css");

@import url("../css/main.css");

@import url("../css/sub.css");
</style>

<script type="text/javascript">
$(function () {
	$.ajax({
		url : './calender.js',
		type : 'get',
		dataType : "script",
		//요청성공시 콜백메소드 : 무기명함수 형태로 정의됨
		success : function(resData) { 
			calendarMaker($("#calendar"), new Date());
			calMoveEvtFn();
		},
		//요청실패시 콜백메소드 : 외부함수 형태로 정의됨.
		error : function() {
			alert('에러발생');
		} //호출시 함수명만 명시한다.
	});
});
</script>
<script>
<c:choose>
	<c:when test="${not empty message }">
		alert('${message}');
	</c:when>
</c:choose>
</script>
</head>
<body>
	<center>
		<div id="wrap">
			<%@ include file="../include/top.jsp"%>

			<div id="main_visual">
				<a href="../product/sub01.jsp"><img
					src="../images/main_image_01.jpg" /></a><a
					href="../product/sub01_02.jsp"><img
					src="../images/main_image_02.jpg" /></a><a
					href="../product/sub01_03.jsp"><img
					src="../images/main_image_03.jpg" /></a><a href="../product/sub02.jsp"><img
					src="../images/main_image_04.jpg" /></a>
			</div>
	
			<div class="main_contents">
				<div class="main_con_left">
					<p class="main_title" style="border: 0px; margin-bottom: 0px;">
						<img src="../images/main_title01.gif" alt="로그인 LOGIN" />
					</p>
					<div class="login_box" id="login_box">
						<%
							if (session.getAttribute("USER_ID") == null) {//로그인 전 상태
						%>
						<form action="../member/LoginProc.jsp">
							<table cellpadding="0" cellspacing="0" border="0">
								<colgroup>
									<col width="45px" />
									<col width="120px" />
									<col width="55px" />
								</colgroup>

								<tr>
									<th><img src="../images/login_tit01.gif" alt="아이디" /></th>
									<td><input type="text" name="user_id"
										value="<%=(save.length() == 0) ? "" : save%>" class="login_input" /></td>
									<td rowspan="2"><input type="image"
										src="../images/login_btn01.gif" alt="로그인" id="login" /></td>
								</tr>
								<tr>
									<th><img src="../images/login_tit02.gif" alt="패스워드" /></th>
									<td><input type="password" name="user_pw" value=""
										class="login_input" /></td>
								</tr>
							</table>
							<p>
								<input type="checkbox" name="id_save"
									<%if (save.length() != 0) {%> checked="checked" <%}%> /><img
									src="../images/login_tit03.gif" alt="저장" /> <a
									href="../member/id_pw.jsp"><img
									src="../images/login_btn02.gif" alt="아이디/패스워드찾기" /></a> <a
									href="../member/join01.jsp"><img
									src="../images/login_btn03.gif" alt="회원가입" /></a>
							</p>
						</form>
						<%
							} else {
						%>
						<!-- 로그인 후 -->
						<p style="padding: 10px 0px 10px 10px">
							<span style="font-weight: bold; color: #333;" id="user_name"><%=session.getAttribute("USER_NAME")%>님,</span>
							반갑습니다.<br />로그인 하셨습니다.
						</p>
						<p style="text-align: right; padding-right: 10px;">
							<a href="../member/modify.jsp"><img src="../images/login_btn04.gif" /></a> <a
								href="../member/Logout.jsp"><img
								src="../images/login_btn05.gif" /></a>
						</p>
						<%
							}
						%>
					</div>
				</div>
				<div class="main_con_center">
					<p class="main_title">
						<img src="../images/main_title02.gif" alt="공지사항 NOTICE" /><a
							href="../space/sub01.jsp"><img src="../images/more.gif"
							alt="more" class="more_btn" /></a>
					</p>
					<ul class="main_board_list">
						<c:choose>
							<c:when test="${empty noticeLists }">
								<li>등록된 게시물이 없습니다.</li>
							</c:when>
							<c:otherwise>
								<c:forEach items="${noticeLists }" var="nrow" varStatus="loop">
									<!-- 리스트반복 start -->
									<li><a href="../space/sub01_view.jsp?num=${nrow.num }">${nrow.title }</a><span>${nrow.postdate }</span></li>
									<!-- 리스트반복 end -->
								</c:forEach>

							</c:otherwise>
						</c:choose>
					</ul>
				</div>
				<div class="main_con_right">
					<p class="main_title">
						<img src="../images/main_title03.gif" alt="자유게시판 FREE BOARD" /><a
							href="../space/sub03.jsp"><img src="../images/more.gif"
							alt="more" class="more_btn" /></a>
					</p>
					<ul class="main_board_list">
						<c:choose>
							<c:when test="${empty lists }">
								<li>등록된 게시물이 없습니다.</li>
							</c:when>
							<c:otherwise>
								<c:forEach items="${lists }" var="row" varStatus="loop">
									<!-- 리스트반복 start -->
									<li><a href="../space/sub03_view.jsp?num=${row.num }">${row.title }</a><span>${row.postdate }</span></li>
									<!-- 리스트반복 end -->
								</c:forEach>

							</c:otherwise>
						</c:choose>
					</ul>
				</div>
			</div>

			<div class="main_contents">
				<div class="main_con_left">
					<p class="main_title">
						<img src="../images/main_title04.gif" alt="월간일정 CALENDAR" />
					</p>
					<img src="../images/main_tel.gif" />
				</div>
				<div class="main_con_center"  id="calendar">
					<p class="main_title" style="border: 0px; margin-bottom: 0px;">
						<img src="../images/main_title05.gif" alt="월간일정 CALENDAR" />
					</p>
					<div class="cal_top">
						<table cellpadding="0" cellspacing="0" border="0">
							<colgroup>
								<col width="13px;" />
								<col width="*" />
								<col width="13px;" />
							</colgroup>
							<tr>
								<td><a href=""><img src="../images/cal_a01.gif"
										style="margin-top: 3px;" /></a></td>
								<td><img src="../images/calender_2012.gif" />&nbsp;&nbsp;<img
									src="../images/calender_m1.gif" /></td>
								<td><a href=""><img src="../images/cal_a02.gif"
										style="margin-top: 3px;" /></a></td>
							</tr>
						</table>
					</div>
					<div class="cal_bottom">
					<!-- 메인 달력 출력부분 -->
					</div>
				</div>
				<div class="main_con_right">
					<p class="main_title">
						<img src="../images/main_title06.gif" alt="사진게시판 PHOTO BOARD" /><a
							href="../space/sub04.jsp"><img src="../images/more.gif"
							alt="more" class="more_btn" /></a>
					</p>
					<ul class="main_photo_list">
					<c:choose>
						<c:when test="${empty plist }">
							<li>등록된 게시물이 없습니다.</li>
						</c:when>
						<c:otherwise>
							<c:forEach items="${plist }" var="pic" varStatus="loop">
								<li>
								<dl>
									<dt>
										<a href="../space/sub04_view.jsp?num=${pic.num }" ><img src="/Project2/images/upload/${pic.attachedfile }"  style="width: 95px;height: 63px;"/></a>
									</dt>
									<dd>
										<a href="../space/sub04_view.jsp?num=${pic.num }">${pic.title }</a>
									</dd>
								</dl>
								</li>
							</c:forEach>
						</c:otherwise>
					</c:choose>
					</ul>
				</div>
			</div>
			<%@ include file="../include/quick.jsp"%>
		</div>

		<%@ include file="../include/footer.jsp"%>

	</center>
</body>
</html>