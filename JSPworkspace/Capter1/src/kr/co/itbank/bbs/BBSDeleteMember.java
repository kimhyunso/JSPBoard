package kr.co.itbank.bbs;

import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

@WebServlet("/BBSDeleteMember")
public class BBSDeleteMember extends HttpServlet {
	
	private String didx = null;
	private String result = "회원 분류 삭제 success";
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		didx = request.getParameter("didx");
		
		if(isNullEmpty(didx)) {
			
			result = "회원 분류 삭제 에러 : 필수정보 부족";
			String nextUrl = "main.jsp?cmd=manSetup.jsp?sub=2";
			request.setAttribute("result", result);
			request.setAttribute("nextUrl", nextUrl);
			RequestDispatcher rd = request.getRequestDispatcher("printResult.jsp");
			rd.forward(request, response);
		}
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Context initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource) envContext.lookup("jdbc/Capter1");
			
			conn = ds.getConnection();
			String sql;
			
			sql = "delete from leveltable where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, didx);
			int affect = pstmt.executeUpdate();
			
			if(affect < 1) {
				result = "삭제 Query 에러";
			}
			
			System.out.println("[BBSDeleteMember] PSTMT = "+pstmt);
			
		}catch(Exception e){
			System.out.println("[BBSDeleteMember] Error : "+e.getMessage());
			result = "회원 분류 삭제 에러 : "+e.getMessage();
		}finally {
			try {
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			}catch(Exception e) {}
		}
		
		String nextUrl = "main.jsp?cmd=manSetup.jsp?sub=2";
		request.setAttribute("result", result);
		request.setAttribute("nextUrl", nextUrl);
		
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
