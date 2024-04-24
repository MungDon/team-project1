package project.bean.product;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.util.ArrayList;
import java.util.List;

import project.bean.category.CategoryDTO;
import project.bean.img.ImgDTO;

public class ProductDAO {
	// 싱글톤 방식으로 사용
	private static ProductDAO instance = new ProductDAO();

	public static ProductDAO getInstance() {
		return instance;
	}

	private ProductDAO() {
	}

	private Connection conn;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private String sql;

	private Connection getConn() throws Exception {
		Class.forName("oracle.jdbc.driver.OracleDriver");
		String dburl = "jdbc:oracle:thin:@localhost:1521:orcl";
		String user = "scott";
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
	
	// 카테고리 불러오기
	public List<CategoryDTO> loadCategorys(){
		List<CategoryDTO> list = new ArrayList<CategoryDTO>();
		try {
			conn = getConn();
			sql="select category_name,category_num from categorys ";
			pstmt = conn.prepareStatement(sql);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				CategoryDTO dto = new CategoryDTO();
				dto.setCategory_name(rs.getString("category_name"));
				dto.setCategory_num(rs.getInt("category_num"));
				list.add(dto);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			close(conn, pstmt, rs);
		}
		return list;
	}
	
	
	//상품 등록
	public int saveProduct(ProductDTO dto) {
		int product_num = 0;
		try {
			conn = getConn();
			sql = "insert into product values(product_seq.nextval, ?, ?, ?, ?, ?, ?, ?, ?, 'N', systimestamp,systimestamp,?)";
			pstmt = conn.prepareStatement(sql, new String[] { "PRODUCT_NUM" });

			pstmt.setInt(1, dto.getMember_num()); // 회원 정보
			pstmt.setInt(2, dto.getCategory_num());	// 카테고리 정보
			pstmt.setString(3, dto.getProduct_name()); // 상품 이름
			pstmt.setString(4, dto.getProduct_info()); // 상품 정보
			pstmt.setInt(5, dto.getPrice()); // 상품 가격
			pstmt.setInt(6, dto.getDelivery_price()); // 배송비
			pstmt.setString(7, dto.getHas_delivery_fee()); // 배송비 여부
			pstmt.setInt(8, dto.getStock()); // 상품 재고
			pstmt.setInt(9, dto.getFirst_stock()+dto.getStock());// 상품 최초 재고

			pstmt.executeUpdate();

			rs = pstmt.getGeneratedKeys();

			if (rs.next()) {
				product_num = rs.getInt(1);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return product_num;
	}
	
	
	// 상품이미지 등록
	public int saveImg(ImgDTO imgDTO) {
		int result = 0;
		try {
			conn = getConn();
			sql = "insert into img values(img_seq.nextval, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);

			pstmt.setInt(1, imgDTO.getProduct_num());
			pstmt.setString(2, imgDTO.getImg_name());
			pstmt.setString(3, imgDTO.getOriginal_name());
			pstmt.setString(4, imgDTO.getExtension());
			pstmt.setString(5, imgDTO.getImg_type());

			result = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			close(conn, pstmt, rs);
		}
		return result;
	}
	
	// 상품 목록 보기
	public List<ProductDTO> productList(int start, int end) {
		List<ProductDTO> list = new ArrayList<ProductDTO>();
		try {
			conn = getConn();
			sql="select * from (select p.*, rownum r from (select P.*, I.img_name from product  P left outer join img I on P.product_num = I.product_num where P.delete_yn = 'N' and I.img_type = 'thumbnail' order by P.product_num desc) p ) where r between ? and ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setInt(1, start);
			pstmt.setInt(2, end);
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				ProductDTO dto = new ProductDTO();
				ImgDTO imgDto = new ImgDTO();
				dto.setProduct_num(rs.getInt("product_num"));
				dto.setProduct_name(rs.getString("product_name"));
				dto.setProduct_info(rs.getString("product_info"));
				dto.setPrice(rs.getInt("price"));
				dto.setDelivery_price(rs.getInt("delivery_price"));
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
	// 카테고리별 상품 목록 보기
		public List<ProductDTO> CateProductList(int category_num, int start, int end) {
			List<ProductDTO> list = new ArrayList<ProductDTO>();
			try {
				conn = getConn();
				sql="select * from (select p.*, rownum r from (select P.*,I.img_name from product  P left outer join img I on P.product_num = I.product_num where P.delete_yn = 'N' and I.img_type = 'thumbnail' and category_num = ? order by P.product_num desc) p ) where r between ? and ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, category_num);
				pstmt.setInt(2, start);
				pstmt.setInt(3, end);
				rs = pstmt.executeQuery();
				
				while(rs.next()) {
					ProductDTO dto = new ProductDTO();
					ImgDTO imgDto = new ImgDTO();
					dto.setProduct_num(rs.getInt("product_num")); 
					dto.setProduct_name(rs.getString("product_name"));
					dto.setProduct_info(rs.getString("product_info"));
					dto.setPrice(rs.getInt("price"));
					dto.setDelivery_price(rs.getInt("delivery_price"));
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
		
		// 전체 상품 수 가져오기
		public int productCount() {
			int result = 0;
			try {
				conn = getConn();
				sql = "select count(*) from product";
				pstmt = conn.prepareStatement(sql);
				rs= pstmt.executeQuery();
				if(rs.next()) {
					result = rs.getInt("count(*)");
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close(conn, pstmt, rs);
			}
			return result;
		}
		
		// 상품 수정하기 폼
		public List<ProductDTO> updateForm(int product_num) {
			List<ProductDTO> list = new ArrayList<ProductDTO>();
			try {
				conn = getConn();
				sql="select P.*,I.img_name, I.img_num, c.category_name from product  P left outer join img I on P.product_num = I.product_num left outer join categorys C on P.category_num = C.category_num where P.delete_yn = 'N' and P.product_num = ? order by P.product_num desc";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, product_num);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					ProductDTO dto = new ProductDTO();
					dto.setProduct_num(rs.getInt("product_num"));
					dto.setMember_num(rs.getInt("member_num"));
					dto.setCategory_num(rs.getInt("category_num"));
					dto.setCategory_name(rs.getString("category_name"));
					dto.setProduct_name(rs.getString("product_name"));
					dto.setProduct_info(rs.getString("product_info"));
					dto.setStock(rs.getInt("stock"));
					dto.setPrice(rs.getInt("price"));
					dto.setDelivery_price(rs.getInt("delivery_price"));
					dto.setHas_delivery_fee(rs.getString("has_delivery_fee"));
					
					  // 이미지 정보
					List<ImgDTO> imgs = new ArrayList<ImgDTO>();
     		            do {
		                ImgDTO imgDto = new ImgDTO();
		                imgDto.setImg_name(rs.getString("img_name"));
		                imgDto.setImg_num(rs.getInt("img_num"));
		                imgs.add(imgDto);
		            } while (rs.next() && product_num == rs.getInt("product_num")); // 같은 상품 번호인 경우에만 계속해서 이미지 추가
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
		// 상품 수정
		public int updateProduct(ProductDTO dto) {
			int result = 0;
			try {
				conn = getConn();
				sql = "update product set category_num = ?, product_name = ?, product_info = ?, price = ?, delivery_price = ?, has_delivery_fee = ?, stock = ?, first_stock = ? where product_num = ?";
				pstmt = conn.prepareStatement(sql);

				pstmt.setInt(1, dto.getCategory_num());	// 카테고리 정보
				pstmt.setString(2, dto.getProduct_name()); // 상품 이름
				pstmt.setString(3, dto.getProduct_info()); // 상품 정보
				pstmt.setInt(4, dto.getPrice()); // 상품 가격
				pstmt.setInt(5, dto.getDelivery_price()); // 배송비
				pstmt.setString(6, dto.getHas_delivery_fee()); // 배송비 여부
				pstmt.setInt(7, dto.getStock()); // 상품 재고
				pstmt.setInt(8, dto.getStock()+dto.getFirst_stock());	 // 상품 최초 재고
				pstmt.setInt(9, dto.getProduct_num());	// 상품 번호

				result = pstmt.executeUpdate();


			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close(conn, pstmt, rs);
			}
			return result;
		}
		//썸네일이미지 가져오기
		public String getThumbnail(int product_num) {
			String thumbnail="";
			try {
				conn = getConn();
				sql="select img_name from img where product_num = ? and img_type = 'thumbnail'";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, product_num);
				
				rs = pstmt.executeQuery();
				if(rs.next()) {
					thumbnail = rs.getString("img_name");
				}
				
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				close(conn, pstmt, rs);
			}
			return thumbnail;
		}
		
		// 이미지 이름 가져오기
		public String getImgName(int imgNum) {
			String imgName="";
			try {
				conn = getConn();
				sql="select img_name from img where img_num = ?";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setInt(1, imgNum);
				rs = pstmt.executeQuery();
				if(rs.next()) {
					imgName = rs.getString("img_name");
				}
			} catch (Exception e) {
				e.printStackTrace();
			} finally {
				close(conn, pstmt, rs);
			}
			return imgName;
		}
		
		// 이미지 삭제 
		public void deleteImg(String imgName) {
			try {
				conn = getConn();
				sql="delete from img where img_name = ?";
				pstmt = conn.prepareStatement(sql);
				
				pstmt.setString(1, imgName);
				
				pstmt.executeUpdate();
			} catch (Exception e) {
				e.printStackTrace();
			}finally {
				close(conn, pstmt, rs);
			}
			
		}
}
