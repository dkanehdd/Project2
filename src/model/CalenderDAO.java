package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class CalenderDAO {
	Connection con;
	PreparedStatement psmt;
	ResultSet rs;
	public CalenderDAO() { 
		try {
			Context initctx = new InitialContext();
			Context ctx = (Context) initctx.lookup("java:comp/env");
			DataSource source = (DataSource) ctx.lookup("jdbc_mariadb");
			con = source.getConnection();
			System.out.println("DBCP 연결성공");
		} catch (Exception e) {
			System.out.println("DBCP 연결실패");
			e.printStackTrace();
		}
	}
	
	public List<CalenderDTO> selectCalender(String year, String month) {
		List<CalenderDTO> list = new Vector<CalenderDTO>();
		try {
			String sql = "SELECT * from CALENDARMEMO where c_YEAR=? and c_MONth=?";
			
			psmt = con.prepareStatement(sql);
			psmt.setString(1, year);
			psmt.setString(2, month);
			
			rs = psmt.executeQuery();
			while(rs.next()) {
				CalenderDTO dto = new CalenderDTO();
				dto.setTitle(rs.getString("title"));
				dto.setContents(rs.getString("contents"));
				dto.setC_day(rs.getString("c_day"));
				dto.setNum(rs.getString("num"));
				list.add(dto);
			}
		}
		catch (Exception e) {
			e.printStackTrace();
			System.out.println("예외발생");
		}
		return list;
	}
	
	public void close() {
		try {
			// 사용된 자원이 있다면 자원해제 해준다.
			if (rs != null)
				rs.close();
			if (psmt != null)
				psmt.close();
			if (con != null)
				con.close();
			System.out.println("자원반납");
		} catch (Exception e) {
			System.out.println("자원반납시 예외발생");
		}
	}
	
	public CalenderDTO selectView(String num) {

		CalenderDTO dto = new CalenderDTO();
		String query = "SELECT CONCAT(c_year,'-', c_month,'-', c_day) pdate, title, contents, b.id, name,num "
				+ "FROM calendarmemo b " + 
				"				INNER JOIN membership m " + 
				"				ON b.id=m.id"
				+ " WHERE num=?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, num);
			rs = psmt.executeQuery();
			if (rs.next()) {
				dto.setNum(rs.getString("num"));
				dto.setTitle(rs.getString("title"));
				dto.setContents(rs.getString("contents"));
				dto.setPdate(rs.getString("pdate"));
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
			}
		} catch (Exception e) {
			System.out.println("상세보기시 예외발생");
			e.printStackTrace();
		}
		return dto;
	}
	
	public int insertCal(CalenderDTO dto) {
		int affected = 0;
		try {
			String sql = "INSERT INTO calendarmemo (title, contents, c_year, c_month, c_day, id)" + 
					"VALUES(?, ?,?,?,?,?);";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContents());
			psmt.setString(3, dto.getC_year());
			psmt.setString(4, dto.getC_month());
			psmt.setString(5, dto.getC_day());
			psmt.setString(6, dto.getId());
			
			affected = psmt.executeUpdate();
			System.out.println("입력성공");
		}
		catch (Exception e) {
			System.out.println("일정 입력중 예외");
			e.printStackTrace();
		}
		return affected;
	}
}
