<%@page import="util.FileUtil"%>
<%@page import="util.JavascriptUtil"%>
<%@page import="model.BoardDAO"%>
<%@page import="model.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../member/isLogin.jsp"%>
<%
request.setCharacterEncoding("UTF-8");
String num = request.getParameter("num");
String attachedfile = request.getParameter("attachedfile");

BoardDTO dto = new BoardDTO();
BoardDAO dao = new BoardDAO();

dto = dao.selectView(num);
String flag = request.getParameter("flag");
System.out.println(num+ attachedfile + flag);
int affected = 0;
affected = dao.delete(num);//delete메소드 호출

FileUtil.deleteFile(request, "/images/upload", attachedfile);

dao.close();
if(affected==1){
	/*
	삭제이후에는 기존 게시물이 사라지므로 리스트로 이동해서
	삭제된 내역을 확인한다.
	*/
	
	JavascriptUtil.jsAlertLocation("삭제되었습니다.", "noticeboard.jsp?flag="+flag, out);
	
}
else{
	out.println(JavascriptUtil.jsAlertBack("삭제실패하였습니다."));
}
%>
