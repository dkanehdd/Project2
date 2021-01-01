<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
   <script>
       function zipcodeFind() {
           new daum.Postcode({
               oncomplete: function (data) {
                   //Daum 우편번호 API가 전달해주는 값을 콘솔에 출력
                   console.log(data.zonecode);
                   console.log(data.address);
                   console.log(data.sido);
                   console.log(data.sigungu);
                   //가입폼에 적용하기
                   var f = document.regiform;
                   f.zipcode.value = data.zonecode;
                   f.addr1.value = data.address;
                   f.addr2.focus();
               }
           }).open();
       }
   </script>
   <script>
        function isValidate(frm) {

        	if (!frm.name.value) {
                alert("이름을 입력하세요");
                return false;
            }
            if (frm.user_id.value == '') {
                alert("아이디를 입력하세요");
                frm.user_id.focus();
                return false;
            }
            if (frm.user_id.readOnly != true){
            	alert("중복확인을 하세요");
            	return false;
            }
            if (!frm.user_pass.value || !frm.pass2.value) {
                alert("패스워드를 입력하세요");
                return false;
            }
            
            if (!frm.mobile1.value || !frm.mobile2.value ||!frm.mobile3.value ) {
                alert("핸드폰번호를 입력하세요");
                return false;
            }
            if (!frm.email1.value || !frm.email2.value) {
                alert("이메일을 입력하세요");
                return false;
            }
            if (!frm.zipcode.value || !frm.addr1.value) {
                alert("주소를 입력하세요");
                return false;
            }
            if (checkId()) {
                return false;
            }
            if (checkPw(frm.user_pass.value)) {
                alert("비밀번호 형식이 잘못되었습니다.");
                return false;
            }
            if (checkPw2(frm.pass2.value)) {
                alert("비밀번호확인이 일치하지 않습니다.");
                return false;
            }
        }

        function emailSelect(obj) {
            var domain = document.getElementById("email2");
            var dom = document.getElementById("dom");
            if (obj.value == "") {
                domain.readOnly = false;
                domain.value = "";
                domain.focus();
            } else {
                domain.readOnly = true;
                dom.style.display = "none";
                domain.value = obj[obj.selectedIndex].value;
            }
        }

        function checkId() {
            var f = document.regiform;
            var id = f.user_id.value;
            if (id == "") {
                alert("※ 아이디를 입력하세요");
                return true;
            }
            if (id.length < 4 || id.length > 12) {
                alert("※ 4~12자 사이로 입력하세요");
                return true;
            }
            if (id.charCodeAt(0) >= 48 && id.charCodeAt(0) <= 57) {
                alert("※ 첫글자는 숫자로 시작할수 없습니다.");
                return true;
            }
            for (var i = 0; i < id.length; i++) {
                if ((id.charCodeAt(i) >= 48 && id.charCodeAt(i) <= 57) ||
                    (id.charCodeAt(i) >= 65 && id.charCodeAt(i) <= 90) ||
                    (id.charCodeAt(i) >= 97 && id.charCodeAt(i) <= 122)) {} else {
                    alert("※ 영문과 숫자만 가능합니다.");
                    return true;
                }
            }
            if (f.user_id.readOnly == true) return false;
            f.user_id.readOnly = true;
            window.open("./id_overapping2.jsp?id=" + f.user_id.value,
                "idover", "width=600,height=600");

        }

        function checkPw(pw) {
            var f1 = true,
                f2 = true,
                f3 = true;
            if (pw.length >= 4 && pw.length <= 12) {
                for (var i = 0; i < pw.length; i++) {
                    if (pw.charCodeAt(i) >= 48 && pw.charCodeAt(i) <= 57) {
                        f1 = false;
                    } else if ((pw.charCodeAt(i) >= 65 && pw.charCodeAt(i) <= 90) ||
                        (pw.charCodeAt(i) >= 97 && pw.charCodeAt(i) <= 122)) {
                        f2 = false;
                    } else {
                        switch (pw.charCodeAt(i)) {
                            case 33:
                            case 63:
                            case 42:
                            case 35:
                            case 64:
                            case 36:
                            case 37:
                            case 94:
                            case 38: {
                                f3 = false;
                                break;
                            }
                            default:
                                f3 = true;
                        }
                    }
//                     console.log(i);
                }
                if (f1 == false && f2 == false && f3 == false) {
                    isN = false;
                } else {
                    isN = true;
                }
            } else {
                isN = true;
            }
            if (isN) {
                pw1.style.color = "red";
                return true;
            } else {
            	pw1.style.color = "#A59683";
                return false;
            }
        }
        //비밀번호 확인 
        function checkPw2(pw) {
            var f = document.regiform;
            var pw1 = f.user_pass.value;
            var pw2 = document.getElementById("pw2");
            if (pw1 != pw) {
                pw2.hidden = false;
                pw2.style.color = "red";
                return true;
            } else {
                pw2.hidden = "hidden";
                return false;
            }
        }
        //전화번호 입력시 자동 포커스 이동
        function commonFocusMove(obj, mLength, next_obj) {

            if (obj.value.length >= mLength) {
                document.getElementById(next_obj).focus();
            }
        }
        //이메일 체크
        function emailCheck() {
            var domain = document.getElementById("email2").value;
            var dom = document.getElementById("dom");
            if (domain.indexOf(".") == -1) {
                dom.style.display = "";
            } else {
                dom.style.display = "none";
            }
        }
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
					<img src="../images/join_tit.gif" alt="회원가입" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;멤버쉽&nbsp;>&nbsp;회원가입<p>
				</div>

				<p class="join_title"><img src="../images/join_tit03.gif" alt="회원정보입력" /></p>
				<!-- 회원가입폼  method는 포스트로 바꾸기!! -->
				<form action="../member/MemberJoin.do" name="regiform" onsubmit="return isValidate(this);" method="post">
				
				<table cellpadding="0" cellspacing="0" border="0" class="join_box">
					<colgroup>
						<col width="80px;" />
						<col width="*" />
					</colgroup>
					<tr>
						<th><img src="../images/join_tit001.gif" /></th>
						<td><input type="text" name="name" value="" class="join_input" /></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit002.gif" /></th>
						<td><input type="text" name="user_id"  value="" class="join_input" />&nbsp;<a onclick="checkId();" style="cursor:hand;"><img src="../images/btn_idcheck.gif" alt="중복확인"/></a>&nbsp;&nbsp;<span>* 4자 이상 12자 이내의 영문/숫자 조합하여 공백 없이 기입</span></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit003.gif" /></th>
						<td><input type="password" name="user_pass" value="" class="join_input" onblur="checkPw(this.value);" />&nbsp;&nbsp;<span id="pw1">* 4자 이상 12자 이내의 영문/숫자/특수문자 조합</span></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit04.gif" /></th>
						<td><input type="password" name="pass2" value="" class="join_input" onblur="checkPw2(this.value);" />&nbsp;&nbsp;<span id="pw2" hidden>* 비밀번호가 일치하지 않습니다.</span></td>
					</tr>
					

					<tr>
						<th><img src="../images/join_tit06.gif" /></th>
						<td>
							<input type="text" name="tel1" value="" maxlength="3" class="join_input" style="width:50px;" 
								onkeyup="commonFocusMove(this, 3, 'tel2');" />&nbsp;-&nbsp;
							<input type="text" name="tel2" value="" maxlength="4" class="join_input" style="width:50px;" 
								onkeyup="commonFocusMove(this, 4, 'tel3');" id="tel2"/>&nbsp;-&nbsp;
							<input type="text" name="tel3" value="" maxlength="4" class="join_input" style="width:50px;" 
								onkeyup="commonFocusMove(this, 4, 'mobile1');" id="tel3"/>
						</td>
					</tr>
					<tr>
						<th><img src="../images/join_tit07.gif" /></th>
						<td>
							<input type="text" name="mobile1" value="" maxlength="3" class="join_input" style="width:50px;" 
								onkeyup="commonFocusMove(this, 3, 'mobile2');" id="mobile1"/>&nbsp;-&nbsp;
							<input type="text" name="mobile2" value="" maxlength="4" class="join_input" style="width:50px;" 
								onkeyup="commonFocusMove(this, 4, 'mobile3');" id="mobile2"/>&nbsp;-&nbsp;
							<input type="text" name="mobile3" value="" maxlength="4" class="join_input" style="width:50px;" 
								onkeyup="commonFocusMove(this, 4, 'eamil1');" id="mobile3"/></td>
					</tr>
					<tr>
						<th><img src="../images/join_tit08.gif" /></th>
						<td>
 
	<input type="text" name="email1" style="width:100px;height:20px;border:solid 1px #dadada;" value="" id="eamil1"/> @ 
	<input type="text" name="email2" id="email2" style="width:150px;height:20px;border:solid 1px #dadada;" value="" onblur="emailCheck();"/>
	<select name="last_email_check2" onChange="emailSelect(this);" class="pass" id="last_email_check2" >
		<option selected="" value="">선택해주세요</option>
		<option value="" >직접입력</option>
		<option value="dreamwiz.com" >dreamwiz.com</option>
		<option value="empal.com" >empal.com</option>
		<option value="empas.com" >empas.com</option>
		<option value="freechal.com" >freechal.com</option>
		<option value="hanafos.com" >hanafos.com</option>
		<option value="hanmail.net" >hanmail.net</option>
		<option value="hotmail.com" >hotmail.com</option>
		<option value="intizen.com" >intizen.com</option>
		<option value="korea.com" >korea.com</option>
		<option value="kornet.net" >kornet.net</option>
		<option value="msn.co.kr" >msn.co.kr</option>
		<option value="nate.com" >nate.com</option>
		<option value="naver.com" >naver.com</option>
		<option value="netian.com" >netian.com</option>
		<option value="orgio.co.kr" >orgio.co.kr</option>
		<option value="paran.com" >paran.com</option>
		<option value="sayclub.com" >sayclub.com</option>
		<option value="yahoo.co.kr" >yahoo.co.kr</option>
		<option value="yahoo.com" >yahoo.com</option>
	</select>
	 
						<input type="checkbox" name="open_email">
						<span>이메일 수신동의</span></td>
					</tr>
					<tr id="dom" style="display: none; color: red; font-size: 0.8em; text-align: right;">
                        <td></td>
                        <td><div style="text-align: right;padding-right: 350px;"> ※ 이메일 형식이 잘못되었습니다.</div></td>
                    </tr>
					<tr>
						<th><img src="../images/join_tit09.gif" /></th>
						<td>
						<input type="text" name="zipcode" value=""  class="join_input" style="width:50px;" />
						<a href="javascript:;" title="새 창으로 열림" onclick="zipcodeFind();" onkeypress="">[우편번호검색]</a>
						<br/>
						
						<input type="text" name="addr1" value=""  class="join_input" style="width:550px; margin-top:5px;" /><br>
						<input type="text" name="addr2" value=""  class="join_input" style="width:550px; margin-top:5px;" />
						
						</td>
					</tr>
				</table>
				<p style="text-align:center; margin-bottom:20px"><button type="submit" class="btn-link"><img src="../images/btn01.gif" /></button>&nbsp;&nbsp;<a href="#"><img src="../images/btn02.gif" /></a></p>
				</form>
				
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
