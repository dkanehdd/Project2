<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>


 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/market/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				
				<%@ include file = "../include/market_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/market/sub05_title.gif" alt="체험학습신청" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린장터&nbsp;>&nbsp;체험학습신청<p>
				</div>
				<p class="con_tit"><img src="../images/market/sub05_tit01.gif" /></p>
				<ul class="dot_list">
					<li>무 방부제 • 무첨가제 수제 빵 제작 체험</li>
					<li>사전에 준비된 반죽으로 성형 및 굽기 체험</li>
					<li>참가비 : 일인당 20,000원 (교육비, 재료비 포함)</li>
				</ul>
				<p class="con_tit"><img src="../images/market/sub05_tit02.gif" /></p>
				<ul class="dot_list">
					<li>내가만든 맛있는 쿠키~!</li>
					<li>쿠키의 반죽 ,성형, 굽기 기술 경험의 기회! </li>
					<li>참가비 : 일인당 15,000원 (교육비, 재료비 포함)</li>
				</ul>
				<p class="con_tit"><img src="../images/market/sub05_tit03.gif" /></p>
				<ul class="dot_list">
					<li>만드는 즐거움 받는이에겐 감동을~!</li>
					<li>직접 데코레이션한 세상에서 하나뿐인
케익을 소중한 사람에게 전하세요~!
</li>
					<li>준비된 케익시트에 테코레이션 과정 체험</li>
					<li>참가비 : 일인당 25,000원 (교육비, 재료비 포함)</li>
				</ul>
				<div style="text-align:left">
					<img src="../images/market/sub05_img01.jpg" style="margin-bottom:30px;" />
				</div>
				<form action="../market/experience" name="regiform" method="post" onsubmit="return isValidate(this)">
				<table cellpadding="0" cellspacing="0" border="0" class="con_table" style="width:100%;">
					<colgroup>
						<col width="25%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th>고객명/회사명</th>
							<td style="text-align:left;"><input type="text" name="compony"  value="" class="join_input" /></td>
						</tr>
						<tr>
							<th>장애유무</th>
							<td style="text-align:left;" style="padding:0px;">
								<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
									<tr>
										<td style="border-bottom:0px;"><input type="radio" name="handicap1"  value="장애있음" /> 유&nbsp;&nbsp;&nbsp;<input type="radio" name="handicap1" checked value="장애없음" /> 무</td>
										<th style="border-bottom:0px;" width="100px">주요장애유형</th>
										<td style="border-right:0px; border-bottom:0px;"><input type="text" name="handicap2"  value="" class="join_input" /></td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<th>보장구 사용유무</th>
							<td style="text-align:left;" style="padding:0px;">
								<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
									<tr>
										<td style="border-bottom:0px;"><input type="radio" name="assistingdevices1"  value="보장구있음" /> 유&nbsp;&nbsp;&nbsp;<input type="radio" name="assistingdevices1" checked value="보장구없음" /> 무</td>
										<th style="border-bottom:0px;" width="100px">보장구 명</th>
										<td style="border-right:0px; border-bottom:0px;"><input type="text" name="assistingdevices2"  value="" class="join_input" /></td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<th>연락처</th>
							<td style="text-align:left;"><input type="text" name="tel1" id='tel1' onkeyup="commonFocusMove(this, 3, 'tel2');" value="" class="join_input" style="width:50px;" maxlength="3"/> - 
							<input type="text" name="tel2" id='tel2' onkeyup="commonFocusMove(this, 4, 'tel3');" value="" class="join_input" style="width:50px;" maxlength="4"/> - 
							<input type="text" name="tel3" id='tel3' onkeyup="commonFocusMove(this, 4, 'mobile1');" value="" class="join_input" style="width:50px;" maxlength="4"/></td>
						</tr>
						<tr>
							<th>담당자휴대전화</th>
							<td style="text-align:left;"><input type="text" id='mobile1' name="mobile1" onkeyup="commonFocusMove(this, 3, 'mobile2');" value="" class="join_input" style="width:50px;" maxlength="3"/> - 
							<input type="text" name="mobile2" id='mobile2' onkeyup="commonFocusMove(this, 4, 'mobile3');" value="" class="join_input" style="width:50px;" maxlength="4"/> - 
							<input type="text" name="mobile3"  id='mobile3' value="" class="join_input" style="width:50px;" maxlength="4"/></td>
						</tr>
						<tr>
							<th>이메일</th>
							<td style="text-align:left;"><input type="text" name="email_1"  value="" class="join_input" style="width:100px;" /> @ <input type="text" name="email_2" id="email2" style="width:150px;height:20px;border:solid 1px #dadada;" value="" />
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
	</select></td>
						</tr>
						<tr>
							<th>체험내용</th>
							<td style="text-align:left;" style="padding:0px;">
								<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
									<tr>
										<td>케익체험</td>
										<td style="border-right:0px;"><input type="text" name="experience1"  value="" class="join_input" /></td>
									</tr>
									<tr>
										<td style="border-bottom:0px;">쿠키체험</td>
										<td style="border:0px;"><input type="text" name="experience2"  value="" class="join_input" /></td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<th>체험 희망날짜</th>
							<td style="text-align:left;"><select name="year" >
									<option value="2021" >2021</option>
									<option value="2022" >2022</option>
									<option value="2023" >2023</option>
									<option value="2024" >2024</option>
									<option value="2025" >2025</option>
								</select>년
								<select name="month" >
									<option value="1" >1</option>
									<option value="2" >2</option>
									<option value="3" >3</option>
									<option value="4" >4</option>
									<option value="5" >5</option>
									<option value="6" >6</option>
									<option value="7" >7</option>
									<option value="8" >8</option>
									<option value="9" >9</option>
									<option value="10" >10</option>
									<option value="11" >11</option>
									<option value="12" >12</option>
								</select>월
								<input type="text" name="day" maxlength="2" style="width:50px;"  class="join_input"/>일
								</td>
								</td>
						</tr>
						<tr>
							<th>접수종류 구분</th>
							<td style="text-align:left;">
                            <input type="radio" name="register" id="radio-1" checked value="예약신청">
							<label for="radio-1">예약신청</label>
                            <input type="radio" name="register" id="radio-2" value="견적문의">
                            <label for="radio-2">견적문의</label></td>
						</tr>
						<tr>
							<th>기타특이사항</th>
							<td style="text-align:left;"><input type="text" name="other"  value="" class="join_input" style="width:400px;" /></td>
						</tr>
					</tbody>
				</table>
				<p style="text-align:center; margin-bottom:40px"><button type="submit"><img src="../images/btn01.gif" /></button>&nbsp;&nbsp;<a href="#"><img src="../images/btn02.gif" /></a></p>
			</form>
			</div>
			<script>

function emailSelect(obj) {
    var domain = document.getElementById("email2");
    if (obj.value == "") {
        domain.readOnly = false;
        domain.value = "";
        domain.focus();
    } else {
        domain.readOnly = true;
        domain.value = obj[obj.selectedIndex].value;
    }
}
function commonFocusMove(obj, mLength, next_obj) {

    if (obj.value.length >= mLength) {
        document.getElementById(next_obj).focus();
    }
}
function isValidate(frm) {

	if (!frm.compony.value) {
        alert("빈칸없이 입력해주세요.");
        return false;
    }
    if (frm.handicap2.value == '') {
    	alert("빈칸없이 입력해주세요.");
        return false;
    }
    if (frm.day.value == '') {
    	alert("빈칸없이 입력해주세요.");
        return false;
    }
    if (frm.other.value == '') {
    	alert("빈칸없이 입력해주세요.");
        return false;
    }
    if (!frm.assistingdevices2.value) {
    	alert("빈칸없이 입력해주세요.");
        return false;
    }
    if (!frm.tel1.value || !frm.tel2.value ||!frm.tel3.value ) {
        alert("핸드폰번호를 입력하세요");
        return false;
    }
    if (!frm.mobile1.value || !frm.mobile2.value ||!frm.mobile3.value ) {
        alert("핸드폰번호를 입력하세요");
        return false;
    }
    if (!frm.email_1.value || !frm.email_2.value) {
        alert("이메일을 입력하세요");
        return false;
    }
    if (!frm.experience1.value || !frm.experience2.value) {
    	alert("빈칸없이 입력해주세요.");
        return false;
    }
}
</script>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
