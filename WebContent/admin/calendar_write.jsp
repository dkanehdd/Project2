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
String id = session.getAttribute("USER_ID").toString();
String year = request.getParameter("year");
String month = request.getParameter("month");

MemberDAO dao = new MemberDAO();
MemberDTO dto = dao.getMemberDTO(id);
dao.close();

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
<script language="javascript">
function checkFormModify()
{
	str2=document.regFrm;
	if(!str2.title.value){ alert("제목을 입력하세요..!!");str2.id.focus();return false;}
	if(!str2.contents.value){ alert("내용을 입력하세요..!!");str2.name.focus();return false;}
	if(!str2.day.value){ alert("날짜 입력하세요..!!");str2.name.focus();return false;}
}
</script>
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
<ul class="sidebar navbar-nav">
    <!-- Sidebar -->
    <li class="nav-item">
        <a class="nav-link" href="member_table.jsp">
          <i class="fas fa-fw fa-table"></i>
          <span>회원정보</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="noticeboard.jsp">
          <i class="fas fa-fw fa-table"></i>
          <span>공지사항테이블</span></a>
      </li>
      <li class="nav-item active">
        <a class="nav-link" href="freeboard.jsp">
          <i class="fas fa-fw fa-table"></i>
          <span>자유게시판</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="calendarmemo.jsp">
          <i class="fas fa-fw fa-chart-area"></i>
          <span>일정관리</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="photoboard.jsp">
          <i class="fas fa-fw fa-table"></i>
          <span>사진게시판</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="dataroom.jsp">
          <i class="fas fa-fw fa-table"></i>
          <span>정보자료실</span></a>
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
<form name="regFrm" method="post" action="../calendar/write" onSubmit="return checkFormModify();">
              <table class=list_table cellspacing=0 cellpadding=3 width="95%" align=center border=0>
				<tr>
					<td class=facts_label width="15%">아 이 디</td>
					<td class=facts_value width="85%">
							<input type="text" size=32 name="user_id" value='<%=dto.getId() %>' readonly>
					</td>
				</tr>
				<tr>
					<td class=facts_label width="15%">제 목</td>
					<td class=facts_value width="85%">
						<input type="text" size=32 name="title" value=''>
					</td>
				</tr>
				<tr>
					<td class=facts_label width="15%">내 용</td>
					<td class=facts_value width="85%">
						<textarea style="width: 85%" rows="15" name="contents"></textarea>
					</td>
				</tr>
				
				<tr>
					<td class=facts_label width="15%">날 짜</td>
					<td class=facts_value width="85%">
						<input type="text" name="year" size="4" value="<%=year %>" maxlength="4">년
						<input type="text" name="month" size="4" value="<%=month %>"   maxlength="2">월
						<input type="text" name="day" size="4" value=""   maxlength="2">일
					</td>
				</tr>
				
			<br>
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
