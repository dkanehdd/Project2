package market;

import java.io.IOException;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.ServletContext;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.BoardDTO;
import model.ProductDAO;
import model.ProductDTO;
import util.PagingUtil;

@WebServlet("/market/list")
public class ListCtrl extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		ProductDAO dao = new ProductDAO();
		Map<String, Object> param = new HashMap<String, Object>();
		
		int totalRecordCount = dao.getTotalRecordCount();// join O
		param.put("totalCount", totalRecordCount);
		/*********** 페이지처리를 위한 코드 추가 start ************/ 
		//한페이지에 출력할 레코드의 갯수 : 10
		ServletContext application = this.getServletContext();
		int pageSize = Integer.parseInt(application.getInitParameter("PAGE_SIZE"));
		//한 블럭당 출력할 페이지의 갯수 : 5
		int blockPage = Integer.parseInt(application.getInitParameter("BLOCK_PAGE"));

		int totalPage = (int)Math.ceil((double)totalRecordCount/pageSize);
		//System.out.println(totalPage);

		int nowPage = (req.getParameter("nowPage")==null ||
			req.getParameter("nowPage").equals("")) ?
					1 : Integer.parseInt(req.getParameter("nowPage"));

		//한페이지에 출력할 게시물의 범위를 결정한다. MariaDB에서는 limit를 사용하므로
		//계산식이 조금 달라지게 된다.
		int start = (nowPage-1)*pageSize;
		int end = pageSize;
		//게시물의 범위를 Map컬렉션에 저장하고 DAO로 전달한다.
		
		param.put("start", start);
		param.put("end", end);
		param.put("totalPage", totalPage);
		param.put("nowPage", nowPage);
		param.put("totalRecordCount", totalRecordCount);
		param.put("pageSize", pageSize);
		String pagingBS4 = PagingUtil.pagingBS4(totalRecordCount, 
				pageSize, blockPage, nowPage, 
				"../merket/list?nowPage="+nowPage);
		param.put("pagingBS4", pagingBS4);
		
		List<ProductDTO> lists = dao.selectAll(param); 
		//DB자원해제
		dao.close();
		
		//데이터를 request영역에 저장한다.
		req.setAttribute("lists", lists);
		req.setAttribute("map", param);
		
		
		req.getRequestDispatcher("/market/sub01.jsp").forward(req, resp);
		
	}
}
