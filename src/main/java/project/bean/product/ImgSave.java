package project.bean.product;

public class ImgSave {
	public void insertImg(int product_num, String original, String sysImgName,String imgType) {
		ImgDTO imgDTO = new ImgDTO();
		
		imgDTO.setProduct_num(product_num);
		imgDTO.setOriginal_name(original);
	    imgDTO.setImg_name(sysImgName);
	    imgDTO.setExtension(original.substring(original.lastIndexOf("."))); // 예시로 고정된 확장자
	    imgDTO.setImg_type(imgType); // 대표 이미지
	    
	    ProductDAO dao = ProductDAO.getInstance();
	    dao.saveImg(imgDTO);
	}
}
