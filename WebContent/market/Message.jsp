<%@page import="util.JavascriptUtil"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%-- Message.jsp --%>
<%
String param = request.getParameter("SUC");
if(param.equals("1")){
	JavascriptUtil.jsAlertLocation("상품 주문이 완료되었습니다.", "../main/main.do", out);
}

%>
<script type="text/javascript">
<c:choose>
	<c:when test="${SUC==1 }">
		
			alert("상품 주문이 완료되었습니다.");
			location.href='../main/main.do';
	</c:when>
	<c:otherwise>
			alert("주문 실패");
			location.href='../main/main.do';
		
	</c:otherwise>
</c:choose>
</script>
