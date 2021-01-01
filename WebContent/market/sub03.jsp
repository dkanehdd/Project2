<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%@ include file="../member/isLogin.jsp"%>
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
</script>
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
    	    if (frm.sort.value == '') {
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
    	    if (!frm.zipcode.value || !frm.addr1.value ||!frm.addr2.value ) {
    	    	alert("빈칸없이 입력해주세요.");
    	        return false;
    	    }
    	    if (!frm.email_1.value || !frm.email_2.value) {
    	        alert("이메일을 입력하세요");
    	        return false;
    	    }
    	    if (!frm.acre.value) {
    	    	alert("빈칸없이 입력해주세요.");
    	        return false;
    	    }
    	}
   </script>
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
					<img src="../images/market/sub03_title.gif" alt="블루크리닝 견적 의뢰" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린장터&nbsp;>&nbsp;블루크리닝 견적 의뢰<p>
				</div>
				<form action="../market/blue" name="regiform" method="post" onsubmit="return isValidate(this);">
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
							<th>청소할 곳 주소</th>
							<td style="text-align: left">
						<input type="text" name="zipcode" value=""  class="join_input" style="width:50px;" />
						<a href="javascript:;" title="새 창으로 열림" onclick="zipcodeFind();">[우편번호검색]</a>
						<br/>
						
						<input type="text" name="addr1" value=""  class="join_input" style="width:550px; margin-top:5px;" /><br>
						<input type="text" name="addr2" value=""  class="join_input" style="width:550px; margin-top:5px;" />
						
						</td>
						</tr>
						<tr>
							<th>연락처</th>
							<td style="text-align:left;"><input type="text" name="tel1" id='tel1' onkeyup="commonFocusMove(this, 3, 'tel2');" value="" class="join_input" style="width:50px;" maxlength="3"/> - 
							<input type="text" name="tel2" id='tel2' onkeyup="commonFocusMove(this, 4, 'tel3');" value="" class="join_input" style="width:50px;" maxlength="4"/> - 
							<input type="text" name="tel3" id='tel3' onkeyup="commonFocusMove(this, 4, 'mobile1');" value="" class="join_input" style="width:50px;" maxlength="4"/></td>
						</tr>
						<tr>
							<th>휴대전화</th>
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
							<th>청소의뢰내역</th>
							<td style="text-align:left;" style="padding:0px;">
								<table cellpadding="0" cellspacing="0" border="0" style="width:100%;">
									<tr>
										<td>청소종류</td>
										<td style="border-right:0px;"><input type="text" name="sort"  value="" class="join_input" /></td>
									</tr>
									<tr>
										<td style="border-bottom:0px;">분양평수/등기평수</td>
										<td style="border:0px;"><input type="text" name="acre"  value="" class="join_input" /></td>
									</tr>
								</table>
							</td>
						</tr>
						<tr>
							<th>청소 희망날짜</th>
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
				<p style="text-align:center; margin-bottom:40px"><button type="submit" style="border: 0"><img src="../images/btn01.gif" /></button>&nbsp;&nbsp;<a href="#"><img src="../images/btn02.gif" /></a></p>
			</form>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
