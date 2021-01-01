<%@page import="util.JavascriptUtil"%>
<%@page import="model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String id = request.getParameter("id");

MemberDAO dao = new MemberDAO();
int affected = dao.delete(id); 

dao.close();
if(affected==1){
	/*
	삭제이후에는 기존 게시물이 사라지므로 리스트로 이동해서
	삭제된 내역을 확인한다.
	*/
	
	JavascriptUtil.jsAlertLocation("삭제되었습니다.", "member_table.jsp", out);
	
}
else{
	out.println(JavascriptUtil.jsAlertBack("삭제실패하였습니다."));
}
%>
