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

@WebServlet("/Join")
public class Join extends HttpServlet {
	
	private String id = null;
	private String pass = null;
	private String name = null;
	private String mobile = null;
	private String zipcode = null;
	private String addr1 = null;
	private String addr2 = null;
	private String gender = null;
	private String email = null;
	private String birth = null;
	
	private String result = "회원가입 success";
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		id = request.getParameter("id");
		pass = request.getParameter("pass");
		name = request.getParameter("name");
		mobile = request.getParameter("mobile");
		zipcode = request.getParameter("zipcode");
		addr1 = request.getParameter("addr1");
		addr2 = request.getParameter("addr2");
		gender = request.getParameter("gender");
		email = request.getParameter("email");
		birth = request.getParameter("birth");
		
		if(isNullEmpty(id)) {
			result = "회원 가입 에러";
			String nextUrl = "main.jsp?cmd=printJoin.jsp";
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
			
			sql = "insert into member_table "
					+ "(id, pass, level, name, mobile, "
					+ "zipcode, addr1, addr2, gender, email, "
					+ "birth, regdate, lastupdate) values "
					+ "(?, password(?), 1, ?, ?, "
					+ "?, ?, ?, ?, ?, "
					+ "?, now(), now() )";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pass);
			pstmt.setString(3, name);
			pstmt.setString(4, mobile);
			pstmt.setString(5, zipcode);
			pstmt.setString(6, addr1);
			pstmt.setString(7, addr2);
			pstmt.setString(8, gender);
			pstmt.setString(9, email);
			pstmt.setString(10, birth);
			
			int affect = pstmt.executeUpdate();
			
			if(affect < 1) {
				result = "회원가입 Query 에러";
			}
			
			System.out.println("[Join] PSTMT = "+pstmt);
			
		}catch(Exception e){
			System.out.println("[Join] Error : "+e.getMessage());
			result = "회원 분류 등록 에러 : "+e.getMessage();
		}finally {
			try {
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			}catch(Exception e) {}
		}
		
		String nextUrl = "main.jsp";
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
