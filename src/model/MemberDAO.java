package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class MemberDAO {

	Connection con;// 커넥션 객체를 멤버변수로 설정하여 공유
	PreparedStatement psmt;
	ResultSet rs;

	// 기본생성자를 통한 DB연결
	public MemberDAO() {
		try {
			Context initctx = new InitialContext();
			Context ctx = (Context)initctx.lookup("java:comp/env");
			DataSource source = (DataSource)ctx.lookup("jdbc_mariadb");
			con = source.getConnection();
			System.out.println("DBCP 연결성공");
		}
		catch (Exception e) {
			System.out.println("DBCP 연결실패");
			e.printStackTrace();
		}
	}

	// 로그인방법3 : DTO객체 대신 Map컬렉션에 회원정보를 저장후 반환한다.
	public Map<String, String> getMemberMap(String id, String pwd) {

		// 회원정보를 저장할 Map컬렉션 생성
		Map<String, String> maps = new HashMap<String, String>();

		String query = "SELECT id, pass, name FROM membership" + " where id=? and pass=?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, id);
			psmt.setString(2, pwd);
			rs = psmt.executeQuery();

			// 회원정보가 있다면 put()을 통해 정보를 저장한다.
			if (rs.next()) {
				maps.put("id", rs.getString("id"));
				maps.put("pass", rs.getString("pass"));
				maps.put("name", rs.getString("name"));
				System.out.println("결과");
			} else {
				System.out.println("결과셋이 없습니다.");
			}

		} catch (Exception e) {
			System.out.println("getMemberMap오류");
			e.printStackTrace();
		}
		return maps;
	}
	
	public MemberDTO getMemberDTO(String id) {

		// 회원정보를 저장할 Map컬렉션 생성
		MemberDTO dto = new MemberDTO();

		String query = "SELECT * FROM membership" + " where id=?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, id);
			rs = psmt.executeQuery();

			// 회원정보가 있다면 put()을 통해 정보를 저장한다.
			if (rs.next()) {
				dto.setId(rs.getString("id"));
				dto.setName(rs.getString("name"));
				dto.setPass(rs.getString("pass"));
				dto.setEmail(rs.getString("email"));
				dto.setTelephone(rs.getString("telephone"));
				dto.setCellphone(rs.getString("cellphone"));
				dto.setAdmin(rs.getString("admin"));
				dto.setAddress(rs.getString("address"));
			} else {
				System.out.println("결과셋이 없습니다.");
			}

		} catch (Exception e) {
			System.out.println("getMemberMap오류");
			e.printStackTrace();
		}
		return dto;
	}
	
	public boolean isMember(String id, String pass) {

		// 쿼리문 작성
		String sql = "SELECT COUNT(*) FROM membership WHERE id=?" + "	AND pass=?";
		int isMember = 0;
		boolean isFlag = false;

		try {
			// prepare객체를 통해 쿼리문을 전송한다.
			// 생성자에서 연결정보를 저장한 커넥션 객체를 사용함.
			psmt = con.prepareStatement(sql);
			// 쿼리문의 인파라미터 설정(DB의 인덱스는 1부터시작)
			psmt.setString(1, id);
			psmt.setString(2, pass);
			// 쿼리문 실행후 결과는 ResultSet객체를 통해 반환받음
			rs = psmt.executeQuery();
			// 실행결과를 가져오기 위해 next()를 호출한다.
			rs.next();
			// select절의 첫번째 결과값을 얻어오기위해 getInt()사용함.
			isMember = rs.getInt(1);
			System.out.println("affected:" + isMember);
			if (isMember == 0)// 회원이 아닌경우
				isFlag = false;
			else // 회원인 경우(해당 아이디, 패스워드가 일치함)
				isFlag = true;
		} catch (Exception e) {
			// 예외가 발생한다면 확인이 불가능하므로 무조건 false를 반환한다.
			isFlag = false;
			e.printStackTrace();
		}
		return isFlag;
	}

	public int insert(MemberDTO dto) {

		int affected = 0;
		try {
			String sql = "INSERT INTO membership ( id, pass,NAME,open_email,email,telephone,cellphone,address,admin) "
					+ " VALUES ("
					+ " ?,?,?,?,?,?,?,?,?)";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getPass());
			psmt.setString(3, dto.getName());
			psmt.setString(4, dto.getOpen_email());
			psmt.setString(5, dto.getEmail());
			psmt.setString(6, dto.getTelephone());
			psmt.setString(7, dto.getCellphone());
			psmt.setString(8, dto.getAddress());
			psmt.setString(9, dto.getAdmin());

			affected = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return affected;
	}
	
	public boolean overlapId(String id) {
		boolean isFlag = false;
		
		String sql = "SELECT COUNT(*) FROM membership WHERE id=?";
		int isMember = 0;
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, id);
			rs = psmt.executeQuery();
			rs.next();
			isMember = rs.getInt(1);
//			System.out.println("affected:" + isMember);
			if (isMember == 0)//중복된 아이디가 없는경우
				isFlag = true;
			else //중복된 아이디가 있는경우
				isFlag = false;
		} catch (Exception e) {
			// 예외가 발생한다면 확인이 불가능하므로 무조건 false를 반환한다.
			isFlag = false;
			e.printStackTrace();
		}
		
		return isFlag;
	}
	
	public void close() {
		try {
			//사용된 자원이 있다면 자원해제 해준다.
			if(rs!=null) rs.close();
			if(psmt!=null) psmt.close();
			if(con!=null) con.close();
			System.out.println("자원반납");
		}
		catch (Exception e) {
			System.out.println("자원반납시 예외발생");
		}
	}
	
	public String findID(String name, String email) {
		String id = "";
		try {
			String sql = "SELECT id FROM membership WHERE NAME=? AND email=?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, name);
			psmt.setString(2, email);
			
			rs = psmt.executeQuery();
			if(rs.next()) {
				id = rs.getString(1);
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return id;
	}
	
	public String findPW(String name, String email, String id) {
		String pass ="";
		try {
			String sql = "SELECT pass FROM membership WHERE NAME=? AND email=? AND id=?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, name);
			psmt.setString(2, email);
			psmt.setString(3, id);
			
			rs = psmt.executeQuery();
			if(rs.next()) {
				pass = rs.getString(1);
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return pass;
	}
	
	public String adminCheck(String id) {
		String admin = "";
		try {
			String sql = "SELECT admin FROM membership WHERE id=?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, id);
			rs = psmt.executeQuery();
			rs.next();
			admin = rs.getString(1);
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return admin;
	}
	public List<MemberDTO> selectAll(Map<String, Object> map){
		List<MemberDTO> list = new Vector<MemberDTO>();
		try {
			String sql = "SELECT * FROM membership ";
			if (map.get("Word") != null) {
				sql += " where " + map.get("Column") + " LIKE '%" + map.get("Word") + "%'";
			}
			sql += "ORDER BY regidate desc";
			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery();
			System.out.println(sql);
			while(rs.next()) {
				MemberDTO dto = new MemberDTO();
				dto.setName(rs.getString("name"));
				dto.setId(rs.getString("id"));
				dto.setEmail(rs.getString("email"));
				dto.setAdmin(rs.getString("admin"));
				dto.setCellphone(rs.getString("cellphone"));
				dto.setAdmin(rs.getString("admin"));
				list.add(dto);		
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	public int editMember(MemberDTO dto) {
		int affected = 0;
		try {
			String query = "UPDATE membership SET name=?, pass=?, email=?, admin=?,"
					+ " telephone=?, cellphone=? "
					+ " WHERE id=? ";
			
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getName());
			psmt.setString(2, dto.getPass());
			psmt.setString(3, dto.getEmail());
			psmt.setString(4, dto.getAdmin());
			psmt.setString(5, dto.getTelephone());
			psmt.setString(6, dto.getCellphone());
			psmt.setString(7, dto.getId());
			
			affected = psmt.executeUpdate();
			System.out.println("수정성공"+ affected);
		}
		catch (Exception e) {
			System.out.println("수정하기중 예외발생");
			e.printStackTrace();
		}
		return affected;
	}
}
