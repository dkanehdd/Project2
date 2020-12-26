<%@page import="java.util.HashMap"%>
<%@page import="java.util.Map"%>
<%@page import="smtp.SMTPAuth"%>
<%@page import="model.MemberDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");
String name = request.getParameter("pw_name");
String email = request.getParameter("pw_email");
String id = request.getParameter("pw_id");
System.out.println(name+"+" +email+"+"+id);
MemberDAO dao = new MemberDAO();
String pass = dao.findPW(name, email,id);
String alert = "";
if(!(pass.equals("")||pass==null)){
	
//메일 발송을 위한 객체생성
SMTPAuth smtp = new SMTPAuth();
	String subject = "마포구립 장애인 직업재활센터";
	String content = "비밀번호: "+ pass;
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
		alert="이메일로 비밀번호가 전송되었습니다.";
	} else {
		alert="메일 전송 실패";
	}
}
else{
	alert="가입되어있지 않은 회원정보입니다.";
}
System.out.println(alert);
dao.close();
out.print(alert);
%>
