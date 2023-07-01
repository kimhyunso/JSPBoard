import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/CarServlet")
public class CarServlet extends HttpServlet {
      
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setContentType("text/html; charset=utf-8"); 
		
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		kr.co.itbank.network.Car taxi = new kr.co.itbank.network.Car();
		
		taxi.setColor("빨강");
		taxi.setSpeed(30);
		
		kr.co.itbank.network.Car bus = new kr.co.itbank.network.Car();
		
		bus.setColor("파랑");
		bus.setSpeed(50);
		
		request.setAttribute("TaxiInfo", taxi);
		request.setAttribute("BusInfo", bus);
		
		RequestDispatcher rd = request.getRequestDispatcher("sAction05.jsp");
		rd.forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
	}
}