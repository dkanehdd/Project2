<%@page import="model.PhotoDAO"%>
<%@page import="model.PhotoDTO"%>
<%@page import="util.FileUtil"%>
<%@page import="com.oreilly.servlet.MultipartRequest"%>
<%@page import="util.JavascriptUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("UTF-8");

//폼값받기
MultipartRequest mr = FileUtil.upload(request,
		request.getServletContext().getRealPath("images/upload"));
PhotoDTO dto = new PhotoDTO();

int affected = 0 ;
if(mr!=null) {
	//파일업로드가 완료되면 나머지 폼값을 받기위해 mr참조변수를 이용한다.
	String num = mr.getParameter("num");
	String title = mr.getParameter("title");
	String content = mr.getParameter("content");
	//서버에 저장된 실제파일명을 가져온다.
	String originalfile = mr.getParameter("originalfile");
	String attachedfile = mr.getFilesystemName("attachedfile");
	if(attachedfile==null) {
		attachedfile = originalfile;
	}
	System.out.println(attachedfile);
	dto.setNum(num);
	dto.setAttachedfile(attachedfile);
	dto.setContent(content);
	dto.setTitle(title);
	//DAO객체생성 및 연결 ...insert처리
	PhotoDAO dao = new PhotoDAO();
	
	//파일업로드 성공 및 insert성공시
	affected = dao.updateEdit(dto); 
	if(affected==1 && mr.getFilesystemName("attachedfile")!=null) {
		FileUtil.deleteFile(request, "/images/upload", originalfile);
	}
	System.out.println("파일삭제?"+affected);
	dao.close();
}
else {
	//mr객체가 생성되지 않은경우, 즉 파일업로드 실패시...
	affected = -1;
}

if(affected==1){
	JavascriptUtil.jsAlertLocation("수정되었습니다.", "sub04.jsp", out);
}
else{
	out.println(JavascriptUtil.jsAlertBack("수정실패하였습니다."));
} %>
