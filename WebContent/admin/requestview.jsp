<%@page import="model.FormDTO"%>
<%@page import="model.FormDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="./isAdminLogin.jsp"%>
<%
	//파라미터로 전송된 게시물의 일련번호를 받음
String num = request.getParameter("num");

FormDAO dao = new FormDAO();
//조회수를 업데이트하여 visitcount컬럼을 1증가시킴

//일련번호에 해당하는 게시물을 DTO객체로 반환함.
FormDTO dto = dao.selectView(num); 
 
dao.close();
%>
<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta http-equiv="Content-Script-Type" content="text/javascript" />
<head>
	<meta name="viewport"
		content="width=device-width, initial-scale=1, shrink-to-fit=no">
	<meta name="description" content="">
	<meta name="author" content="">
	

<title>관리자모드</title>

<!-- Custom fonts for this template-->
<link href="vendor/fontawesome-free/css/all.min.css" rel="stylesheet"
	type="text/css">

<!-- Page level plugin CSS-->
<link href="vendor/datatables/dataTables.bootstrap4.css"
	rel="stylesheet">

<!-- Custom styles for this template-->
<link href="css/sb-admin.css" rel="stylesheet">

</head>

<body id="page-top">

	<nav class="navbar navbar-expand navbar-dark bg-dark static-top">
	<a class="navbar-brand mr-1" href="index.html">관리자모드</a>

	<button class="btn btn-link btn-sm text-white order-1 order-sm-0"
		id="sidebarToggle">
		<i class="fas fa-bars"></i>
	</button>

	<!-- Navbar Search --> <!-- Navbar --> 
	</nav>

	<div id="wrapper">

		<!-- Sidebar -->
		<ul class="sidebar navbar-nav">
     
      <li class="nav-item">
        <a class="nav-link" href="member_table.jsp">
          <i class="fas fa-fw fa-table"></i>
          <span>회원정보</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="noticeboard.jsp?flag=notice">
          <i class="fas fa-fw fa-table"></i>
          <span>공지사항테이블</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="noticeboard.jsp?flag=free">
          <i class="fas fa-fw fa-table"></i>
          <span>자유게시판</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="calendarmemo.jsp">
          <i class="fas fa-fw fa-chart-area"></i>
          <span>일정관리</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="noticeboard.jsp?flag=photo">
          <i class="fas fa-fw fa-table"></i>
          <span>사진게시판</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="noticeboard.jsp?flag=dataroom">
          <i class="fas fa-fw fa-table"></i>
          <span>정보자료실</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="noticeboard.jsp?flag=admin">
          <i class="fas fa-fw fa-table"></i>
          <span>직원자료실</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="noticeboard.jsp?flag=parents">
          <i class="fas fa-fw fa-table"></i>
          <span>보호자 게시판</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="request_form.jsp?flag=bluecleaning">
          <i class="fas fa-fw fa-table"></i>
          <span>블루클리닝견적의뢰서</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="request_form.jsp?flag=experience">
          <i class="fas fa-fw fa-table"></i>
          <span>체험학습신청서</span></a>
      </li>
    </ul>
		<div id="content-wrapper">

			<div class="container-fluid">

				<!-- Breadcrumbs-->
				<ol class="breadcrumb">
					<li class="breadcrumb-item"><a href="#"><%=dto.getFlag()%></a>
					</li>
					<li class="breadcrumb-item active">Tables</li>
				</ol>

				<!-- DataTables Example -->
				<div class="card mb-3">
					<div class="card-header">
						<i class="fas fa-table"></i> 회원정보
					</div>
					<div class="card-body">
						<div class="table-responsive">
							<table class="table table-bordered" id="dataTable" width="100%"
								cellspacing="0">
								<tbody>
									<tr>
										<th class="text-center" style="vertical-align: middle;">고객명/회사명</th>
										<td><%=dto.getCompony()%></td>
										<th class="text-center" style="vertical-align: middle;">작성일</th>
										<td><%=dto.getPostdate()%></td>
									</tr>
									<tr>
										<th class="text-center" style="vertical-align: middle;">이메일</th>
										<td><%=dto.getEmail()%></td>
										<th class="text-center" style="vertical-align: middle;">핸드폰번호(담당자)</th>
										<td><%=dto.getCellphone()%>
									</tr>
									<tr>
										<th class="text-center" style="vertical-align: middle;">의뢰날짜</th>
										<td><%=dto.getSeleteDate()%></td>
										<th class="text-center" style="vertical-align: middle;">전화번호</th>
										<td><%=dto.getTelephone()%></td>
									</tr>
									<tr>
										<th class="text-center" style="vertical-align: middle;">핸드폰번호(담당자)</th>
										<td><%=dto.getCellphone()%>
										</td>
										<th class="text-center" style="vertical-align: middle;">기타특이사항</th>
										<td><%=dto.getOther()%>
										</td>
									</tr>
									<tr>
									<th class="text-center" style="vertical-align: middle;">접수구분</th>
										<td colspan="3"><%=dto.getRegister()%>
										</td>
									</tr>
									<%
										if (dto.getHandicap() != null) {
									%>
									<tr>
									<th class="text-center" style="vertical-align: middle;">체험내용</th>
										<td colspan="3"><%=dto.getExperience()%>
										</td>
									</tr>
									<tr>
									<th class="text-center" style="vertical-align: middle;">장애유무</th>
										<td colspan="3"><%=dto.getHandicap()%>
										</td>
									</tr>
									<tr>
									<th class="text-center" style="vertical-align: middle;">보장구 유무</th>
										<td colspan="3"><%=dto.getAssistingdevices()%>
										</td>
									</tr>
									<%
										}else{
									%>
									<tr>
									<th class="text-center" style="vertical-align: middle;">청소할곳주소</th>
										<td colspan="3"><%=dto.getAddress()%>
										</td>
									</tr>
									<tr>
									<th class="text-center" style="vertical-align: middle;">청소종류</th>
										<td colspan="3"><%=dto.getSort()%>
										</td>
									</tr>
									<tr>
									<th class="text-center" style="vertical-align: middle;">분양평수/등기평수</th>
										<td colspan="3"><%=dto.getAcre()%>
										</td>
									</tr>
									<%} %>
									<tr>
										<td>
											<button class="btn btn-info" type='button' value=" 리스트 "
												onClick="javascript:location.href='request_form.jsp?flag=<%=dto.getFlag()%>';">리스트보기</button>
										</td>
									</tr>
								</tbody>
							</table>
						</div>
					</div>
					<div class="card-footer small text-muted">Updated yesterday
						at 11:59 PM</div>
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
	<a class="scroll-to-top rounded" href="#page-top"> <i
		class="fas fa-angle-up"></i>
	</a>

	<!-- Logout Modal-->
	<div class="modal fade" id="logoutModal" tabindex="-1" role="dialog"
		aria-labelledby="exampleModalLabel" aria-hidden="true">
		<div class="modal-dialog" role="document">
			<div class="modal-content">
				<div class="modal-header">
					<h5 class="modal-title" id="exampleModalLabel">Ready to Leave?</h5>
					<button class="close" type="button" data-dismiss="modal"
						aria-label="Close">
						<span aria-hidden="true">Ã</span>
					</button>
				</div>
				<div class="modal-body">Select "Logout" below if you are ready
					to end your current session.</div>
				<div class="modal-footer">
					<button class="btn btn-secondary" type="button"
						data-dismiss="modal">Cancel</button>
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