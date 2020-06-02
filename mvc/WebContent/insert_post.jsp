<%@page import="com.jsp.board.commentDTO"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.List"%>
<%@page import="com.jsp.board.BoardDTO"%>
<%@page import="com.jsp.board.BoardDAOImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String name = (String)session.getAttribute("name");
String id = (String)session.getAttribute("id");
BoardDAOImpl dao = new BoardDAOImpl();
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
<link href="https://fonts.googleapis.com/css2?family=Orbitron&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poor+Story&display=swap" rel="stylesheet">
<link href="./css/bootstrap.min.css" rel="stylesheet">
<link href="./css/custom.css" rel="stylesheet">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="./js/bootstrap.min.js"></script>
<style type="text/css">
.jg{font-family: 'Jeju Gothic', sans-serif;}
.jm{font-family: 'Jeju Myeongjo', serif;}
.ng{font-family: 'Nanum Gothic', sans-serif;}
.pg{font-family: 'Orbitron', sans-serif;}
.tl{font-family: 'Poor Story', cursive;}
</style>
<script type="text/javascript">
var id = "<%=session.getAttribute("id")%>";
window.onload = function() {
	if(id == "null"){
		alert("권한이 없습니다")
		window.location.replace("login_main.jsp");
	}
}

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

function insertCheck_post() {
	confirm("등록 하시겠습니까?");
	if($("#title").val() == ""){
		alert("제목을 입력해주세요")
	} else if($("#contents").val() == ""){
		alert("본문을 입력해주세요")
	}else if($("#title").val().length > 35){
		alert("제목은 35글자 이내로 작성하여야 합니다.")
	}else if($("#contents").val().length > 5000){
		alert("본문은 5000자 이내로 작성하여야 합니다.")
	}else{
		$.ajax({
			type : "post",
			url : "insertPost",
			cache : false,
			data : $("#insertPostForm").serialize(),
			success : function(){
				alert("ajax 성공")
				alert("성공적으로 등록 되었습니다.")
				location.replace("board.jsp");
			}
		});
		return;
	}
}
</script> 
</head>
<body>

<nav class="navbar navbar-expand-lg navbar-light bg-light">
  <a class="navbar-brand ng" href="#"><b>익명 게시판</b></a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarNav">
    <ul class="navbar-nav">
      <li class="nav-item">
        <a class="nav-link" href="login_main.jsp">Home </a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="board.jsp">게시판</a>
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
	sb.append("<small class=\"text-muted jg\"><b>"+name+"</b>님 반갑습니다!</small>");
	sb.append("<a class=\"btn btn-default\" href=\"./logout.jsp\" id=\"logout_button\"><span class=\"badge badge-secondary\">로그아웃</span></a>");
	sb.append("</div>");
}

%>

<div align="right" style="margin-right: 10px" id="login_logout_button">
	<%=sb %>
</div>
<br>

<form id="insertPostForm">
	<div class="form-group" style="width: 85%; margin-left: 7%; margin-right: 25%;">
		<label>제목</label>
		<input type="text" class="form-control" id="title" name="title" placeholder="35자 이내로 작성해주세요">
	</div>
	<div class="form-group" style="width: 85%; margin-left: 7%; margin-right: 25%;">
		<label>내용</label>
		<textarea rows="15" class="form-control" id="contents" name="contents" placeholder="5000자 이내로 작성해주세요"></textarea>
	</div>
	<div class="form-group" align="right" style="margin-right: 8%;">
		<input type="hidden" value="<%=id%>" id="writer" name="writer">
		<input type="hidden" value="<%=name%>" id="writer_name" name="writer_name">
		<button class="btn btn-primary" type="button" onclick="history.back()">취소</button>
		<input class="btn btn-primary" type="reset" value="초기화">
		<button class="btn btn-primary" type="button" onclick="insertCheck_post()">등록</button>
	</div>
</form>
</body>
</html>
