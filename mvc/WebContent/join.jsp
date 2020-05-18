<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>부트스트랩 기본 틀</title>
<link href="./css/bootstrap.min.css" rel="stylesheet">
<link href="./css/custom.css" rel="stylesheet">
<script
    src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="./js/bootstrap.min.js"></script>
</head>
<body>

<div class="jumbotron jumbotron-fluid" align="center">
  <div class="container">
    <h1 class="display-4">회원가입</h1>
    <p class="lead">익명게시판에 오신것을 환영합니다!</p>
  </div>
</div>

<div style="margin: 30px; padding-left: 30px; padding-right: 30px">
	<form method="post" accept-charset="UTF-8">
	  <div class="form-row"> 
	    <div class="form-group col-md-6">
	      <label>ID</label>
	      <input type="text" class="form-control" id="id" name="id" placeholder="아이디">
	    </div>
	    <div class="form-group col-md-6">
		    <label>닉네임</label>
		    <input type="text" class="form-control" id="name" name="name" placeholder="닉네임">
	  	</div>
	    <div class="form-group col-md-6">
	      <label>Password</label>
	      <input type="password" class="form-control" id="pw" name="pw" placeholder="비밀번호">
	    </div>
	    <div class="form-group col-md-6">
	      <label>Password Check</label>
	      <input type="password" class="form-control" id="pw_check" name="pw_check" placeholder="비밀번호 확인">
	    </div>
	    <div class="form-group col-md-7">
	      <label>이메일</label>
	      <input type="email" class="form-control" id="email" name="email" placeholder="ex) abc123@gmail.com">
	    </div>
	    <div class="form-group col-md-6">
	      <label>성별</label>
	      <select id="sex" name="sex" class="form-control">
	        <option selected>male</option>
	        <option>female</option>
	      </select>
	    </div>
	 </div>
	  <hr>
	  <div class="form-group">
	  <button type="submit" formaction="email_check.jsp" class="btn btn-primary btn-block">다음단계</button>
	  </div>
	  
	</form>
</div>

</body>
</html>