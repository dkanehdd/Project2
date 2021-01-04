package controller;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.FormDAO;
import model.FormDTO;
@WebServlet("/market/experience")
public class ExperienceCtrl extends HttpServlet{

	@Override
	protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		req.setCharacterEncoding("UTF-8");
		String compony = req.getParameter("compony");
		String handicap = req.getParameter("handicap1")+":"+req.getParameter("handicap2");
		String assistingdevices = req.getParameter("assistingdevices1")+":"+req.getParameter("assistingdevices2");
		String telephone = req.getParameter("tel1")+"-"
				+ req.getParameter("tel2")+"-"
				+req.getParameter("tel3");
		String cellphone = req.getParameter("mobile1")+"-"
				+req.getParameter("mobile2")+"-"
				+req.getParameter("mobile3");
		String email = req.getParameter("email_1")
				+"@"+req.getParameter("email_2");
		String experience1 = "케잌체험 : "+req.getParameter("experience1");
		String experience2 = "쿠키체험 : "+req.getParameter("experience2");
		String seleteDate = req.getParameter("year")+"-"+req.getParameter("month")+"-"+req.getParameter("day");
		String register = req.getParameter("register");
		String other = req.getParameter("other");
		
		FormDTO dto = new FormDTO();
		
		dto.setCompony(compony);
		dto.setHandicap(handicap);
		dto.setTelephone(telephone);
		dto.setCellphone(cellphone);
		dto.setEmail(email);
		dto.setExperience(experience1+experience2);
		dto.setAssistingdevices(assistingdevices);;
		dto.setSeleteDate(seleteDate);
		dto.setRegister(register);
		dto.setOther(other);
		
		FormDAO dao = new FormDAO();
		int affected = 0;
		affected = dao.exinsert(dto);
		
		dao.close();
		String mailContents = ""
				+"<table border=1 style='border: 1px solid black; padding: 5px;'>"
				+"<tr>"
				+"	<td>고객명/회사명</td>"
				+"	<td>"+dto.getCompony()+"</td>"
				+"</tr>"
				+"<tr>"
				+"	<td>장애유무</td>"
				+"	<td>"+dto.getHandicap()+"</td>"
				+"</tr>"
				+"<tr>" 
				+"	<td>보장구 사용유무</td>"
				+"	<td>"+dto.getAssistingdevices()+"</td>"
				+"</tr>"
				+"<tr>" 
				+"	<td>연락처</td>"
				+"	<td>"+dto.getTelephone()+"</td>"
				+"</tr>"
				+"<tr>" 
				+"	<td>담당자휴대전화</td>"
				+"	<td>"+dto.getCellphone()+"</td>"
				+"</tr>"
				+"<tr>" 
				+"	<td>이메일</td>"
				+"	<td>"+dto.getEmail()+"</td>"
				+"</tr>"
				+"<tr>" 
				+"	<td>체험내용</td>"
				+"	<td>"+dto.getExperience()+"</td>"
				+"</tr>"
				+"<tr>" 
				+"	<td>체험 희망날짜</td>"
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
			req.setAttribute("title", "마포구립 장애인 직업재활센터 체험학습신청 의뢰서 입니다.");
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
