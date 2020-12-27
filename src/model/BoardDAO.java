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

public class BoardDAO {

	Connection con;
	PreparedStatement psmt;
	ResultSet rs;

	public BoardDAO() {
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

	public List<BoardDTO> selectList(String notice) {// 메인화면용 공지사항 글 가져오기
		List<BoardDTO> lists = new Vector<BoardDTO>();
		try {

			String sql = "SELECT IF(char_LENGTH(title)>20, concat(LEFT(title,20),'...'), title) AS 'title', "
					+ "DATE_FORMAT(postdate , '%Y.%m.%d') AS pdate, num "
					+ "FROM multi_board WHERE notice=? ORDER BY num DESC LIMIT 0, 4 ";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, notice);
			rs = psmt.executeQuery();
			while (rs.next()) {
				BoardDTO dto = new BoardDTO();
				dto.setTitle(rs.getString("title"));
				dto.setPostdate(rs.getString("pdate"));
				dto.setNum(rs.getString("num"));
				lists.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return lists;
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
		} catch (Exception e) {
			System.out.println("자원반납시 예외발생");
		}
	}

	public List<BoardDTO> selectListPageSearch(Map<String, Object> map) {
		List<BoardDTO> bbs = new Vector<BoardDTO>();

		// 쿼리문이 아래와같이 페이지처리 쿼리문으로 변경됨.
		String query = "" + " SELECT IF(char_LENGTH(title)>20, concat(LEFT(title,20),'...'), title) AS title3 ,"
				+ " DATE_FORMAT(postdate , '%Y.%m.%d') AS pdate ," + "b.*, m.name FROM multi_board b "
				+ " INNER JOIN membership m " + " ON b.id=m.id  WHERE notice=?";
		if (map.get("Word") != null) {
			query += " AND " + map.get("Column") + " LIKE '%" + map.get("Word") + "%'";
		}
		query += " ORDER By ";
		if (map.get("Sort") != null) {
			query += map.get("Sort").toString();
		} else {
			query += " num ";
		}
		query += "  DESC LIMIT ?, ? ";
		System.out.println(query);
		try {
			psmt = con.prepareStatement(query);

			psmt.setInt(2, Integer.parseInt(map.get("start").toString()));
			psmt.setInt(3, Integer.parseInt(map.get("end").toString()));
			psmt.setString(1, map.get("notice").toString());
			rs = psmt.executeQuery();

			while (rs.next()) {
				BoardDTO dto = new BoardDTO();
				// setter()를 통해 각각의 컬럼에 데이터 저장
				dto.setNum(rs.getString("num"));
				dto.setTitle(rs.getString("title3"));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getString("pdate"));
				dto.setId(rs.getString("id"));
				dto.setVisitcount(rs.getInt("visitcount"));
				// member테이블과 JOIN으로 이름이 추가됨
				dto.setName(rs.getString("name"));
				// DTO객체를 List컬렉션에 추가
				bbs.add(dto);
			}
		} catch (Exception e) {
			System.out.println("Select시 예외발생");
			e.printStackTrace();
		}
		return bbs;
	}

	public int getTotalRecordCountSearch(Map<String, Object> map) {

		// 게시물의 갯수는 최초 0으로 초기화
		int totalCount = 0;
		// 기본쿼리문(전체레코드를 대상으로 함)
		String query = "SELECT COUNT(*) FROM multi_board B" + "		INNER JOIN membership M "
				+ "ON B.id=M.id  WHERE notice=?";
		// JSP페이지에서 검색어를 입력한 경우 where절이 동적으로 추가된다.
		if (map.get("Word") != null) {
			query += " AND " + map.get("Column") + " LIKE '%" + map.get("Word") + "%'";
		}
		System.out.println("query=" + query);

		try {
			// 쿼리 실행후 결과값 반환
			psmt = con.prepareStatement(query);
			psmt.setString(1, map.get("notice").toString());
			rs = psmt.executeQuery();
			rs.next();
			totalCount = rs.getInt(1);
		} catch (Exception e) {
		}

		return totalCount;
	}

	// 게시물 조회수를 증가시킴
	public void updateVisitCount(String num) {
		String query = "UPDATE multi_board SET visitcount=visitcount+1 " + " WHERE num=?";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, num);
			/*
			 * 쿼리 실행시 executeQuery() 혹은 executeUpdate() 둘다 사용가능하다. 단, 두메소드의 차이는 반환값이 다르다는
			 * 점이다. 반환값이 굳이 필요없는 경우라면 어떤것을 사용해도 무방하다.
			 */
			psmt.executeQuery();
		} catch (Exception e) {
			System.out.println("조회수 증가시 예외발생");
			e.printStackTrace();
		}
	}

	// 일련번호에 해당하는 게시물 하나를 가져온다
	public BoardDTO selectView(String num) {

		BoardDTO dto = new BoardDTO();
		String query = "SELECT" + "    num, title, content, " + "DATE_FORMAT(postdate , '%Y-%m-%d') AS pdate, "
				+ "b.id, visitcount, name ,email " + " FROM membership m INNER JOIN multi_board b "
				+ "    ON m.id=b.id " + " WHERE num=? ";
		try {
			psmt = con.prepareStatement(query);
			psmt.setString(1, num);
			rs = psmt.executeQuery();
			if (rs.next()) {
				dto.setNum(rs.getString("num"));
				dto.setTitle(rs.getString("title"));
				dto.setContent(rs.getString("content"));
				dto.setPostdate(rs.getString("pdate"));
				dto.setId(rs.getString("id"));
				dto.setVisitcount(rs.getInt("visitcount"));
				/*
				 * member 테이블과 join하여 얻어온 name을 DTO에 추가함.
				 */
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
			}
		} catch (Exception e) {
			System.out.println("상세보기시 예외발생");
			e.printStackTrace();
		}
		return dto;
	}
	
	public int insertWrite(BoardDTO dto) {
		int affected = 0;
		try {
			String sql = "INSERT INTO multi_board (title, content, id, notice) " + 
					"	VALUES (?,?,?,?)";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getTitle());
			psmt.setString(2, dto.getContent());
			psmt.setString(3, dto.getId());
			psmt.setString(4, dto.getNotice());
			/*
			쿼리문 실행시 사용하는 메소드
			 	executeQuery() : select계열의 쿼리문을 실행할때 사용한다.
			 	행에 영향을 주지않고 조회를 위해 사용된다. 반환타입은 ResultSet
			 	executeUpdate() : insert, delete, update쿼리문을 
			 	실행할때 사용한다. 행에 영향을 주게되고 반환타입은 쿼리의 영향을
			 	받은 행이 갯수가 반환되므로 int형이 된다.
			*/
			affected = psmt.executeUpdate();
		}
		catch (Exception e) {
			System.out.println("insert중 예외발생");
			e.printStackTrace();
		}
		return affected;
	}
}
