package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import com.oreilly.servlet.MultipartRequest;

import model.BoardDAO;
import model.BoardDTO;
import model.MemberDAO;
import model.MemberDTO;
import util.FileUtil;

@WebServlet("/community/write")
public class writeCtrl extends HttpServlet {

	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		int nowPage = (req.getParameter("nowPage") == null || req.getParameter("nowPage").equals("")) ? 1
				: Integer.parseInt(req.getParameter("nowPage"));

		HttpSession session = req.getSession(false);
		String id = session.getAttribute("USER_ID").toString();
		String flag = req.getParameter("flag");
		MemberDAO dao = new MemberDAO();
		MemberDTO dto = dao.getMemberDTO(id);
		dao.close();
		req.setAttribute("dto", dto);
		req.setAttribute("flag", flag);
		if(flag.equals("notice")) {
			req.getRequestDispatcher("../community/sub01_write.jsp").forward(req, resp);
		}
		else {
			req.getRequestDispatcher("../community/sub02_write.jsp").forward(req, resp);
		}
	}

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");

		// request객체와 물리적경로를 매개변수로 upload()를 호출한다.
		MultipartRequest mr = FileUtil.upload(req, req.getServletContext().getRealPath("images/upload"));

		int sucOrFail;
		String flag = mr.getParameter("flag");
		if (mr != null) {
			// 파일업로드가 완료되면 나머지 폼값을 받기위해 mr참조변수를 이용한다.
			String id = mr.getParameter("id");
			String title = mr.getParameter("title");
			String content = mr.getParameter("content");
			// 서버에 저장된 실제파일명을 가져온다.
			String attachedfile = mr.getFilesystemName("attachedfile");
			
			// DTO객체에 위의 폼값을 저장한다.
			BoardDTO dto = new BoardDTO();
			dto.setAttachedfile(attachedfile);
			dto.setContent(content);
			dto.setTitle(title);
			dto.setId(id);
			dto.setFlag(flag);
			// DAO객체생성 및 연결 ...insert처리
			BoardDAO dao = new BoardDAO();

			// 파일업로드 성공 및 insert성공시
			sucOrFail = dao.insertWrite(dto);
			/*
			 * 페이지처리를 위한 100개 데이터입력
			 */
//			sucOrFail =1;
//			for(int i=1 ; i<=100 ; i++) {
//				dto.setTitle("자료실"+i+"번째 포스팅");
//				dao.insert(dto);
//			}

			dao.close();
		} else {
			// mr객체가 생성되지 않은경우, 즉 파일업로드 실패시...
			sucOrFail = -1;
		}

		if (sucOrFail == 1) {
			// 글쓰기 성공시 리스트로 이동
			resp.sendRedirect("../community/sub.do?flag="+flag);
		} else {
			// 실패시 글쓰기 페이지로 이동
			resp.sendRedirect("../community/write?flag="+flag);
		}
	}
}
