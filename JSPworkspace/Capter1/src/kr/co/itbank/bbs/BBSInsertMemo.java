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

@WebServlet("/BBSInsertMemo")
public class BBSInsertMemo extends HttpServlet {
	
	private String memo = null;
	private String bid = null;
	private String bidx = null;
	private HttpSession session = null;
	private String id = null;
	private String name = null;
	private String result = "메모 등록 success";
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		session = request.getSession();
		
		id = (String)session.getAttribute("sessID");
		name = (String)session.getAttribute("sessName");
		
		memo = request.getParameter("memo");
		bid = request.getParameter("bid");
		bidx = request.getParameter("bidx");
		
		if(isNullEmpty(bidx)) {
			
			result = "댓글 등록 에러 : 필수정보 부족";
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
			/*
			 *  RunConfiguration
			 *  -Djava.net.preferIPv4Stack=true
			 * 
			 * 
			 */
			String ip = request.getRemoteAddr();
			
			memo = memo.replaceAll("script", "S C R I P T NotAllowed");
			memo = memo.replaceAll("function", "F U N C T I O N NotAllowed");
			memo = memo.replaceAll("location", "L O C A T I O N NotAllowed");
			memo = memo.replaceAll(";",":");
			memo = memo.replaceAll("window", "W I N D O W NotAllowed");
			
			memo = memo.replaceAll("a href", "a target='_blank' href");
			
			sql = "insert into bbsmsg (bid, bidx, memo, id, name, time, ip) "
					+ "values (?, ?, ?, ?, ?, now(), ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bid);
			pstmt.setString(2, bidx);
			pstmt.setString(3, memo);
			pstmt.setString(4, id);
			pstmt.setString(5, name);
			pstmt.setString(6, ip);
			
			int affect = pstmt.executeUpdate();
			
			if(affect < 1) {
				result = "등록 Query 에러";
			}
			
			System.out.println("[BBSInsertMemo] PSTMT = "+pstmt);
			
		}catch(Exception e){
			System.out.println("[BBSInsertMemo] Error : "+e.getMessage());
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
