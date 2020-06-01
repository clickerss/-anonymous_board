<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="com.jsp.board.BoardDTO"%>
<%@page import="com.jsp.board.BoardDAOImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String name = (String)session.getAttribute("name");
int b_no = Integer.parseInt(request.getParameter("b_no"));
BoardDAOImpl dao = new BoardDAOImpl();
BoardDTO dto = dao.getPost_bno(b_no);

SimpleDateFormat format1 = new SimpleDateFormat("h:mm a");
SimpleDateFormat format2 = new SimpleDateFormat("yyyy-MM-dd");

Date now = new Date();
Date bdate = dto.getB_date();
System.out.println(bdate);
long calDate = now.getTime()-bdate.getTime();
long calDateDays = calDate / (1000*60*60*24);
String to = "";
if(calDateDays < 1){
	to = format1.format(bdate);
}else{
	to = format2.format(bdate);
}
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>부트스트랩 기본 틀</title>
<link href="http://fonts.googleapis.com/earlyaccess/jejugothic.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/earlyaccess/jejumyeongjo.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/earlyaccess/nanumgothic.css" rel="stylesheet">
<link href="./css/bootstrap.min.css" rel="stylesheet">
<link href="./css/custom.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="./js/bootstrap.min.js"></script>
<style type="text/css">
.jg{font-family: 'Jeju Gothic', sans-serif;}
.jm{font-family: 'Jeju Myeongjo', serif;}
.ng{font-family: 'Nanum Gothic', sans-serif;}
</style>
<script type="text/javascript">
function login_check() {
	$.ajax({
		type : "post",
		url : "userCheck",
		cache : false,
		data : $("#loginForm").serialize(),
		success : function(data){
			if(data.length>6){
				window.location.href = data;
			}else{
				alert("아이디 또는 비밀번호가 일치하지 않습니다.")
			}			
		}
	});
	return;
}
</script> 
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand" href="#">익명 게시판</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarNav">
    <ul class="navbar-nav">
      <li class="nav-item active">
        <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">게시판</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">내 정보</a>
      </li>
      <li class="nav-item">
        <a class="nav-link disabled" href="#" tabindex="-1" aria-disabled="true">Disabled</a>
      </li>
    </ul>
  </div>
</nav>
<% 
StringBuilder sb = new StringBuilder();
if(name == null){
	sb.append("<div id=\"login\">");
	sb.append("<button class=\"btn btn-outline-primary\" data-target=\"#layerpop\" data-toggle=\"modal\" id=\"login_button\">로그인</button>");
	sb.append("</div>");
}else{
	sb.append("<div id=\"logout\">");
	sb.append(name+"님 반갑습니다!");
	sb.append("<a class=\"btn btn-default\" href=\"./logout.jsp\" id=\"logout_button\"><span class=\"badge badge-secondary\">로그아웃</span></a>");
	sb.append("</div>");
}

%>

<div align="right" style="margin-right: 10px" id="login_logout_button">
	<%=sb %>
</div>
<br>
<div style="margin-left: 10px">
	<h3 class="jg"><%=dto.getTitle() %></h3>
</div>
<div style="margin-left: 10px">
	<small class="text-muted ng">작성자</small>&nbsp;
	<small class="text-muted ng"><b><%=dto.getWriter_name()%></b></small>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	<small class="text-muted ng"><%=to%></small>&nbsp;&nbsp;&nbsp;&nbsp;
	<small class="text-muted ng">조회 <%=dto.getVw()%>회</small>&nbsp;&nbsp;&nbsp;&nbsp;
	<small class="text-muted ng">댓글 <%=dto.getCmt()%>건</small>&nbsp;&nbsp;&nbsp;&nbsp;
</div>
<hr style="margin-top: 1px">
<div align="right" style="margin-right: 10px">
	<button class="btn btn-outline-secondary btn-sm"><font class="ng">수정</font></button>
	<button class="btn btn-outline-secondary btn-sm"><font class="ng">삭제</font></button>
	<button class="btn btn-outline-secondary btn-sm"><font class="ng">목록</font></button>
	<button class="btn btn-primary btn-sm"><font class="ng">글쓰기</font></button>
</div>
<pre class="jg" style="white-space: pre-wrap;">
<%=dto.getContents()%>
</pre><br>

<div align="center">
	<table style="width: 400px;">
		<tr>
			<td colspan="4" align="center">
				<button style="border: none; background: none;">
					<img src="https://img.icons8.com/ios-filled/50/000000/good-quality.png"/>
				</button>
			</td>
			<td colspan="4" align="center">
				<button style="border: none; background: none;">
					<img src="https://img.icons8.com/ios-filled/50/000000/poor-quality.png"/>
				</button>
			</td>
		</tr>
		<tr>
			<td colspan="4" align="center"><%=dto.getLikes()%></td>
			<td colspan="4" align="center"><%=dto.getUnlikes()%></td>			
		</tr>
	</table>
	
	
</div>

<br>
<hr>
<div style="margin-left: 40px; margin-right: 40px">
	<small class="ng"><b>댓글목록</b></small>
	<hr style="margin-top: 3px; margin-bottom: 3px">
	<small class="text-muted ng" style="font-size: x-small;"><b>홍길동</b> 작성일 20-12-12 16:43</small><br>
	<small class="ng"><b>댓글을 달았다</b></small>
	<div align="right">
		<button style="border: none; background: none;" class="btn btn-sm"><small class="text-muted ng" style="font-size: x-small;">삭제</small></button>
	</div>
	<form action="" style="display: flex; flex-direction: column; align-items: flex-end;">
		<textarea id="cmt" placeholder="댓글은 로그인 후 작성 가능합니다." 
		style="width: 100%; height: 90px; margin-bottom: 5px; border-width: thin;"></textarea>
	<input class="btn btn-outline-success" type="submit" value="작성">
</form>
</div>
<hr>

<%=b_no %>
</body>
</html>



















