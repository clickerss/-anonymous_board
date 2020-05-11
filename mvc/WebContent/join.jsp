<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="utf-8">
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
	<form action="#">
	  <div class="form-row"> 
	    <div class="form-group col-md-6">
	      <label>ID</label>
	      <input type="text" class="form-control" id="id" placeholder="아이디">
	    </div>
	    <div class="form-group col-md-6">
		    <label>닉네임</label>
		    <input type="text" class="form-control" id="name" placeholder="닉네임">
	  	</div>
	    <div class="form-group col-md-6">
	      <label>Password</label>
	      <input type="password" class="form-control" id="pw" placeholder="비밀번호">
	    </div>
	    <div class="form-group col-md-6">
	      <label>Password Check</label>
	      <input type="password" class="form-control" id="pw_check" placeholder="비밀번호 확인">
	    </div>
	    <div class="form-group col-md-4">
	      <label>성별</label>
	      <select id="sex" class="form-control">
	        <option selected>male</option>
	        <option>female</option>
	      </select>
	    </div>
	 </div>
	 <div class="form-row">
	 	<div class="form-group col-md-5">
	      <label>이메일</label>
	      <input type="email" class="form-control" id="email" placeholder="ex) abc123@gmail.com">
	    </div>
	    <div class="form-group col-md-1">
	    <button type="button" class="btn btn-info" onclick="checkCode()" style="margin-top: 32px;">인증번호 발송</button>
	 	</div>
	 </div>
	 <div class="form-row">
	  	<div class="form-group col-md-2">
	  		<input class="form-control" type="text" id="code_check">
	  	</div>
	  	<div class="form-group col-md-1">
	  		<button type="button" class="btn btn-primary">인증하기</button>
	  	</div>
	  </div>
	  <hr>
	  <div class="form-group">
	  <input type="hidden" value="0">	    
	  <button type="submit" class="btn btn-primary btn-block">가입하기</button>
	  </div>
	  
	</form>
</div>

</body>
</html>