<%@page import="util.JavascriptUtil"%>
<%@page import="model.BasketDTO"%>
<%@page import="model.BasketDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String[] num = request.getParameterValues("num");
String[] count = request.getParameterValues("count");
String location = request.getParameter("location");
BasketDAO dao = new BasketDAO();
int affected=0;
for(int i=0 ; i<num.length ; i++){
	BasketDTO dto = dao.select(num[i]);
	dto.setGoods_count(Integer.parseInt(count[i]));
	dto.setTotal_price(Integer.parseInt(count[i])*dto.getGoods_price());
	affected=  dao.updateEdit(dto);
}
if(affected==1){
	JavascriptUtil.jsAlertLocation("수정되었습니다.", location, out);
}
else{
	JavascriptUtil.jsAlertLocation("수정실패", location, out);
}
%>
