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
String b_no_ajax = request.getParameter("b_no");
int b_no = Integer.parseInt(request.getParameter("b_no"));
BoardDAOImpl dao = new BoardDAOImpl();
BoardDTO dto = dao.getPost_bno(b_no);

SimpleDateFormat format1 = new SimpleDateFormat("h:mm a");
SimpleDateFormat format2 = new SimpleDateFormat("yyyy-MM-dd");

Date now = new Date();
Date bdate = dto.getB_date();
String n = format2.format(now);
String b = format2.format(bdate);

String to = "";
if(n.equals(b)){
	to = format1.format(bdate);
}else{
	to = format2.format(bdate);
}

dao.updateVw(b_no, id);
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
		$("#cmt").attr("placeholder", "댓글은 로그인 후 작성 가능합니다.")
		$("#cmt").attr("disabled",true);
		$("#cmt_submit").attr("disabled",true);
		$("#modify").hide();
		$("#delete").hide();
	}
}

function insertCheck_cmt() {
	if($("#cmt").val() == ""){
		alert("내용을 입력해주세요.")
	}else{
		confirm("댓글을 등록 하시겠습니까?");
		$.ajax({
			type : "post",
			url : "insertCmt",
			cache : false,
			data : $("#cmtForm").serialize(),
			success : function(){				
				location.reload();
			}
		});
		return;
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

function update_like() {
	if(id == "null"){		
		alert("좋아요는 로그인 후 가능합니다");
		return;
	}else{
		$.ajax({
			type : "post",
			url : "updateLks",
			cache : false,
			data : $("#hiddenForm").serialize(),
			success : function(data){
				$("#totalLike").empty();
				$("#totalLike").append(data);
				
			}
		});		
	}
	return;
}

function update_unlike() {
	if(id == "null"){	
		alert("좋아요는 로그인 후 가능합니다");
		return;
	}else{
		$.ajax({
			type : "post",
			url : "updateUnlks",
			cache : false,
			data : $("#hiddenForm").serialize(),
			success : function(data){
				$("#totalUnLike").empty();
				$("#totalUnLike").append(data);
				
			}
		});
	}
	return;
}

function delete_post() {
	confirm("정말 삭제하시겠습니까?");
	$.ajax({
		type : "post",
		url : "deletePost",
		cache : false,
		data : $("#hiddenForm").serialize(),
		success : function(data){
			alert("ajax 성공")
			if(data == "true"){
				alert("삭제성공")
				location.replace("board.jsp")
			}else{
				alert("삭제실패")
			}
		}
	});
}

function modify_post() {
	document.modifyHiddenForm.action = "modify_post.jsp";
	document.modifyHiddenForm.submit();
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
        <a class="nav-link" href="myPage.jsp">내 정보</a>
      </li>
      <li class="nav-item">
        <a class="nav-link disabled" href="explanation.jsp">사이트 설명</a>
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
<div style="margin-left: 10px">
	<h3 class="jg"><%=dto.getTitle() %></h3>
</div>
<div style="margin-left: 10px">
	<small class="text-muted ng">작성자</small>&nbsp;
	<small class="text-muted ng"><b><%=dto.getWriter_name()%></b></small>&nbsp; &nbsp; &nbsp; &nbsp; &nbsp;
	<small class="text-muted ng"><%=to%></small>&nbsp;&nbsp;&nbsp;&nbsp;
	<small class="text-muted ng">조회 <%=dao.countVw(b_no)%>회</small>&nbsp;&nbsp;&nbsp;&nbsp;
	<small class="text-muted ng">댓글 <%=dto.getCmt()%>건</small>&nbsp;&nbsp;&nbsp;&nbsp;
</div>
<hr style="margin-top: 1px">
<div align="right" style="margin-right: 10px">
	<button class="btn btn-outline-secondary btn-sm" id="modify" onclick="modify_post()"><font class="ng">수정</font></button>
	<button class="btn btn-outline-secondary btn-sm" id="delete" onclick="delete_post()"><font class="ng">삭제</font></button>
	<button class="btn btn-outline-secondary btn-sm"><font class="ng">목록</font></button>
	<button class="btn btn-primary btn-sm" onclick="location.href = 'insert_post.jsp'"><font class="ng">글쓰기</font></button>
</div>
<pre class="jg" style="white-space: pre-wrap; margin-left: 20px">
<%=dto.getContents()%>
</pre><br>

<div align="center">
	<table style="width: 400px;">
		<tr>
			<td colspan="4" align="center">
				<button style="border: none; background: none;" onclick="update_like()">
					<img src="https://img.icons8.com/ios-filled/50/000000/good-quality.png"/>
				</button>
			</td>
			<td colspan="4" align="center">
				<button style="border: none; background: none;"onclick="update_unlike()">
					<img src="https://img.icons8.com/ios-filled/50/000000/poor-quality.png"/>
				</button>
			</td>
		</tr>
		<tr>
			<td colspan="4" align="center" id="totalLike"><%=dto.getLikes()%></td>
			<td colspan="4" align="center" id="totalUnLike"><%=dto.getUnlikes()%></td>			
		</tr>
	</table>
	
	
</div>

<br>
<hr>
<div style="margin-left: 40px; margin-right: 40px">
	<small class="ng"><b>댓글목록</b></small>
	<% 					
		List<commentDTO> list = dao.getCmt(b_no);
		
		for(int i=0; i<list.size(); i++){
			Date now2 = new Date();
			Date cdate = list.get(i).getC_date();
			String n2 = format2.format(now);
			String c = format2.format(bdate);
			
			String to2 = "";
			if(n.equals(b)){
				to = format1.format(bdate);
			}else{
				to = format2.format(bdate);
			}
				
	%>		
			<hr style="margin-top: 3px; margin-bottom: 3px">
			<small class="text-muted ng" style="font-size: x-small;"><b><%=list.get(i).getWriter_name() %></b> 작성일 <%=to2 %></small><br>
			<pre class="jg"><b><%=list.get(i).getContent()%></b></pre>
			<div align="right">
				<input type="hidden" id="c_no" name="c_no" value="<%=list.get(i).getC_no()%>">
				<button style="border: none; background: none;" class="btn btn-sm"><small class="text-muted ng" style="font-size: x-small;">삭제</small></button>
			</div>
  			
	<%	}%>
<form id="cmtForm" style="display: flex; flex-direction: column; align-items: flex-end;">
	<textarea id="cmt" name="cmt"
		style="width: 100%; height: 90px; margin-bottom: 5px; border-width: thin;"></textarea>
	<input type="hidden" id="writer" name="writer" value="<%=id%>">
	<input type="hidden" id="writer_name" name="writer_name" value="<%=name%>">
	<input type="hidden" id="b_no2" name="b_no2" value="<%=b_no%>">
	<button id="cmt_submit" name="cmt_submit" class="btn btn-outline-success" type="button" onclick="insertCheck_cmt()">작성</button>
</form>
</div>
<hr>

<div class="modal fade" id="layerpop" >
  <div class="modal-dialog">
    <div class="modal-content">
      <!-- header -->
      <div class="modal-header">
      	<!-- header title -->
        <h4 class="modal-title">Login</h4>
        <!-- 닫기(x) 버튼 -->
        <button type="button" class="close" data-dismiss="modal">×</button>        
      </div>
      <form id="loginForm" name="loginForm" method="post" accept-charset="UTF-8">
	    <div class="modal-body">  
	    	<div class="form-row">
	    		<div class="form-group col-md-12">
	    			<label>ID</label>
	    			<input type="text" class="form-control" id="id" name="id" placeholder="아이디">
	    		</div>
	    		<div class="form-group col-md-12">
	    			<label>PassWord</label>
	    			<input type="password" class="form-control" id="pwd" name="pwd" placeholder="비밀번호">
	    		</div>
	    	</div>          
	    </div>
	    <div class="modal-footer">	      
	      <button type="button" class="btn btn-default" data-dismiss="modal">취소</button>
	      <a class="btn btn-outline-success" href="join.jsp" role="button">회원가입</a>
	      <button type="button" class="btn btn-primary" onclick="login_check()">로그인</button>
      	</div>
      </form>
    </div>
  </div>
</div>

<form id="hiddenForm">
	<input type="hidden" value=<%=b_no_ajax%> id="b_no" name="b_no">
	<input type="hidden" value=<%=id%> id="id" name="id">
</form>
<form id="modifyHiddenForm" name="modifyHiddenForm" method="post" accept-charset="UTF-8">
	<input type="hidden" value=<%=dto.getB_no()%> id="b_no" name="b_no">
	<input type="hidden" value=<%=dto.getTitle()%> id="title" name="title">
	<input type="hidden" value=<%=dto.getContents()%> id="contents" name="contents">
</form>
</body>
</html>



















