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

//작성자 본인확인을 위해 기존 게시물의 내용을 가져온다.
dto = dao.selectView(num);
//세션영역에 저장된 로그인 아이디를 String형으로 가져온다.
String session_id = session.getAttribute("USER_ID").toString();//방법1
//String session_id = (String)session.getAttribute("USER_ID");//방법2
String flag = request.getParameter("flag");
int affected = 0;
//작성자 본인 확인을 위해 DB에 입력된 작성자와 세션영역에 저장된 속성을 비교한다.
if(session_id.equals(dto.getId())){
	dto.setNum(num);//dto에 일련번호를 저장한후..
	affected = dao.delete(num);//delete메소드 호출
	if(attachedfile!=null){ 
		FileUtil.deleteFile(request, "/images/upload", attachedfile);
	}
} 
else{
	//작성자 본인이 아닌경우...
	JavascriptUtil.jsAlertBack("본인만 삭제가능합니다.", out);
	return;
}
dao.close();
if(affected==1){
	/*
	삭제이후에는 기존 게시물이 사라지므로 리스트로 이동해서
	삭제된 내역을 확인한다.
	*/
	
	JavascriptUtil.jsAlertLocation("삭제되었습니다.", "sub01_list.jsp?flag="+flag, out);
	
}
else{
	out.println(JavascriptUtil.jsAlertBack("삭제실패하였습니다."));
}
%>
