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

@WebServlet("/BBSInsertCategroy")
public class BBSInsertCategroy extends HttpServlet {
	
	private String title = null;
	private String odr = null;
	private String useflag = null;
	
	private String result = "분류 등록 success";
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		title = request.getParameter("title");
		odr = request.getParameter("odr");
		useflag = request.getParameter("useflag");
		
		if(isNullEmpty(title)) {
			
			result = "게시판 분류 등록 에러 : 필수정보 부족";
			String nextUrl = "main.jsp?cmd=manBBS.jsp?sub=2";
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
			
			sql = "insert into bbscat (title, odr, useflag) values (?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, odr);
			pstmt.setString(3, useflag);
			int affect = pstmt.executeUpdate();
			
			if(affect < 1) {
				result = "등록 Query 에러";
			}
			
			System.out.println("[BBSInsertCategroy] PSTMT = "+pstmt);
			
		}catch(Exception e){
			System.out.println("[BBSInsertCategroy] Error : "+e.getMessage());
			result = "분류 등록 에러 : "+e.getMessage();
		}finally {
			try {
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			}catch(Exception e) {}
		}
		
		String nextUrl = "main.jsp?cmd=manBBS.jsp?sub=2";
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
