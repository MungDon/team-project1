package project.bean.util;

import java.util.UUID;

import javax.servlet.http.Part;

import project.bean.enums.ImgType;
import project.bean.img.ImgDTO;
import project.bean.product.ProductDAO;

public class ImgSave {
	
	
	public static int insertImg(int product_num,Part part ,String fileName) {
		int result = 0;
		ImgDTO imgDTO = new ImgDTO();
		ProductDAO dao = ProductDAO.getInstance();
		String uuid = String.valueOf(UUID.randomUUID()); 
		imgDTO.setProduct_num(product_num);
		imgDTO.setOriginal_name(part.getSubmittedFileName());
	    imgDTO.setExtension(imgDTO.getOriginal_name().substring(imgDTO.getOriginal_name().lastIndexOf("."))); // 예시로 고정된 확장자
	    imgDTO.setImg_name(uuid+imgDTO.getExtension());

	    switch(part.getName()) {
	    	case "img" :
	    		imgDTO.setImg_type(ImgType.productImg.name());
	    		break;
	    	case "textImg":
	    		imgDTO.setImg_type(ImgType.textImg.name());
	    		break;
	    	case "thumbnail":
	    		imgDTO.setImg_type(ImgType.thumbnail.name());
	    		break;
	    }
	    result =  dao.saveImg(imgDTO);
	   
	    return result;
	  
	}
}
