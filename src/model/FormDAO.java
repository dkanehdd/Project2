package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class FormDAO {
	Connection con;
	PreparedStatement psmt;
	ResultSet rs;
	public FormDAO() {
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
	
	public int blueinsert(FormDTO dto) {
		int affected = 0;
		try {
			String sql = "INSERT into request_form ("
					+ "compony,address,telephone,cellphone,"
					+ " email,sort,acre,seleteDate,register,other,flag)"
					+ "values(?,?,?,?,?,?,?,?,?,?,'bluecleaning')";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getCompony());
			psmt.setString(2, dto.getAddress());
			psmt.setString(3, dto.getTelephone());
			psmt.setString(4, dto.getCellphone());
			psmt.setString(5, dto.getEmail());
			psmt.setString(6, dto.getSort());
			psmt.setString(7, dto.getAcre());
			psmt.setString(8, dto.getSeleteDate());
			psmt.setString(9, dto.getRegister());
			psmt.setString(10, dto.getOther());
			affected = psmt.executeUpdate();
		}
		catch (Exception e) {
			System.out.println("블루클리닝 입력시예외");
			e.printStackTrace();
		}
		return affected;
	}
	public int exinsert(FormDTO dto) {
		int affected = 0;
		try {
			String sql = "INSERT into request_form ("
					+ "compony,handicap,telephone,cellphone,"
					+ " email,assistingdevices,experience,seleteDate,register,other,flag)"
					+ "values(?,?,?,?,?,?,?,?,?,?,'experience')";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getCompony());
			psmt.setString(2, dto.getHandicap());
			psmt.setString(3, dto.getTelephone());
			psmt.setString(4, dto.getCellphone());
			psmt.setString(5, dto.getEmail());
			psmt.setString(6, dto.getAssistingdevices());
			psmt.setString(7, dto.getExperience());
			psmt.setString(8, dto.getSeleteDate());
			psmt.setString(9, dto.getRegister());
			psmt.setString(10, dto.getOther());
			affected = psmt.executeUpdate();
		}
		catch (Exception e) {
			System.out.println("블루클리닝 입력시예외");
			e.printStackTrace();
		}
		return affected;
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
	public List<FormDTO> selectAll(Map<String, Object> map) {
		List<FormDTO> bbs = new Vector<FormDTO>();

		// 쿼리문이 아래와같이 페이지처리 쿼리문으로 변경됨.
		String query = "" + " SELECT * from request_form where flag=?";
		System.out.println(query);
		try {
			psmt = con.prepareStatement(query);

			psmt.setString(1, map.get("flag").toString());
			rs = psmt.executeQuery();

			while (rs.next()) {
				FormDTO dto = new FormDTO();
				// setter()를 통해 각각의 컬럼에 데이터 저장
				dto.setNum(rs.getString("num"));
				dto.setCompony(rs.getString("compony"));
				dto.setAddress(rs.getString("address"));
				dto.setSort(rs.getString("sort"));
				dto.setAcre(rs.getString("acre"));
				dto.setTelephone(rs.getString("telephone"));
				dto.setCellphone(rs.getString("cellphone"));
				// member테이블과 JOIN으로 이름이 추가됨
				dto.setEmail(rs.getString("email"));
				dto.setHandicap(rs.getString("handicap"));
				dto.setAssistingdevices(rs.getString("assistingdevices"));
				dto.setExperience(rs.getString("experience"));
				dto.setSeleteDate(rs.getString("seletedate"));
				dto.setPostdate(rs.getString("postdate"));
				dto.setRegister(rs.getString("register"));
				dto.setOther(rs.getString("other"));
				dto.setFlag(rs.getString("flag"));
				bbs.add(dto);
			}
		} catch (Exception e) {
			System.out.println("Select시 예외발생");
			e.printStackTrace();
		}
		return bbs;
	}
	
	public FormDTO selectView(String num) {
		FormDTO dto = new FormDTO();
		// 쿼리문이 아래와같이 페이지처리 쿼리문으로 변경됨.
		String query = "" + " SELECT * from request_form where num=?";
		System.out.println(query);
		try {
			psmt = con.prepareStatement(query);

			psmt.setString(1, num);
			rs = psmt.executeQuery();

			rs.next();
				
			// settera()를 통해 각각의 컬럼에 데이터 저장
			dto.setNum(rs.getString("num"));
			dto.setCompony(rs.getString("compony"));
			dto.setAddress(rs.getString("address"));
			dto.setSort(rs.getString("sort"));
			dto.setAcre(rs.getString("acre"));
			dto.setTelephone(rs.getString("telephone"));
			dto.setCellphone(rs.getString("cellphone"));
			// member테이블과 JOIN으로 이름이 추가됨
			dto.setEmail(rs.getString("email"));
			dto.setHandicap(rs.getString("handicap"));
			dto.setAssistingdevices(rs.getString("assistingdevices"));
			dto.setExperience(rs.getString("experience"));
			dto.setSeleteDate(rs.getString("seletedate"));
			dto.setPostdate(rs.getString("postdate"));
			dto.setRegister(rs.getString("register"));
			dto.setOther(rs.getString("other"));
			dto.setFlag(rs.getString("flag"));
			
		} catch (Exception e) {
			System.out.println("Select시 예외발생");
			e.printStackTrace();
		}
		return dto;
	}
}
