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
import project.bean.util.Util;

@WebServlet("/productUpdate")
@MultipartConfig
public class ProductUpdateServlet extends HttpServlet {
	ProductDTO dto = new ProductDTO();
	ProductDAO dao = ProductDAO.getInstance();

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws IOException, ServletException {
		int uploadStatus = 0; // 이미지 저장 성공 여부 상태 성공 1, 실패 0
		String fileName = "";

		request.setCharacterEncoding("UTF-8");

		final String uploadPath = getServletContext().getRealPath("/views/upload");

		// 폴더가없다면 생성
		File filefolder = new File(uploadPath);
		if (!filefolder.exists()) {
			filefolder.mkdirs();
		}

		// 수정 정보 저장
		ProductDTO data = dto.setProductAdd(request);

		int result = dao.updateProduct(data);

		// 삭제 할 이미지 처리
		String totalImgNums = request.getParameter("deleteList");

		// 삭제할 이미지가 없으면 "" 로넘어옴
		if (!(totalImgNums.equals(""))) {
			String[] imgNums = totalImgNums.split(",");

			Integer[] convertImgNums = new Integer[imgNums.length];

			for (int i = 0; i < convertImgNums.length; i++) {
				convertImgNums[i] = Integer.parseInt(imgNums[i]);
			}

			for (int imgNum : convertImgNums) {

				String imgName = dao.getImgName(imgNum);
				ImageProcess.deleteImg(uploadPath, imgName);
			}
		}
		// 공백체크 -> continue -> 업로드 - > 썸네일 체크 - > 썸네일삭제
		// 이미지 저장
		for (Part part : request.getParts()) {
			fileName = ImageProcess.getFileName(part);

			// 파일이 공백이라면 continue
			if (Util.isEmpty(fileName)) {
				continue;
			}
			
			uploadStatus = ImageProcess.insertImg(uploadPath, data.getProduct_num(), part, request);
			if (part.getSize() > 0 && part.getName().equals("thumbnail")) {
				String thumbnail = dao.getThumbnail(data.getProduct_num());
				ImageProcess.deleteImg(uploadPath, thumbnail);
			}
		}

		// 모든 처리후 포워드로 이동
		request.setAttribute("uploadStatus", uploadStatus);
		request.setAttribute("result", result);
		RequestDispatcher dispatcher = request.getRequestDispatcher("/views/product/productUpdatePro.jsp");
		dispatcher.forward(request, response);
	}
}
