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

@WebServlet("/BBSInsert")
public class BBSInsert extends HttpServlet {

	private String ridx = null;
	private String bid = null;
	private String notice = null;
	private String nall = null;
	private String head = null;
	private String id = null;
	
	private String title = null;
	private String writer = null;
	private String html = null;
	private String html2 = null;
	private String file1 = null;
	private String file2 = null;
	private String ip = null;
	private String resultMsg = "success";
	
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {

		//response.setContentType("text/html; charset=utf-8");
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		// 이 코드는 반드시 <html> 태그 전에 써 있어야 한다.
		// 한글 깨짐 방지 위해서 항상 다음 두 줄은 추가해야 한다.
		HttpSession session  = request.getSession();
		id = (String)session.getAttribute("sessID");
		
		ip = request.getRemoteAddr();
		
		String savePath = "ch02/upload/bbs";
		String uploadFilePath = getServletContext().getRealPath(savePath);
		System.out.println("[BBSInsert] uploadFilePath = " + uploadFilePath);
		
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
			if(tempName.equals("writer")) writer = multi.getParameter(tempName);
			if(tempName.equals("html"))	html = multi.getParameter(tempName);
			if(tempName.equals("html2")) html2 = multi.getParameter(tempName);
			if(tempName.equals("ridx"))	ridx = multi.getParameter(tempName);
			if(tempName.equals("bid"))	bid = multi.getParameter(tempName);
			if(tempName.equals("notice")) notice = multi.getParameter(tempName);
			if(tempName.equals("nall"))	nall = multi.getParameter(tempName);
			if(tempName.equals("head"))	head = multi.getParameter(tempName);
				
			// DB추가될 때 마다, 이곳에 추가한다. 예 : 비밀글, 머릿글, 공지사항...
		
		}
		
		System.out.println("NOTICE = " + notice);
		System.out.println("NALL = " + nall);
		System.out.println("is null notice = " + isNullEmpty("notice"));
		System.out.println("is null nall = " + isNullEmpty("nall"));
		
		if(isNullEmpty(notice))
			notice = "0";
		else
			notice = "1";
		
		if(isNullEmpty(nall))
			nall = "0";
		else
			nall = "1";
		
		if(isNullEmpty(title))
			title = "No Tilte";
		
		if(isNullEmpty(bid))
		{
			resultMsg = "필수 정보(게시판 번호) 에러";
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
			
			int gid = 0;
			String thread = "";
			ResultSet rs = null;
			
			if(isNullEmpty(ridx) == false)
			{
				String orgSql = "select * from bbs where idx=?";
				pstmt = conn.prepareStatement(orgSql);
				pstmt.setString(1, ridx);
				rs = pstmt.executeQuery();
				
				if(rs.next())
				{
					gid = rs.getInt("gid");
					String threadOrg = rs.getString("thread");
					String threadSql = "select thread as resultThread, "
							+ "right(thread, 1) as resultRight "
							+ "from bbs "
							+ "where gid=? and "
							+ "length(thread) = length(?) + 1 "
							+ "and locate(?, thread) = 1 "
							+ "order by thread desc limit 1";
					pstmt = conn.prepareStatement(threadSql);
					pstmt.setString(1, Integer.toString(gid));
					pstmt.setString(2, threadOrg);
					pstmt.setString(3, threadOrg);
					
					rs = pstmt.executeQuery();
					
					if(rs.next())
					{
						String header = rs.getString("resultThread").substring(0, rs.getString("resultThread").length()-1);
						String foot = rs.getString("resultRight");
						char tmpLast = foot.charAt(0);
						
						String tail = ++tmpLast + "";
						thread = header + tail;
					}else
					{
						thread = threadOrg + "A";
					}
					
				}else
				{
					resultMsg = "FAIL, 답글에 원본데이터가 없습니다.";
				}
			}else 
			{  // 완전 새 글
			
				String gidSql = "select max(gid) +1 as maxgid from bbs"; 
				pstmt = conn.prepareStatement(gidSql);
				rs = pstmt.executeQuery();
				if(rs.next())
				{
					gid = rs.getInt("maxgid");
				}else
				{
					gid = 1;
				}
				
				thread = "A";
			}	
			
			html2 = html2.replaceAll("script", "S C R I P T NotAllowed");
			html2 = html2.replaceAll("function", "F U N C T I O N NotAllowed");
			html2 = html2.replaceAll("location", "L O C A T I O N NotAllowed");
			html2 = html2.replaceAll(";",":");
			html2 = html2.replaceAll("window", "W I N D O W NotAllowed");
			html2 = html2.replaceAll("a href", "a target='_blank' href");
			
			String sql = "insert into bbs (title, writer, html, time, file1, file2, hit, gid, thread, bid, notice, nall, head, id, html2) "
					+ "values (?, ?, ?, now(), ?, ?, '0', ?, ?, ?, ?, ?, ?, ?, ?) ";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title);
			pstmt.setString(2, writer);
			pstmt.setString(3, html);
			pstmt.setString(4,  serverFileName1);
			pstmt.setString(5,  serverFileName2);
			pstmt.setString(6,  Integer.toString(gid));
			pstmt.setString(7,  thread);
			pstmt.setString(8,  bid);
			pstmt.setString(9,  notice);
			pstmt.setString(10,  nall);
			pstmt.setString(11, head);
			pstmt.setString(12, id);
			pstmt.setString(13, html2);
			
			System.out.println("[BBSInsert] PSTMT = " + pstmt );
			
			int affectedRow = 0;
			affectedRow = pstmt.executeUpdate();
			
			sql = "insert into log (title, id, name, time, ip) values (?, ?, ?, now(), ?)";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, title+" [ 글작성 ] "+(String)session.getAttribute("sessID")+", "+(String)session.getAttribute("sessName"));
			pstmt.setString(2, (String)session.getAttribute("sessID"));
			pstmt.setString(3, (String)session.getAttribute("sessName"));
			pstmt.setString(4, ip);
			
			int effected = pstmt.executeUpdate();
			
			if(affectedRow != 1)
			{
				resultMsg = resultMsg + " insert query Error !!";
			}

		}catch(Exception e)
		{
			System.out.println("[BBSInsert] Error : " + e.getMessage());
		} finally
		{
			try {
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {}
		}
		
		if(resultMsg.equals("success"))
		{
			resultMsg = "글이 등록되었습니다.";
		}
		
		String nextUrl = "main.jsp?cmd=bbsList?bid="+bid;
		request.setAttribute("result", resultMsg);
		request.setAttribute("nextUrl", nextUrl);
		
		notice = null;
		nall = null;
		
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
