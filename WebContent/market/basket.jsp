<%@page import="java.util.List"%>
<%@page import="model.BasketDTO"%>
<%@page import="model.BasketDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   <%@taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ include file="../member/isLogin.jsp"%>
<%
String id = session.getAttribute("USER_ID").toString();

BasketDAO bdao = new BasketDAO();
List<BasketDTO> list = bdao.selectAll(id);
bdao.close();
int totalprice = 0;
%>
<%@ include file="../include/global_head.jsp" %>


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
				<form action="deletebasket.jsp" method="get" name="regifrm">
				<table cellpadding="0" cellspacing="0" border="0" class="basket_list">
					<colgroup>
						<col width="7%" />
						<col width="10%" />
						<col width="*" />
						<col width="10%" />
						<col width="8%" />
						<col width="10%" />
						<col width="10%" />
						<col width="10%" />
						<col width="8%" />
					</colgroup>
					<thead>
						<tr>
							<th>선택</th>
							<th>이미지</th>
							<th>상품명</th>
							<th>판매가</th>
							<th>적립금</th>
							<th>수량</th>
							<th>배송구분</th>
							<th>배송비</th>
							<th>합계</th>
						</tr>
					</thead>
					<tbody>
					<%for(BasketDTO dto : list){ 
						totalprice+= dto.getTotal_price();
					%>
						<tr>
							<td><input type="checkbox" name="delete" value="<%=dto.getNum() %>" /></td>
							<td><img src="../images/market/<%=dto.getImage() %>"  style="width: 50px;height: 50px"/></td>
							<td><%=dto.getGoods_name() %></td>
							<td><fmt:formatNumber value="<%=dto.getGoods_price() %>" type="number" />원</td>
							<td><img src="../images/market/j_icon.gif" />&nbsp;<%=dto.getGoods_mileage() %>원</td>
							<td><input type="number" name='count' value="<%=dto.getGoods_count() %>" class="basket_num" />&nbsp;<a onclick="edit()" style="border: 0"><img src="../images/market/m_btn.gif" /></a></td>
							<td>무료배송</td>
							<td>[조건]</td><input type="hidden" name="num" value="<%=dto.getNum() %>"/>
							<td><span><fmt:formatNumber value="<%=dto.getTotal_price() %>" type="number" />원<span></td>
						</tr>
						
						<%} %>
					</tbody>
					<input type="hidden" name="location" value="basket.jsp" />
				</table>
				<p class="basket_text">[ 기본 배송 ] <span>상품구매금액</span><fmt:formatNumber value="<%=totalprice%>" type="number" /> + 
				<span>배송비</span> <%=totalprice>=50000?0:"2,500" %> = 합계 : <span class="money"><fmt:formatNumber value="<%=totalprice>=50000?totalprice:totalprice+2500%>" type="number" />원</span><br /><br />
				<button type="submit" class="btn btn-danger" style="width: 152px;height: 42px;font-weight: bold;">선택항목삭제</button>&nbsp;<a href="../market/list"><img src="../images/market/basket_btn01.gif" /></a>&nbsp;<a href="basket02.jsp"><img src="../images/market/basket_btn02.gif" /></a></p>
				</form>
				<script type="text/javascript">
				function edit() {
					var f = document.regifrm;
					f.action="updatebasket.jsp";
					f.submit();
				}
				</script>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
