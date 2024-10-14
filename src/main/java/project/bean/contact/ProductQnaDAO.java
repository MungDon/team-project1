package project.bean.contact;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;

public class ProductQnaDAO {
	private static ProductQnaDAO instance = new ProductQnaDAO();

	public static ProductQnaDAO getInstance() {
		return instance;
	}

	private ProductQnaDAO() {
	}

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private String sql;

	private Connection getConn() throws Exception {
		try {
			Class.forName("oracle.jdbc.driver.OracleDriver");
			String user = "system";
			String password = "10220809";
			String url = "jdbc:oracle:thin:@localhost:1521:orcl";
			conn = DriverManager.getConnection(url, user, password);

		} catch (Exception e) {
			e.printStackTrace();
		}
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

	// 글 작성
	public int productQnaWrite(ProductQnaDTO dto) {
		int result = 0;
		System.out.println(dto.getProduct_num());
		System.out.println(dto.getMember_num());
		System.out.println(dto.getImg());
		System.out.println(dto.getCategory());
		System.out.println(dto.getTitle());
		System.out.println(dto.getQuestion());
		System.out.println(dto.getAnswer());
		System.out.println(dto.getPassword());
		System.out.println(dto.getReadCount());
		System.out.println(dto.getSecret_yn());
		System.out.println(dto.getDelete_yn());
		try {
			conn = getConn();
			sql = "insert into product_qna values(product_qna_seq.NEXTVAL,?,?,?,?,?,?,?,?,sysdate,sysdate,?,?,?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, dto.getProduct_num());
			pstmt.setInt(2, dto.getMember_num());
			pstmt.setString(3, dto.getCategory());
			pstmt.setString(4, dto.getTitle());
			pstmt.setString(5, dto.getQuestion());
			pstmt.setString(6, dto.getAnswer());
			pstmt.setString(7, dto.getPassword());
			pstmt.setInt(8, dto.getReadCount());
			pstmt.setString(9, dto.getSecret_yn());
			pstmt.setString(10, dto.getDelete_yn());
			pstmt.setString(11, dto.getImg());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return result;
	}

	// 글목록
	public ArrayList<ProductQnaDTO> list(int start, int end) {
		ArrayList<ProductQnaDTO> list = new ArrayList<ProductQnaDTO>();
		try {
			conn = getConn();
			sql = "SELECT * FROM (SELECT PQ.product_qna_num, PQ.answer, PQ.category AS pq_category, PQ.secret_yn AS pq_secret_yn, PQ.password AS pq_password, PQ.product_num AS pq_product_num, PQ.member_num AS pq_member_num, PQ.title AS pq_title, PQ.question AS pq_question, PQ.reg AS pq_reg, PQ.delete_yn AS pq_delete_yn, P.product_name AS p_product_name, P.category_num AS p_category_num, I.img_name AS i_img_name, C.category_name AS c_category_name, M.name AS member_name, ROWNUM AS r FROM PRODUCT_QNA PQ LEFT OUTER JOIN PRODUCT P ON PQ.product_num = P.product_num LEFT OUTER JOIN IMG I ON P.product_num = I.product_num LEFT OUTER JOIN categorys C ON P.category_num = C.category_num LEFT OUTER JOIN MEMBER M ON PQ.member_num = M.member_num WHERE PQ.delete_yn = 'n' AND I.img_type = 'thumbnail' ORDER BY PQ.reg DESC) WHERE r >= ? AND r <= ?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ProductQnaDTO dto = new ProductQnaDTO();
				dto.setProduct_qna_num(rs.getInt("product_qna_num"));
				dto.setCategory(rs.getString("pq_category")); // 수정된 별칭 사용
				dto.setTitle(rs.getString("pq_title"));
				dto.setAnswer(rs.getString("answer"));
				dto.setPassword(rs.getString("pq_password"));
				dto.setReg(rs.getTimestamp("pq_reg"));
				dto.setSecret_yn(rs.getString("pq_secret_yn"));

				dto.setMember_name(rs.getString("member_name"));

				dto.setCategory_name(rs.getString("c_category_name"));
				dto.setImg_name(rs.getString("i_img_name"));
				dto.setProduct_name(rs.getString("p_product_name"));

				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return list;
	}

	// 글 개수
	public int count() {
		int result = 0;
		try {
			conn = getConn();
			sql = "select count(*) from product_qna";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return result;
	}

	// 글 내용
	public ProductQnaDTO content(int num) {
		ProductQnaDTO dto = new ProductQnaDTO();
		try {
			conn = getConn();
			sql = "update product_qna set readcount = readcount+1 where product_qna_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();

			sql = "SELECT PQ.product_qna_num, PQ.category, PQ.product_num, PQ.member_num, PQ.img_name, PQ.title, PQ.reg_answer, PQ.answer, PQ.secret_yn, PQ.reg, PQ.question, PQ.readcount, P.product_name, P.category_num AS product_category_num, I.img_name AS product_img, C.category_name, M.name AS member_name FROM PRODUCT_QNA PQ LEFT OUTER JOIN PRODUCT P ON PQ.product_num = P.product_num LEFT OUTER JOIN IMG I ON P.product_num = I.product_num LEFT OUTER JOIN categorys C ON P.category_num = C.category_num LEFT OUTER JOIN MEMBER M ON PQ.member_num = M.member_num WHERE PQ.delete_yn = 'n' AND I.img_type = 'thumbnail' AND PQ.product_qna_num = ?";

			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dto.setTitle(rs.getString("title"));
				dto.setCategory(rs.getString("category"));
				dto.setSecret_yn(rs.getString("secret_yn"));
				dto.setImg(rs.getString("img_name"));
				dto.setReg(rs.getTimestamp("reg"));
				dto.setReg_answer(rs.getTimestamp("reg_answer"));
				dto.setQuestion(rs.getString("question"));
				dto.setAnswer(rs.getString("answer"));
				dto.setReadCount(rs.getInt("readcount"));
				// 회원
				dto.setMember_num(rs.getInt("member_num"));
				dto.setMember_name(rs.getString("member_name"));
				// 상품
				dto.setProduct_num(rs.getInt("product_num"));
				dto.setProduct_name(rs.getString("product_name"));
				dto.setCategory_name(rs.getString("category_name"));
				dto.setCatetgory_num(rs.getInt("product_category_num"));
				dto.setImg_name(rs.getString("product_img"));

			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return dto;
	}

	// 답글
	public int productAnswerWrite(ProductQnaDTO dto) {
		int result = 0;
		sql = "update product_qna set answer=?, reg_answer=sysdate where product_qna_num=?";
		try {
			conn = getConn();
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, dto.getAnswer());
			pstmt.setInt(2, dto.getProduct_qna_num());
			result = pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return result;
	}

	// 글수정 pro
	public int productQnaUpdatePro(ProductQnaDTO dto, int num) {
		int result = 0;
		String dbpw = "";
		try {
			conn = getConn();
			sql = "select password from product_qna where product_qna_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				dbpw = rs.getString("password");
				if (dbpw.equals(dto.getPassword())) {
					sql = "update product_qna set title=?, question=?, img=?, secret_yn=?, reg=sysdate where product_qna_num=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setString(1, dto.getTitle());
					pstmt.setString(2, dto.getQuestion());
					pstmt.setString(3, dto.getImg());
					pstmt.setString(4, dto.getSecret_yn());
					pstmt.setInt(5, dto.getProduct_qna_num());
					result = pstmt.executeUpdate();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return result;
	}

	// 글삭제
	public int qnaDelete(int num, String password) {
		int result = 0;
		String dbpw = "";
		try {
			conn = getConn();
			pstmt = conn.prepareStatement("select password from product_qna where product_qna_num=?");
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				dbpw = rs.getString("password");
				if (dbpw.equals(password)) {
					sql = "update product_qna set delete_yn = 'y' where product_qna_num=?";
					pstmt = conn.prepareStatement(sql);
					pstmt.setInt(1, num);
					result = pstmt.executeUpdate();
				}
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return result;
	}

	// 글삭제2 (이미지 리턴)
	public String delete(int num) {
		String img = "";
		try {
			conn = getConn();
			sql = "select & from product_qna where product_qna_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				img = rs.getString("img");
			}

			sql = "update product_qna set delete_yn = 'y' where product_qna_num=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, num);
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return img;
	}

	// ---------------------universe's made-------------------------
	// productContent.jsp 상품 상세 페이지 하단에 보여질 상품 문의 리스트

	public ArrayList<ProductQnaDTO> productQnaList(int product_num) {
		ArrayList<ProductQnaDTO> list = new ArrayList<ProductQnaDTO>();
		try {
			conn = getConn();
			sql = "select * from (select b.*, rownum r from(select PQ.*, M.name AS member_name, P.product_name from product_qna PQ left outer join product P on PQ.product_num = P.product_num left outer join member M on PQ.member_num = M.member_num where PQ.delete_yn='n' and PQ.product_num = ? order by PQ.reg desc) b) where r <= 5";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, product_num);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				ProductQnaDTO dto = new ProductQnaDTO();
				dto.setProduct_num(rs.getInt("product_qna_num"));
				dto.setCategory(rs.getString("category"));
				dto.setProduct_name(rs.getString("product_name"));
				dto.setTitle(rs.getString("title"));
				dto.setQuestion(rs.getString("question"));
				dto.setAnswer(rs.getString("answer"));
				dto.setMember_name(rs.getString("member_name"));
				dto.setMember_num(rs.getInt("member_num"));
				dto.setSecret_yn(rs.getString("secret_yn"));
				dto.setReg(rs.getTimestamp("reg"));
				list.add(dto);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return list;
	}

	// -------------------------------------------
	public int getSellerProductNum(int num) {
		int product_num = 0;
		try {
			conn = getConn();
			sql = "select product_num from product_qna where product_qna_num = ?";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, num);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				product_num = rs.getInt("product_num");
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return product_num;
	}

	public boolean isReal(int snum, int product_num) {
		boolean result = false;
		try {
			conn = getConn();
			sql = "select * from product where member_num = ? and product_num = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, snum);
			pstmt.setInt(2, product_num);

			rs = pstmt.executeQuery();
			if (rs.next()) {
				result = true;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
}
