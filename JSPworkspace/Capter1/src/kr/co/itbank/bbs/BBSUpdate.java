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
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("/BBSUpdate")
public class BBSUpdate extends HttpServlet {
	
	private String title = null;
	private String writer = null;
	private String html = null;
	private String html2 = null;
	private String file1 = null;
	private String file2 = null;
	private String resultMsg = "success";
	private String uidx = null;
	private String delFile1 = null;
	private String delFile2 = null;
	private String bid = null;
	private String notice = null;
	private String nall = null;
	private String head = null;
	private HttpSession session = null;
	private String ip = null;
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		//response.setContentType("text/html; charset=utf-8"); 
		
		response.setCharacterEncoding("UTF-8");
		request.setCharacterEncoding("UTF-8");
		
		session = request.getSession();
		ip = request.getRemoteAddr();
		
		String savePath = "ch02/upload/bbs";
		String uploadFilePath = getServletContext().getRealPath(savePath);
		System.out.println("[BBSUpdate] uploadFilePath = " + uploadFilePath);
		
		int uploadFileSizeLimit = 50 * 1024 * 1024;
		String encType = "utf-8";
		
		MultipartRequest multi = new MultipartRequest(
									request,
									uploadFilePath,
									uploadFileSizeLimit,
									encType,
									new DefaultFileRenamePolicy()
								);
		
		
		Enumeration params = multi.getParameterNames();
		
		while(params.hasMoreElements()) {
			String tmpName = null;
			String tmpValue = null;
			
			tmpName = (String)params.nextElement();
			
			if(tmpName.equals("title")) title = multi.getParameter(tmpName);
			if(tmpName.equals("writer")) writer = multi.getParameter(tmpName);
			if(tmpName.equals("html")) html = multi.getParameter(tmpName);
			if(tmpName.equals("html2")) html2 = multi.getParameter(tmpName);
			if(tmpName.equals("uidx")) uidx = multi.getParameter(tmpName);
			if(tmpName.equals("delFile1")) delFile1 = multi.getParameter(tmpName);
			if(tmpName.equals("delFile2")) delFile2 = multi.getParameter(tmpName);
			if(tmpName.equals("bid")) bid = multi.getParameter(tmpName);
			if(tmpName.equals("notice"))notice = multi.getParameter(tmpName);
			if(tmpName.equals("nall"))nall = multi.getParameter(tmpName);
			if(tmpName.equals("head"))head = multi.getParameter(tmpName);
			
			//DB 추가될  때 마다, 이곳에 추가한다.
		}
		
		
		if(isNullEmpty(notice))
			notice = "0";
		else
			notice = "1";
		
		if(isNullEmpty(nall))
			nall = "0";
		else
			nall = "1";
		
		if(isNullEmpty(title)) title = "No Title";
		if(isNullEmpty(uidx)) {
			RequestDispatcher rd = request.getRequestDispatcher("main.jsp");
			rd.forward(request, response);
		}
		
		String serverFileName1 = multi.getFilesystemName("upfile1");
		String originalFileName1 = multi.getOriginalFileName("upfile1");
		String serverFileName2 = multi.getFilesystemName("upfile2");
		String originalFileName2 = multi.getOriginalFileName("upfile2");
		
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		
		try {
			Context initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource) envContext.lookup("jdbc/Capter1");
			
			conn = ds.getConnection();
			String sql = null;
			//원본 데이터를 가져와서, 파일을 삭제해야하는 경우, 원본을 지워야함.
			sql="select * from bbs where idx = ? ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, uidx);
			ResultSet rs = pstmt.executeQuery();
			
			if(rs.next()) {
				System.out.println("[BBSUpdate] title = "+rs.getString("title"));
			}
			
			if(isNullEmpty(delFile1) == true) {
				delFile1 = "";
			}
			
			if(isNullEmpty(delFile2) == true) {
				delFile2 = "";
			}
			
			boolean delFlag1 = false;
			boolean delFlag2 = false;
			
			//DB에 FILE이 있고, 삭제 CHECK버튼을 눌렀을 경우..
			if(isNullEmpty(rs.getString("file1")) == false && isNullEmpty(delFile1) == false) {
				delFlag1 = true;
			}
			
			//DB에 데이터가 있고, 삭제 CHECK버튼이 안눌렸을 경우..
			if(isNullEmpty(rs.getString("file1")) == false && isNullEmpty(delFile1) == true) {
				if(isNullEmpty(serverFileName1) == false) { //업로드 된 경우 삭제
					delFlag1 = true;
				}else {
					//원본 파일을 그대로 사용..
					serverFileName1 = rs.getString("file1");
				}
			}
			
			//DB에 FILE이 있고, 삭제 CHECK버튼을 눌렀을 경우..
			if(isNullEmpty(rs.getString("file2")) == false && isNullEmpty(delFile2) == false) {
				delFlag2 = true;
			}
			
			//DB에 데이터가 있고, 삭제 CHECK버튼이 안눌렸을 경우..
			if(isNullEmpty(rs.getString("file2")) == false && isNullEmpty(delFile2) == true) {
				if(isNullEmpty(serverFileName2) == false) { //업로드 된 경우 삭제
					delFlag2 = true;
				}else {
					//원본 파일을 그대로 사용..
					serverFileName2 = rs.getString("file2");
				}
			}
			
			if(delFlag1 == true) {
				String fileName = rs.getString("file1");
				String fn = uploadFilePath + "/" + fileName;
				
				File f = new File(fn);
				if(f.exists()) {
					f.delete();
				}
			}
			
			if(delFlag2 == true) {
				String fileName = rs.getString("file2");
				String fn = uploadFilePath + "/" + fileName;
				
				File f = new File(fn);
				if(f.exists()) {
					f.delete();
				}
				
			}
			
			html2 = html2.replaceAll("script", "S C R I P T NotAllowed");
			html2 = html2.replaceAll("function", "F U N C T I O N NotAllowed");
			html2 = html2.replaceAll("location", "L O C A T I O N NotAllowed");
			html2 = html2.replaceAll(";",":");
			html2 = html2.replaceAll("window", "W I N D O W NotAllowed");
			
			html2 = html2.replaceAll("a href", "a target='_blank' href");
			
			sql = "update bbs set title=?, html=?, file1=?, file2=?, writer=?, notice=?, nall=?, head=?, html2=? where idx = ?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, html);
			pstmt.setString(3, serverFileName1);
			pstmt.setString(4, serverFileName2);
			pstmt.setString(5, writer);
			pstmt.setString(6, notice);
			pstmt.setString(7, nall);
			pstmt.setString(8, head);
			pstmt.setString(9, html2);
			pstmt.setString(10, uidx);
			
			
			System.out.println("[BBSUpdate] PSTMT = "+pstmt);
			
			int affectedRow = 0;
			affectedRow = pstmt.executeUpdate();
			
			
			sql = "insert into log (title, id, name, time, ip) values (?, ?, ?, now(), ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, "[ 글수정 ] "+(String)session.getAttribute("sessID")+", "+(String)session.getAttribute("sessName"));
			pstmt.setString(2, (String)session.getAttribute("sessID"));
			pstmt.setString(3, (String)session.getAttribute("sessName"));
			pstmt.setString(4, ip);
			
			int effected = pstmt.executeUpdate();
			
			if(affectedRow != 1) {
				resultMsg = resultMsg + " update query Error !";
			}
			
		}catch(Exception e){
			System.out.println("[BBSUpdate] Error : "+e.getMessage());
		}finally {
			try {
				if(pstmt!=null) pstmt.close();
				if(conn!=null) conn.close();
			}catch(Exception e) {}
		}
		
		String nextUrl = "main.jsp?cmd=bbsList?bid="+bid;
		request.setAttribute("result", resultMsg);
		request.setAttribute("nextUrl", nextUrl);
		
		notice = null;
		nall = null;
		delFile1 = null;
		delFile2 = null;
		
		RequestDispatcher rd = request.getRequestDispatcher("main.jsp?cmd=printResult.jsp");
		rd.forward(request, response);
	}
	
	public BBSItem readDB() {
		BBSItem bbsData = new BBSItem();
		
		return bbsData;
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
