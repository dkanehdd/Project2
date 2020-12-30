package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.MemberDAO;
import model.MemberDTO;

@WebServlet("/member/memberedit")
public class MemberEditCtrl extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
req.setCharacterEncoding("UTF-8");
		
		String id = req.getParameter("user_id");
		String pw = req.getParameter("user_pass")==null?req.getParameter("originalpass"):req.getParameter("user_pass");
		String name = req.getParameter("name");
		String telephone = req.getParameter("tel1")+"-"
				+ req.getParameter("tel2")+"-"
				+req.getParameter("tel3");
		String cellphone = req.getParameter("mobile1")+"-"
				+req.getParameter("mobile2")+"-"
				+req.getParameter("mobile3");
		String email = req.getParameter("email_1")
				+"@"+req.getParameter("email_2");
		String address = req.getParameter("zipcode")+"/"+req.getParameter("addr1")+"/"+ req.getParameter("addr2");
		String admin = req.getParameter("admin");
		
		MemberDTO dto = new MemberDTO();
		dto.setId(id);
		dto.setPass(pw);
		dto.setName(name);
		dto.setTelephone(telephone);
		dto.setCellphone(cellphone);
		dto.setEmail(email);
		dto.setAdmin(admin);
		dto.setAddress(address);
		System.out.println(id+pw+name+telephone+cellphone+email+admin);
		MemberDAO dao = new MemberDAO();
		int sucOrFail = -1;
		sucOrFail = dao.editMember(dto);
		dao.close();
		req.setAttribute("SUC_FAIL", sucOrFail);
		
		resp.sendRedirect("../admin/member_table.jsp");
	}
}
