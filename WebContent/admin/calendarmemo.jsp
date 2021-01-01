<%@page import="model.CalenderDAO"%>
<%@page import="java.util.List"%>
<%@page import="model.CalenderDTO"%>
<%@page import="java.util.Map"%>
<%@page import="java.util.HashMap"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="./isAdminLogin.jsp"%>
	<%
  java.util.Calendar cal=java.util.Calendar.getInstance(); //Calendar객체 cal생성
  int currentYear=cal.get(java.util.Calendar.YEAR); //현재 날짜 기억
  int currentMonth=cal.get(java.util.Calendar.MONTH);
  int currentDate=cal.get(java.util.Calendar.DATE);
  String Year=request.getParameter("year"); //나타내고자 하는 날짜
  String Month=request.getParameter("month");
  int year, month;
  if(Year == null && Month == null){ //처음 호출했을 때
  year=currentYear;
  month=currentMonth;
  }
  else { //나타내고자 하는 날짜를 숫자로 변환
   year=Integer.parseInt(Year);
   month=Integer.parseInt(Month);
   if(month<0) { month=11; year=year-1; } //1월부터 12월까지 범위 지정.
   if(month>11) { month=0; year=year+1; }
  }
  CalenderDAO dao = new CalenderDAO();
  List<CalenderDTO> list = dao.selectCalender(Integer.toString(year), Integer.toString(month+1));
  
  dao.close();
  
  cal.set(year, month, 1); //현재 날짜를 현재 월의 1일로 설정
  int startDay=cal.get(java.util.Calendar.DAY_OF_WEEK); //현재날짜(1일)의 요일
  int end=cal.getActualMaximum(java.util.Calendar.DAY_OF_MONTH); //이 달의 끝나는 날
  int br=0; //7일마다 줄 바꾸기
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

  <title>관리자모드</title>
 
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
      <li class="nav-item">
        <a class="nav-link" href="productslist.jsp">
          <i class="fas fa-fw fa-table"></i>
          <span>상품목록</span></a>
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
           <div class="row">
						<!-- 달력 상단 부분, 더 좋은 방법이 없을까? -->
						<table border=1 cellspacing=0 style="padding: 5px">
						<tr>
						<td colspan="7" style="text-align: center;"><a href="calendarmemo.jsp?year=<%=year - 1%>&month=<%=month%>"><span class="glyphicon glyphicon-backward">◀◀</span></a>
						<a href="calendarmemo.jsp?year=<%=year%>&month=<%=month - 1%>"><span class="glyphicon glyphicon-triangle-left">◀</span></a> 
						<%=year%>년 <%=month + 1%>월 
						<a href="calendarmemo.jsp?year=<%=year%>&month=<%=month + 1%>">▶</span></a> 
						<a href="calendarmemo.jsp?year=<%=year + 1%>&month=<%=month%>"><span class="glyphicon glyphicon-forward">▶▶</span></a>
						</td></tr>	<!-- 달력 부분 -->
							<tr style="text-align: center; background-color: #fdfac3;font-weight: bold;" height="30">
								<td width=150 style="color: red;">SUN</td>
								<!-- 일=1 -->
								<td width=150>MON</td>
								<!-- 월=2 -->
								<td width=150>TUE</td>
								<!-- 화=3 -->
								<td width=150>WED</td>
								<!-- 수=4 -->
								<td width=150>THU</td>
								<!-- 목=5 -->
								<td width=150>FRI</td>
								<!-- 금=6 -->
								<td width=150 style="color: blue;">SAT</td>
								<!-- 토=7 -->
							</tr>
							<tr height=80 style="vertical-align: top; text-align: left;">
								<%
									for (int i = 0; i < (startDay - 1); i++) { //빈칸출력
								%>
								<td>&nbsp;</td>
								<%
									br++;
								if ((br % 7) == 0) {
									%>
									</tr>
									<%
									}
								}
								for (int i = 1; i <= end; i++) { //날짜출력
									if(br%7==0)out.println("<td style='color: red; padding: 5px;'>" + i + "<br>");
									else if(br % 7==6)out.println("<td style='color: blue; padding: 5px;'>" + i + "<br>");
									else out.println("<td style='padding: 5px;'>" + i + "<br>");
									//메모(일정) 추가 부분
									for (CalenderDTO dto : list) {
										if (Integer.parseInt(dto.getC_day()) == i) {%>
											<a href="calendar_view.jsp?num=<%=dto.getNum()%>"><%=dto.getTitle() %></a><br />
										<%
										}
									}
	
									out.println("</td>");
									br++;
									if ((br % 7) == 0 && i != end) {
										out.println("</tr><tr height=80 style='vertical-align: top; text-align: left'>");
									}
								}
								while ((br++) % 7 != 0) //말일 이후 빈칸출력
								out.println("<td>&nbsp;</td>");
								%>
							</tr>
							
						</table>
					</div>
					<button type="button" class="btn btn-info"
								onclick="location.href='calendar_write.jsp?year=<%=year%>&month=<%=month+1%>';">일정등록하기</button>
          </div>
          <div class="card-footer small text-muted">Updated yesterday at 11:59 PM</div>
        </div>

        

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
