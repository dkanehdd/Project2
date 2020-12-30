package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.BoardDAO;
import model.BoardDTO;

@WebServlet("/community/view")
public class viewCtrl extends HttpServlet{

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String num = req.getParameter("num");
		BoardDAO dao = new BoardDAO();
		//조회수를 업데이트하여 visitcount컬럼을 1증가시킴
		dao.updateVisitCount(num); 

		//일련번호에 해당하는 게시물을 DTO객체로 반환함.
		BoardDTO dto = dao.selectView(num);
		dto.setContent(dto.getContent().replaceAll("\r\n", "<br/>"));
		//커넥션풀에 객체 반납
		dao.close();
		//request영역에 DTO객체 저장
		req.setAttribute("dto", dto);
		dao.close();
		if(dto.getFlag().equals("parents")) {
			req.getRequestDispatcher("/community/sub02_view.jsp").forward(req, resp);
		}
		else {
			req.getRequestDispatcher("/community/sub01_view.jsp").forward(req, resp);
		}
	}
}
