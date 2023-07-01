

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;



@WebServlet("/UploadServlet")
public class UploadServlet extends HttpServlet {
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8");
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		
		PrintWriter out = response.getWriter();
		
		out.print("<!docType html>"
				+ "<html>"
				+ "<head><meta charset='utf-8'>"
				+ "<title>서블릿을 이용한 파일 업로드</title>"
				+ "</head>"
				+ "<body>");

		String savePath = "/ch01/upload";
		String uploadFilePath = getServletContext().getRealPath(savePath);
		System.out.println("uploadFilePath = " + uploadFilePath);
		
		int uploadFileSizeLimit = 50 * 1024 * 1024;
		String encType = "utf-8";
		
		MultipartRequest multi = new MultipartRequest(
				request,
				uploadFilePath,
				uploadFileSizeLimit,
				encType,
				new DefaultFileRenamePolicy()
			);
		
		String serverFileName = multi.getFilesystemName("upfile");
		String originalFileName = multi.getOriginalFileName("upfile");
		
		out.print("savePath = "+savePath+"<br>");
		out.print("uploadFilePath = "+uploadFilePath+"<br>");
		out.print("serverFileName = "+serverFileName+"<br>");
		out.print("originalFileName = "+originalFileName+"<br>");
		
		out.print("<img src=\"upload/"+serverFileName + "\"><br>");
		out.print("<a href='jsp17FileUpload.jsp'>이전화면</a>");
		
		
		out.print("</body>"
				+ "</html>");
		
	}

}
