package market;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;

import model.ProductDAO;
import model.ProductDTO;
import util.FileUtil;

@WebServlet("/market/edit")
public class EditCtrl extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");
		
		//첨부파일 업로드
		MultipartRequest mr = FileUtil.upload(req, 
				req.getServletContext().getRealPath("images/market"));
		int sucOrFail = 0;
		
		//멀티파트 객체가 정상적으로 생성되면 나머지 폼값을 받아온다.
		if(mr!=null) {
			//첨부파일의 수정을 위해 hidden폼으로 작성한 기존파일명을 받는다.
			String originalfile = mr.getParameter("originalfile");
			
			//수정처리후 상세보기 페이지로 이동해야하므로 영역에 속성을 저장한다.
			String num = mr.getParameter("num");
			String name = mr.getParameter("name");
			String price = mr.getParameter("price");
			String mileage = mr.getParameter("mileage");
			String content = mr.getParameter("content");
			
			/*
			수정폼에서 첨부한 파일이 있다면 기존파일은 삭제해야하고,
			없다면 기존 파일명으로 유지해야 한다.
			 */
			String image = mr.getFilesystemName("image");
			if(image==null) {
				image = originalfile;
			}
			
			ProductDTO dto = new ProductDTO();
			dto.setGoods_content(content);
			dto.setGoods_name(name);
			dto.setNum(Integer.parseInt(num));
			dto.setGoods_price(Integer.parseInt(price));
			dto.setGoods_mileage(Integer.parseInt(mileage));
			dto.setImage(image);
			
			ProductDAO dao = new ProductDAO();
			sucOrFail = dao.updateEdit(dto);
			 
			/*
			레코드의 update가 성공이고 동시에 새로운 파일이 업로드 되었다면
			기존의 파일은 삭제처리 한다.
			첨부한 파일이 없다면 기존파일은 유지된다.
			 */
			if(sucOrFail==1 && mr.getFilesystemName("attachedfile")!=null) {
				FileUtil.deleteFile(req, "/images/upload", originalfile);
			}
			dao.close();
		}
		else {
			sucOrFail = -1;
		}
		
		//수정처리 이후에는 상세보기 페이지로 이동한다.
		resp.sendRedirect("../admin/productslist.jsp");
	}
}
