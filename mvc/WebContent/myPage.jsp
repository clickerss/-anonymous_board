<%@page import="com.jsp.users.UserDAOImpl"%>
<%@page import="java.util.Date"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="com.jsp.board.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.jsp.board.BoardDAOImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String name = (String)session.getAttribute("name");
String id = (String)session.getAttribute("id");
BoardDAOImpl dao = new BoardDAOImpl();
UserDAOImpl dao2 = new UserDAOImpl();

List<BoardDTO> list = dao.getPost_writer(id);
SimpleDateFormat format1 = new SimpleDateFormat("h:mm a");
SimpleDateFormat format2 = new SimpleDateFormat("yyyy-MM-dd");


%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>익명게시판</title>
<link href="http://fonts.googleapis.com/earlyaccess/jejugothic.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/earlyaccess/jejumyeongjo.css" rel="stylesheet">
<link href="http://fonts.googleapis.com/earlyaccess/nanumgothic.css" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Orbitron&display=swap" rel="stylesheet">
<link href="https://fonts.googleapis.com/css2?family=Poor+Story&display=swap" rel="stylesheet">
<link href="./css/bootstrap.min.css" rel="stylesheet">
<link href="./css/custom.css" rel="stylesheet">
<script
    src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="./js/bootstrap.min.js"></script>
<style type="text/css">
.jg{font-family: 'Jeju Gothic', sans-serif;}
.jm{font-family: 'Jeju Myeongjo', serif;}
.ng{font-family: 'Nanum Gothic', sans-serif;}
.pg{font-family: 'Orbitron', sans-serif;}
.tl{font-family: 'Poor Story', cursive;}
</style>
<%
if(name == null){
%>
	<script>alert('로그인이 필요합니다.'); window.history.back(); </script>
<%} %>
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
  <a class="navbar-brand ng" href="#"><b>익명 게시판</b></a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarNav">
    <ul class="navbar-nav">
      <li class="nav-item active">
        <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="board.jsp">게시판</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">내 정보</a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="explanation.jsp">사이트 설명</a>
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
<div class="jumbotron jumbotron-fluid" align="center">
  <div class="container">
    <h1 class="display-4 jg">마이 페이지</h1><br>
  </div>
</div>
<table class="table table-sm table-borderless tl" style="background-color: #fafbff; margin-bottom: 0px">
  <thead>
    <tr>  
      <td width="1">*</td>    
      <td width="70">ID</td>
      <td width="1">:</td>
      <td><font size="4"><%=dao2.getUser(id).getId() %></font></td>
      <td width="1">*</td>    
      <td width="70">닉네임</td>
      <td width="1">:</td>
      <td><font size="4"><%=dao2.getUser(id).getName() %></font></td>
      <td></td>
    </tr>
  </thead>
  <tbody>
    <tr>      
      <td width="1">*</td>    
      <td width="70">이메일</td>
      <td width="1">:</td>
      <td><font size="4"><%=dao2.getUser(id).getEmail() %></font></td>
      <td width="1">*</td>    
      <td width="70">가입일</td>
      <td width="1">:</td>
      <td><font size="4"><%=format2.format(dao2.getUser(id).getDate())%></font></td>
      <td></td>
    </tr>
    <tr>      
      <td width="1">*</td>    
      <td width="70">성별</td>
      <td width="1">:</td>
      <td><font size="4"><%=dao2.getUser(id).getSex() %></font></td>
      <td colspan="5" align="right"><button class="btn btn-primary" onclick="location.href = 'modify_user.jsp'">정보수정</button></td>
    </tr>
    <tr>
      <td colspan="9"><hr></td>
    </tr>
  </tbody>
</table>
<table class="table table-sm table-borderless tl" style="background-color: #fafbff; margin-bottom: 0px;">
  <tr>  
    <td style="text-align: left;">* <font size="4">받은 좋아요 : <b><%=dao2.countLk(id) %></b></font></td>
    <td style="text-align: left;">* <font size="4">받은 싫어요 : <b><%=dao2.countUnlk(id) %></b></font></td>
    <td style="text-align: left;">* <font size="4">받은 댓글 : <b><%=dao2.countCmt(id) %></b></font></td>
    <td colspan="5"></td>
  </tr>
  <tr>
    <td colspan="8"><hr></td>
  </tr>
</table>
<table class="table table-borderless" style="background-color: #fafbff; margin-bottom: 0px">
	<thead>
		<tr>
			<td colspan="6" class="jg" style="text-align: center;"><h2>나의 글 목록</h3></td>
		</tr>
		<tr>
	    	<th class="tl" style="width: 5%">#</th>
	    	<th class="tl" style="width: 40%; text-align: center;">title</th>
	    	<th class="tl" style="width: 5%; text-align: center;">like</th>
	    	<th class="tl" style="width: 5%; text-align: center;">cmt</th>
	    	<th class="tl" style="width: 20%; text-align: center;">writer</th>
	    	<th class="tl" style="width: 25%; text-align: center;">date</th>
	   </tr>
	</thead>
	<tbody>
	<%	
			for(int i=0; i<list.size(); i++){
				Date now = new Date();
				Date bdate = list.get(i).getB_date();
				String n = format2.format(now);
				String b = format2.format(bdate);
				
				String to = "";
				if(n.equals(b)){
					to = format1.format(bdate);
				}else{
					to = format2.format(bdate);
				}
					
	%>		
				<tr>
					<td><%=list.get(i).getB_no() %></td>
					<td><a class="tl" href="post_view.jsp?b_no=<%=list.get(i).getB_no()%>"><%=list.get(i).getTitle()%></a></td>
					<td class="tl" style="text-align: center;"><%=list.get(i).getLikes()%></td>
					<td class="tl" style="text-align: center;"><%=list.get(i).getCmt()%></td>
					<td class="tl" style="text-align: center;"><%=list.get(i).getWriter_name()%></td>
					<td class="tl" style="text-align: center;"><%=to%></td>
				</tr>
			
	<%	}%>
	</tbody>
</table>
</body>
</html>



