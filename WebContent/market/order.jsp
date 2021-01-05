<%@page import="model.OrderingDAO"%>
<%@page import="model.OrderingDTO"%>
<%@page import="model.BasketDTO"%>
<%@page import="java.util.List"%>
<%@page import="model.BasketDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
request.setCharacterEncoding("utf-8");

String id = request.getParameter("id");
String order_name = request.getParameter("order_name");
String order_info = "주소 : "+request.getParameter("order_zipcode")+" "+request.getParameter("order_addr1")+" "+request.getParameter("order_addr2")
				+"/"+"휴대폰 : "+ request.getParameter("order_tel1")+"-"+request.getParameter("order_tel2")+"-"+request.getParameter("order_tel3")
				+"/"+"이메일 : "+ request.getParameter("order_email1")+"@"+request.getParameter("order_email2");
String delivery_name = request.getParameter("delivery_name");
String delivery_info = "주소 : "+request.getParameter("delivery_zipcode")+" "+request.getParameter("delivery_addr1")+" "+request.getParameter("delivery_addr2")
+"/"+"휴대폰 : "+ request.getParameter("delivery_tel1")+"-"+request.getParameter("delivery_tel2")+"-"+request.getParameter("delivery_tel3")
+"/"+"이메일 : "+ request.getParameter("delivery_email1")+"@"+request.getParameter("delivery_email2");
String message = request.getParameter("message");
String totalprice = request.getParameter("totalprice");
String payment = request.getParameter("payment");
BasketDAO bdao = new BasketDAO();
List<BasketDTO> list = bdao.selectAll(id);
String basket = "";
for(BasketDTO dto : list) {
	basket += dto.getGoods_name()+" : " + dto.getGoods_count()+"개"+" /";
}

OrderingDTO odto = new OrderingDTO();
odto.setId(id);
odto.setOrder_name(order_name);
odto.setOrder_info(order_info);
odto.setDelivery_name(delivery_name);
odto.setDelivery_info(delivery_info);
odto.setMessage(message);
odto.setBasket(basket);
odto.setPayment(payment);
odto.setTotal_price(Integer.parseInt(totalprice));

OrderingDAO odao = new OrderingDAO();
int suc = odao.insertOrder(odto);

bdao.deleteall(id);

odao.close();
bdao.close();

String email = request.getParameter("order_email1")+"@"+request.getParameter("order_email2");
String phone = request.getParameter("order_tel1")+"-"+request.getParameter("order_tel2")+"-"+request.getParameter("order_tel3");
String address = request.getParameter("order_zipcode")+" "+request.getParameter("order_addr1")+" "+request.getParameter("order_addr2");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript" src="https://code.jquery.com/jquery-1.12.4.min.js" ></script>
<script type="text/javascript" src="https://cdn.iamport.kr/js/iamport.payment-1.1.5.js"></script>
</head>
<body>
    <script>
    $(function(){
        var IMP = window.IMP; // 생략가능
        IMP.init('imp61347257'); // 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
        var msg;
        
        IMP.request_pay({
            pg : 'kakaopay',
            pay_method : 'card',
            merchant_uid : 'merchant_' + new Date().getTime(),
            name : '테스트',
            amount : <%=Integer.parseInt(totalprice)%>,
            buyer_email : '<%=email%>',
            buyer_name : '<%=order_name%>',
            buyer_tel : '<%=phone%>',
            buyer_addr : '<%=address%>',
            buyer_postcode : '123-456',
            //m_redirect_url : 'http://www.naver.com'
        }, function(rsp) {
            if ( rsp.success ) {
                //[1] 서버단에서 결제정보 조회를 위해 jQuery ajax로 imp_uid 전달하기
                jQuery.ajax({
                    url: "/payments/complete", //cross-domain error가 발생하지 않도록 주의해주세요
                    type: 'POST',
                    dataType: 'json',
                    data: {
                        imp_uid : rsp.imp_uid
                        //기타 필요한 데이터가 있으면 추가 전달
                    }
                }).done(function(data) {
                    //[2] 서버에서 REST API로 결제정보확인 및 서비스루틴이 정상적인 경우
                    if ( everythings_fine ) {
                        msg = '결제가 완료되었습니다.';
                        msg += '\n고유ID : ' + rsp.imp_uid;
                        msg += '\n상점 거래ID : ' + rsp.merchant_uid;
                        msg += '\결제 금액 : ' + rsp.paid_amount;
                        msg += '카드 승인번호 : ' + rsp.apply_num;
                        
                        alert(msg);
                    } else {
                        //[3] 아직 제대로 결제가 되지 않았습니다.
                        //[4] 결제된 금액이 요청한 금액과 달라 결제를 자동취소처리하였습니다.
                    }
                });
                //성공시 이동할 페이지
                location.href='<%=request.getContextPath()%>/market/Message.jsp?SUC=1';
            } else {
                msg = '결제에 실패하였습니다.';
                msg += '에러내용 : ' + rsp.error_msg;
                //실패시 이동할 페이지
                location.href="<%=request.getContextPath()%>/order/payFail";
                alert(msg);
            }
        });
        
    });
    </script>
 
</body>
</html>
