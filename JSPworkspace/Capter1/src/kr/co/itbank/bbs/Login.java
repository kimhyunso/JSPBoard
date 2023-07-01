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

@WebServlet("/Login")
public class Login extends HttpServlet {
	
	private String id = null;
	private String pass = null;
	private String resultMsg = "";
	private HttpSession session = null;
	private String ip = null;
	
	@Override
	public void init() throws ServletException {
		// TODO Auto-generated method stub
		System.out.print("testse");
		super.init();
	}
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		id = request.getParameter("id");
		pass = request.getParameter("pass");
		session = request.getSession();
		ip = request.getRemoteAddr();
		
		doLogin();
		
		request.setAttribute("result",resultMsg);
		request.setAttribute("nextUrl", "main.jsp");
		
		RequestDispatcher rd = request.getRequestDispatcher("printResult.jsp");
		rd.forward(request, response);
	}
	
	public void doLoginTest() {
		
		if(isNullEmpty(id)) {
			resultMsg = "아이디를 확인하세요";
			return;
		}
		
		if(isNullEmpty(pass)) {
			resultMsg = "비밀번호를 확인하세요";
			return;
		}
		
		if(id.equals("admin") && pass.equals("1111")) {
			session.setAttribute("sessID",id);
			session.setAttribute("sessName", "관리자");
			session.setAttribute("sessLevel", "9");
			resultMsg = id + " 님 반갑습니다.";
			
		} else if(id.equals("test") && pass.equals("1111")) {
			session.setAttribute("sessID",id);
			session.setAttribute("sessName", "홍길동");
			session.setAttribute("sessLevel", "1");
			resultMsg = "홍길동 님 반갑습니다.";
		} else {
			resultMsg = "아이디와 비번을 확인하세요";
		}
		
	}
	
	
	
	public void doLogin() {
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Context initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource) envContext.lookup("jdbc/Capter1");
			
			conn = ds.getConnection();
			String sql = "select * from member_table where id = ? and pass = password(?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, pass);
			rs = pstmt.executeQuery();
			
			System.out.println("[Login] PSTMT = "+pstmt);
			
			int cnt = 0;
			System.out.println("[Login] 확인");
			
			
			
			if(rs.next()) {
				session.setAttribute("sessID", rs.getString("id"));
				session.setAttribute("sessName", rs.getString("name"));
				session.setAttribute("sessLevel", rs.getInt("level"));
				
				String loginName = rs.getString("name");
				
				sql = "select * from leveltable where level = ?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setInt(1, rs.getInt("level"));
				
				System.out.println("[PSTMT] = "+pstmt);
				rs = pstmt.executeQuery();
				
				if(rs.next()) {
					if(rs.getInt("isadmin") == 1) {
						session.setAttribute("sessRole", "admin");
					}
					
					if(rs.getInt("isdev") == 1) {
						session.setAttribute("sessRole", "dev");
					}
				}
				
				
				sql = "insert into log (title, id, name, time, ip) values (?, ?, ?, now(), ?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, "[ Login ] "+(String)session.getAttribute("sessID")+", "+(String)session.getAttribute("sessName"));
				pstmt.setString(2, (String)session.getAttribute("sessID"));
				pstmt.setString(3, (String)session.getAttribute("sessName"));
				pstmt.setString(4, ip);
				
				System.out.println("[Login] PSTMT " +pstmt);
				int effected = pstmt.executeUpdate();
				resultMsg = loginName + " 님 반갑습니다.";
			}else {
				
				resultMsg = "아이디와 비밀번호를 확인하세요.";
			}
			
		}catch(Exception e){
			System.out.println("[Login] Error : "+e.getMessage());
		}finally {
			try {
				if(rs!=null) rs.close();
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			}catch(Exception e) {}
		}
		
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
