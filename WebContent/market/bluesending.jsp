<%@page import="util.JavascriptUtil"%>
<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="smtp.SMTPAuth"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
//메일 발송을 위한 객체생성
SMTPAuth smtp = new SMTPAuth();
String subject = request.getAttribute("title").toString();
String content = request.getAttribute("mailcontent").toString();
String email = request.getAttribute("user_email").toString();
//메일을 보내기위한 여러가지 폼값을 Map컬렉션에 저장
Map<String, String> emailContent = new HashMap<String, String>();
emailContent.put("from", "dkanehdd@naver.com");
emailContent.put("to", email);
emailContent.put("subject", subject);
// emailContent.put("content", request.getParameter("content"));
emailContent.put("content", content);
//내용이 null값이 아니라면 이메일 발송
boolean emailResult = smtp.emailSending(emailContent);
if (emailResult == true) {
	emailContent.put("to", application.getInitParameter("adminEmail").toString());
	smtp.emailSending(emailContent);
	JavascriptUtil.jsAlertLocation("신청완료되었습니다.", "../main/main.do", out);
} else {
	JavascriptUtil.jsAlertLocation("신청실패", "../main/main.do", out);
}
%>
