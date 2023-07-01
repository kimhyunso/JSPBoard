package kr.co.itbank.bbs;

import java.io.File;
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

@WebServlet("/BBSDelete")
public class BBSDelete extends HttpServlet {
	
	private String didx = null;
	private String bid = null;
	private String result = "success";
	private HttpSession session = null;
	private String ip = null; 
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		didx = request.getParameter("didx");
		bid = request.getParameter("bid");
		
		session = request.getSession();
		ip = request.getRemoteAddr();
		
		if(isNullEmpty(didx)) {
			RequestDispatcher rd = request.getRequestDispatcher("main.jsp");
			rd.forward(request, response);
		}
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Context initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource) envContext.lookup("jdbc/Capter1");
			
			conn = ds.getConnection();
			String sql;
			
			sql = "select * from bbs where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, didx);
			rs = pstmt.executeQuery();
			
			System.out.println("[BBSDelete] PSTMT = "+pstmt);
			// 원본데이터에 파일이 있는가?
			if(rs.next()) {
				String savePath = "ch02/upload/bbs";
				String uploadFilePath = getServletContext().getRealPath(savePath);
				System.out.println("[BBSDelete] "+uploadFilePath);
				if(isNullEmpty(rs.getString("file1")) == false) {
					String fileName = rs.getString("file1");
					String fn = uploadFilePath + "/" + fileName;
					
					File f = new File(fn);
					if(f.exists()) {
						f.delete();
					}
				}
				
				if(isNullEmpty(rs.getString("file2")) == false) {
					String fileName = rs.getString("file2");
					String fn = uploadFilePath + "/" + fileName;
					
					File f = new File(fn);
					if(f.exists()) {
						f.delete();
					}
				}
				
			}
			
			
			sql = "select * from bbs where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, didx);
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				sql = "insert into log (title, id, name, time, ip) values (?, ?, ?, now(), ?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, rs.getString("title")+" [ 글삭제 ] "+(String)session.getAttribute("sessID")+", "+(String)session.getAttribute("sessName"));
				pstmt.setString(2, (String)session.getAttribute("sessID"));
				pstmt.setString(3, (String)session.getAttribute("sessName"));
				pstmt.setString(4, ip);
				
				int effected = pstmt.executeUpdate();
			}
			
			
			
			sql = "delete from bbs where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, didx);
			System.out.println("[BBSDelete] "+pstmt);
			int affect = pstmt.executeUpdate();
			
			
		}catch(Exception e){
			System.out.println("[BBSDelet] Error : "+e.getMessage());
			result = "글 삭제 에러"+e.getMessage();
		}finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			}catch(Exception e) {}
		}
		
		String nextUrl="main.jsp?cmd=bbsList?bid="+bid;
		request.setAttribute("result", result);
		request.setAttribute("nextUrl", nextUrl);
		bid = null;
		
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

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doGet(request, response);
	}

}
