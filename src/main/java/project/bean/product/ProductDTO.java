package project.bean.product;

import java.io.File;
import java.sql.Timestamp;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import com.oreilly.servlet.MultipartRequest;

public class ProductDTO {

	private int product_num;					// 상품 PK/번호
	
	private int member_num;					// 회원 FK/정보
	
	private String product_name;			// 상품명
	
	private String product_info;				// 상품 정보	
	
	private int price;								// 상품 가격
	
	private int delivery_price;				// 배송비
	
	private String has_delivery_fee;		// 배송비 유무 
	
	private int buy_limit;						// 구매 가능 수량
	
	private String brand;						// 제조사
	
	private int stock;								// 재고
	
	private Timestamp created_date;		// 상품 등록 일시
	
	private Timestamp modified_date;	// 상품 수정 일시


	
	// getter()/setter()//
	
	public int getProduct_num() {
		return product_num;
	}

	public void setProduct_num(int product_num) {
		this.product_num = product_num;
	}

	public int getMember_num() {
		return member_num;
	}

	public void setMember_num(int member_num) {
		this.member_num = member_num;
	}

	public String getProduct_name() {
		return product_name;
	}

	public void setProduct_name(String product_name) {
		this.product_name = product_name;
	}

	public String getProduct_info() {
		return product_info;
	}

	public void setProduct_info(String product_info) {
		this.product_info = product_info;
	}

	public int getPrice() {
		return price;
	}

	public void setPrice(int price) {
		this.price = price;
	}

	public int getDelivery_price() {
		return delivery_price;
	}

	public void setDelivery_price(int delivery_price) {
		this.delivery_price = delivery_price;
	}

	public String getHas_delivery_fee() {
		return has_delivery_fee;
	}

	public void setHas_delivery_fee(String has_delivery_fee) {
		this.has_delivery_fee = has_delivery_fee;
	}

	public int getBuy_limit() {
		return buy_limit;
	}

	public void setBuy_limit(int buy_limit) {
		this.buy_limit = buy_limit;
	}

	public String getBrand() {
		return brand;
	}

	public void setBrand(String brand) {
		this.brand = brand;
	}

	public Timestamp getCreated_date() {
		return created_date;
	}

	public void setCreated_date(Timestamp created_date) {
		this.created_date = created_date;
	}

	public Timestamp getModified_date() {
		return modified_date;
	}

	public void setModified_date(Timestamp modified_date) {
		this.modified_date = modified_date;
	}


	public int getStock() {
		return stock;
	}

	public void setStock(int stock) {
		this.stock = stock;
	}

	// jsp 에 다쓰면 너무 지저분해 보여서 여기다 메서드로 따로 뺌
	// 상품정보 받아온걸 multipartReq 로 dto 에 set 함
	public ProductDTO setProductAdd(HttpServletRequest request) {
		ProductDTO dto = new ProductDTO();
		
		dto.setMember_num(Integer.parseInt(request.getParameter("member_num")));// 회원 고유번호
		dto.setProduct_name(request.getParameter("product_name"));
		dto.setProduct_info(request.getParameter("product_info"));
		dto.setPrice(Integer.parseInt(request.getParameter("price")));
		dto.setDelivery_price(Integer.parseInt(request.getParameter("delivery_price")));
		dto.setHas_delivery_fee(request.getParameter("has_delivery_fee"));
		dto.setBrand(request.getParameter("brand"));
		dto.setStock(Integer.parseInt(request.getParameter("stock")));
		
		return dto;
	}
	
	
}
