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

import project.bean.util.ImageProcess;
@WebServlet("/productUpdate")
@MultipartConfig
public class ProductUpdateServlet  extends HttpServlet{
	ProductDTO dto  = new ProductDTO();
	ProductDAO dao = ProductDAO.getInstance();
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException, ServletException{
			request.setCharacterEncoding("UTF-8");
		
			final String uploadPath =request.getRealPath("views/upload") ;
		
			int uploadStatus = 0;
			String fileName="";
			
			// 수정 정보 저장
			ProductDTO data =  dto.setProductAdd(request);
			int result = dao.updateProduct(data);

			// 기존 썸네일 제거
			String thumbnail = dao.getThumbnail(data.getProduct_num());
			if(!(thumbnail.equals(""))) {
				ImageProcess.deleteImg(uploadPath, thumbnail);
				
			}
			
			
			// 폴더가없다면 생성
			File filefolder = new File(uploadPath);
			if(!filefolder.exists()) {
				filefolder.mkdirs();
			}
			
			// 삭제 할 이미지 처리
			String totalImgNums = request.getParameter("deleteList");
			if(!totalImgNums.equals("")) {
				String[] imgNums = totalImgNums.split(",");
				
				Integer[] convertImgNums = new Integer[imgNums.length];
				for(int i = 0; i<convertImgNums.length; i++) {
					convertImgNums[i] = Integer.parseInt(imgNums[i]);
				}
				for(int imgNum : convertImgNums) {
					
					String imgName = dao.getImgName(imgNum);
					ImageProcess.deleteImg(uploadPath, imgName);
				}
			}	
			
			// 이미지 저장
			for(Part part : request.getParts()) {
				fileName = getFileName(part);
				
				if(!("".equals(fileName))) {// ""일반 파라미터 ""가아니면 파일
					uploadStatus = ImageProcess.insertImg(data.getProduct_num(), part, request);
				}
			}
			
			// 모든 처리후 포워드로 이동
			request.setAttribute("uploadStatus", uploadStatus);
			request.setAttribute("result", result);
			RequestDispatcher dispatcher = request.getRequestDispatcher("/views/product/productUpdatePro.jsp");
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
