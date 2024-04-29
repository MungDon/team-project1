package project.bean.orders;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import project.bean.img.ImgDTO;
import project.bean.product.ProductDTO;

public class OrdersDAO {
	private static OrdersDAO instance = new OrdersDAO();
	public static OrdersDAO getInstance() {
		return instance;
	}
	private OrdersDAO() {}
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private String sql;
	
	private Connection getConn() throws Exception {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
			String user = "project1";
			String pw = "tiger";
			conn = DriverManager.getConnection(dburl, user, pw);
		} catch (Exception e) {
			e.printStackTrace();
		}
		return conn;
	}
	
	private void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		try {if (conn != null) 	{conn.close();}	} catch (SQLException e) {e.printStackTrace();}
		try {if (pstmt != null) {pstmt.close();}} catch (SQLException e) {e.printStackTrace();}
		try {if (rs != null) 	{rs.close();}	} catch (SQLException e) {e.printStackTrace();}
	}
	
//	주문상품. 썸네일 1장 + 상품 목록 2개 join
	public List<ProductDTO> orderProduct(int product_num) {
		List<ProductDTO> list = new ArrayList<ProductDTO>();
		try {
			conn = getConn();
			sql = "select b.* from (select P.*, I.img_name from product P left outer join img I on P.product_num = I.product_num where P.delete_yn = 'N' and I.img_type = 'thumbnail' order by P.product_num desc) b where product_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_num);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ProductDTO dto = new ProductDTO();
				ImgDTO imgDto = new ImgDTO();
				dto.setProduct_num(rs.getInt("product_num"));
				dto.setCategory_num(rs.getInt("category_num"));
				dto.setProduct_name(rs.getString("product_name"));
				dto.setProduct_info(rs.getString("product_info"));
				dto.setPrice(rs.getInt("price"));
				dto.setDelivery_price(rs.getInt("delivery_price"));
				dto.setHas_delivery_fee(rs.getString("has_delivery_fee"));
				
				imgDto.setImg_name(rs.getString("img_name"));
				
				List<ImgDTO> imgs = new ArrayList<ImgDTO>();
				imgs.add(imgDto);
				dto.setImages(imgs);
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return list;
	}
	
	
//	주문상품 리스트
	public List<OrdersDTO> orderList(int product_num, int snum) {
		List<OrdersDTO> list = new ArrayList<OrdersDTO>();
		try {
			conn = getConn();
			sql = "select * from orders where product_num = ? and member_num = ? order by orders_date desc";
			pstmt = conn.prepareStatement(sql);		// 같은사람이 같은제품을 주문할 경우를 대비해 주문일자 내림차순 정렬
			pstmt.setInt(1, product_num);
			pstmt.setInt(2, snum);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				OrdersDTO dto = new OrdersDTO();
				dto.setCount(rs.getInt("count"));
				dto.setOrders_date(rs.getTimestamp("orders_date"));
				dto.setOrders_name(rs.getString("orders_name"));
				dto.setReceiver_name(rs.getString("receciver_name"));
				dto.setPhone(rs.getString("phone"));
				dto.setCellphone(rs.getString("cellphone"));
				dto.setEmail(rs.getString("email"));
				dto.setAddress1(rs.getString("address1"));
				dto.setAddress1(rs.getString("address2"));
				dto.setAddress1(rs.getString("address3"));
				dto.setFinal_price(rs.getInt("final_price"));
				dto.setPayment_option(rs.getString("payment_option"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return list;
	}
	
//	주문상품 insert
	public int orderInsert(OrdersDTO dto, int snum) {
		int result = 0;
		try {
			conn = getConn();
			sql = "insert into orders values(orders_seq.NEXTVAL, ?, ?, ?, ?, 1, 1, 1, ?, systimestamp, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getMember_num());
			pstmt.setInt(2, dto.getProduct_num());
			pstmt.setInt(3, dto.getDelivery_num());
			pstmt.setInt(4, dto.getImg_num());
			pstmt.setInt(5, dto.getCount());
			pstmt.setString(6, dto.getOrders_name());
			pstmt.setString(7, dto.getReceiver_name());
			pstmt.setString(8, dto.getPhone());
			pstmt.setString(9, dto.getCellphone());
			pstmt.setString(10, dto.getEmail());
			pstmt.setString(11, dto.getAddress1());
			pstmt.setString(12, dto.getAddress2());
			pstmt.setString(13, dto.getAddress3());
			pstmt.setInt(14, dto.getFinal_price());
			pstmt.setString(15, dto.getPayment_option());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
}