package model;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.List;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

public class OrderingDAO {
	
	Connection con;
	PreparedStatement psmt;
	ResultSet rs;
	public OrderingDAO() {
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
	
	public int insertOrder(OrderingDTO dto) {
		int affected = 0;
		try {
			String sql = "INSERT INTO shop_ordering ("
					+ "id, order_name,order_info, delivery_name,delivery_info, basket, message, total_price, payment)"
					+ "values(?,?,?,?,?,?,?,?,?)";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, dto.getId());
			psmt.setString(2, dto.getOrder_name());
			psmt.setString(3, dto.getOrder_info());
			psmt.setString(4, dto.getDelivery_name());
			psmt.setString(5, dto.getDelivery_info());
			psmt.setString(6, dto.getBasket());
			psmt.setString(7, dto.getMessage());
			psmt.setInt(8, dto.getTotal_price());
			psmt.setString(9, dto.getPayment());
			
			affected = psmt.executeUpdate();
		}
		catch (Exception e) {
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
	
	public List<OrderingDTO> selectAll(){
		List<OrderingDTO> list = new Vector<OrderingDTO>();
		try {
			String sql = "SELECT * FROM shop_ordering";
			psmt = con.prepareStatement(sql);
			rs = psmt.executeQuery();
			while(rs.next()) {
				OrderingDTO dto = new OrderingDTO();
				dto.setId(rs.getString("id"));
				dto.setIdx(rs.getInt("idx"));
				dto.setOrder_name(rs.getString("Order_name"));
				dto.setOrder_info(rs.getString("Order_info"));
				dto.setDelivery_name(rs.getString("Delivery_name"));
				dto.setDelivery_info(rs.getString("Delivery_info"));
				dto.setMessage(rs.getString("Message"));
				dto.setTotal_price(rs.getInt("total_price"));
				dto.setPayment(rs.getString("payment"));
				dto.setBasket(rs.getString("basket"));
				dto.setPostdate(rs.getString("postdate"));
				list.add(dto);
			}
			
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return list;
	}
	
	public OrderingDTO selectView(String idx) {
		OrderingDTO dto = new OrderingDTO();
		try {
			String sql = "SELECT * FROM shop_ordering where idx=?";
			psmt = con.prepareStatement(sql);
			psmt.setString(1, idx);
			
			rs=psmt.executeQuery();
			if(rs.next()) {
				
				dto.setId(rs.getString("id"));
				dto.setIdx(rs.getInt("idx"));
				dto.setOrder_name(rs.getString("Order_name"));
				dto.setOrder_info(rs.getString("Order_info"));
				dto.setDelivery_name(rs.getString("Delivery_name"));
				dto.setDelivery_info(rs.getString("Delivery_info"));
				dto.setMessage(rs.getString("Message"));
				dto.setTotal_price(rs.getInt("total_price"));
				dto.setPayment(rs.getString("payment"));
				dto.setBasket(rs.getString("basket"));
				dto.setPostdate(rs.getString("postdate"));
			}
		}
		catch (Exception e) {
			e.printStackTrace();
		}
		return dto;
	}
}
