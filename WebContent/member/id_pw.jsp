<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>

<script>
$(function() {
	
	$('#find_id').click(function() {
		$.get('./find_id.jsp', 
			{
				'id_name':$('#id_name').val(),
				'id_email':$('#id_email').val()
			},	
		function(data) {
			alert(data);
		});
	});
	$('#find_pw').click(function() {
		$.get('./find_pw.jsp', 
			{
				'pw_id':$('#pw_id').val(),
				'pw_name':$('#pw_name').val(),
				'pw_email':$('#pw_email').val()
			},	
		function(data) {
			alert(data);
		});
	});
});
</script>
 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/member/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				<%@ include file = "../include/member_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/member/id_pw_title.gif" alt="" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;아이디/비밀번호찾기<p>
				</div>
				<div class="idpw_box">
					<div class="id_box">
						<ul> 
							<li><input type="text" id="id_name" value="" class="login_input01" /></li>
							<li><input type="text" id="id_email" value="" class="login_input01" /></li>
						</ul>
						<button id="find_id"><img src="../images/member/id_btn01.gif" class="id_btn" /></button>
						<a href="./join01.jsp"><img src="../images/login_btn03.gif" class="id_btn02" /></a>
					</div>
					<div class="pw_box">
						<ul>
							<li><input type="text" id="pw_id" value="" class="login_input01" /></li>
							<li><input type="text" id="pw_name" value="" class="login_input01" /></li>
							<li><input type="text" id="pw_email" value="" class="login_input01" /></li>
						</ul>
						<button id="find_pw"><img src="../images/member/id_btn01.gif" class="pw_btn" /></button>
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
