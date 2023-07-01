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
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

@WebServlet("/UpdateMember")
public class UpdateMember extends HttpServlet {
	
	private String idx = null; 
	private String pass = null;
	private String pass2 = null;
	private String name = null;
	private String mobile = null;
	private String zipcode = null;
	private String addr1 = null;
	private String addr2 = null;
	private String gender = null;
	private String email = null;
	private String birth = null;
	private String level = null;
	private String from = null;  // mypage
	
	private HttpSession session;
	private String myid = null;
	
	private String result = "회원정보 변경 : Success";
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		session = request.getSession();
		myid = (String) session.getAttribute("sessID");
		
		idx = request.getParameter("idx");
		pass = request.getParameter("pass");
		pass2 = request.getParameter("pass2");
		name = request.getParameter("name");
		mobile = request.getParameter("mobile");
		zipcode = request.getParameter("zipcode");
		addr1 = request.getParameter("addr1");
		addr2 = request.getParameter("addr2");
		gender = request.getParameter("gender");
		email = request.getParameter("email");
		birth = request.getParameter("birth");
		level = request.getParameter("level");
		from = request.getParameter("from");
		
		if(isNullEmpty(idx) )
		{
			result = "회원정보변경 에러 : 필수정보 부족";
			String nextUrl = "main.jsp";
			
			request.setAttribute("result", result);
			request.setAttribute("nextUrl", nextUrl);
			
			RequestDispatcher rd = request.getRequestDispatcher("printResult.jsp");
			rd.forward(request, response);
		}
		
		if(isNullEmpty(pass) == false && pass.equals(pass2) == false )
		{
			result = "회원정보변경 에러 : 비밀번호 불일치";
			String nextUrl = "";
			if(isNullEmpty(from) == false) {
				nextUrl = "main.jsp?cmd=mypage.jsp?sub=3";
			}else {
				nextUrl = "main.jsp";
			}
			
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
			
			if(isNullEmpty(pass) == false)
			{
				if(isNullEmpty(from) == false && from.equals("mypage")) {
					sql = "update member_table set "
							+ "level=?, name=?, mobile=?, "
							+ "zipcode=?, addr1=?, addr2=?, "
							+ "gender=?, email=?, birth=?, "
							+ "lastupdate=now(), pass=password(?) "
							+ "where idx=? and id='"+myid+"' ";
				}else {
					sql = "update member_table set "
							+ "level=?, name=?, mobile=?, "
							+ "zipcode=?, addr1=?, addr2=?, "
							+ "gender=?, email=?, birth=?, "
							+ "lastupdate=now(), pass=password(?) "
							+ "where idx=?";
				}
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, level);
				pstmt.setString(2, name);
				pstmt.setString(3, mobile);
				pstmt.setString(4, zipcode);
				pstmt.setString(5, addr1);
				pstmt.setString(6, addr2);
				pstmt.setString(7, gender);
				pstmt.setString(8, email);
				pstmt.setString(9, birth);
				pstmt.setString(10, pass);
				pstmt.setString(11, idx);
			}else
			{
				if(isNullEmpty(from) == false && from.equals("mypage")) {
					sql = "update member_table set "
							+ "level=?, name=?, mobile=?, "
							+ "zipcode=?, addr1=?, addr2=?, "
							+ "gender=?, email=?, birth=?, "
							+ "lastupdate=now() "
							+ "where idx=? and id='"+myid+"' ";
				}else {
					sql = "update member_table set "
							+ "level=?, name=?, mobile=?, "
							+ "zipcode=?, addr1=?, addr2=?, "
							+ "gender=?, email=?, birth=?, "
							+ "lastupdate=now() "
							+ "where idx=?";
				}
				
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, level);
				pstmt.setString(2, name);
				pstmt.setString(3, mobile);
				pstmt.setString(4, zipcode);
				pstmt.setString(5, addr1);
				pstmt.setString(6, addr2);
				pstmt.setString(7, gender);
				pstmt.setString(8, email);
				pstmt.setString(9, birth);
				pstmt.setString(10, idx);
			}
			
			int affect = pstmt.executeUpdate();
			if(affect <1) {
				System.out.println("Affected Row Count = " + affect);
				result = "회원정보변경 Query 에러 ";
			}
			System.out.println("[UpdateMember] PSTMT = " + pstmt );
			
			
		}catch(Exception e)
		{
			System.out.println("[Join] Error : " + e.getMessage());
			result = "회원정보 에러 : " + e.getMessage();
		} finally
		{
			try {
				if(pstmt != null)
					pstmt.close();
				if(conn != null)
					conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		
		String nextUrl = "showMember.jsp?idx="+idx;
		
		if(isNullEmpty(from) == false && from.equals("mypage")) {
			nextUrl = "main.jsp?cmd=mypage.jsp?sub=3";
		}
		
		request.setAttribute("result",result);
		request.setAttribute("nextUrl",nextUrl);
		
		RequestDispatcher rd = request.getRequestDispatcher("printResult.jsp");
		rd.forward(request, response);
	}

	public boolean isNullEmpty(String str)
	{
		if(str == null)
			return true;
		
		if(str.equals(""))
			return true;
		
		return false;
	}
	

}
