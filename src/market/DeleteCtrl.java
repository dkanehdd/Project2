package market;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.ProductDAO;
import model.ProductDTO;
import util.FileUtil;

@WebServlet("/market/delete")
public class DeleteCtrl extends HttpServlet{

	@Override
	protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		String num = req.getParameter("num");
		
		
		ProductDAO dao = new ProductDAO();
		//첨부파일 삭제를 위해 기존의 게시물을 가져와서  DTO객체에 저장
		ProductDTO dto = dao.selectView(num);
		//게시물 삭제
		int sucOrFail = dao.delete(num);
		if(sucOrFail==1) {
			//게시물 삭제가 완료되었다면 첨부파일도 삭제한다.
			String fileName = dto.getImage();
			//경로명, 파일명을 전달하여 물리적경로에 저장된 파일을 삭제처리함.
			FileUtil.deleteFile(req, "/images/market", fileName);
		}
		
		resp.sendRedirect("../admin/productslist.jsp");
	}
}
