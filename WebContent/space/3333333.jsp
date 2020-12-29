<%@page import="model.CalenderDTO"%>
<%@page import="java.util.List"%>
<%@page import="model.CalenderDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
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
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>celender</title>
</head>
<body>

	<center>
		<table border=0>
			<!-- 달력 상단 부분, 더 좋은 방법이 없을까? -->
			<tr>
				<td align=left width=200><a href="3333333.jsp">오늘날짜로 이동</a></td>
				<td align=center width=300>
					<a href="3333333.jsp?year=<%=year-1%>&month=<%=month%>">◀◀</a>


					<a
					href="3333333.jsp?year=<%=year%>&month=<%=month-1%>">◀</a>
					<%=year%>년 <%=month+1 %>월 <a
					href="3333333.jsp?year=<%=year%>&month=<%=month+1%>">▶</a>
					<a
					href="3333333.jsp?year=<%=year+1%>&month=<%=month%>">▶▶</a>
				</td>
				<td align=right width=200>
				</td>
			</tr>
		</table>
		<table border=1 cellspacing=0>
			<!-- 달력 부분 -->
			<tr>
				<td width=100>SUN</td>
				<!-- 일=1 -->
				<td width=100>MON</td>
				<!-- 월=2 -->
				<td width=100>화</td>
				<!-- 화=3 -->
				<td width=100>수</td>
				<!-- 수=4 -->
				<td width=100>목</td>
				<!-- 목=5 -->
				<td width=100>금</td>
				<!-- 금=6 -->
				<td width=100>토</td>
				<!-- 토=7 -->
			</tr>
			<tr height=30>
		<%
   
   for(int i=0; i<(startDay-1); i++) { //빈칸출력%>
	<td>&nbsp;</td>   
	<%
    br++;
    if((br%7)==0) {
     out.println("<br>");
    }
   }
   for(int i=1; i<=end; i++) { //날짜출력
    out.println("<td>" + i + "<br>");
      //메모(일정) 추가 부분
      for(CalenderDTO dto : list){
        if(Integer.parseInt(dto.getC_day())==i) {
         out.println(dto.getTitle()+"<br>"); 
        }
      }
         
    out.println("</td>");
    br++;
    if((br%7)==0 && i!=end) {
     out.println("</tr><tr height=30>");
    }
   }
   while((br++)%7!=0) //말일 이후 빈칸출력
    out.println("<td>&nbsp;</td>");
   %>
			</tr>
		</table>
	</center>
</body>
</html>
<%--    <% --%>
<!-- //         //사용한 자원을 반납한다. -->
<!-- //        pstmt.close(); -->
<!-- //        conn.close(); -->
<%--    %> --%>
</html>