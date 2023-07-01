package kr.co.itbank.bbs;

import java.io.Serializable;
import java.sql.Connection;

import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.Timestamp;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.ServletException;
import javax.sql.DataSource;

public class BBSItem implements Serializable{
	
	private static final long serialVersionUID = 1L;
	
	private int idx;
	private int bid;
	private int gid;
	private String thread;
	private String id;
	private int notice;
	private int nall;
	private String title;
	private String head;
	private String html;
	private String html2;
	private String writer;
	private String file1;
	private String file2;
	private int hit;
	private Timestamp time;
		
	public int getIdx() {
		return idx;
	}
	public void setIdx(int idx) {
		this.idx = idx;
	}
	public int getBid() {
		return bid;
	}
	public void setBid(int bid) {
		this.bid = bid;
	}
	public int getGid() {
		return gid;
	}
	public void setGid(int gid) {
		this.gid = gid;
	}
	public String getThread() {
		return thread;
	}
	public void setThread(String thread) {
		this.thread = thread;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}	
	public void setNotice(int notice) {
		this.notice = notice;
	}
	public int getNotice() {
		return notice;
	}
	public void setNall(int nall) {
		this.nall = nall;
	}
	public int getNall() {
		return nall;
	}		
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}	
	public String getHead() {
		return head;
	}
	public void setHead(String head) {
		this.head = head;
	}
	public String getHtml() {
		return html;
	}
	public void setHtml(String html) {
		this.html = html;
	}	
	public String getHtml2() {
		return html2;
	}
	public void setHtml2(String html2) {
		this.html2 = html2;
	}	
	public String getWriter() {
		return writer;
	}
	public String getFile1() {
		return file1;
	}
	public String getFile2() {
		return file2;
	}
	public int getHit() {
		return hit;
	}
	public void setWriter(String writer) {
		this.writer = writer;
	}
	public void setFile1(String file1) {
		this.file1 = file1;
	}
	public void setFile2(String file2) {
		this.file2 = file2;
	}
	public void setHit(int hit) {
		this.hit = hit;
	}
	public Timestamp getTime() {
		return time;
	}
	public void setTime(Timestamp time) {
		this.time = time;
	}
	
	public void readDB() throws ServletException
	{
		Connection conn = null;
		PreparedStatement pstmt = null;
		ResultSet rs = null;
		
		try {
			Context initContext = new InitialContext();
			Context envContext = (Context) initContext.lookup("java:/comp/env");
			DataSource ds = (DataSource) envContext.lookup("jdbc/itbank2_pool");
			
			conn = ds.getConnection();
			String sql = "select * from bbs where idx=?";
			pstmt = conn.prepareStatement(sql);
			pstmt.setString(1, Integer.toString(idx));
			rs = pstmt.executeQuery();
			
			System.out.println("[BBSItem] PSTMT = " + pstmt );
			
			
			while(rs.next())
			{
				idx = rs.getInt("idx");
				bid = rs.getInt("bid");
				gid = rs.getInt("gid");
				thread = rs.getString("thread");
				id = rs.getString("id");
				notice = rs.getInt("notice");
				nall = rs.getInt("nall");				
				title = rs.getString("title");
				html = rs.getString("html");
				html2 = rs.getString("html2");
				writer = rs.getString("writer");
				head = rs.getString("head");				
				file1 = rs.getString("file1");
				file2 = rs.getString("file2");				
				hit = rs.getInt("hit");				
				time = rs.getTimestamp("time");				
				System.out.println("[BBSItem] T: " + title + ", "
						+ "W : " + writer + ", "
						+ "H : " + html);
			}
			 
		}catch(Exception e)
		{
			System.out.println("[BBSItem] Error : " + e.getMessage());
		} finally
		{
			try {
				if(rs != null) rs.close();
				if(pstmt != null) pstmt.close();
				if(conn != null) conn.close();
			} catch (Exception e2) {}
		}
	}
}

