package model;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.HashMap;
import java.util.Map;

public class MemberDAO {

	Connection con;// 커넥션 객체를 멤버변수로 설정하여 공유
	PreparedStatement psmt;
	ResultSet rs;

	// 기본생성자를 통한 DB연결
	public MemberDAO() {
		String driver = "org.mariadb.jdbc.Driver";
		String url = "jdbc:mariadb://127.0.0.1:3306/suamil_db";
		try {
			Class.forName(driver);
			String id = "suamil_user";
			String pw = "1234";
			con = DriverManager.getConnection(url, id, pw);
			System.out.println("DB연결성공(디폴트생성자)");
		} catch (Exception e) {
			System.out.println("DB연결실패(디폴트생성자)");
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
		}
		catch (Exception e) {
			System.out.println("자원반납시 예외발생");
		}
	}
}
