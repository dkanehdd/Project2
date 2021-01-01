package calendar;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.CalenderDAO;
import model.CalenderDTO;

@WebServlet("/calendar/write")
public class CalenderWriteCtrl extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		
		CalenderDTO dto = new CalenderDTO();
		String id = req.getParameter("user_id");
		String title = req.getParameter("title");
		String contents = req.getParameter("contents");
		String year = req.getParameter("year");
		String month = req.getParameter("month");
		String day = req.getParameter("day");
		
		dto.setId(id);
		dto.setTitle(title);
		dto.setContents(contents);
		dto.setC_year(year);
		dto.setC_month(month);
		dto.setC_day(day);
		
		CalenderDAO dao = new CalenderDAO();
		
		int affected = dao.insertCal(dto);
		
		resp.sendRedirect("../admin/calendarmemo.jsp");
	}
}
