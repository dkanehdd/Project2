<%@page import="model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
/*
해당 페이지처럼 JSP코드를 포함한 파일을 include 할때는 지시어를 통해 include하는것이 좋다
액션태그를 사용하는 경우 먼저 컴파일된후 페이지에 삽입되므로 문제가 될수 있다.
*/
//글쓰기 페이지 진입전 로그인 되었는지 확인
if(session.getAttribute("USER_ID")!=null){
	MemberDAO dao = new MemberDAO();
	if(dao.adminCheck(session.getAttribute("USER_ID").toString()).equals("F")){
	dao.close();
	
	StringBuffer r_url = request.getRequestURL();
	String r_uri = request.getRequestURI();
%>
	<script>
	
		alert("관리자회원만 이용하실수 있습니다.");
		location.href = "../main/main.do";
	</script>
<%
	return;
	}
	dao.close();
}
else{
	%>
<script>
	
		alert("로그인후 이용하실수 있습니다.");
		location.href = "../member/login.jsp";
	</script>
<%
	return;
}
%>