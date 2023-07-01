package kr.co.itbank.bbs;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

@WebServlet("/Logout")
public class Logout extends HttpServlet {
	
	private HttpSession session = null;
	private String ip = null;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		session = request.getSession();
		ip = request.getRemoteAddr();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Context initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource) envContext.lookup("jdbc/Capter1");
			conn = ds.getConnection();
			
			String sql;
			
			sql = "insert into log (title, id, name, time, ip) values (?, ?, ?, now(), ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "[ Logout ] "+(String)session.getAttribute("sessID")+", "+(String)session.getAttribute("sessName"));
			pstmt.setString(2, (String)session.getAttribute("sessID"));
			pstmt.setString(3, (String)session.getAttribute("sessName"));
			pstmt.setString(4, ip);
			
			System.out.println("[Logout] PSTMT " +pstmt);
			int effected = pstmt.executeUpdate();
			
			
			
		}catch(Exception e){
			System.out.println("[Logout] Error : "+e.getMessage());
		}finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			}catch(Exception e) {}
		}
		
		
		session.removeAttribute("sessID");
		session.removeAttribute("sessName");
		session.removeAttribute("sessLevel");
		session.removeAttribute("sessRole");
		request.setAttribute("result", "안녕히 가세요");
		request.setAttribute("nextUrl", "main.jsp");
		RequestDispatcher rd = request.getRequestDispatcher("printResult.jsp");
		rd.forward(request, response);
	}
	
	
	public boolean isNullEmpty(String str) {
		if(str == null) {
			return true;
		}
		
		if(str.equals("")) {
			return true;
		}
		
		return false;
	}


}
