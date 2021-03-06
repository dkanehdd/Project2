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
String count = request.getParameter("count");
ProductDAO dao = new ProductDAO();

//일련번호에 해당하는 게시물을 DTO객체로 반환함.
ProductDTO dto = dao.selectView(num);
//커넥션풀에 객체 반납
dao.close();
BasketDTO bdto = new BasketDTO();

bdto.setGoods_count(Integer.parseInt(count));
bdto.setUser_id(session.getAttribute("USER_ID").toString());
bdto.setProduct_num(Integer.parseInt(num));
bdto.setTotal_price(Integer.parseInt(count)*dto.getGoods_price());

BasketDAO bdao = new BasketDAO();
int affected = bdao.addBasket(bdto);
bdao.close();
if(affected==1){
	JavascriptUtil.jsAlertLocation("장바구니에 추가되었습니다.", "../market/list", out);
}
else{
	JavascriptUtil.jsAlertBack("장바구니 추가 실패", out);
}
%>
