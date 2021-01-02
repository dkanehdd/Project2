<%@page import="util.JavascriptUtil"%>
<%@page import="model.BasketDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String[] num = request.getParameterValues("delete");
String location = request.getParameter("location");
int count = 0;
BasketDAO dao = new BasketDAO();
if(num!=null){
	for(String i : num){
		int affected = dao.delete(i);
		if(affected==1){
			count++;
			continue;
		}
		else{
			break;
		}
	}
	dao.close();
	JavascriptUtil.jsAlertLocation("선택항목이 삭제되었습니다.", location, out);
}
else{
	JavascriptUtil.jsAlertLocation("항목을 선택해주세요.", location, out);
}

%>
