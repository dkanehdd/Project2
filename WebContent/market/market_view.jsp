<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="../include/global_head.jsp" %>
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
				<div class="market_view_box">
					<div class="market_left">
						<img src="../images/market/${dto.image }" style="width: 500px; height: 300px"/>
						<p class="plus_btn"><a href=""><img src="../images/market/plus_btn.gif" /></a></p>
					</div>
					<div class="market_right">
						<p class="m_title">${dto.goods_name }
						<p>${dto.goods_name }</p>
						
						<form action="addbasket.jsp" method="get">
						<input type="hidden" name="num" value="${dto.num }"/>
						<ul class="m_list">
							<li>
								<dl>
									<dt>가격</dt>
									<dd class="p_style"><fmt:formatNumber value="${dto.goods_price }" type="number" /></dd>
								</dl>
								<dl>
									<dt>적립금</dt>
									<dd>${dto.goods_mileage }</dd>
								</dl>
								<dl>
									<dt>수량</dt>
									<dd><input type="number" name="count" value="1" class="n_box" /></dd>
								</dl>
								<dl style="border-bottom:0px;">
									<dt>주문정보</dt>
									<dd><input type="text" name="" class="n_box" style="width:200px;" /></dd>
								</dl>
								<div style="clear:both;"></div>
							</li>
						</ul>
						<p class="btn_box"><a href="addbasket2.jsp?num=${dto.num }&location=basket02.jsp"><img src="../images/market/m_btn01.gif" alt="바로구매" /></a>&nbsp;&nbsp;<button type="submit" style="border: 0;"><img src="../images/market/m_btn02.gif" alt="장바구니" /></button>
						</p>
						<p>${dto.goods_content }</p>
						</form>
						
						<button class="btn btn-success" onclick="location.href='../market/list'">상품목록</button>
						<button class="btn btn-danger" onclick="location.href='basket.jsp'">장바구니 바로가기</button>
						
					</div>
				</div>
			</div>
		</div>
		<%@ include file="../include/quick.jsp" %>
	</div>
	

	<%@ include file="../include/footer.jsp" %>
	</center>
 </body>
</html>
