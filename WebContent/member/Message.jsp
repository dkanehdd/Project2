<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>    
<%-- Message.jsp --%>
<c:choose>
	<c:when test="${SUC_FAIL==1 }">
		<!-- 수정처리의 경우 -->
		<c:set var="sucmsg" value="회원가입이 완료되었습니다. 로그인페이지로 이동합니다." />
		<c:set var="sucurl" 
		value="/member/login.jsp" />
	</c:when>
	<c:otherwise>
		<!-- 삭제일 경우 -->
		<c:set var="failmsg" value="회원가입 실패" />
	</c:otherwise>
</c:choose>

<%--
수정을 성공하는 경우에는 상세보기 페이지로 돌아가고,
삭제를 성공하는 경우에는 리스트 페이지로 로케이션 된다.
 --%>
<script>
<c:choose>
	<c:when test="${SUC_FAIL==1 }">
		alert("${sucmsg }");
		location.href="<c:url value='${sucurl }' />";
	</c:when>
	<c:when test="${SUC_FAIL==0 }">
		alert("${failmsg }");
		history.back();
	</c:when>
</c:choose>
</script>