package kr.co.itbank.bbs;

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

@WebServlet("/BBSInsertManager")
public class BBSInsertManager extends HttpServlet {

	private String cat = null;
	private String title = null;
	private String useflag = null;
	private String manager = null;
	
	private String odr = null;
	private String rlevel = null;
	private String wlevel = null;

	private String mwlevel = null;
	private String downlevel = null;
	private String heads = null;
	private String lpp = null;
	private String filecount = null;
	private String ext = null;
	private String css = null;
	private String cssno = null;
	private String csshead = null;
	private String csstitle = null;
	private String csswriter = null;
	private String cssfile = null;
	private String csstime = null;
	private String csshit = null;
	private String cssleft = null;
	private String cssright = null;
	private String wysiwyg = null;
	private String isdft = null;
	
	
	private String file1 = null;
	private String file2 = null;
	private String result = "게시판 분류 등록 success";
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//response.setContentType("text/html; charset=utf-8");
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		// 이 코드는 반드시 <html> 태그 전에 써 있어야 한다.
		// 한글 깨짐 방지 위해서 항상 다음 두 줄은 추가해야 한다.
		
		String savePath = "ch02/upload/bbslogo";
		String uploadFilePath = getServletContext().getRealPath(savePath);
		System.out.println("[BBSInsertManager] uploadFilePath = " + uploadFilePath);
		
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
		
		while(params.hasMoreElements())
		{
			String tempName = null;
			String tempValue = null;
			
			tempName = (String) params.nextElement();
			
			if(tempName.equals("cat")) cat = multi.getParameter(tempName);
			if(tempName.equals("title")) title = multi.getParameter(tempName);
			if(tempName.equals("useflag")) useflag = multi.getParameter(tempName);
			if(tempName.equals("manager")) manager = multi.getParameter(tempName);
			
			if(tempName.equals("odr")) odr = multi.getParameter(tempName);
			if(tempName.equals("rlevel")) rlevel = multi.getParameter(tempName);
			if(tempName.equals("wlevel")) wlevel = multi.getParameter(tempName);
			if(tempName.equals("mwlevel")) mwlevel = multi.getParameter(tempName);
			if(tempName.equals("downlevel")) downlevel = multi.getParameter(tempName);
			if(tempName.equals("heads")) heads = multi.getParameter(tempName);
			if(tempName.equals("lpp")) lpp = multi.getParameter(tempName);
			if(tempName.equals("filecount")) filecount = multi.getParameter(tempName);
			if(tempName.equals("ext")) ext = multi.getParameter(tempName);
			if(tempName.equals("css")) css = multi.getParameter(tempName);
			if(tempName.equals("cssno")) cssno = multi.getParameter(tempName);
			if(tempName.equals("csshead")) csshead = multi.getParameter(tempName);
			if(tempName.equals("csstitle")) csstitle = multi.getParameter(tempName);
			if(tempName.equals("csswriter")) csswriter = multi.getParameter(tempName);
			if(tempName.equals("cssfile")) cssfile = multi.getParameter(tempName);
			if(tempName.equals("csstime")) csstime = multi.getParameter(tempName);
			if(tempName.equals("csshit")) csshit = multi.getParameter(tempName);
			if(tempName.equals("cssleft")) cssleft = multi.getParameter(tempName);
			if(tempName.equals("cssright")) cssright = multi.getParameter(tempName);
			if(tempName.equals("wysiwyg")) wysiwyg = multi.getParameter(tempName);
			if(tempName.equals("isdft")) isdft = multi.getParameter(tempName);
			
				
			// DB추가될 때 마다, 이곳에 추가한다. 예 : 비밀글, 머릿글, 공지사항...
		
		}
		
		if(isNullEmpty(title)) title = "No Tilte";
		
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
			
			
			String sql = "insert into bbsmanager "
					+ "(cat, title, useflag, manager, odr, rlevel, wlevel, mwlevel, downlevel, heads, lpp, filecount, ext, css, cssno, csshead, csstitle, csswriter, cssfile, csstime, csshit, cssleft, cssright, uplogo, downlogo, wysiwyg, isdft) "
					+ "values (?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?, ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, cat);
			pstmt.setString(2, title);
			pstmt.setString(3, useflag);
			pstmt.setString(4,  manager);
			pstmt.setString(5,  odr);
			pstmt.setString(6,  rlevel);
			pstmt.setString(7,  wlevel);
			pstmt.setString(8,  mwlevel);
			pstmt.setString(9,  downlevel);
			pstmt.setString(10, heads);
			pstmt.setString(11, lpp);
			pstmt.setString(12, filecount);
			pstmt.setString(13, ext);
			pstmt.setString(14, css);
			pstmt.setString(15, cssno);
			pstmt.setString(16, csshead);
			pstmt.setString(17, csstitle);
			pstmt.setString(18, csswriter);
			pstmt.setString(19, cssfile);
			pstmt.setString(20, csstime);
			pstmt.setString(21, csshit);
			pstmt.setString(22, cssleft);
			pstmt.setString(23, cssright);
			pstmt.setString(24, serverFileName1);
			pstmt.setString(25, serverFileName2);
			pstmt.setString(26, wysiwyg);
			pstmt.setString(27, isdft);
			
			System.out.println("[BBSInsertManager] PSTMT = " + pstmt );
			
			int affectedRow = 0;
			affectedRow = pstmt.executeUpdate();
	
			if(affectedRow != 1)
			{
				result = "insert query Error !!";
			}

		}catch(Exception e)
		{
			System.out.println("[BBSInsertManager] Error : " + e.getMessage());
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
		
		String nextUrl = "main.jsp?cmd=manBBS.jsp?sub=3";
		request.setAttribute("result", result);
		request.setAttribute("nextUrl", nextUrl);
		
		RequestDispatcher rd = request.getRequestDispatcher("printResult.jsp");
		rd.forward(request, response);
	}
	
	public BBSItem readDB()
	{
		BBSItem bbsData = new BBSItem();
		return bbsData;
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
