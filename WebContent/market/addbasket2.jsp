<%@page import="util.JavascriptUtil"%>
<%@page import="model.BasketDTO"%>
<%@page import="model.BasketDAO"%>
<%@page import="model.ProductDTO"%>
<%@page import="model.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../member/isLogin.jsp"%>
<%
String num = request.getParameter("num");
String location = request.getParameter("location");
ProductDAO dao = new ProductDAO();

//일련번호에 해당하는 게시물을 DTO객체로 반환함.
ProductDTO dto = dao.selectView(num);
//커넥션풀에 객체 반납
dao.close();
BasketDTO bdto = new BasketDTO();

bdto.setGoods_count(1);
bdto.setUser_id(session.getAttribute("USER_ID").toString());
bdto.setProduct_num(Integer.parseInt(num));
bdto.setTotal_price(dto.getGoods_price());

BasketDAO bdao = new BasketDAO();
int affected = bdao.addBasket(bdto);

if(affected==1){
	JavascriptUtil.jsAlertLocation("구매하기페이지로 이동합니다.", location, out);
}
else{
	JavascriptUtil.jsAlertBack("실패", out);
}
%>
