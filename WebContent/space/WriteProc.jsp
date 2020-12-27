<%@page import="util.FileUtil"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="model.BoardDAO"%>
<%@page import="model.BoardDTO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 글작성 완료전 로그인 확인하기 -->
<%@ include file = "../member/isLogin.jsp" %>
<%
request.setCharacterEncoding("UTF-8");
//폼값받기
MultipartRequest mr = FileUtil.upload(request,
		request.getServletContext().getRealPath("images/upload"));
BoardDTO dto = new BoardDTO();
int affected;
if(mr!=null) {
	//파일업로드가 완료되면 나머지 폼값을 받기위해 mr참조변수를 이용한다.
	String id = session.getAttribute("USER_ID").toString();
	String title = mr.getParameter("title");
	String content = mr.getParameter("content");
	//서버에 저장된 실제파일명을 가져온다.
	String attachedfile = mr.getFilesystemName("attachedfile");
	
	//DTO객체에 위의 폼값을 저장한다.
	
	System.out.println(attachedfile);
	dto.setId(id);
	dto.setAttachedfile(attachedfile);
	dto.setContent(content);
	dto.setTitle(title);
	dto.setNotice("F");
	//DAO객체생성 및 연결 ...insert처리
	BoardDAO dao = new BoardDAO();
	
	//파일업로드 성공 및 insert성공시
	affected = dao.insertWrite(dto);
	dao.close();
}
else {
	//mr객체가 생성되지 않은경우, 즉 파일업로드 실패시...
	affected = -1;
}
// BoardDTO dto = new BoardDTO();
// dto.setTitle(title);
// dto.setContent(content);
// //세션영역에 저장된 회원인증정보를 가져와서 DTO에 삽입
// dto.setId(session.getAttribute("USER_ID").toString());
// dto.setNotice("F");
// //DAO객체 생성시 application내장객체를 파라미터로 전달
// BoardDAO dao = new BoardDAO();
// //사용자의 입력값을 저장한 DTO객체를 DAO로 전달후 insert처리
// int affected = dao.insertWrite(dto); 


/*
//테스트데이터가 필요한 경우 아래 for문을 사용 할것 100개 한번에 입력
int affected = 1;
for(int i=1 ; i<=100 ; i++){
	
	dto.setTitle(title+" "+i+"번째 게시물");
	dto.setContent(content+" "+i+"번째 게시물");
	affected = dao.insertWrite(dto);
}
*/
// dao.close();
if(affected==1){
	//글쓰기에 성공했을때
	//새로운 게시물이 생성됬는지 확인하기위해 리스트의 첫번째페이지로 이동
	if(dto.getAttachedfile()==null){
		response.sendRedirect("sub03.jsp");
	}
	else{
		response.sendRedirect("sub05.jsp");
	}
	
}
else{
%>
<script type="text/javascript">
	alert("글쓰기에 실패하였습니다.");
	history.go(-1);
</script>
<%} %>
