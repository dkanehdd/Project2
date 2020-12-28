<%@page import="model.PhotoDAO"%>
<%@page import="model.PhotoDTO"%>
<%@page import="util.FileUtil"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- 글작성 완료전 로그인 확인하기 -->
<%@ include file = "../member/isLogin.jsp" %>
<%
request.setCharacterEncoding("UTF-8");
//폼값받기
MultipartRequest mr = FileUtil.upload(request,
		request.getServletContext().getRealPath("images/upload"));
PhotoDTO dto = new PhotoDTO();
int affected;
if(mr!=null) {
	//파일업로드가 완료되면 나머지 폼값을 받기위해 mr참조변수를 이용한다.
	String id = session.getAttribute("USER_ID").toString();
	String title = mr.getParameter("title");
	String content = mr.getParameter("content");
	//서버에 저장된 실제파일명을 가져온다.
	String attachedfile = mr.getFilesystemName("attachedfile");
	
	//DTO객체에 위의 폼값을 저장한다.
	
	dto.setId(id);
	dto.setAttachedfile(attachedfile);
	dto.setContent(content);
	dto.setTitle(title);
	//DAO객체생성 및 연결 ...insert처리
	PhotoDAO dao = new PhotoDAO();
	
	//파일업로드 성공 및 insert성공시
	affected = dao.insert(dto);
	dao.close(); 
}
else {
	//mr객체가 생성되지 않은경우, 즉 파일업로드 실패시...
	affected = -1;
}
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
	response.sendRedirect("sub04.jsp");
}
else{
%>
<script type="text/javascript">
	alert("글쓰기에 실패하였습니다.");
	history.go(-1);
</script>
<%} %>
