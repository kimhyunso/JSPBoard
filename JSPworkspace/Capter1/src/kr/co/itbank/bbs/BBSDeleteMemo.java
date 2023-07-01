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

@WebServlet("/BBSDeleteMemo")
public class BBSDeleteMemo extends HttpServlet {
	
	private String midx = null;
	private String bid = null;
	private String bidx = null;
	private HttpSession session = null;
	private String id = null;
	private String name = null;
	private String role = null;
	private String result = "댓글 삭제 success";
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doPost(request, response);
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		session = request.getSession();
		
		id = (String)session.getAttribute("sessID");
		name = (String)session.getAttribute("sessName");
		role = (String)session.getAttribute("sessRole");
		
		midx = request.getParameter("midx");
		bid = request.getParameter("bid");
		bidx = request.getParameter("bidx");
		
		if(isNullEmpty(midx)) {
			
			result = "댓글 삭제 에러 : 필수정보 부족";
			String nextUrl = "main.jsp";
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
			
			if(isNullEmpty(role)) {
				sql = "delete from bbsmsg where midx = ? and id = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, midx);
				pstmt.setString(2, id);
			}else {
				sql = "delete from bbsmsg where midx = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, midx);
			}
			
			int affect = pstmt.executeUpdate();
			
			if(affect < 1) {
				result = "등록 Query 에러";
			}
			
			System.out.println("[BBSDeleteMemo] PSTMT = "+pstmt);
			
		}catch(Exception e){
			System.out.println("[BBSDeleteMemo] Error : "+e.getMessage());
			result = "댓글 등록 에러 : "+e.getMessage();
		}finally {
			try {
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			}catch(Exception e) {}
		}
		
		String nextUrl = "main.jsp?cmd=bbsView?bid="+bid+"&idx="+bidx;
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
