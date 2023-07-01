

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Calculator")
public class Calculator extends HttpServlet {
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8");
		// 이 코드는 반드시 <html> 태그 전에 써져 있어야 한다.
		
		int num1 = Integer.parseInt(request.getParameter("num1"));
		int num2 = Integer.parseInt(request.getParameter("num2"));		
		
		int plus = num1 + num2;
		int minus = num1 - num2;
		int product = num1 * num2;
		double divide = (double)num1 / num2;
		
		request.setAttribute("num1",num1);
		request.setAttribute("num2",num2);
		request.setAttribute("plusResult",plus);
		request.setAttribute("minusResult",minus);
		request.setAttribute("productResult",product);
		request.setAttribute("divideResult",divide);
		
		RequestDispatcher rd = request.getRequestDispatcher("numberResult.jsp");
		rd.forward(request, response);
	}

}
