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
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import com.oreilly.servlet.MultipartRequest;
import com.oreilly.servlet.multipart.DefaultFileRenamePolicy;

@WebServlet("/InsertBanner")
public class InsertBanner extends HttpServlet {

	
	private String title = null;
	private String pos = null;
	private String odr = null;
	private String day = null;
	private String url = null;
	private String useflag = null;
	
	private String ip = null;
	private String resultMsg = "success";
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//response.setContentType("text/html; charset=utf-8");
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		// 이 코드는 반드시 <html> 태그 전에 써 있어야 한다.
		// 한글 깨짐 방지 위해서 항상 다음 두 줄은 추가해야 한다.
		HttpSession session  = request.getSession();
		ip = request.getRemoteAddr();
		
		String savePath = "ch02/upload/banner";
		String uploadFilePath = getServletContext().getRealPath(savePath);
		System.out.println("[InsertBanner] uploadFilePath = " + uploadFilePath);
		
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
			
			if(tempName.equals("title")) title = multi.getParameter(tempName);
			if(tempName.equals("pos"))	pos = multi.getParameter(tempName);
			if(tempName.equals("odr"))	odr = multi.getParameter(tempName);
			if(tempName.equals("day")) day = multi.getParameter(tempName);
			if(tempName.equals("url")) url = multi.getParameter(tempName);
			if(tempName.equals("useflag"))	useflag = multi.getParameter(tempName);
		}
		
		String serverFileName1 = multi.getFilesystemName("upfile1");
		String originalFileName1 = multi.getOriginalFileName("upfile1");
		
		Connection conn = null;
		PreparedStatement pstmt = null;
				
		try {
			Context initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource) envContext.lookup("jdbc/Capter1");
			ResultSet rs = null;
			
			conn = ds.getConnection();
			
			String sql = "insert into banner (title, pos, odr, day, useflag, url, file) "
					+ "values (?, ?, ?, ?, ?, ?, ?) ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, pos);
			pstmt.setString(3, odr);
			pstmt.setString(4, day);
			pstmt.setString(5, useflag);
			pstmt.setString(6, url);
			pstmt.setString(7, serverFileName1);
			
			System.out.println("[InsertBanner] PSTMT = " + pstmt );
			
			int affectedRow = 0;
			affectedRow = pstmt.executeUpdate();
			
			if(affectedRow != 1)
			{
				resultMsg = resultMsg + " insert query Error !!";
			}

		}catch(Exception e)
		{
			System.out.println("[InsertBanner] Error : " + e.getMessage());
		} finally
		{
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {}
		}
		
		if(resultMsg.equals("success"))
		{
			resultMsg = "배너가 등록되었습니다.";
		}
		
		String nextUrl = "main.jsp?cmd=manBanner.jsp";
		request.setAttribute("result", resultMsg);
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
