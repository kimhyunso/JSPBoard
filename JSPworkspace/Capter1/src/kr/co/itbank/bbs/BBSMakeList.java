package kr.co.itbank.bbs;

import java.io.IOException;
import java.net.URLEncoder;
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
import javax.sql.DataSource;

@WebServlet("/BBSMakeList")
public class BBSMakeList extends HttpServlet {
	
	private int page = 1;
	private int linePerPage = 10;
	private int PPG = 5;
	private int group = 1;
	private int totalGroup = 1;
	private String paramPage = "";
	private int totalPage = 1;
	private int totalData = 0;
	
	private String bid = "";
	private String sopt = null;
	private String key = null;
	private String keyword = null;
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("utf-8");
		response.setCharacterEncoding("utf-8");
		
		paramPage = request.getParameter("page");
		keyword = request.getParameter("keyword");
		
		if(isNullEmpty(paramPage) == true)
			page = 1;
		else
			page = Integer.parseInt(paramPage);
		
		bid = request.getParameter("bid");
		sopt = request.getParameter("sopt");
		key = request.getParameter("key");
		
		BBSList list = readDB();
		request.setAttribute("BBSList", list);
		request.setAttribute("listSize", list.getListSize());
		request.setAttribute("totalPage", totalPage);
		request.setAttribute("totalData", totalData);
		
		
		totalGroup = (int)Math.ceil((double)totalPage/(double)PPG);
		group = (int)Math.ceil((double)page/(double)PPG);
		
		request.setAttribute("page", page);
		request.setAttribute("totalGroup", totalGroup);
		request.setAttribute("group", group);
		request.setAttribute("PPG", 5);
		
		request.setAttribute("sopt", sopt);
		request.setAttribute("key", key);
		request.setAttribute("keyword", keyword);
		
		if(isNullEmpty(key) == false) {
			request.setAttribute("enKey", URLEncoder.encode(key, "UTF-8"));
		}
		
		if(isNullEmpty(keyword) == false) {
			request.setAttribute("enKeyword", URLEncoder.encode(keyword, "UTF-8"));
		}
		
		RequestDispatcher rd;
		rd = request.getRequestDispatcher("main.jsp?cmd=bbsList.jsp?bid="+bid);
		rd.forward(request, response);
	}
	
	public BBSList readDB()
	{
		BBSList list = new BBSList();
		
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Context initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource) envContext.lookup("jdbc/Capter1");
			
			conn = ds.getConnection();
			String sql ="";
			
			if(isNullEmpty(bid)) {
				sql = "select * from bbsmanager where isdft='1'";
			}else {
				sql = "select * from bbsmanager where idx=?";
			}
			
			pstmt = conn.prepareStatement(sql);
			
			if(isNullEmpty(bid) == false) {
				pstmt.setString(1, bid);
			}
			
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				linePerPage = rs.getInt("lpp");
			}
			
			if(isNullEmpty(key) == false) {
				
				if(sopt.equals("1")) {
					sql = "select count(*) as datacount from bbs where bid=? and title like '%"+key+"%' order by idx desc ";
				}else if(sopt.equals("2")) {
					sql = "select count(*) as datacount from bbs where bid=? and writer like '%"+key+"%' order by idx desc ";
				}else if(sopt.equals("3")) {
					sql = "select count(*) as datacount from bbs where bid=? and html like '%"+key+"%' order by idx desc ";
				}else if(sopt.equals("4")) {
					sql = "select count(*) as datacount from bbs where bid=? and ( title like '%"+key+"%' or writer like '%"+key+"%' or html like '%"+key+"%' ) order by idx desc ";
				}
				
			}else if(isNullEmpty(keyword) == false) {
				sql = "select count(*) as datacount from bbs ( title like '%"+keyword+"%' or writer like '%"+keyword+"%' or html like '%"+keyword+"%' ) order by idx desc ";
			}else{
				sql = "select count(*) as datacount from bbs where (bid=? or nall='1') ";
			}
			
			pstmt = conn.prepareStatement(sql);
			if(isNullEmpty(keyword)) {
				pstmt.setString(1, bid);
			}
			rs = pstmt.executeQuery();
			int start = 0;
			
			if(rs.next())
			{
				 totalData = rs.getInt("datacount");
				
				if(totalData == 0)
					totalPage = 1;
				else
					totalPage = (int)(Math.ceil((double)totalData / (double)linePerPage));
				
				start = (page-1) * linePerPage;
			}
			
			if(isNullEmpty(key) == false) {
				
				if(sopt.equals("1")) {
					sql = "select * from bbs where bid=? and title like '%"+key+"%' limit ?, ?";
				}else if(sopt.equals("2")) {
					sql = "select * from bbs where bid=? and writer like '%"+key+"%' limit ?, ?";
				}else if(sopt.equals("3")) {
					sql = "select * from bbs where bid=? and html like '%"+key+"%' limit ?, ?";
				}else if(sopt.equals("4")) {
					sql = "select * from bbs where bid=? and ( title like '%"+key+"%' or writer like '%"+key+"%' or html like '%"+key+"%' )  limit ?, ?";
				}
				
			}else if(isNullEmpty(keyword) == false){
				bid = "0";
				sql = "select * from bbs where bid>? ( title like '%"+keyword+"%' or writer like '%"+keyword+"%' or html like '%"+keyword+"%' )  limit ?, ?";
			}else{
				sql = "select * from bbs where (bid=? or nall='1' ) order by notice desc, gid desc, thread asc limit ?, ?";
			}
				
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, bid);
			pstmt.setInt(2, start);
			pstmt.setInt(3, linePerPage);
			
			System.out.println("PSTMT = " + pstmt);
			
			rs = pstmt.executeQuery();
			
			System.out.println("[BBSMakeList] PSTMT = " + pstmt );
			
			int cnt = 0;
			System.out.println("[BBSMakeList] 데이터 목록");
			while(rs.next())
			{
				list.setIdx(rs.getInt("idx"));
				list.setBid(rs.getInt("bid"));
				list.setThread(rs.getString("thread"));
				
				list.setNotice(rs.getInt("notice"));
				list.setNall(rs.getInt("nall"));				
				list.setHead(rs.getString("head"));
				
				if(isNullEmpty(key) ==false && (sopt.equals("1") || sopt.equals("4")))
				{
					String tmp = rs.getString("title");
					tmp = tmp.replaceAll(key, "<mark>"+key+"</mark>");
					list.setTitle(tmp);
				}else
				{
					list.setTitle(rs.getString("title"));
				}
				
				if(isNullEmpty(key) ==false && (sopt.equals("2") || sopt.equals("4")))
				{
					String tmp = rs.getString("writer");
					tmp = tmp.replaceAll(key, "<mark>"+key+"</mark>");
					list.setWriter(tmp);
				}else
				{
					list.setWriter(rs.getString("writer"));
				}
				
				list.setFile1(rs.getString("file1"));
				list.setFile2(rs.getString("file2"));
				list.setHit(rs.getInt("hit"));
				
				list.setHtml(rs.getString("html"));
				list.setHtml2(rs.getString("html2"));
				list.setTime(rs.getTimestamp("time"));
				
				cnt ++;
				System.out.println("["+cnt+"] " + rs.getString("title"));
			}

		}catch(Exception e)
		{
			System.out.println("[BBSMakeList] Error : " + e.getMessage());
		} finally
		{
			try {
				if(rs != null)
					rs.close();
				if(pstmt != null)
					pstmt.close();
				if(conn != null)
					conn.close();
			} catch (Exception e2) {
				// TODO: handle exception
			}
		}
		
		return list;
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
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
