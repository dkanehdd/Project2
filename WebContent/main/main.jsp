<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" trimDirectiveWhitespaces="true"%>
<%
//리퀘스트 내장객체를 이용해서 생성된 쿠키를 가져온다.
Cookie[] cookies = request.getCookies();
//쿠키값을 저장할 변수
String save="";
//생성된 쿠키가 존재한다면 로그인 아이디와 아디디저장에 관련된값이 있는지 확인한다.
if(cookies!=null){
	for(Cookie ck : cookies){
		if(ck.getName().equals("SaveId")){
			//아이디저장에 관련된값이 있는지 확인
			save = ck.getValue();
// 			System.out.println("save="+save);
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
<script>
$(function() {
	$('#login').click(function(){
		//요청할 서버의 URL
 		/*
 			serialize()
 			: <form> 태그의 하위태그들을 "name"속성을 통해 JSON으로
 		 	조립해준다. 전송할 폼값이 많을경우 주로 사용한다. 
 		*/
		var s_params = $('#loginFrm').serialize();
		$.post(
				"LoginProc.jsp",
			{
				'user_id':$('#user_id').val(),
				'user_pw':$('#user_pw').val()
			},			
			function(resData){
				var d = JSON.parse(resData);
					console.log(d.result);
				if(d.result==1){
					//JSON에 포함된 HTML값을 얻어와서 삽입
					$('#loginFrm').html(d.HTML);
					//로그인 버튼은 숨김처리
					/*
					#btnLogin2의 경우 loginFrm 하위에 있는 태그이므로
					위에 html()함수로 초기화를 시켰기때문에 hide()하지 않아도 
					없어지는데.....
					*/
				}
				else{
					/*
					로그인실패시 JSON에 저장되있던 
					message키값을 얻어와 경고창에 띄워줌
					*/
					alert(d.message);
				}
				
				//콜백된 데이터를 Text형태로 출력한다. 
				$('#jsonDisplay').html(resData);
			}
		);		
	});
});
function errFunc() {
	alert("에러발생. 디버깅하세욤.");
}


</script>
</head>
<body>
<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp"%>
		
		<div id="main_visual">
		<a href="/product/sub01.jsp"><img src="../images/main_image_01.jpg" /></a><a href="/product/sub01_02.jsp"><img src="../images/main_image_02.jpg" /></a><a href="/product/sub01_03.jsp"><img src="../images/main_image_03.jpg" /></a><a href="/product/sub02.jsp"><img src="../images/main_image_04.jpg" /></a>
		</div>

		<div class="main_contents">
			<div class="main_con_left">
				<p class="main_title" style="border:0px; margin-bottom:0px;"><img src="../images/main_title01.gif" alt="로그인 LOGIN" /></p>
				<div class="login_box" id="login_box">
				<%
				if(session.getAttribute("USER_ID")==null){//로그인 전 상태
				%>
				<form id="loginFrm" method="post">
					<table cellpadding="0" cellspacing="0" border="0">
						<colgroup>
							<col width="45px" />
							<col width="120px" />
							<col width="55px" />
						</colgroup>
						
						<tr>
							<th><img src="../images/login_tit01.gif" alt="아이디" /></th>
							<td><input type="text" id="user_id" value="" class="login_input" /></td>
							<td rowspan="2"><input type="image" src="../images/login_btn01.gif" alt="로그인" id="login"/></td>
						</tr>
						<tr>
							<th><img src="../images/login_tit02.gif" alt="패스워드" /></th>
							<td><input type="text" id="user_pw" value="" class="login_input" /></td>
						</tr>
					</table>
					<p>
						<input type="checkbox" id="id_save" value="checked" /><img src="../images/login_tit03.gif" alt="저장" />
						<a href="../member/id_pw.jsp"><img src="../images/login_btn02.gif" alt="아이디/패스워드찾기" /></a>
						<a href="../member/join01.jsp"><img src="../images/login_btn03.gif" alt="회원가입" /></a>
					</p>
					</form>
					<%}else{ %>
						<!-- 로그인 후 -->
						<p style="padding:10px 0px 10px 10px"><span style="font-weight:bold; color:#333;" id="user_name"><%=session.getAttribute("USER_NAME") %>님,</span> 반갑습니다.<br />로그인 하셨습니다.</p>
						<p style="text-align:right; padding-right:10px;">
							<a href=""><img src="../images/login_btn04.gif" /></a>
							<a href="Logout.jsp"><img src="../images/login_btn05.gif" /></a>
						</p>
					<%} %>
				</div>
			</div>
			<div class="main_con_center">
				<p class="main_title"><img src="../images/main_title02.gif" alt="공지사항 NOTICE" /><a href="/space/sub01.jsp"><img src="../images/more.gif" alt="more" class="more_btn" /></a></p>
				<ul class="main_board_list">
					<li><p><a href="">마포 구립 장애인 직업재활센터 홈페이지</a><span>2012.01.26</span></p></li>
					<li><a href="">마포 구립 장애인 직업재활센터 홈페이지</a><span>2012.01.26</span></li>
					<li><a href="">마포 구립 장애인 직업재활센터 홈페이지</a><span>2012.01.26</span></li>
					<li><a href="">마포 구립 장애인 직업재활센터 홈페이지</a><span>2012.01.26</span></li>
				</ul>
			</div>
			<div class="main_con_right">
				<p class="main_title"><img src="../images/main_title03.gif" alt="자유게시판 FREE BOARD" /><a href="/space/sub03.jsp"><img src="../images/more.gif" alt="more" class="more_btn" /></a></p>
				<ul class="main_board_list">
					<li><p><a href="">마포 구립 장애인 직업재활센터 홈페이지</a><span>2012.01.26</span></p></li>
					<li><a href="">마포 구립 장애인 직업재활센터 홈페이지마포 구립 장애인 직업재활센터 홈페이지마포 구립 장애인 직업재활센터 홈페이지</a><span>2012.01.26</span></li>
					<li><a href="">마포 구립 장애인 직업재활센터 홈페이지</a><span>2012.01.26</span></li>
					<li><a href="">마포 구립 장애인 직업재활센터 홈페이지</a><span>2012.01.26</span></li>
				</ul>
			</div>
		</div>

		<div class="main_contents">
			<div class="main_con_left">
				<p class="main_title"><img src="../images/main_title04.gif" alt="월간일정 CALENDAR" /></p>
				<img src="../images/main_tel.gif" />
			</div>
			<div class="main_con_center">
				<p class="main_title" style="border:0px; margin-bottom:0px;"><img src="../images/main_title05.gif" alt="월간일정 CALENDAR" /></p>
				<div class="cal_top">
					<table cellpadding="0" cellspacing="0" border="0">
						<colgroup>
							<col width="13px;" />
							<col width="*" />
							<col width="13px;" />
						</colgroup>
						<tr>
							<td><a href=""><img src="../images/cal_a01.gif" style="margin-top:3px;" /></a></td>
							<td><img src="../images/calender_2012.gif" />&nbsp;&nbsp;<img src="../images/calender_m1.gif" /></td>
							<td><a href=""><img src="../images/cal_a02.gif" style="margin-top:3px;" /></a></td>
						</tr>
					</table>
				</div>
				<div class="cal_bottom">
					<table cellpadding="0" cellspacing="0" border="0" class="calendar">
						<colgroup>
							<col width="14%" />
							<col width="14%" />
							<col width="14%" />
							<col width="14%" />
							<col width="14%" />
							<col width="14%" />
							<col width="*" />
						</colgroup>
						<tr>
							<th><img src="../images/day01.gif" alt="S" /></th>
							<th><img src="../images/day02.gif" alt="M" /></th>
							<th><img src="../images/day03.gif" alt="T" /></th>
							<th><img src="../images/day04.gif" alt="W" /></th>
							<th><img src="../images/day05.gif" alt="T" /></th>
							<th><img src="../images/day06.gif" alt="F" /></th>
							<th><img src="../images/day07.gif" alt="S" /></th>
						</tr>
						<tr>
							<td><a href="">&nbsp;</a></td>
							<td><a href="">&nbsp;</a></td>
							<td><a href="">&nbsp;</a></td>
							<td><a href="">&nbsp;</a></td>
							<td><a href="">1</a></td>
							<td><a href="">2</a></td>
							<td><a href="">3</a></td>
						</tr>
						<tr>
							<td><a href="">4</a></td>
							<td><a href="">5</a></td>
							<td><a href="">6</a></td>
							<td><a href="">7</a></td>
							<td><a href="">8</a></td>
							<td><a href="">9</a></td>
							<td><a href="">10</a></td>
						</tr>
						<tr>
							<td><a href="">11</a></td>
							<td><a href="">12</a></td>
							<td><a href="">13</a></td>
							<td><a href="">14</a></td>
							<td><a href="">15</a></td>
							<td><a href="">16</a></td>
							<td><a href="">17</a></td>
						</tr>
						<tr>
							<td><a href="">18</a></td>
							<td><a href="">19</a></td>
							<td><a href="">20</a></td>
							<td><a href="">21</a></td>
							<td><a href="">22</a></td>
							<td><a href="">23</a></td>
							<td><a href="">24</a></td>
						</tr>
						<tr>
							<td><a href="">25</a></td>
							<td><a href="">26</a></td>
							<td><a href="">27</a></td>
							<td><a href="">28</a></td>
							<td><a href="">29</a></td>
							<td><a href="">30</a></td>
							<td><a href="">31</a></td>
						</tr>
						<tr>
							<td><a href="">&nbsp;</a></td>
							<td><a href="">&nbsp;</a></td>
							<td><a href="">&nbsp;</a></td>
							<td><a href="">&nbsp;</a></td>
							<td><a href="">&nbsp;</a></td>
							<td><a href="">&nbsp;</a></td>
							<td><a href="">&nbsp;</a></td>
						</tr>
					</table>
				</div>
			</div>
			<div class="main_con_right">
				<p class="main_title"><img src="../images/main_title06.gif" alt="사진게시판 PHOTO BOARD" /><a href="/space/sub04.jsp"><img src="../images/more.gif" alt="more" class="more_btn" /></a></p>
				<ul class="main_photo_list">
					<li>
						<dl>
							<dt><a href=""><img src="../images/g_img.gif" /></a></dt>
							<dd><a href="">마포 구립 장애인...</a></dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt><a href=""><img src="../images/g_img.gif" /></a></dt>
							<dd><a href="">마포 구립 장애인...</a></dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt><a href=""><img src="../images/g_img.gif" /></a></dt>
							<dd><a href="">마포 구립 장애인...</a></dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt><a href=""><img src="../images/g_img.gif" /></a></dt>
							<dd><a href="">마포 구립 장애인...</a></dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt><a href=""><img src="../images/g_img.gif" /></a></dt>
							<dd><a href="">마포 구립 장애인...</a></dd>
						</dl>
					</li>
					<li>
						<dl>
							<dt><a href=""><img src="../images/g_img.gif" /></a></dt>
							<dd><a href="">마포 구립 장애인...</a></dd>
						</dl>
					</li>
				</ul>
			</div>
		</div>
		<%@ include file="../include/quick.jsp"%>
	</div>

	<%@ include file="../include/footer.jsp"%>
	
</center>
</body>
</html>