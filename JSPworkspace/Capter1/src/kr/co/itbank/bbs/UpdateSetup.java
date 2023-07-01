package kr.co.itbank.bbs;

import java.io.File;
import java.io.IOException;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.Enumeration;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("/UpdateSetup")
public class UpdateSetup extends HttpServlet {
	
	private String privacy = null;
	private String rule = null;
	private String css = null;
	private String siteinfo = null;
	private String resultMsg = "설정 변경 success";
	private String delFile1 = null;
	
	private String bbs1 = null;
	private String bbs2 = null;
	private String bbs3 = null;
	private String bbs4 = null;
	private String bbs5 = null;
	private String bbs6 = null;
	private String bbs7 = null;
	private String bbs8 = null;
	private String bbs9 = null;
	private String bbs10 = null;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//response.setContentType("text/html; charset=utf-8"); 
		
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		String savePath = "ch02/upload/setup";
		String uploadFilePath = getServletContext().getRealPath(savePath);
		System.out.println("[UpdateSetup] uploadFilePath = " + uploadFilePath);
		
		int uploadFileSizeLimit = 50 * 1024 * 1024;
		String encType = "utf-8";
		
		MultipartRequest multi = new MultipartRequest(
									request,
									uploadFilePath,
									uploadFileSizeLimit,
									encType,
									new DefaultFileRenamePolicy()
								);
		
		
		Enumeration<?> params = multi.getParameterNames();
		
		while(params.hasMoreElements()) {
			String tmpName = null;
			String tmpValue = null;
			
			tmpName = (String)params.nextElement();
			
			if(tmpName.equals("privacy")) privacy = multi.getParameter(tmpName);
			if(tmpName.equals("rule")) rule = multi.getParameter(tmpName);
			if(tmpName.equals("siteinfo")) siteinfo = multi.getParameter(tmpName);
			if(tmpName.equals("css")) css = multi.getParameter(tmpName);
			if(tmpName.equals("delFile1")) delFile1 = multi.getParameter(tmpName);
			if(tmpName.equals("bbs1")) bbs1 = multi.getParameter(tmpName);
			if(tmpName.equals("bbs2")) bbs2 = multi.getParameter(tmpName);
			if(tmpName.equals("bbs3")) bbs3 = multi.getParameter(tmpName);
			if(tmpName.equals("bbs4")) bbs4 = multi.getParameter(tmpName);
			if(tmpName.equals("bbs5")) bbs5 = multi.getParameter(tmpName);
			if(tmpName.equals("bbs6")) bbs6 = multi.getParameter(tmpName);
			if(tmpName.equals("bbs7")) bbs7 = multi.getParameter(tmpName);
			if(tmpName.equals("bbs8")) bbs8 = multi.getParameter(tmpName);
			if(tmpName.equals("bbs9")) bbs9 = multi.getParameter(tmpName);
			if(tmpName.equals("bbs10")) bbs10 = multi.getParameter(tmpName);
			//DB 추가될  때 마다, 이곳에 추가한다.
		}
		
		String serverFileName1 = multi.getFilesystemName("upfile1");
		String originalFileName1 = multi.getOriginalFileName("upfile1");
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Context initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource) envContext.lookup("jdbc/Capter1");
			
			conn = ds.getConnection();
			String sql = null;
			//원본 데이터를 가져와서, 파일을 삭제해야하는 경우, 원본을 지워야함.
			sql="select * from setup";
			pstmt = conn.prepareStatement(sql);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				System.out.println("ok Data");
			}
			
			if(isNullEmpty(delFile1) == true) {
				delFile1 = "";
			}
			
			boolean delFlag1 = false;
			
			//DB에 FILE이 있고, 삭제 CHECK버튼을 눌렀을 경우..
			if(isNullEmpty(rs.getString("logo")) == false && isNullEmpty(delFile1) == false) {
				delFlag1 = true;
			}
			
			//DB에 데이터가 있고, 삭제 CHECK버튼이 안눌렸을 경우..
			if(isNullEmpty(rs.getString("logo")) == false && isNullEmpty(delFile1) == true) {
				if(isNullEmpty(serverFileName1) == false) { //업로드 된 경우 삭제
					delFlag1 = true;
				}else {
					//원본 파일을 그대로 사용..
					serverFileName1 = rs.getString("logo");
				}
			}
			
			if(delFlag1 == true) {
				String fileName = rs.getString("logo");
				String fn = uploadFilePath + "/" + fileName;
				
				File f = new File(fn);
				if(f.exists()) {
					f.delete();
				}
			}
			
			sql = "update setup set "
					+ "privacy=?, rule=?, siteinfo=?, css=?, bbs1=?, "
					+ "bbs2=?, bbs3=?, bbs4=?, bbs5=?, bbs6=?, "
					+ "bbs7=?, bbs8=?, bbs9=?, bbs10=?, logo=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, privacy);
			pstmt.setString(2, rule);
			pstmt.setString(3, siteinfo);
			pstmt.setString(4, css);
			pstmt.setString(5, bbs1);
			pstmt.setString(6, bbs2);
			pstmt.setString(7, bbs3);
			pstmt.setString(8, bbs4);
			pstmt.setString(9, bbs5);
			pstmt.setString(10, bbs6);
			pstmt.setString(11, bbs7);
			pstmt.setString(12, bbs8);
			pstmt.setString(13, bbs9);
			pstmt.setString(14, bbs10);
			pstmt.setString(15, serverFileName1);

			
			System.out.println("[UpdateSetup] PSTMT = "+pstmt);
			
			int affectedRow = 0;
			affectedRow = pstmt.executeUpdate();
			
			if(affectedRow != 1) {
				resultMsg = "설정정보 변경" + " update query Error !";
			}
			
		}catch(Exception e){
			System.out.println("[UpdateSetup] Error : "+e.getMessage());
		}finally {
			try {
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			}catch(Exception e) {}
		}
		
		String nextUrl = "main.jsp?cmd=manSetup.jsp?sub=1";
		request.setAttribute("result", resultMsg);
		request.setAttribute("nextUrl", nextUrl);
		
		delFile1 = null;
		
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
