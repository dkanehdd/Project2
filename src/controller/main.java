package controller;

import java.io.IOException;
import java.util.List;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.BoardDAO;
import model.BoardDTO;
import model.PhotoDAO;
import model.PhotoDTO;

@WebServlet("/main/main.do")
public class main extends HttpServlet{

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		BoardDAO dao = new BoardDAO();
		PhotoDAO pdao = new PhotoDAO();
		
		List<BoardDTO> noticeLists = dao.selectList("T");//공지사항 글 가져오기
		List<BoardDTO> lists = dao.selectList("F");//자유게시판 글 가져오기
		List<PhotoDTO> plist = pdao.selectList(); 
		req.setAttribute("noticeLists", noticeLists);
		req.setAttribute("lists", lists);
		req.setAttribute("plist", plist);
		dao.close();
		pdao.close();
		req.getRequestDispatcher("../main/main.jsp").forward(req, resp);
	}
}
