<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<%
	request.setCharacterEncoding("utf-8");
	response.setCharacterEncoding("utf-8");
%>

<div class="container">
	
	<ul class="nav nav-tabs">
	  <li class="active"><a data-toggle="tab" href="#home">Home</a></li>
	  <li><a data-toggle="tab" href="#menu1">Menu 1</a></li>
	  <li><a data-toggle="tab" href="#menu2">Menu 2</a></li>
	  <li><a data-toggle="tab" href="#menu3">Menu 3</a></li>
	</ul>
	
	<div class="tab-content">
		<div id="home" class="tab-pane fade in active">
	    	<h3>HOME</h3>
	    	<p>Some content.</p>
		</div>
		
		<div id="menu1" class="tab-pane fade">
			<h3>Menu 1</h3>
	    	<p>Some content in menu 1.</p>
		</div>
		
		<div id="menu2" class="tab-pane fade">
	    	<h3>Menu 2</h3>
	    	<p>Some content in menu 2.</p>
	  	</div>
	  	<div id="menu3" class="tab-pane fade">
	    	<h3>Menu 3</h3>
	    	<p>Some content in menu 3.</p>
	 	 </div>
	</div>

</div>



