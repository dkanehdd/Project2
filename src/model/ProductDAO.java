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

public class ProductDAO {

	
	Connection con;
	PreparedStatement psmt;
	ResultSet rs;

	public ProductDAO() {
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
	public List<ProductDTO> selectAll(){
		List<ProductDTO> list = new Vector<ProductDTO>();
		try {
			String sql = "SELECT * FROM shop_products ";
			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next()) {
				ProductDTO dto  = new ProductDTO();
				dto.setNum(rs.getInt("num"));
				dto.setImage(rs.getString("image"));
				dto.setGoods_name(rs.getString("goods_name"));
				dto.setGoods_price(rs.getInt("goods_price"));
				dto.setGoods_mileage(rs.getInt("goods_mileage"));
				dto.setGoods_content(rs.getString("goods_content"));
				
				list.add(dto);
			}
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	public List<ProductDTO> selectAll(Map<String, Object> map){
		List<ProductDTO> list = new Vector<ProductDTO>();
		try {
			String sql = "SELECT * FROM shop_products ";
			sql += " LIMIT ?, ? ";
			psmt = con.prepareStatement(sql);
			psmt.setInt(1, Integer.parseInt(map.get("start").toString()));
			psmt.setInt(2, Integer.parseInt(map.get("end").toString()));
			rs = psmt.executeQuery();
			while(rs.next()) {
				ProductDTO dto  = new ProductDTO();
				dto.setNum(rs.getInt("num"));
				dto.setImage(rs.getString("image"));
				dto.setGoods_name(rs.getString("goods_name"));
				dto.setGoods_price(rs.getInt("goods_price"));
				dto.setGoods_mileage(rs.getInt("goods_mileage"));
				dto.setGoods_content(rs.getString("goods_content"));
				
				list.add(dto);
			}
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public int getTotalRecordCount() {

		// 게시물의 갯수는 최초 0으로 초기화
		int totalCount = 0;
		// 기본쿼리문(전체레코드를 대상으로 함)
		String query = "SELECT COUNT(*) FROM shop_product ";
		// JSP페이지에서 검색어를 입력한 경우 where절이 동적으로 추가된다.
		System.out.println("query=" + query);

		try {
			// 쿼리 실행후 결과값 반환
			psmt = con.prepareStatement(query);
			rs = psmt.executeQuery();
			rs.next();
			totalCount = rs.getInt(1);
		} catch (Exception e) {
		}

		return totalCount;
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
	
	public int insertWrite(ProductDTO dto) {
		int affected = 0;
		try {
			String sql = "INSERT INTO shop_products (image, goods_name, goods_price,goods_mileage,goods_content) " + 
					"	VALUES (?,?,?,?,?)";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getImage());
			psmt.setString(2, dto.getGoods_name());
			psmt.setInt(3, dto.getGoods_price());
			psmt.setInt(4, dto.getGoods_mileage());
			psmt.setString(5, dto.getGoods_content());
			
			affected = psmt.executeUpdate();
		}
		catch (Exception e) {
			System.out.println("insert중 예외발생");
			e.printStackTrace();
		}
		return affected;
	}
	
	public ProductDTO selectView(String num) {

		ProductDTO dto = new ProductDTO();
		String sql = "SELECT * FROM shop_products where num=?";
		try {
			psmt = con.prepareStatement(sql);
			psmt.setString(1, num);
			rs = psmt.executeQuery();
			if (rs.next()) {
				dto.setNum(rs.getInt("num"));
				dto.setGoods_content(rs.getString("goods_content"));
				dto.setGoods_price(rs.getInt("goods_price"));
				dto.setGoods_mileage(rs.getInt("goods_mileage"));
				dto.setGoods_name(rs.getString("goods_name"));
				dto.setImage(rs.getString("image"));
			}
		} catch (Exception e) {
			System.out.println("상세보기시 예외발생");
			e.printStackTrace();
		}
		return dto;
	}
	
	public int updateEdit(ProductDTO dto) {
		int affected = 0;
		try {
			String query = "UPDATE shop_products SET image=?, goods_name=?, goods_price=?, goods_mileage=?, goods_content=? "
					+ " WHERE num=? ";
			
			psmt = con.prepareStatement(query);
			psmt.setString(1, dto.getImage());
			psmt.setString(2, dto.getGoods_name());
			psmt.setInt(3, dto.getGoods_price());
			psmt.setInt(4, dto.getGoods_mileage());
			psmt.setString(5, dto.getGoods_content());
			psmt.setInt(6, dto.getNum());
			
			affected = psmt.executeUpdate();
			System.out.println("수정성공"+ affected);
		}
		catch (Exception e) {
			System.out.println("수정하기중 예외발생");
			e.printStackTrace();
		}
		return affected;
	}
	
	public int delete(String num) {
		int affected = 0;
		try {
			String query = "DELETE FROM shop_products "
					+ " WHERE num=? ";
			psmt = con.prepareStatement(query);
			psmt.setString(1, num);
			
			affected = psmt.executeUpdate();
		}
		catch (Exception e) {
			System.out.println("delete중 예외발생");
			e.printStackTrace();
		}
		return affected;
	}
}
