

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/AddNumber2")
public class AddNumber2 extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8");
		// 이 코드는 반드시 <html> 태그 전에 써져 있어야 한다.
		
		int num1 = Integer.parseInt(request.getParameter("num1"));
		int num2 = Integer.parseInt(request.getParameter("num2"));		
		int sum = num1 + num2;
		
		PrintWriter out = response.getWriter();
		out.print("<!doctype html>"
				+ "<head><meta charset=utf-8></head>"
				+ "<html>"
				+ "<body>");
		
		out.print("포스트 방식의 더하기 입니다.<br>");
		out.print(num1+" + "+num2+" = "+sum+"<br>");
		
				
		out.print("</body>"
				+ "</html>");
	}

}
