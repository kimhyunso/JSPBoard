<%@page import="kr.co.itbank.bbs.BBSItem"%>
<%@page import="java.sql.*"%>
<%@page import="java.util.*"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<%@ taglib prefix="sql" uri="http://java.sun.com/jsp/jstl/sql" %>

<%
	request.setCharacterEncoding("utf-8");
	response.setCharacterEncoding("utf-8");
%>

	<c:if test="${not empty param.bid and param.bid ge 0 }">
		<sql:query var="bbsRs" dataSource="jdbc/Capter1">
			select *, CAST(css as char(10000) character set utf8) as mycss from bbsmanager where idx = '${param.bid }'
		</sql:query>
	</c:if>
	
	<c:if test="${empty param.bid or param.bid eq 0 }">
		<sql:query var="bbsRs" dataSource="jdbc/Capter1">
			select *, CAST(css as char(10000) character set utf8) as mycss from bbsmanager where isdft = '1'
		</sql:query>
	</c:if>
	
	<c:forEach var="bbsConf" items="${bbsRs.rows }">
		<c:set var="title">${bbsConf.title }</c:set>
		<c:set var="readLevel">${bbsConf.rlevel}</c:set>
		<c:set var="writeLevel">${bbsConf.wlevel}</c:set>
		<c:set var="bbscss">${bbsConf.mycss }</c:set>	
		<c:set var="cssno">${bbsConf.cssno }</c:set>
		<c:set var="csshead">${bbsConf.csshead }</c:set>
		<c:set var="csstitle">${bbsConf.csstitle }</c:set>
		<c:set var="csswriter">${bbsConf.csswriter }</c:set>
		<c:set var="cssfile">${bbsConf.cssfile }</c:set>
		<c:set var="csstime">${bbsConf.csstime }</c:set>
		<c:set var="csshit">${bbsConf.csshit }</c:set>
	</c:forEach>

	<h3 class="text-primary">
		<span class="glyphicon glyphicon-list"></span>
		 ${title }
	</h3>
	
	<c:if test="${not empty bbscss }">
		<style>
			${bbscss}		
		</style>
	</c:if>
	
	<div class="row rowLine">
		<div class="${cssno }"><label>순서</label></div>
		<div class="${csshead }"><label>머리글</label></div>
		<div class="${csstitle }"><label>제목</label></div>
		<div class="${csswriter }"><label>작성자</label></div>
		<div class="${cssfile }"><label>첨부</label></div>
		<div class="${csstime }"><label>작성일</label></div>
		<div class="${csshit }"><label>조회수</label></div>
	</div>
	
	
	
	<c:if test="${listSize ge 1 }">
		<c:forEach var="cnt" begin="0" end="${listSize-1 }" step="1">
			<div class="row rowLine">
				<div class="${cssno }">
					<c:if test="${BBSList.notice[cnt] eq 1 }">
						<span class="label label-danger">공지</span>
					</c:if>
					<c:if test="${BBSList.notice[cnt] ne 1 }">
						${BBSList.idx[cnt] }
					</c:if>
				</div>
	
				<div class="${csshead }">
					${BBSList.head[cnt] }
				</div>
	
				<div class="${csstitle }">
				
					<c:if test="${fn:length(BBSList.thread[cnt]) gt 1 }">
						<c:forEach var="i" begin="1"
							end="${fn:length(BBSList.thread[cnt]) -1 }" step="1">&nbsp; &nbsp;</c:forEach>
						<span class="glyphicon glyphicon-share-alt"></span>
					</c:if>
	
					<c:if test="${fn:contains(BBSList.time[cnt], today) }">
						<span class="badge badge-danger myBadge">New</span>
					</c:if>
					
					<c:if test="${(not empty sessionScope.sessID and sessionScope.sessLevel ge readLevel) or (BBSList.notice[cnt] eq 1)}">
						<a href="main.jsp?cmd=bbsView?bid=${BBSList.bid[cnt] }&idx=${BBSList.idx[cnt] }&sopt=${sopt}&key=${enKey}&keyword=${enKeyword}">${BBSList.title[cnt] }</a>
					</c:if>
					
					<c:if test="${ (BBSList.notice[cnt] ne 1) and (empty sessionScope.sessID or sessionScope.sessLevel lt readLevel) }">
						<a href="javascript:alert('읽기 권한이 없습니다.')">${BBSList.title[cnt] }</a>
					</c:if>
					
					<sql:query var="msgRs" dataSource="jdbc/Capter1">
						select count(*) as msgCnt from bbsmsg where bidx='${BBSList.idx[cnt]}'
					</sql:query>
					
					<c:forEach var="msgInfo" items="${msgRs.rows }">
						<c:if test="${msgInfo.msgCnt gt 0 }">
							<span class="badge" style="background-color: #008299;">${msgInfo.msgCnt }</span>
						</c:if>						
					</c:forEach>
					
				</div>
	
				<div class="${csswriter }">
					${BBSList.writer[cnt] }
				</div>
	
				<div class="col-md-1 hidden-xs hidden-sm">
					<c:if
						test="${not empty BBSList.file1[cnt] or not empty BBSList.file2[cnt] }">
						<span class="glyphicon glyphicon-floppy-disk"></span>
					</c:if>
				</div>
	
				<div class="${csstime }">
					<c:if test="${fn:contains(BBSList.time[cnt], today) }">
						${fn:substring(BBSList.time[cnt], 11, 16) }
					</c:if>
					<c:if test="${fn:contains(BBSList.time[cnt], today) eq false }">
						${fn:substring(BBSList.time[cnt], 0, 10) }
					</c:if>
				</div>
	
				<div class="${csshit }">
					${BBSList.hit[cnt] }
				</div>
			</div>
		</c:forEach>
	</c:if>
	
	<div class="row rowLine" style="border-bottom:none;">
		<div class="col-md-3 col-xs-3 col-sm-3">
			<c:if test="${not empty sessionScope.sessID and sessionScope.sessLevel ge writeLevel }">
				<button type="button" class="btn btn-primary" onclick="location.href='main.jsp?cmd=bbsInput.jsp?bid=${param.bid}'">
					<span class="glyphicon glyphicon-pencil"></span> 글쓰기
				</button>
			</c:if>
			
			<c:if test="${empty sessionScope.sessID or sessionScope.sessLevel lt writeLevel }">
				<button type="button" class="btn btn-primary" disabled onclick="alert('글쓰기 권한이 없습니다.')">
					<span class="glyphicon glyphicon-pencil"></span> 글쓰기
				</button>
			</c:if>
		</div>	
		
		<!-- 
		<form action="" class="form-inline">
			<div class="col-md-6 col-xs-6 col-sm-6 text-right">
				<div class="form-group">
					<input type="text" name="key" class="form-control" placeholder="검색어">
				</div>
			</div>
			<div class="col-md-3 col-xs-3 col-sm-3">
				<button type="submit" class="btn btn-primary hidden-xs"><span class="glyphicon glyphicon-search"></span> 검색</button>
			</div>
		</form>
		-->
		
		<div class="col-md-9 col-xs-9 col-sm-9 text-right">
			<c:if test="${empty keyword}">
				<form action="bbsList?bid=${param.bid }" class="form-inline" method="post">
					<div class="form-group">
						<select name="sopt" class="form-control hidden-xs">
							<option value="1">제목</option>						
							
							<c:if test="${sopt eq 2}">
								<option value="2" selected>작성자</option>						
							</c:if>
							
							<c:if test="${sopt ne 2}">
								<option value="2">작성자</option>						
							</c:if>
							
							<c:if test="${sopt eq 3}">
								<option value="3" selected>내용</option>						
							</c:if>
							
							<c:if test="${sopt ne 3}">
								<option value="3">내용</option>						
							</c:if>
							
							<c:if test="${sopt eq 4}">
								<option value="4" selected>전체</option>						
							</c:if>
							
							<c:if test="${sopt ne 4}">
								<option value="4">전체</option>						
							</c:if>
							
						</select>
						<input type="text" name="key" value="${key }" class="form-control" placeholder="검색어">
					</div>
					<button type="submit" class="btn btn-primary hidden-xs"><span class="glyphicon glyphicon-search"></span> 검색</button>
				</form>
			</c:if>
		</div>
		
		<c:if test="${totalPage ge 2 }">
			<div class="row text-center">
				<ul class="pagination">
				
					<c:if test="${group gt 2}">
						<li><a href="main.jsp?cmd=bbsList?page=1&bid=${param.bid}&sopt=${sopt}&key=${enKey}&keyword=${enKeyword}"><span class="glyphicon glyphicon-step-backward"></span></a></li>
					</c:if>
					
					<c:if test="${group gt 1}">
						<li><a href="main.jsp?cmd=bbsList?page=${(group -2)*PPG +1 }&bid=${param.bid}&sopt=${sopt}&key=${enKey}&keyword=${enKeyword}"><span class="glyphicon glyphicon-chevron-left"></span></a></li>
					</c:if>
					
					<c:forEach var="p" begin="${(group-1)* PPG + 1 }" end="${group * PPG }">
						<c:if test="${p le totalPage}">
							<c:if test="${p eq page }">
								<li class="active"><a href="main.jsp?cmd=bbsList?page=${p }&bid=${param.bid}&sopt=${sopt}&key=${enKey}&keyword=${enKeyword}">${p }</a></li>
							</c:if>
							
							<c:if test="${p ne page }">
								<li><a href="main.jsp?cmd=bbsList?page=${p }&bid=${param.bid}&sopt=${sopt}&key=${enKey}&keyword=${enKeyword}">${p }</a></li>
							</c:if>
						</c:if>
					</c:forEach>
					
					<c:if test="${group lt totalGroup}">
						<li><a href="main.jsp?cmd=bbsList?page=${group * PPG+1 }&bid=${param.bid}&sopt=${sopt}&key=${enKey}&keyword=${enKeyword}"><span class="glyphicon glyphicon-chevron-right"></span></a></li>
					</c:if>
					
					<c:if test="${group lt totalGroup -1 }">
						<li><a href="main.jsp?cmd=bbsList?page=${(totalGroup-1) * PPG +1 }&bid=${param.bid}&sopt=${sopt}&key=${enKey}&keyword=${enKeyword}"><span class="glyphicon glyphicon-step-forward"></span></a></li>
					</c:if>
				</ul>
			</div>
		</c:if>
	</div>	
	
	
	
	
	
	
	
	