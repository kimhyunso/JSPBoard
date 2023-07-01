package kr.co.itbank.bbs;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
	private HttpSession session = null;
	private String resultMsg = null;
	private String id = null;
	private String pass = null;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		session = request.getSession();
		id = request.getParameter("id");
		pass = request.getParameter("pass");
		
		doLogin();
		
		request.setAttribute("resultMsg", resultMsg);
		RequestDispatcher rd = request.getRequestDispatcher("main.jsp");
		rd.forward(request, response);
	}
	
	public void doLogin() {
		session.setAttribute("sessID", id);
		session.setAttribute("sessName", "관리자");
		
		resultMsg = (String)session.getAttribute("sessName")+"님 환영합니다.";
	}

}
