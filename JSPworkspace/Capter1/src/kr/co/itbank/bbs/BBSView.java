package kr.co.itbank.bbs;

import java.io.IOException;
import java.net.URLEncoder;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;

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

@WebServlet("/BBSView")
public class BBSView extends HttpServlet {
	
	
	private String idx = null;
	private String uidx = null;
	private String ridx = null;
	private String thisIdx = null;
	private String bid = null;
	private String notice = null;
	private String nall = null;
	
	private String ext1 = null;
	private String ext2 = null;
	private String encodeFile1 = null;
	private String encodeFile2 = null;
	
	private String sopt = "";
	private String key = "";
	private String keyword = "";
	
	private int prev = 0;
	private int next = 0;
	private String prevTitle = "";
	private String nextTitle = "";
	private HttpSession session = null;
	private String ip = null;
	

	private String html = "";
	private String html2 = "";
	
	
	private ArrayList<Integer> msgMidxList = new ArrayList<Integer>();
	private ArrayList<String> msgMemoList = new ArrayList<String>();
	private ArrayList<String> msgBidList = new ArrayList<String>();
	private ArrayList<String> msgIdList = new ArrayList<String>();
	private ArrayList<String> msgNameList = new ArrayList<String>();
	private ArrayList<String> msgTimeList = new ArrayList<String>();
	private ArrayList<String> msgIpList = new ArrayList<String>();
	
	private int msgCount = 0;
	
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		session = request.getSession();
		ip = request.getRemoteAddr();
		idx = request.getParameter("idx");
		ridx = request.getParameter("ridx");
		uidx = request.getParameter("uidx");
		bid = request.getParameter("bid");
		sopt = request.getParameter("sopt");
		key = request.getParameter("key");
		keyword = request.getParameter("keyword");
		
		if(isNullEmpty(idx) == false)
			thisIdx = idx;  // 글 보기
		else if(isNullEmpty(uidx) == false)
			thisIdx = uidx;   // 업데이트
		else if(isNullEmpty(ridx) == false)
			thisIdx = ridx;  // 답글 달기
		
		if(isNullEmpty(thisIdx) )
		{
			RequestDispatcher rd = request.getRequestDispatcher("main.jsp");
			rd.forward(request, response);
		}
		
		if(isNullEmpty(key)) {
			key = "";
			sopt="";
		}
		
		if(isNullEmpty(keyword)) {
			keyword = "";
		}
					
		BBSItem bbsData = readDB();
		request.setAttribute("BBSItem", bbsData);
		request.setAttribute("ext1", ext1);
		request.setAttribute("ext2", ext2);
		request.setAttribute("encodeFile1", encodeFile1);
		request.setAttribute("encodeFile2", encodeFile2);
		request.setAttribute("prev", prev);
		request.setAttribute("next", next);
		request.setAttribute("prevTitle", prevTitle);
		request.setAttribute("nextTitle", nextTitle);
		request.setAttribute("enKey", URLEncoder.encode(key, "UTF-8"));
		request.setAttribute("sopt", sopt);
		request.setAttribute("enKeyword", URLEncoder.encode(keyword, "UTF-8"));
		
		request.setAttribute("msgMidxList",msgMidxList);
		request.setAttribute("msgMemoList",msgMemoList);
		request.setAttribute("msgBidList",msgBidList);
		request.setAttribute("msgIdList",msgIdList);
		request.setAttribute("msgNameList",msgNameList);
		request.setAttribute("msgTimeList",msgTimeList);
		request.setAttribute("msgIpList",msgIpList);
		
		request.setAttribute("msgCount", msgMidxList.size());
		
		prev = 0;
		next = 0;
		
		if(isNullEmpty(idx) == false)
		{
			RequestDispatcher rd = request.getRequestDispatcher("main.jsp?cmd=bbsView.jsp?bid="+bid);
			rd.forward(request, response);
		}else if(isNullEmpty(uidx) == false)
		{
			RequestDispatcher rd = request.getRequestDispatcher("main.jsp?cmd=bbsUpdateForm.jsp?bid="+bid);
			rd.forward(request, response);
		}else if(isNullEmpty(ridx) == false)
		{
			RequestDispatcher rd = request.getRequestDispatcher("main.jsp?cmd=bbsReplyForm.jsp?bid="+bid);
			rd.forward(request, response);
		}
	}
	
	public BBSItem readDB()
	{
		BBSItem bbsData = new BBSItem();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Context initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource) envContext.lookup("jdbc/Capter1");
			
			conn = ds.getConnection();
			String sql;
			
			if(isNullEmpty(idx) == false)
			{
				sql = "update bbs set hit=hit+1 where idx=?";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, thisIdx);
				pstmt.executeUpdate();
			}
			//이전 글, 다음 글
			String pnSql = "";
			if(isNullEmpty(key) == false) {
				
				if(sopt.equals("1")) {
					pnSql = "select * from bbs where bid=? and (title like '%"+key+"%' ) order by notice desc, gid desc, thread asc";
				}else if(sopt.equals("2")) {
					pnSql = "select * from bbs where bid=? and (writer like '%"+key+"%' ) order by notice desc, gid desc, thread asc";
				}else if(sopt.equals("3")) {
					pnSql = "select * from bbs where bid=? and (html like '%"+key+"%' ) order by notice desc, gid desc, thread asc";
				}else if(sopt.equals("4")) {
					pnSql = "select * from bbs where bid=? and (title like '%"+key+"%' or writer like '%"+key+"%' or html like '%"+key+"%' ) order by notice desc, gid desc, thread asc";
				}
				
			}else if(isNullEmpty(keyword) == false){
				pnSql = "select * from bbs where (title like '%"+keyword+"%' or writer like '%"+keyword+"%' or html like '%"+keyword+"%' ) order by idx desc";
			}else {
				pnSql = "select * from bbs where bid=? order by notice desc, gid desc, thread asc";
			}
			
			pstmt = conn.prepareStatement(pnSql);
			
			if(isNullEmpty(keyword)) {
				pstmt.setString(1, bid);
			}else {
				
			}
			
			rs = pstmt.executeQuery();
			
			boolean find = false;
			
			while(rs.next()) {
				
				if(rs.getInt("idx") == Integer.parseInt(thisIdx)) {
					find = true;
				}else {
					if(find == true) {
						next = rs.getInt("idx");
						nextTitle = rs.getString("title");
						break;
					}else {
						prev = rs.getInt("idx");
						prevTitle = rs.getString("title");
					}
				}
			}
			//이전글, 다음글 검사 완료
			System.out.println("prev = "+prev);
			System.out.println("prevTitle = "+prevTitle);
			System.out.println("next = "+next);
			System.out.println("nextTitle = "+nextTitle);
			
			sql = "select * from bbs where idx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, thisIdx);
			rs = pstmt.executeQuery();
			
			System.out.println("[BBSView] PSTMT = " + pstmt );
			
			int cnt = 0;
			System.out.println("[BBSView] 데이터 목록");
			if(rs.next())
			{
				bbsData.setIdx(rs.getInt("idx"));
				bbsData.setBid(rs.getInt("bid"));
				
				// 답글이면, Re : 원래 제목
				if(isNullEmpty(ridx) == false)
				{
					bbsData.setTitle("Re: " + rs.getString("title"));
				}else
				{
					bbsData.setTitle(rs.getString("title"));
				}
				
				bbsData.setHead(rs.getString("head"));
				
				bbsData.setNotice(rs.getInt("notice"));
				bbsData.setNall(rs.getInt("nall"));
				
				bbsData.setWriter(rs.getString("writer"));
				bbsData.setId(rs.getString("id"));
				
				bbsData.setFile1(rs.getString("file1"));
				bbsData.setFile2(rs.getString("file2"));
				bbsData.setHit(rs.getInt("hit"));
								
				if(isNullEmpty(rs.getString("file1")) ==false)
				{
					encodeFile1 = URLEncoder.encode(rs.getString("file1"), "utf-8");
					int pos = rs.getString("file1").lastIndexOf(".");
					ext1 = rs.getString("file1").substring(pos +1);
					ext1 = ext1.toLowerCase();
				}
				if(isNullEmpty(rs.getString("file2")) ==false)
				{
					encodeFile2 = URLEncoder.encode(rs.getString("file2"), "utf-8");
					int pos = rs.getString("file2").lastIndexOf(".");
					ext2 = rs.getString("file2").substring(pos +1);
					ext2 = ext2.toLowerCase();
				}
				
				if(isNullEmpty(idx) == false)
				{
					html = rs.getString("html");
					html2 = rs.getString("html2");
					html = html.replaceAll("\n", "<br>");
				}else if(isNullEmpty(uidx) ==false)
				{
					html = rs.getString("html");
					html2 = rs.getString("html2");
				}else if(isNullEmpty(ridx) ==false)
				{
					html = rs.getString("html");
					html = html.replaceAll("^", ">> ");
					html = html.replaceAll("\n", "\n>> ");
					html = html.replaceAll("^", "\n\n\n\n");
					
					html2 = rs.getString("html2");
					html2 = html2.replaceAll("^", ">> ");
					html2 = html2.replaceAll("<p>", "<p>>> ");
					html2 = html2.replaceAll("<div>", "<div>>> ");
					html2 = html2.replaceAll("^", "<br></br><br></br><br></br>");
				}
				
				if(isNullEmpty(html2)) {
					html2 = rs.getString("html2");
				}
				
				bbsData.setHtml(html);
				bbsData.setHtml2(html2);
				bbsData.setTime(rs.getTimestamp("time"));
				
				cnt ++;
				System.out.println("["+cnt+"] " + rs.getString("title"));
				System.out.println("file 1 = " + rs.getString("file1"));
			}
			
			if(isNullEmpty(idx) == false) {
				msgMidxList.removeAll(msgMidxList);
				msgBidList.removeAll(msgBidList);
				msgMemoList.removeAll(msgMemoList);
				msgIdList.removeAll(msgIdList);
				msgNameList.removeAll(msgNameList);
				msgTimeList.removeAll(msgTimeList);
				msgIpList.removeAll(msgIpList);
				
				//댓글 목록 가져오기
				sql = "select * from bbsmsg where bidx=? order by bidx desc";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, idx);
				rs = pstmt.executeQuery();
				
				
				while(rs.next()) {
					msgMidxList.add(rs.getInt("midx"));
					String tmp = rs.getString("memo");
					tmp = tmp.replaceAll("\r\n\r\n", "");
					tmp = tmp.replaceAll("\n\n", "\n");
					
					tmp = tmp.replaceAll("\r\n", "<br>");
					tmp = tmp.replaceAll("\r", "<br>");
					tmp = tmp.replaceAll("\n", "<br>");
					
					msgMemoList.add(tmp);
					msgBidList.add(Integer.toString(rs.getInt("bid")));
					msgIdList.add(rs.getString("id"));
					msgNameList.add(rs.getString("name"));
					msgTimeList.add(rs.getTimestamp("time").toString());
					msgIpList.add(rs.getString("ip"));
				}
				
			}
			
			if(isNullEmpty(uidx) == false) {
				sql = "insert into log (title, id, name, time, ip) values (?, ?, ?, now(), ?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, bbsData.getTitle()+" [ 글수정 ] "+(String)session.getAttribute("sessID")+", "+(String)session.getAttribute("sessName"));
				pstmt.setString(2, (String)session.getAttribute("sessID"));
				pstmt.setString(3, (String)session.getAttribute("sessName"));
				pstmt.setString(4, ip);
				int effected = pstmt.executeUpdate();
				
			}else if(isNullEmpty(ridx) == false) {
				sql = "insert into log (title, id, name, time, ip) values (?, ?, ?, now(), ?)";
				pstmt = conn.prepareStatement(sql);
				pstmt.setString(1, bbsData.getTitle()+" [ 글답글 ] "+(String)session.getAttribute("sessID")+", "+(String)session.getAttribute("sessName"));
				pstmt.setString(2, (String)session.getAttribute("sessID"));
				pstmt.setString(3, (String)session.getAttribute("sessName"));
				pstmt.setString(4, ip);
				int effected = pstmt.executeUpdate();
			}
			
			

		}catch(Exception e)
		{
			System.out.println("[BBSView] Error : " + e.getMessage());
		} finally
		{
			try {
				if(rs != null)	rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {}
		}
		
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
	

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
