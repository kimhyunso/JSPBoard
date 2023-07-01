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

@WebServlet("/BBSUpdateMember")
public class BBSUpdateMember extends HttpServlet {
	
	private String title = null;
	private String level = null;
	private String useflag = null;
	private String isadmin = null;
	private String isdev = null;
	private String idx = null;
	private String result = "회원 분류 변경 success";
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		title = request.getParameter("title");
		level = request.getParameter("level");
		useflag = request.getParameter("useflag");
		isadmin = request.getParameter("isadmin");
		isdev = request.getParameter("isdev");
		idx = request.getParameter("idx");
		
		if(isNullEmpty(isdev)) {
			isdev = "0";
		}
		
		if(isNullEmpty(idx)) {
			
			result = "회원 분류 변경 에러 : 필수정보 부족";
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
			
			sql = "update leveltable set title=?, level=?, useflag=?, isadmin=?, isdev=? where idx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, level);
			pstmt.setString(3, useflag);
			pstmt.setString(4, isadmin);
			pstmt.setString(5, isdev);
			pstmt.setString(6, idx);
			int affect = pstmt.executeUpdate();
			
			if(affect < 1) {
				result = "등록 Query 에러";
			}
			
			System.out.println("[BBSUpdateMember] PSTMT = "+pstmt);
			
		}catch(Exception e){
			System.out.println("[BBSUpdateMember] Error : "+e.getMessage());
			result = "회원 분류 변경 에러 : "+e.getMessage();
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
