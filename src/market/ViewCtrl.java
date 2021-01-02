package market;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.ProductDAO;
import model.ProductDTO;

@WebServlet("/market/view")
public class ViewCtrl extends HttpServlet{

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String num = req.getParameter("num");
		ProductDAO dao = new ProductDAO();

		//일련번호에 해당하는 게시물을 DTO객체로 반환함.
		ProductDTO dto = dao.selectView(num);
		//커넥션풀에 객체 반납
		dao.close();
		//request영역에 DTO객체 저장
		req.setAttribute("dto", dto);
		
		req.getRequestDispatcher("/market/market_view.jsp").forward(req, resp);
		
	}
}
