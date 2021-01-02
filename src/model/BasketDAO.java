package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class BasketDAO {

	Connection con;
	PreparedStatement psmt;
	ResultSet rs;

	public BasketDAO() {
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

	public int addBasket(BasketDTO dto) {
		int affected = 0;
		try {
			String sql = "INSERT into shop_basket(product_num,user_id,goods_count,total_price) " + "values( ?,?,?,?)";
			psmt = con.prepareStatement(sql);
			psmt.setInt(1, dto.getProduct_num());
			psmt.setString(2, dto.getUser_id());
			psmt.setInt(3, dto.getGoods_count());
			psmt.setInt(4, dto.getTotal_price());

			affected = psmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}
		return affected;
	}

	public List<BasketDTO> selectAll(String id) {
		List<BasketDTO> list = new Vector<BasketDTO>();
		try {
			String sql = "SELECT * FROM shop_basket b INNER JOIN shop_products p "
					+ " ON b.product_num=p.NUM WHERE user_id=?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, id);

			rs = psmt.executeQuery();
			while (rs.next()) {
				BasketDTO dto = new BasketDTO();
				dto.setGoods_count(rs.getInt("goods_count"));
				dto.setProduct_num(rs.getInt("product_num"));
				dto.setTotal_price(rs.getInt("total_price"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setNum(rs.getInt("num"));
				dto.setGoods_price(rs.getInt("goods_price"));
				dto.setGoods_mileage(rs.getInt("goods_mileage"));
				dto.setGoods_name(rs.getString("goods_name"));
				dto.setImage(rs.getString("image"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
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

	public int delete(String num) {
		int affected= 0;
		try {
			String sql = "DELETE FROM shop_basket where num=?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, num);

			affected = psmt.executeUpdate();
		} catch (Exception e) {
			System.out.println("delete중 예외발생");
			e.printStackTrace();
		}
		return affected; 
	}
	public BasketDTO select(String num) {
		BasketDTO dto = new BasketDTO();
		try {
			String sql = "SELECT * FROM shop_basket b INNER JOIN shop_products p "
					+ " ON b.product_num=p.NUM WHERE b.num=?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, num);

			rs = psmt.executeQuery();
			while (rs.next()) {
				
				dto.setGoods_count(rs.getInt("goods_count"));
				dto.setProduct_num(rs.getInt("product_num"));
				dto.setTotal_price(rs.getInt("total_price"));
				dto.setUser_id(rs.getString("user_id"));
				dto.setNum(rs.getInt("num"));
				dto.setGoods_price(rs.getInt("goods_price"));
				dto.setGoods_mileage(rs.getInt("goods_mileage"));
				dto.setGoods_name(rs.getString("goods_name"));
				dto.setImage(rs.getString("image"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
	
	public int updateEdit(BasketDTO dto) {
		int affected = 0;
		try {
			String query = "UPDATE shop_basket SET goods_count=?, total_price=?"
					+ " WHERE num=? ";
			
			psmt = con.prepareStatement(query);
			psmt.setInt(1, dto.getGoods_count());
			psmt.setInt(2, dto.getTotal_price());
			psmt.setInt(3, dto.getNum());
			
			affected = psmt.executeUpdate();
		}
		catch (Exception e) {
			System.out.println("수정하기중 예외발생");
			e.printStackTrace();
		}
		return affected;
	}
}
