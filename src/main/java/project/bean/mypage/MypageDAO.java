package project.bean.mypage;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

import project.bean.img.ImgDTO;
import project.bean.member.MemberDTO;
import project.bean.product.ProductDTO;
import project.bean.orders.OrdersDTO;

public class MypageDAO {
	private static MypageDAO instance = new MypageDAO();
	public static MypageDAO getInstance () {
		return instance;
	}
	private MypageDAO() {};
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private String sql;
	
	private Connection getConn() throws Exception {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		String url = "jdbc:oracle:thin:@localhost:1521:orcl";
		String user = "project1";
		String password = "tiger";
		conn = DriverManager.getConnection(url, user, password);
		return conn;
	}
	private void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		try {
			if(conn!=null) {
				conn.close();
			}
		}catch(SQLException s){}
		try {
			if(pstmt!=null) {
				pstmt.close();
			}
		}catch(SQLException s) {}
		try {
			if(rs!=null) {
				rs.close();
			}
		}catch(SQLException s) {}
	}
	
	//회원 등급
	public String grade (int member_num) {
		String grade = "";
		try {
			conn = getConn();
			sql = "select grade from member where member_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, member_num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				grade = rs.getString("grade");
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return grade;
	}
	
	//30일 간 판매물품 등록 갯수
	public int reg_count_main (int memberNum) {
		int result = 0;
		try {
			conn = getConn();
			sql="select count(*) from product where delete_yn='N' and member_num=? and trunc(modified_date) >= trunc(sysdate) - 30";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, memberNum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	//30일 간 판매물품 등록 현황
	public ArrayList<MypageWrapper> registration_main (int memberNum, int start, int end) {
		ArrayList<MypageWrapper>list = new ArrayList<MypageWrapper>();
		try {
			conn = getConn();
			sql = "select * from (select p.*, rownum r from (select P.*,I.img_name from product P left outer join img I on P.product_num = I.product_num where P.delete_yn='N' and I.img_type='thumbnail' and P.member_num=? and P.modified_date >= trunc(sysdate) - 30 order by P.modified_date desc) p) where r between ? and ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, memberNum);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ProductDTO productDTO = new ProductDTO();
				ImgDTO imgDTO = new ImgDTO();
				productDTO.setModified_date(rs.getTimestamp("modified_date"));
				productDTO.setProduct_num(rs.getInt("product_num"));
				productDTO.setProduct_name(rs.getString("product_name"));
				imgDTO.setImg_name(rs.getString("img_name"));
				productDTO.setPrice(rs.getInt("price"));
				productDTO.setStock(rs.getInt("stock"));
				MypageWrapper wrapper = new MypageWrapper(productDTO, imgDTO);
				list.add(wrapper);
			}
			
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return list;
	}
	
	//정해진 기간 판매물품 등록 갯수
	public int reg_count(int memberNum, String start, String end) {
		int result = 0;
		try {
			conn = getConn();
			sql="select count(*) from product where delete_yn='N' and member_num=? and trunc(modified_date) between to_date(?, 'YYYY-MM-DD') and to_date(?, 'YYYY-MM-DD')";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, memberNum);
			pstmt.setString(2, start);
			pstmt.setString(3, end);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	//정해진 기간 판매물품 등록 현황
	public ArrayList<MypageWrapper> registration (int memberNum, String start, String end) {
		ArrayList<MypageWrapper>list = new ArrayList<MypageWrapper>();
		try {
			conn = getConn();
			sql = "select P.*,I.img_name from product P left outer join img I on P.product_num = I.product_num where P.delete_yn='N' and I.img_type='thumbnail' and P.member_num = ? and trunc(P.modified_date) between to_date(?, 'YYYY-MM-DD') and to_date(?, 'YYYY-MM-DD') order by P.modified_date desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, memberNum);
			pstmt.setString(2, start);
			pstmt.setString(3, end);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ProductDTO productDTO = new ProductDTO();
				ImgDTO imgDTO = new ImgDTO();
				productDTO.setModified_date(rs.getTimestamp("modified_date"));
				productDTO.setProduct_num(rs.getInt("product_num"));
				productDTO.setProduct_name(rs.getString("product_name"));
				imgDTO.setImg_name(rs.getString("img_name"));
				productDTO.setPrice(rs.getInt("price"));
				productDTO.setStock(rs.getInt("stock"));
				MypageWrapper wrapper = new MypageWrapper(productDTO, imgDTO);
				list.add(wrapper);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return list;
	}
	
	//정해진 기간 판매매출 현황
	public ArrayList<MypageWrapper> sales (int memberNum, String start, String end) {
		ArrayList<MypageWrapper>list = new ArrayList<MypageWrapper>();
		try {
			conn = getConn();
			sql = "select P.*, I.img_name from product P left outer join img I on P.product_num = I.product_num where P.delete_yn='N' and I.img_type='thumbnail' and P.member_num=? and trunc(P.modified_date) between to_date(?, 'YYYY-MM-DD') and to_date(?, 'YYYY-MM-DD') order by P.modified_date desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, memberNum);
			pstmt.setString(2, start);
			pstmt.setString(3, end);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ProductDTO productDTO = new ProductDTO();
				ImgDTO imgDTO = new ImgDTO();
				productDTO.setModified_date(rs.getTimestamp("modified_date"));
				productDTO.setProduct_num(rs.getInt("product_num"));
				productDTO.setProduct_name(rs.getString("product_name"));
				imgDTO.setImg_name(rs.getString("img_name"));
				productDTO.setPrice(rs.getInt("price"));
				productDTO.setFirst_stock(rs.getInt("first_stock"));
				productDTO.setStock(rs.getInt("stock"));
				MypageWrapper wrapper = new MypageWrapper(productDTO, imgDTO);
				list.add(wrapper);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		
		return list;
	}
	
	//판매 주문 갯수
	public int wholeSales_count(int memberNum) {
		int result = 0;
		try {
			conn = getConn();
			sql="select count(*) from orders O left outer join product P on O.product_num = P.product_num where P.delete_yn='N' and orders_status='1' and P.member_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, memberNum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	//전체 판매 주문 현황
	public ArrayList<MypageWrapper> wholeSales (int memberNum, int start, int end) {
		ArrayList<MypageWrapper>list = new ArrayList<MypageWrapper>();
		try {
			conn = getConn();
			sql = "select * from (select p.*, rownum r from (select I.img_name, O.count, M.id, P.* from orders O left outer join product P on O.product_num = P.product_num left outer join member M on O.member_num = M.member_num left outer join img I on O.product_num = I.product_num where P.delete_yn='N' and I.img_type='thumbnail' and orders_status='1'and P.member_num = ? order by P.modified_date desc)p) where r between ? and ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, memberNum);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				ImgDTO imgDTO = new ImgDTO();
				ProductDTO productDTO = new ProductDTO();
				OrdersDTO ordersDTO = new OrdersDTO();
				MemberDTO memberDTO = new MemberDTO();
				productDTO.setProduct_name(rs.getString("product_name"));
				productDTO.setPrice(rs.getInt("price"));
				ordersDTO.setCount(rs.getInt("count"));
				memberDTO.setId(rs.getString("id"));
				MypageWrapper wrapper = new MypageWrapper(imgDTO, memberDTO, productDTO, ordersDTO);
				list.add(wrapper);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return list;
	}
	
	//30일 간 주문 갯수
	public int orders_count_main(int memberNum) {
		int result = 0;
		try {
			conn = getConn();
			sql = "select count(*) from orders where member_num=? and trunc(orders_date) >= trunc(sysdate) - 30";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, memberNum);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}

	//30일 간 주문/배송현황
	public ArrayList<MypageWrapper> orders_main (int memberNum, int start, int end) {
		ArrayList<MypageWrapper>list = new ArrayList<MypageWrapper>();
		try {
			conn = getConn();
			sql = "select* from (select p.*, rownum r from (select O.*, P.*, I.img_name from orders O left outer join product P on O.product_num= P.product_num left outer join img I on O.product_num = I.product_num where P.delete_yn='N' and I.img_type='thumbnail' and O.member_num=? and trunc(O.orders_date) >= trunc(sysdate) - 30 order by O.orders_date desc)p) where r between ? and ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, memberNum);
			pstmt.setInt(2, start);
			pstmt.setInt(3, end);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				OrdersDTO ordersDTO = new OrdersDTO();
				ImgDTO imgDTO = new ImgDTO();
				ProductDTO productDTO = new ProductDTO();
				ordersDTO.setOrders_date(rs.getTimestamp("orders_date"));
				ordersDTO.setOrders_num(rs.getInt("orders_num"));
				imgDTO.setImg_name(rs.getString("img_name"));
				productDTO.setProduct_name(rs.getString("product_name"));
				productDTO.setPrice(rs.getInt("price"));
				ordersDTO.setCount(rs.getInt("count"));
				ordersDTO.setDelivery_status(rs.getString("delivery_status"));
				MypageWrapper wrapper = new MypageWrapper(ordersDTO, productDTO, imgDTO);
				list.add(wrapper);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return list;
	}
	
	//정해진 기간 주문 갯수
	public int orders_count(int memberNum, String start, String end) {
		int result = 0;
		try {
			conn = getConn();
			sql = "select count(*) from orders where member_num=? and trunc(O.orders_date) between to_date(?, 'YYYY-MM-DD') and to_date(?, 'YYYY-MM-DD')";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, memberNum);
			pstmt.setString(2, start);
			pstmt.setString(3, end);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch(Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	//정해진 기간 주문/배송 현황
	public ArrayList<MypageWrapper> orders (int memberNum, String start, String end) {
		ArrayList<MypageWrapper>list = new ArrayList<MypageWrapper>();
		try {
			conn = getConn();
			sql = "select O.*, P.*, I.img_name from orders O left outer join product P on O.product_num= P.product_num left outer join img I on O.product_num = I.product_num where P.delete_yn='N' and I.img_type='thumbnail' and O.member_num=? and trunc(O.orders_date) between to_date(?, 'YYYY-MM-DD') and to_date(?, 'YYYY-MM-DD') order by O.orders_date desc;";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, memberNum);
			pstmt.setString(2, start);
			pstmt.setString(3, end);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				OrdersDTO ordersDTO = new OrdersDTO();
				ImgDTO imgDTO = new ImgDTO();
				ProductDTO productDTO = new ProductDTO();
				ordersDTO.setOrders_date(rs.getTimestamp("orders_date"));
				ordersDTO.setOrders_num(rs.getInt("orders_num"));
				imgDTO.setImg_name(rs.getString("img_name"));
				productDTO.setProduct_name(rs.getString("product_name"));
				productDTO.setPrice(rs.getInt("price"));
				ordersDTO.setCount(rs.getInt("count"));
				ordersDTO.setDelivery_status(rs.getString("delivery_status"));
				MypageWrapper wrapper = new MypageWrapper(ordersDTO, productDTO, imgDTO);
				list.add(wrapper);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return list;
	}
	
	//정해진 기간 취소/반품/교환 신청 갯수
	public int cancellation_request_count (int memberNum, String start, String end) {
		int result = 0;
		try {
			conn = getConn();
			sql="select count(*) from orders where member_num=? and request_status!='1' and trunc(O.orders_date) between to_date(?, 'YYYY-MM-DD') and to_date(?, 'YYYY-MM-DD')";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, memberNum);
			pstmt.setString(2, start);
			pstmt.setString(3, end);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	//정해진 기간 취소/교환/환불 신청 내역
	public ArrayList<MypageWrapper> cancellation_request (int memberNum, String start, String end) {
		ArrayList<MypageWrapper>list = new ArrayList<MypageWrapper>();
		try {
			conn = getConn();
			sql = "select O.*, P.*, I.img_name from orders O left outer join product P on O.product_num= P.product_num left outer join img I on O.product_num = I.product_num where P.delete_yn='N' and I.img_type='thumbnail' and O.request_status!='1' and O.member_num=? and trunc(O.orders_date) between to_date(?, 'YYYY-MM-DD') and to_date(?, 'YYYY-MM-DD') order by O.orders_date desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, memberNum);
			pstmt.setString(2, start);
			pstmt.setString(3, end);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				OrdersDTO ordersDTO = new OrdersDTO();
				ImgDTO imgDTO = new ImgDTO();
				ProductDTO productDTO = new ProductDTO();
				ordersDTO.setOrders_date(rs.getTimestamp("orders_date"));
				ordersDTO.setOrders_num(rs.getInt("orders_num"));
				imgDTO.setImg_name(rs.getString("img_name"));
				productDTO.setProduct_name(rs.getString("product_name"));
				productDTO.setPrice(rs.getInt("price"));
				ordersDTO.setCount(rs.getInt("count"));
				ordersDTO.setRequest_status(rs.getString("orders_status"));
				MypageWrapper wrapper = new MypageWrapper(ordersDTO, productDTO, imgDTO);
				list.add(wrapper);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return list;
	}	
	
	//정해진 기간 취소/반품/교환 처리 갯수
	public int cancellation_count (int memberNum, String start, String end) {
		int result = 0;
		try {
			conn = getConn();
			sql="select count(*) from orders where member_num=? and orders_status!='1' and trunc(O.orders_date) between to_date(?, 'YYYY-MM-DD') and to_date(?, 'YYYY-MM-DD')";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, memberNum);
			pstmt.setString(2, start);
			pstmt.setString(3, end);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				result = rs.getInt(1);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	//정해진 기간 취소/교환/환불 처리 현황
	public ArrayList<MypageWrapper> cancellation (int memberNum, String start, String end) {
		ArrayList<MypageWrapper>list = new ArrayList<MypageWrapper>();
		try {
			conn = getConn();
			sql = "select O.*, P.*, I.img_name from orders O left outer join product P on O.product_num= P.product_num left outer join img I on O.product_num = I.product_num where P.delete_yn='N' and I.img_type='thumbnail' and O.orders_status!='1' and O.member_num=? and trunc(O.orders_date) between to_date(?, 'YYYY-MM-DD') and to_date(?, 'YYYY-MM-DD') order by O.orders_date desc";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, memberNum);
			pstmt.setString(2, start);
			pstmt.setString(3, end);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				OrdersDTO ordersDTO = new OrdersDTO();
				ImgDTO imgDTO = new ImgDTO();
				ProductDTO productDTO = new ProductDTO();
				ordersDTO.setOrders_date(rs.getTimestamp("orders_date"));
				ordersDTO.setOrders_num(rs.getInt("orders_num"));
				imgDTO.setImg_name(rs.getString("img_name"));
				productDTO.setProduct_name(rs.getString("product_name"));
				productDTO.setPrice(rs.getInt("price"));
				ordersDTO.setCount(rs.getInt("count"));
				ordersDTO.setOrders_status(rs.getString("orders_status"));
				MypageWrapper wrapper = new MypageWrapper(ordersDTO, productDTO, imgDTO);
				list.add(wrapper);
			}
		}catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return list;
	}	
		
}