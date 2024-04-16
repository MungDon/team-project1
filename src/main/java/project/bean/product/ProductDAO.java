package project.bean.product;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

public class ProductDAO {
	// 싱글톤 방식으로 사용
	private static ProductDAO instance = new ProductDAO(); 
	
	public static ProductDAO getInstance() {
		return instance;
	}
	private ProductDAO() {}
	
	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	
	private Connection getConn() throws Exception {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
		String user = "project1";
		String pw = "tiger";
		
		Connection conn = DriverManager.getConnection(dburl,user,pw);
		return conn;
	}
	
	private void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		try {
			if(conn != null) {
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			if(pstmt != null) {
				pstmt.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			if(rs != null) {
				rs.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
}
