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
String id_save = request.getParameter("id_save");

System.out.print(id);
//DAO객체 생성 및 DB연결
MemberDAO dao = new MemberDAO();
JSONObject jsonObj = new JSONObject();
//방법3 : Map 컬렉션에 저장된 회원정보를 통해 세션영역에 저장
Map<String, String> memberMap = dao.getMemberMap(id, pw);
if(memberMap.get("id")!=null){
	//로그인 성공시 세션영역에 아래 속성을 저장한다.
	session.setAttribute("USER_ID", memberMap.get("id"));
	session.setAttribute("USER_PW", memberMap.get("pass"));
	session.setAttribute("USER_NAME", memberMap.get("name"));
	//로그인 페이지로 이동
	if(id_save==null){
		//체크해제하면 쿠키를 삭제한다. 
		CookieUtil.makeCookie(request, response, "SaveId", "", 0);
	}
	else{
		//체크하면 쿠키를 생성한다.
		CookieUtil.makeCookie(request, response, "SaveId", id,
				60*60*24);
	}
	jsonObj.put("result", 1);
	String html  ="<p style='padding:10px 0px 10px 10px'><span style='font-weight:bold; color:#333;' id='user_name'>"
			+memberMap.get("name")+"님,</span> 반갑습니다.<br />로그인 하셨습니다.</p>"
	+"<p style='text-align:right; padding-right:10px;'>"
	+"<a href=''><img src='../images/login_btn04.gif' /></a>"
	+"<a href=''><img src='../images/login_btn05.gif' /></a>"
	+"</p>";
	jsonObj.put("HTML", html);
	
}
else{
	jsonObj.put("result", 0);
	jsonObj.put("message", "가입하지 않은 아이디이거나, 잘못된 비밀번호입니다.");
}
dao.close();
String jsonTxt = jsonObj.toJSONString();
out.println(jsonTxt);
%>
