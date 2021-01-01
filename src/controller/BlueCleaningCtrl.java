package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.FormDTO;
import model.FormDAO;

@WebServlet("/market/blue")
public class BlueCleaningCtrl extends HttpServlet{
	
	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String compony = req.getParameter("compony");
		String address = req.getParameter("zipcode")+"/"+req.getParameter("addr1")+"/"+ req.getParameter("addr2");
		String telephone = req.getParameter("tel1")+"-"
				+ req.getParameter("tel2")+"-"
				+req.getParameter("tel3");
		String cellphone = req.getParameter("mobile1")+"-"
				+req.getParameter("mobile2")+"-"
				+req.getParameter("mobile3");
		String email = req.getParameter("email_1")
				+"@"+req.getParameter("email_2");
		String sort = req.getParameter("sort");
		String acre = req.getParameter("acre");
		String seleteDate = req.getParameter("year")+"-"+req.getParameter("month")+"-"+req.getParameter("day");
		String register = req.getParameter("register");
		String other = req.getParameter("other");
		
		FormDTO dto = new FormDTO();
		
		dto.setCompony(compony);
		dto.setAddress(address);
		dto.setTelephone(telephone);
		dto.setCellphone(cellphone);
		dto.setEmail(email);
		dto.setSort(sort);
		dto.setAcre(acre);
		dto.setSeleteDate(seleteDate);
		dto.setRegister(register);
		dto.setOther(other);
		
		FormDAO dao = new FormDAO();
		int affected = 0;
		affected = dao.blueinsert(dto);
		
		dao.close();
		String mailContents = ""
				+"<table border=1>"
				+"<tr>"
				+"	<td>고객명/회사명</td>"
				+"	<td>"+dto.getCompony()+"</td>"
				+"</tr>"
				+"<tr>"
				+"	<td>청소할 곳 주소</td>"
				+"	<td>"+dto.getAddress()+"</td>"
				+"</tr>"
				+"<tr>" 
				+"	<td>연락처</td>"
				+"	<td>"+dto.getTelephone()+"</td>"
				+"</tr>"
				+"<tr>" 
				+"	<td>휴대전화</td>"
				+"	<td>"+dto.getCellphone()+"</td>"
				+"</tr>"
				+"<tr>" 
				+"	<td>이메일</td>"
				+"	<td>"+dto.getEmail()+"</td>"
				+"</tr>"
				+"<tr>" 
				+"	<td>청소종류</td>"
				+"	<td>"+dto.getSort()+"</td>"
				+"</tr>"
				+"<tr>" 
				+"	<td>분양평수/등기평수</td>"
				+"	<td>"+dto.getAcre()+"</td>"
				+"</tr>"
				+"<tr>" 
				+"	<td>청소 희망날짜</td>"
				+"	<td>"+dto.getSeleteDate()+"</td>"
				+"</tr>"
				+"<tr>" 
				+"	<td>접수종류 구분</td>"
				+"	<td>"+dto.getRegister()+"</td>"
				+"</tr>"
				+"<tr>" 
				+"	<td>기타특이사항</td>"
				+"	<td>"+dto.getOther()+"</td>"
				+"</tr>"
				+"</table>";
		String message = ""; 
		if(affected==1) {
			req.setAttribute("title", "마포구립 장애인 직업재활센터 블루클리닝 견적의뢰서 입니다.");
			req.setAttribute("user_email", email);
			req.setAttribute("mailcontent", mailContents);
			req.getRequestDispatcher("../market/bluesending.jsp").forward(req, resp);
		}
		else {
			message = "신청실패";
			req.setAttribute("message", message);
			req.getRequestDispatcher("../main/main.do").forward(req, resp);
		}
		
	}
}
