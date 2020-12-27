package controller;

import java.io.IOException;
import java.net.URLEncoder;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import model.BoardDAO;
import util.FileUtil;
@WebServlet("/Download")
public class DownloadCtrl extends HttpServlet{
	
	@Override
	protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
		
		String filename = req.getParameter("filename");
		
		/*
		방법1 : 서버에 저장된 파일명 그래도 다운로드.
			파일명을 변경할 필요가 없으므로 파일명에 관련된 파라미터는 1개만 있다.
		 */
		FileUtil.download(req, resp, "/images/upload", filename);
		
		/*
		방법2 : 서버에 저장된 파일을 다운로드 할때는 원본파일명으로
			변경하여 다운로드 한다. 이때는 저장된파일명과 원본파일명이
			각각테이블에 저장되어 있어야한다. 여기서는 파일명 변경에
			대해서만 확인해본다.
		FileUtil.download(request객체, response객체, 디렉토리명, 
		서버에저장된파일명, 원본파일명);
		파일명이 한글인 경우에는 반드시 인코딩 처리를 해줘야한다.
		 */
//		FileUtil.download(req, resp, "/Upload", filename,"원본파일.jpg"); 
	}
}
