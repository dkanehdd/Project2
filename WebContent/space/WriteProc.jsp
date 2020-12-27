<%@page import="model.BoardDAO"%>
<%@page import="model.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 글작성 완료전 로그인 확인하기 -->
<%@ include file = "../member/isLogin.jsp" %>
<%
request.setCharacterEncoding("UTF-8");
//폼값받기
String title = request.getParameter("title");//제목
String content = request.getParameter("content");//내용

BoardDTO dto = new BoardDTO();
dto.setTitle(title);
dto.setContent(content);
//세션영역에 저장된 회원인증정보를 가져와서 DTO에 삽입
dto.setId(session.getAttribute("USER_ID").toString());
dto.setNotice("F");
//DAO객체 생성시 application내장객체를 파라미터로 전달
BoardDAO dao = new BoardDAO();
//사용자의 입력값을 저장한 DTO객체를 DAO로 전달후 insert처리
int affected = dao.insertWrite(dto); 


/*
//테스트데이터가 필요한 경우 아래 for문을 사용 할것 100개 한번에 입력
int affected = 1;
for(int i=1 ; i<=100 ; i++){
	
	dto.setTitle(title+" "+i+"번째 게시물");
	dto.setContent(content+" "+i+"번째 게시물");
	affected = dao.insertWrite(dto);
}
*/
dao.close();
if(affected==1){
	//글쓰기에 성공했을때
	//새로운 게시물이 생성됬는지 확인하기위해 리스트의 첫번째페이지로 이동
	response.sendRedirect("sub03.jsp");
}
else{
%>
<script type="text/javascript">
	alert("글쓰기에 실패하였습니다.");
	history.go(-1);
</script>
<%} %>
