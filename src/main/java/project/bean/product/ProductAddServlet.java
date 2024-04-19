package project.bean.product;

import java.io.File;
import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.MultipartConfig;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.Part;

import project.bean.util.ImgSave;

@WebServlet("/productAdd")
@MultipartConfig
public class ProductAddServlet extends HttpServlet{
	ProductDTO dto  = new ProductDTO();
	ProductDAO dao = ProductDAO.getInstance();
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
			String uploadPath ="C:/Program Files/sung/upload" ;
			int uploadStatus = 0;
			File filefolder = new File(uploadPath);
			if(!filefolder.exists()) {
				filefolder.mkdirs();
			}
			
			request.setCharacterEncoding("UTF-8");
			ProductDTO data =  dto.setProductAdd(request);
			int product_num = dao.saveProduct(data);
			String fileName="";
			
			for(Part part : request.getParts()) {
				fileName = getFileName(part);
				
				
				if(!("".equals(fileName))) {
					uploadStatus = ImgSave.insertImg(product_num, part, fileName);
					part.write(uploadPath+File.separator + fileName);
				}
			}
			request.setAttribute("uploadStatus", uploadStatus);
			response.sendRedirect("/project/views/product/productInsertPro.jsp");
			
	}
	
	private String getFileName(Part part) {
		String fileName  = "";
		String contentDispostion = part.getHeader("content-disposition");
		String[] items = contentDispostion.split(";");
		
		for(String item : items) {
			if(item.trim().startsWith("filename")){//대부분의 브라우저에서는 파일 이름을 filename 이라는 문자열과 함께 content-disposition 헤더에 포함시킴
				fileName = item.substring(item.indexOf("=")+2, item.length() -1);
				
			}
		}
		
		return fileName;
	}
}








