package project.bean.util;

import java.io.File;
import java.io.IOException;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.Part;

import project.bean.enums.ImgType;
import project.bean.img.ImgDTO;
import project.bean.product.ProductDAO;

public class ImageProcess {
	
	
	public static int insertImg(int product_num,Part part, HttpServletRequest request ) throws IOException {
		final String uploadPath =request.getRealPath("views/upload") ;
		int result = 0;
		
			ImgDTO imgDTO = new ImgDTO();
			ProductDAO dao = ProductDAO.getInstance();
			String uuid = String.valueOf(UUID.randomUUID()); 
			imgDTO.setProduct_num(product_num);
			imgDTO.setOriginal_name(part.getSubmittedFileName());
			if(imgDTO.getOriginal_name()!=null) {
		    	imgDTO.setExtension(imgDTO.getOriginal_name().substring(imgDTO.getOriginal_name().lastIndexOf("."))); // 예시로 고정된 확장자
			}
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
		    part.write(uploadPath+File.separator + imgDTO.getImg_name());
		    
		    result =  dao.saveImg(imgDTO);
		   
		    return result;
	}
	
	//이미지 삭제
	public static void deleteImg(String uploadPath, String imgName) {
		File fileToDelete = new File(uploadPath, imgName);
		if (fileToDelete.exists()) {
			fileToDelete.delete();
		}
		ProductDAO dao = ProductDAO.getInstance();
		dao.deleteImg(imgName);
	}
}
