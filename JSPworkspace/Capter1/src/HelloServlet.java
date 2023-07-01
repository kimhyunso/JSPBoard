

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/HelloServlet")
public class HelloServlet extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8");
		// 이 코드는 반드시 <html> 태그 전에 써져 있어야 한다.
		
		PrintWriter out = response.getWriter();
		out.print("<!doctype html>"
				+ "<head><meta charset=utf-8></head>"
				+ "<html>"
				+ "<body>");
		
		
		out.print("Hello Servlet World<br>");
		
		int sum = 0;
		for(int i=1; i<=10; i++) {
			out.print("현재 값 : " +i+ "<br>");
			sum+=i;
		}
		
		out.print("합계 = "+sum);
		
		out.print("</body>"
				+ "</html>");
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
