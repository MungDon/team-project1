package project.bean.admin;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import project.bean.member.MemberDTO;

public class AdminDAO {
	// 싱글톤 방식으로 사용
	private static AdminDAO instance = new AdminDAO();

	public static AdminDAO getInstance() {
		return instance;
	}

	private AdminDAO() {
	}

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private String sql;

	private Connection getConn() throws Exception {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
		String user = "project1";
		String pw = "tiger";

		Connection conn = DriverManager.getConnection(dburl, user, pw);
		return conn;
	}

	private void close(Connection conn, PreparedStatement pstmt, ResultSet rs) {
		try {
			if (conn != null) {
				conn.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			if (pstmt != null) {
				pstmt.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
		try {
			if (rs != null) {
				rs.close();
			}
		} catch (SQLException e) {
			e.printStackTrace();
		}
	}
	
	// 전체 회원목록
	public List<MemberDTO> loadAllMemeber(int start, int end){
		List<MemberDTO> list = new ArrayList<MemberDTO>();
		try {
			conn = getConn();
			sql="select * from (select M.*, rownum r from (select * from member order by member_num desc) M ) where r between ? and ?";
			pstmt = conn.prepareStatement(sql);
			
			
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				MemberDTO dto = new MemberDTO();
				dto.setMember_num(rs.getInt("member_num"));
				dto.setId(rs.getString("id"));
				dto.setVendor(rs.getString("vendor"));
				dto.setBusiness_number(rs.getString("business_number"));
				dto.setBusiness_name(rs.getString("business_name"));
				dto.setName(rs.getString("name"));
				dto.setGender(rs.getString("gender"));
				dto.setGrade(rs.getString("grade"));
				dto.setDel(rs.getString("del"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return list;
		
		
	}
	// 전체 회원수 가져오기
	public int AllMemberCount() {
		int count = 0;
		try {
			conn = getConn();
			sql="select count(*) from member";
			pstmt = conn.prepareStatement(sql);
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				count = rs.getInt("count(*)");
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		
		return count;
	}
}
