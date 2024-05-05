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

	/*-----------------관리자 - 회원 파트 --------------------*/
	// 전체 회원목록
	public List<MemberDTO> loadAllMemeber(int start, int end) {
		List<MemberDTO> list = new ArrayList<MemberDTO>();
		try {
			conn = getConn();
			sql = "select * from (select M.*, rownum r from (select * from member order by member_num desc) M ) where r between ? and ?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();

			while (rs.next()) {
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
			sql = "select count(*) from member";
			pstmt = conn.prepareStatement(sql);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				count = rs.getInt("count(*)");
			}

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}

		return count;
	}

	// 회원 상세정보
	public MemberDTO memberDetail(int member_num) {
		MemberDTO dto = new MemberDTO();
		try {
			conn = getConn();
			sql = "select * from member where member_num = ?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, member_num);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				dto.setMember_num(rs.getInt("member_num"));
				dto.setId(rs.getString("id"));
				dto.setVendor(rs.getString("vendor"));
				dto.setBusiness_number(rs.getString("business_number"));
				dto.setBusiness_name(rs.getString("business_name"));
				dto.setName(rs.getString("name"));
				dto.setEmail(rs.getString("email"));
				dto.setCellphone(rs.getString("cellphone"));
				dto.setPhone(rs.getString("phone"));
				dto.setGender(rs.getString("gender"));
				dto.setGrade(rs.getString("grade"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setDel(rs.getString("del"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return dto;
	}

	// 회원 정보 수정
	public int updateMember(MemberDTO dto) {
		int result = 0;
		try {
			conn = getConn();
			sql = "update member set id = ?, vendor = ?, name = ?, grade = ? where member_num = ?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, dto.getId());
			pstmt.setString(2, dto.getVendor());
			pstmt.setString(3, dto.getName());
			pstmt.setString(4, dto.getGrade());
			pstmt.setInt(5, dto.getMember_num());

			result = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return result;
	}

	// 회원 가입상태 변경
	public int changeMemberDel(int memeber_num, String del) {
		int result = 0;
		try {
			conn = getConn();
			sql = "update member set del = ? where member_num = ?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setString(1, del);
			pstmt.setInt(2, memeber_num);

			result = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return result;
	}

	// 판매자 승인대기 목록
	public List<MemberDTO> loadWaitingMemeber(int start, int end) {
		List<MemberDTO> list = new ArrayList<MemberDTO>();
		try {
			conn = getConn();
			sql = "select * from (select M.*, rownum r from (select * from member order by member_num desc where vendor = '0') M ) where r between ? and ?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();

			while (rs.next()) {
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

	// 판매자 가입 승인 및 거절
	public int changeVendor(String vendor, int member_num) {
		int result = 0;
		try {
			conn = getConn();
			sql="update member set vendor = ? where member_num = ?";
			pstmt = conn.prepareStatement(sql);
			
			pstmt.setString(1, vendor);
			pstmt.setInt(2, member_num);
			
			result = pstmt.executeUpdate();
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
}
