<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

 <body>
	<center>
	<div id="wrap">
		<%@ include file="../include/top.jsp" %>

		<img src="../images/market/sub_image.jpg" id="main_visual" />

		<div class="contents_box">
			<div class="left_contents">
				
				<%@ include file = "../include/market_leftmenu.jsp" %>
			</div>
			<div class="right_contents">
				<div class="top_title">
					<img src="../images/market/sub01_title.gif" alt="수아밀 제품 주문" class="con_title" />
					<p class="location"><img src="../images/center/house.gif" />&nbsp;&nbsp;열린장터&nbsp;>&nbsp;수아밀 제품 주문<p>
				</div>
				<form action="addbasket2.jsp">
				<table cellpadding="0" cellspacing="0" border="0" class="market_board01">
					<colgroup>
						<col width="20%" />
						<col width="*" />
						<col width="10%" />
						<col width="10%" />
						<col width="15%" />
					</colgroup>
					<tr>
						<th style="text-align: center;">상품이미지</th>
						<th>상품명</th>
						<th style="text-align: center;">가격</th>
						<th style="text-align: center;">수량</th>
						<th style="text-align: center;">구매</th>
					</tr>
					<c:choose>
						<c:when test="${empty lists }">
							<tr>
								<td colspan="6" align="center">등록된 상품이 없습니다.</td>
							</tr>
						</c:when>
						<c:otherwise>
							<c:forEach items="${lists }" var="row" varStatus="loop">
								<!-- 리스트반복 start -->
								<tr>
									<td><a
										href="../market/view?num=${row.num }&nowPage=${map.nowPage}">
											<img src="../images/market/${row.image }" alt="${row.goods_name }" style="width: 120px;height: 80px"/></a></td>
									<td class="text-left"><a
										href="../market/view?num=${row.num }&nowPage=${map.nowPage}">
											${row.goods_name } </a></td>
									<td  class="p_style"><fmt:formatNumber value="${row.goods_price }" type="number" /></td>
									<td><input type="number" name="count" value="1" class="n_box" readonly="readonly"/></td>
									<td><a href="addbasket2.jsp?num=${row.num }&location=basket02.jsp" style="border: 0"><img src="../images/market/btn01.gif" style="margin-bottom:5px;" /></a><br />
									<a href="basket.jsp"><img src="../images/market/btn02.gif" /></a>
									</td>
								</tr>
								<!-- 리스트반복 end -->
							</c:forEach>
						</c:otherwise>
					</c:choose>
				</table>
				</form>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
