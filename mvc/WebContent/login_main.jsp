<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String name = (String)session.getAttribute("name");

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
	<div class="jumbotron">
		<div align="center">
		  <blockquote class="blockquote text-center">
  			<p class="mb-0 pg">We are Anoymous.<br>We are Legion We do not forgive We do not forget<br>Expect us.</p>
  			<footer class="blockquote-footer">Someone anonymous</footer>
		  </blockquote>
		  <div id="face_div">
		    <div id="carouselExampleControls" class="carousel slide carousel-fade" data-ride="carousel" data-interval="2000">
			    <div class="carousel-inner">
			      <div class="carousel-item active">
			        <img src="https://img.icons8.com/ios/240/000000/anonymous-mask.png" class="d-block" alt="...">
		  	      </div>
			      <div class="carousel-item">
	      		  	<img src="https://img.icons8.com/ios-filled/240/000000/anonymous-mask.png" class="d-block" alt="...">
    		  	  </div>
		  		</div>		  
		  </div>		  		  	  
		  <hr class="my-4">
		  <p>welcome! If you want to use the anonymous bulletin board, sign up now.</p>
		</div>
	  <div align="right">	
	  	<a class="btn btn-secondary btn-lg" href="join.jsp" role="button">회원가입</a>
	  </div>
	</div>
  </div>
  
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
</body>
</html>