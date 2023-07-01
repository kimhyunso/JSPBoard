package kr.co.itbank.bbs;

import java.sql.Timestamp;
import java.util.ArrayList;

public class BBSList {
	private ArrayList<Integer> idxList = new ArrayList<Integer>();
	private ArrayList<Integer> bidList = new ArrayList<Integer>();
	// gid는 없어도 된다.
	private ArrayList<Integer> gidList = new ArrayList<Integer>();
	private ArrayList<String> threadList = new ArrayList<String>();
	private ArrayList<Integer> noticeList = new ArrayList<Integer>();
	private ArrayList<Integer> nallList = new ArrayList<Integer>();
	private ArrayList<String> titleList = new ArrayList<String>();
	private ArrayList<String> headList = new ArrayList<String>();
	private ArrayList<String> htmlList = new ArrayList<String>();
	private ArrayList<String> html2List = new ArrayList<String>();
	private ArrayList<String> writerList = new ArrayList<String>();
	private ArrayList<String> file1List = new ArrayList<String>();
	private ArrayList<String> file2List = new ArrayList<String>();
	private ArrayList<Integer> hitList = new ArrayList<Integer>();
	private ArrayList<Timestamp> timeList = new ArrayList<Timestamp>();
	
	// getter/setter 자동으로 만들지 말고 타이핑
	public void setIdx(Integer idx)
	{
		this.idxList.add(idx);
	}
	public void setBid(Integer bid)
	{
		this.bidList.add(bid);
	}
	public void setGid(Integer gid)
	{
		this.gidList.add(gid);
	}	
	public void setThread(String thread)
	{
		this.threadList.add(thread);
	}	
	public void setNotice(Integer notice)
	{
		this.noticeList.add(notice);
	}
	public void setNall(Integer nall)
	{
		this.nallList.add(nall);
	}	
	public void setTitle(String title)
	{
		this.titleList.add(title);
	}
	
	public void setHead(String head)
	{
		this.headList.add(head);
	}
	
	public void setWriter(String writer)
	{
		this.writerList.add(writer);
	}
	
	public void setFile1(String file1)
	{
		this.file1List.add(file1);
	}
	
	public void setFile2(String file2)
	{
		this.file2List.add(file2);
	}
	public void setHit(Integer hit)
	{
		this.hitList.add(hit);
	}
	public void setHtml(String html)
	{
		this.htmlList.add(html);
	}
	public void setHtml2(String html2)
	{
		this.html2List.add(html2);
	}
	public void setTime(Timestamp time)
	{
		this.timeList.add(time);
	}
	
	public Integer[] getIdx()
	{
		return idxList.toArray(new Integer[idxList.size()]);
	}
	public Integer[] getBid()
	{
		return bidList.toArray(new Integer[idxList.size()]);
	}
	public Integer[] getGid()
	{
		return gidList.toArray(new Integer[idxList.size()]);
	}
	public String[] getThread()
	{
		return threadList.toArray(new String[idxList.size()]);
	}
	
	public Integer[] getNotice()
	{
		return noticeList.toArray(new Integer[idxList.size()]);
	}
	public Integer[] getNall()
	{
		return nallList.toArray(new Integer[idxList.size()]);
	}
		
	public String[] getTitle()
	{
		return titleList.toArray(new String[idxList.size()]);
	}
	
	public String[] getHead()
	{
		return headList.toArray(new String[idxList.size()]);
	}
	
	public String[] getWriter()
	{
		return writerList.toArray(new String[idxList.size()]);
	}
	public String[] getFile1()
	{
		return file1List.toArray(new String[idxList.size()]);
	}
	public String[] getFile2()
	{
		return file2List.toArray(new String[idxList.size()]);
	}
	public Integer[] getHit()
	{
		return hitList.toArray(new Integer[idxList.size()]);
	}
	public String[] getHtml()
	{
		return htmlList.toArray(new String[idxList.size()]);
	}
	public String[] getHtml2()
	{
		return html2List.toArray(new String[idxList.size()]);
	}
	public Timestamp[] getTime()
	{
		return timeList.toArray(new Timestamp[idxList.size()]);
	}
	
	// 게시글 수를 계산
	public int getListSize()
	{
		return idxList.size();
	}
}
