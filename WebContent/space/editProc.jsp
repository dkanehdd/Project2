<%@page import="util.JavascriptUtil"%>
<%@page import="model.BoardDAO"%>
<%@page import="model.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

//폼값받기
String num = request.getParameter("num");
String title = request.getParameter("title");
String content = request.getParameter("content");
int nowPage = (request.getParameter("nowPage")==null ||
request.getParameter("nowPage").equals("")) ?
		1 : Integer.parseInt(request.getParameter("nowPage"));
//DTO객체 생성
BoardDTO dto = new BoardDTO();
dto.setNum(num);//특정게시물에 대한 수정이므로 일련번호 추가됨. WHERE절에 사용 
dto.setTitle(title);
dto.setContent(content);

//DAO객체생성
BoardDAO dao = new BoardDAO();
//수정 메소드 호출
int affected = dao.updateEdit(dto);
if(affected==1){
	JavascriptUtil.jsAlertLocation("수정되었습니다.", "sub03.jsp", out);
}
else{
	out.println(JavascriptUtil.jsAlertBack("삭제실패하였습니다."));
} %>
