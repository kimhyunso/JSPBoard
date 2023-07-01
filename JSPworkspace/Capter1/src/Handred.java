

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Handred")
public class Handred extends HttpServlet {
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8");
		// 이 코드는 반드시 <html> 태그 전에 써져 있어야 한다.
		int total = 0;
		
		for(int i=1; i<=100; i++) {
			total+=i;
		}
		
		request.setAttribute("total", total);
		
		RequestDispatcher rd = request.getRequestDispatcher("jsp02.jsp");
		rd.forward(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
