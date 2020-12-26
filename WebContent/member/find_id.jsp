<%@page import="model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String name = request.getParameter("id_name");
String email = request.getParameter("id_email");
System.out.println(name+ email);
MemberDAO dao = new MemberDAO();
String id = "";
String alert = "";
id = dao.findID(name, email);
if(id.equals("")){
	alert = "일치하는 회원정보가 없습니다.";
}
else{
	alert = "아이디 : "+id;
}
System.out.println(alert);
dao.close();
out.print(alert);
%>
