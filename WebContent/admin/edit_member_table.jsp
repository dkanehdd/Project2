<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@page import="model.MemberDTO"%>
<%@page import="java.util.List"%>
<%@page import="model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="./isAdminLogin.jsp"%>
<%
request.setCharacterEncoding("utf-8");
String id = request.getParameter("id");
MemberDAO dao = new MemberDAO();
MemberDTO dto = dao.getMemberDTO(id);
dao.close();
String[] email = dto.getEmail().split("@");
String[] tel = dto.getTelephone().split("-");
String[] cell = dto.getCellphone().split("-");
String[] zip = dto.getAddress().split("/");
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<head>

  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no">
  <meta name="description" content="">
  <meta name="author" content="">

  <title>SB Admin - Tables</title>
 
  <!-- Custom fonts for this template-->
  <link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet" type="text/css">

  <!-- Page level plugin CSS-->
  <link href="vendor/datatables/dataTables.bootstrap4.css" rel="stylesheet">

  <!-- Custom styles for this template-->
  <link href="css/sb-admin.css" rel="stylesheet">

</head>

<body id="page-top">

   <nav class="navbar navbar-expand navbar-dark bg-dark static-top">

    <a class="navbar-brand mr-1" href="index.html">관리자모드</a>

    <button class="btn btn-link btn-sm text-white order-1 order-sm-0" id="sidebarToggle" href="#">
      <i class="fas fa-bars"></i>
    </button>

    <!-- Navbar Search -->

    <!-- Navbar -->

  </nav>

  <div id="wrapper">

    <!-- Sidebar -->
    <ul class="sidebar navbar-nav">
      <li class="nav-item">
        <a class="nav-link" href="charts.html">
          <i class="fas fa-fw fa-chart-area"></i>
          <span>Charts</span></a>
      </li>
      <li class="nav-item active">
        <a class="nav-link" href="member_table.jsp">
          <i class="fas fa-fw fa-table"></i>
          <span>회원정보</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="notice_table.jsp">
          <i class="fas fa-fw fa-table"></i>
          <span>공지사항테이블</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="calendarmemo.jsp">
          <i class="fas fa-fw fa-table"></i>
          <span>일정관리</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="adminDataRoom.jsp">
          <i class="fas fa-fw fa-table"></i>
          <span>직원자료실</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="parentsboard.jsp">
          <i class="fas fa-fw fa-table"></i>
          <span>보호자 게시판</span></a>
      </li>
    </ul>

    <div id="content-wrapper">

      <div class="container-fluid">

        <!-- Breadcrumbs-->
        <ol class="breadcrumb">
          <li class="breadcrumb-item">
            <a href="#">회원정보</a>
          </li>
          <li class="breadcrumb-item active">Tables</li>
        </ol>

        <!-- DataTables Example -->
        <div class="card mb-3">
          <div class="card-header">
            <i class="fas fa-table"></i>
           회원정보</div>
          <div class="card-body">
            <div class="table-responsive">
<form name="regFrm" method="post" action="../member/memberedit" onSubmit="return checkFormModify();">
              <table class=list_table cellspacing=0 cellpadding=3 width="95%" align=center border=0>
				<input type="hidden" name="originalpass" value="<%=dto.getPass()%>"/>
				<tr>
					<td class=facts_label width="15%">아 이 디</td>
					<td class=facts_value width="85%">
							<input type="text" size=32 name="user_id" value='<%=dto.getId() %>' readonly>
						아이디는 변경하실 수 없습니다.
					</td>
				</tr>
				<tr>
					<td class=facts_label width="15%">패스워드</td>
					<td class=facts_value width="85%">
						<input type="password" size=32 name="user_pass" value=''>
						※입력하시면 입력하신 값으로 패스워드가 변경됩니다.
					</td>
				</tr>
				<tr>
					<td class=facts_label width="15%">이 름</td>
					<td class=facts_value width="85%">
						<input type="text" size=32 name="name" value='<%=dto.getName() %>' >
					</td>
				</tr>
				<tr>
					<td class=facts_label width="15%">이 메 일</td>
					<td class=facts_value width="85%">
						<input type="text" name="email_1" style="width:100px;height:20px;" value="<%=email[0] %>" />
@
<input type="text" name="email_2" style="width:150px;height:20px;" value="" readonly />

<select name="last_email_check2" onChange="email_input(this);">
	<option selected="" value="">선택해주세요</option>
	<option value="1"						>직접입력</option>
	<option value="dreamwiz.com"	>dreamwiz.com</option>
	<option value="empal.com"			>empal.com</option>
	<option value="empas.com"		>empas.com</option>
	<option value="freechal.com"		>freechal.com</option>
	<option value="hanafos.com"		>hanafos.com</option>
	<option value="hanmail.net"		>hanmail.net</option>
	<option value="hotmail.com"		>hotmail.com</option>
	<option value="intizen.com"		>intizen.com</option>
	<option value="korea.com"			>korea.com</option>
	<option value="kornet.net"			>kornet.net</option>
	<option value="msn.co.kr"			>msn.co.kr</option>
	<option value="nate.com"			>nate.com</option>
	<option value="naver.com"			>naver.com</option>
	<option value="netian.com"		>netian.com</option>
	<option value="orgio.co.kr"			>orgio.co.kr</option>
	<option value="paran.com"			>paran.com</option>
	<option value="sayclub.com"		>sayclub.com</option>
	<option value="yahoo.co.kr"		>yahoo.co.kr</option>
	<option value="yahoo.com"		>yahoo.com</option>
</select>
<script language="javascript">

function email_input (code)  { 
	for(var i=0; i<code.length;i++){ 
		if (document.regFrm.last_email_check2.options[i].selected == true)  { 
			if(code.options[code.selectedIndex].value == 1){
				document.regFrm.email_2.value = "";
				//document.regregFrm.getElementByld("email_2").readonly = false;
				document.regFrm.email_2.readOnly = false;
				document.regFrm.email_2.focus();
			}
			else{
				document.regFrm.email_2.readOnly = true;
				document.regFrm.email_2.value = code.options[code.selectedIndex].value;
			}
		}
	}
}
function checkFormModify()
{
	str2=document.regFrm;
	if(!str2.user_id.value){ alert("아이디를 입력하세요..!!");str2.id.focus();return false;}
	if(!str2.name.value){ alert("이름을 입력하세요..!!");str2.name.focus();return false;}
	if(!str2.admin.value){ alert("관리자계정을 입력하세요..!!");str2.name.focus();return false;}
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
                   var f = document.regFrm;
                   f.zipcode.value = data.zonecode;
                   f.addr1.value = data.address;
                   f.addr2.focus();
               }
           }).open();
       }
   </script>
					</td>
				</tr>
				<tr>
					<td class=facts_label width="15%">일반전화</td>
					<td class=facts_value width="85%">
						<input type="text" name="tel1" size="3" value="<%=tel[0] %>" maxlength="3"> -
						<input type="text" name="tel2" size="4" value="<%=tel[1] %>"   maxlength="4"> -
						<input type="text" name="tel3" size="4" value="<%=tel[2] %>"   maxlength="4">
					</td>
				</tr>
				<tr>
					<td class=facts_label width="15%">휴대전화</td>
					<td class=facts_value width="85%">
						<input type="text" name="mobile1" size="3" value="<%=cell[0] %>" maxlength="3"> -
						<input type="text" name="mobile2" size="4" value="<%=cell[1] %>"   maxlength="4"> -
						<input type="text" name="mobile3" size="4" value="<%=cell[2] %>"   maxlength="4">
					</td>
				</tr>
				<tr>
					<td class=facts_label width="15%">관리자계정</td>
					<td class=facts_value width="85%">
						<input type="text" name="admin" value="<%=dto.getAdmin() %>" maxlength="1"> ※ T or F입력, 입력안할시 수정 불가
					</td>
				</tr>
				<tr>
						<th><img src="../images/join_tit09.gif" /></th>
						<td>
						<input type="text" name="zipcode" value="<%=zip[0] %>"  class="join_input" style="width:50px;" />
						<a href="javascript:;" title="새 창으로 열림" onclick="zipcodeFind();" onkeypress="">[우편번호검색]</a>
						<br/>
						
						<input type="text" name="addr1" value="<%=zip[1] %>"  class="join_input" style="width:550px; margin-top:5px;" /><br>
						<input type="text" name="addr2" value="<%=zip[2] %>"  class="join_input" style="width:550px; margin-top:5px;" />
						
						</td>
					</tr>
				<tr>
				  <td align="right"><INPUT type=submit value=" 저 장 ">
				  <INPUT type=reset value=" 취 소 ">
				  <INPUT type=reset value=" 리스트 " onClick="javascript:location.href='member_table.jsp';"></td>
				</tr>
			</table>
			</form>
            </div>
          </div>
          <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>
        </div>

        <p class="small text-center text-muted my-5">
          <em>More table examples coming soon...</em>
        </p>

      </div>
      <!-- /.container-fluid -->

      <!-- Sticky Footer -->
      <footer class="sticky-footer">
        <div class="container my-auto">
          <div class="copyright text-center my-auto">
            <span>Copyright Â© Your Website 2019</span>
          </div>
        </div>
      </footer>

    </div>
    <!-- /.content-wrapper -->

  </div>
  <!-- /#wrapper -->

  <!-- Scroll to Top Button-->
  <a class="scroll-to-top rounded" href="#page-top">
    <i class="fas fa-angle-up"></i>
  </a>

  <!-- Logout Modal-->
  <div class="modal fade" id="logoutModal" tabindex="-1" role="dialog" aria-labelledby="exampleModalLabel" aria-hidden="true">
    <div class="modal-dialog" role="document">
      <div class="modal-content">
        <div class="modal-header">
          <h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
          <button class="close" type="button" data-dismiss="modal" aria-label="Close">
            <span aria-hidden="true">Ã</span>
          </button>
        </div>
        <div class="modal-body">Select "Logout" below if you are ready to end your current session.</div>
        <div class="modal-footer">
          <button class="btn btn-secondary" type="button" data-dismiss="modal">Cancel</button>
          <a class="btn btn-primary" href="login.html">Logout</a>
        </div>
      </div>
    </div>
  </div>

  <!-- Bootstrap core JavaScript-->
  <script src="vendor/jquery/jquery.min.js"></script>
  <script src="vendor/bootstrap/js/bootstrap.bundle.min.js"></script>

  <!-- Core plugin JavaScript-->
  <script src="vendor/jquery-easing/jquery.easing.min.js"></script>

  <!-- Page level plugin JavaScript-->
  <script src="vendor/datatables/jquery.dataTables.js"></script>
  <script src="vendor/datatables/dataTables.bootstrap4.js"></script>

  <!-- Custom scripts for all pages-->
  <script src="js/sb-admin.min.js"></script>

  <!-- Demo scripts for this page-->
  <script src="js/demo/datatables-demo.js"></script>

</body>

</html>
