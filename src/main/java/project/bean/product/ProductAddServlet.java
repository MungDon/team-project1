package project.bean.product;

import java.io.File;
import java.io.IOException;

import javax.servlet.RequestDispatcher;
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
			final String uploadPath =request.getRealPath("views/upload") ;
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
				
				
				if(!("".equals(fileName))) {// ""일반 파라미터 ""가아니면 파일
					uploadStatus = ImgSave.insertImg(product_num, part, request);
					
					
				}
			}
	
			request.setAttribute("uploadStatus", uploadStatus);
			
			RequestDispatcher dispatcher = request.getRequestDispatcher("/views/product/productInsertPro.jsp");
			dispatcher.forward(request, response);
	}
	
	// 이미지 파일인것만 걸러주는 메서드
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









