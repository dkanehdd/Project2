<%@page import="org.json.simple.JSONObject"%>
<%@page import="model.MemberDAO"%>
<%@page import="java.util.Map"%>
<%@page import="util.CookieUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
//폼값받기
String id = request.getParameter("user_id");
String pw = request.getParameter("user_pw");
//DAO객체 생성 및 DB연결
MemberDAO dao = new MemberDAO();
//방법3 : Map 컬렉션에 저장된 회원정보를 통해 세션영역에 저장
Map<String, String> memberMap = dao.getMemberMap(id, pw);
dao.close();
if(memberMap.get("id")!=null){
	//로그인 성공시 세션영역에 아래 속성을 저장한다.
	session.setAttribute("USER_ID", memberMap.get("id"));
	session.setAttribute("USER_NAME", memberMap.get("name"));
	// returnURL의 값에 따라 페이지 이동을 제어한다.
	response.sendRedirect("./member_table.jsp");
}
else{
%>
<script>
alert('가입하지 않은 아이디이거나, 잘못된 비밀번호입니다.');
history.back();
</script>
<%
}

%>
