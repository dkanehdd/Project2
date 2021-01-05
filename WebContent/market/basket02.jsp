<%@page import="model.MemberDAO"%>
<%@page import="model.MemberDTO"%>
<%@page import="model.BasketDTO"%>
<%@page import="model.BasketDAO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
     <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../member/isLogin.jsp"%>
<script src="https://t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
<%
String id = session.getAttribute("USER_ID").toString();

BasketDAO bdao = new BasketDAO();
List<BasketDTO> list = bdao.selectAll(id);
bdao.close();
int totalprice = 0;
MemberDAO mdao = new MemberDAO();
MemberDTO mdto = mdao.getMemberDTO(id);
String[] tel = mdto.getCellphone().split("-");
String[] email = mdto.getEmail().split("@");
String[] address = mdto.getAddress().split("/");
mdao.close();
%>
<%@ include file="../include/global_head.jsp" %>

<script type="text/javascript">
function edit() {
	var f = document.regiform;
	f.action="updatebasket.jsp";
	f.submit();
}
function emailSelect(obj) {
    var domain = document.getElementById("order_email2");
    if (obj.value == "") {
        domain.readOnly = false;
        domain.value = "";
        domain.focus();
    } else {
        domain.readOnly = true;
        domain.value = obj[obj.selectedIndex].value;
    }
}
function emailSelect2(obj) {
    var domain = document.getElementById("delivery_email2");
    if (obj.value == "") {
        domain.readOnly = false;
        domain.value = "";
        domain.focus();
    } else {
        domain.readOnly = true;
        domain.value = obj[obj.selectedIndex].value;
    }
}
function equalsname(value){
	var f = document.regifrm;
	if(f.equals.value=='yes'){
		f.delivery_name.value = f.order_name.value;
		f.delivery_zipcode.value = f.order_zipcode.value;
		f.delivery_addr1.value = f.order_addr1.value;
		f.delivery_addr2.value = f.order_addr2.value;
		f.delivery_tel1.value = f.order_tel1.value;
		f.delivery_tel2.value = f.order_tel2.value;
		f.delivery_tel3.value = f.order_tel3.value;
		f.delivery_email1.value = f.order_email1.value;
		f.delivery_email2.value = f.order_email2.value;
	}
	else{
		f.delivery_name.value = '';
		f.delivery_zipcode.value = '';
		f.delivery_addr1.value = '';
		f.delivery_addr2.value = '';
		f.delivery_tel1.value = '';
		f.delivery_tel2.value = '';
		f.delivery_tel3.value = '';
		f.delivery_email1.value = '';
		f.delivery_email2.value = '';
	}
}
function commonFocusMove(obj, mLength, next_obj) {

    if (obj.value.length >= mLength) {
        document.getElementById(next_obj).focus();
    }
}
</script>
 <body>
 
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
            var f = document.regifrm;
            f.order_zipcode.value = data.zonecode;
            f.order_addr1.value = data.address;
            f.order_addr2.focus();
        }
    }).open();
}
function zipcodeFind2() {
    new daum.Postcode({
        oncomplete: function (data) {
            //Daum 우편번호 API가 전달해주는 값을 콘솔에 출력
            console.log(data.zonecode);
            console.log(data.address);
            console.log(data.sido);
            console.log(data.sigungu);
            //가입폼에 적용하기
            var f = document.regifrm;
            f.delivery_zipcode.value = data.zonecode;
            f.delivery_addr1.value = data.address;
            f.delivery_addr2.focus();
        }
    }).open();
}
function isValidate(frm) {

	if (!frm.order_name.value) {
        alert("주문자 이름을 입력하세요");
        return false;
    }
    if (frm.order_zipcode.value == ''|| frm.order_addr1.value == '') {
    	alert("주소를 입력해주세요.");
        return false;
    }
    if (!frm.order_tel1.value || !frm.order_tel2.value ||!frm.order_tel3.value ) {
        alert("핸드폰번호를 입력하세요");
        return false;
    }
    if (!frm.order_email1.value || !frm.order_email2.value) {
        alert("이메일을 입력하세요");
        return false;
    }
    if (!frm.delivery_name.value) {
        alert("배송받는 이름을 입력하세요");
        return false;
    }
    if (frm.delivery_zipcode.value == ''|| frm.delivery_addr1.value == '') {
    	alert("주소를 입력해주세요.");
        return false;
    }
    if (!frm.delivery_tel1.value || !frm.delivery_tel2.value ||!frm.delivery_tel3.value ) {
        alert("핸드폰번호를 입력하세요");
        return false;
    }
    if (!frm.delivery_email1.value || !frm.delivery_email2.value) {
        alert("이메일을 입력하세요");
        return false;
    }
    if (!frm.payment.value) {
        alert("결제 방법을 선택하세요");
        return false;
    }
}
</script>
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
					<img src="../images/market/sub01_title.gif" alt="수아밀 제품 주문" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린장터&nbsp;>&nbsp;수아밀 제품 주문<p>
				</div>
				<p class="con_tit"><img src="../images/market/basket_title01.gif" /></p>
				
				<form action="deletebasket.jsp" method="get" name="regiform">
				<table cellpadding="0" cellspacing="0" border="0" class="basket_list" style="margin-bottom:50px;">
					<colgroup>
						<col width="7%" />
						<col width="10%" />
						<col width="*" />
						<col width="10%" />
						<col width="8%" />
						<col width="10%" />
						<col width="10%" />
						<col width="10%" />
						<col width="8%" />
					</colgroup>
					<thead>
						<tr>
							<th>선택</th>
							<th>이미지</th>
							<th>상품명</th>
							<th>판매가</th>
							<th>적립금</th>
							<th>수량</th>
							<th>배송구분</th>
							<th>배송비</th>
							<th>합계</th>
						</tr>
					</thead>
					<tbody>
						<%for(BasketDTO dto : list){ 
						totalprice+= dto.getTotal_price();
					%>
						<tr>
							<td><input type="checkbox" name="delete" value="<%=dto.getNum() %>" /></td>
							<td><img src="../images/market/<%=dto.getImage() %>"  style="width: 50px;height: 50px"/></td>
							<td><%=dto.getGoods_name() %></td>
							<td><fmt:formatNumber value="<%=dto.getGoods_price() %>" type="number" />원</td>
							<td><img src="../images/market/j_icon.gif" />&nbsp;<%=dto.getGoods_mileage() %>원</td>
							<td><input type="number" name='count' value="<%=dto.getGoods_count() %>" class="basket_num" />&nbsp;<a onclick="edit()"><img src="../images/market/m_btn.gif" /></a></td>
							<td>무료배송</td>
							<td>[조건]</td><input type="hidden" name="num" value="<%=dto.getNum() %>"/>
							<td><span><fmt:formatNumber value="<%=dto.getTotal_price() %>" type="number" />원<span></td>
						</tr>
						<%} %>
					</tbody>
					<input type="hidden" name="location" value="basket02.jsp" />
				</table>
					<p style="text-align: right;"><button type="submit" class="btn btn-danger" style="font-weight: bold;">선택항목삭제</button></p>
				</form>
				<p class="con_tit"><img src="../images/market/basket_title02.gif" /></p>
				<form action="../market/order" name='regifrm' method="post" onsubmit="return isValidate(this)">
				<table cellpadding="0" cellspacing="0" border="0" class="con_table" style="width:100%;" style="margin-bottom:50px;">
					<colgroup>
						<col width="15%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<input type="hidden" name="id" value="<%=session.getAttribute("USER_ID").toString() %>" />
							<th>성명</th>
							<td style="text-align:left;"><input type="text" name="order_name"  value="<%=mdto.getName() %>" class="join_input" /></td>
						</tr>
						<tr>
							<th>주소</th>
							<td style="text-align:left;"><input type="text" name="order_zipcode"  value="<%=address[0] %>" class="join_input" style="width:100px; margin-bottom:5px;" />
							<a href="javascript:;" title="새 창으로 열림" onclick="zipcodeFind();"><img src="../images/market/basket_btn03.gif" /></a><br />
							<input type="text" name="order_addr1"  value="<%=address.length<=1?"":address[1] %>" class="join_input" style="width:300px; margin-bottom:5px;" /> 기본주소<br />
							<input type="text" name="order_addr2"  value="<%=address.length<=1?"":address[2] %>" class="join_input" style="width:300px;" /> 나머지주소</td>
						</tr>
						<tr>
							<th>휴대폰</th>
							<td style="text-align:left;"><input type="text" name="order_tel1"  value="<%=tel[0] %>" class="join_input" style="width:50px;" onkeyup="commonFocusMove(this, 3, 'order_tel2');"/> - 
							<input type="text" name="order_tel2" id="order_tel2" value="<%=tel[1] %>" class="join_input" style="width:50px;" maxlength="4" onkeyup="commonFocusMove(this, 4, 'order_tel3');"/> - 
							<input type="text" name="order_tel3" id="order_tel3"  value="<%=tel[2] %>" class="join_input" style="width:50px;" maxlength="4" onkeyup="commonFocusMove(this, 4, 'order_email1');"/></td>
						</tr>
						<tr>
							<th>이메일주소</th>
							<td style="text-align:left;"><input type="text" name="order_email1" id="order_email1" value="<%=email[0] %>" class="join_input" style="width:100px;" /> @ 
							<input type="text" name="order_email2" id="order_email2" value="<%=email[1] %>" class="join_input" style="width:100px;" />
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
					</tbody>
				</table>

				<p class="con_tit"><img src="../images/market/basket_title03.gif" /></p>
				<p style="text-align:right">배송지 정보가 주문자 정보와 동일합니까? 예<input type="radio" name="equals" value="yes" onchange="equalsname();"/> 아니오<input type="radio" value="no" name="equals" onchange="equalsname();"/></p>
				<table cellpadding="0" cellspacing="0" border="0" class="con_table" style="width:100%;" style="margin-bottom:50px;">
					<colgroup>
						<col width="15%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th>성명</th>
							<td style="text-align:left;"><input type="text" name="delivery_name"  value="" class="join_input" /></td>
						</tr>
						<tr>
							<th>주소</th>
							<td style="text-align:left;"><input type="text" name="delivery_zipcode"  value="" class="join_input" style="width:50px; margin-bottom:5px;" /><a href="javascript:;" title="새 창으로 열림" onclick="zipcodeFind2();"><img src="../images/market/basket_btn03.gif" /></a><br />
							<input type="text" name="delivery_addr1"  value="" class="join_input" style="width:300px; margin-bottom:5px;" /> 기본주소<br />
							<input type="text" name="delivery_addr2"  value="" class="join_input" style="width:300px;" /> 나머지주소</td>
						</tr>
						<tr>
							<th>휴대폰</th>
							<td style="text-align:left;"><input type="text" name="delivery_tel1"  value="" class="join_input" style="width:50px;" onkeyup="commonFocusMove(this, 3, 'delivery_tel2');"/> - 
							<input type="text" name="delivery_tel2" id="delivery_tel2" value="" class="join_input" style="width:50px;" onkeyup="commonFocusMove(this, 4, 'delivery_tel3');"/> - 
							<input type="text" name="delivery_tel3" id="delivery_tel3" value="" class="join_input" style="width:50px;" onkeyup="commonFocusMove(this, 4, 'delivery_email1');"/></td>
						</tr>
						<tr>
							<th>이메일주소</th>
							<td style="text-align:left;"><input type="text" name="delivery_email1" id="delivery_email1" value="" class="join_input" style="width:100px;" /> @ 
							<input type="text" name="delivery_email2" id="delivery_email2" value="" class="join_input" style="width:100px;" />
							<select name="last_email_check2" onChange="emailSelect2(this);" class="pass" id="last_email_check2" >
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
							<th>배송메세지</th>
							<td style="text-align:left;"><input type="text" name="message"  value="" class="join_input" style="width:500px;" /></td>
						</tr>
					</tbody>
				</table>

				<p class="con_tit"><img src="../images/market/basket_title04.gif" /></p>
				<table cellpadding="0" cellspacing="0" border="0" class="con_table" style="width:100%;" style="margin-bottom:30px;">
					<colgroup>
						<col width="15%" />
						<col width="*" />
					</colgroup>
					<tbody>
						<tr>
							<th>결제금액</th>
							<td style="text-align:left;"><span class="money"><fmt:formatNumber value="<%=totalprice>=50000?totalprice:totalprice+2500%>" type="number" />원</span></td>
							<input type="hidden" name="totalprice" value="<%=totalprice%>"/>
						</tr>
						<tr>
							<th>결제방식선택</th>
							<td style="text-align:left;"><input type="radio" name="payment" value="카드결제" /> 카드결제&nbsp;&nbsp;&nbsp;<input type="radio" name="payment" value="무통장입금"/> 무통장입금&nbsp;&nbsp;&nbsp;<input type="radio" name="payment" value="실시간계좌이체"/> 실시간 계좌이체</td>
						</tr>
					</tbody>
				</table>
				<p style="text-align:right;"><button type="submit" style="border: 0"><img src="../images/market/basket_btn04.gif" /></button></p>
				</form>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
