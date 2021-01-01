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

@WebServlet("/market/write")
public class WriteCtrl extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		req.setCharacterEncoding("UTF-8");

		// request객체와 물리적경로를 매개변수로 upload()를 호출한다.
		MultipartRequest mr = FileUtil.upload(req, req.getServletContext().getRealPath("images/market"));

		int sucOrFail=0;
		if (mr != null) {
			String mileage = mr.getParameter("mileage");
			// 파일업로드가 완료되면 나머지 폼값을 받기위해 mr참조변수를 이용한다.
			String name = mr.getParameter("name");
			String content = mr.getParameter("content");
			String price = mr.getParameter("price");
			// 서버에 저장된 실제파일명을 가져온다.
			String image = mr.getFilesystemName("image");
			
			// DTO객체에 위의 폼값을 저장한다.
			ProductDTO dto = new ProductDTO();
			dto.setGoods_mileage(Integer.parseInt(mileage));
			dto.setGoods_content(content);
			dto.setGoods_price(Integer.parseInt(price));
			dto.setGoods_name(name);
			dto.setImage(image);
			// DAO객체생성 및 연결 ...insert처리
			ProductDAO dao = new ProductDAO();

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
		}

		resp.sendRedirect("../admin/productslist.jsp");
		
	}
}
