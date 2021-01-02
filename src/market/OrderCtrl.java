package market;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.BasketDAO;
import model.BasketDTO;
import model.OrderingDAO;
import model.OrderingDTO;

@WebServlet("/market/order")
public class OrderCtrl extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("utf-8");
		
		String id = req.getParameter("id");
		String order_name = req.getParameter("order_name");
		String order_info = "주소 : "+req.getParameter("order_zipcode")+" "+req.getParameter("order_addr1")+" "+req.getParameter("order_addr2")
						+"/"+"휴대폰 : "+ req.getParameter("order_tel1")+"-"+req.getParameter("order_tel2")+"-"+req.getParameter("order_tel3")
						+"/"+"이메일 : "+ req.getParameter("order_email1")+"@"+req.getParameter("order_email2");
		String delivery_name = req.getParameter("delivery_name");
		String delivery_info = "주소 : "+req.getParameter("delivery_zipcode")+" "+req.getParameter("delivery_addr1")+" "+req.getParameter("delivery_addr2")
		+"/"+"휴대폰 : "+ req.getParameter("delivery_tel1")+"-"+req.getParameter("delivery_tel2")+"-"+req.getParameter("delivery_tel3")
		+"/"+"이메일 : "+ req.getParameter("delivery_email1")+"@"+req.getParameter("delivery_email2");
		String message = req.getParameter("message");
		String totalprice = req.getParameter("totalprice");
		String payment = req.getParameter("payment");
		BasketDAO bdao = new BasketDAO();
		List<BasketDTO> list = bdao.selectAll(id);
		String basket = "";
		for(BasketDTO dto : list) {
			basket = dto.getGoods_name()+" : " + dto.getGoods_count()+"개"+" /";
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
		
		req.setAttribute("SUC", suc );
		req.getRequestDispatcher("../market/Message.jsp").forward(req, resp);
	}
}
