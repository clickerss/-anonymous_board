<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>익명게시판ㄴ</title>
<link href="./css/bootstrap.min.css" rel="stylesheet">
<link href="./css/custom.css" rel="stylesheet">
<script
    src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="./js/bootstrap.min.js"></script>
<script type="text/javascript">
function id_dup_check(){
	$.ajax({
		type : "post",
		url : "duplicateCheck",
		cache : false,
		data : $("#id").serialize(),
		success : function(data){
			$("#is_id_dup").empty();
			$("#is_id_dup").append(data);
			document.getElementById("dupl_check_ok").value = 1;
		}
	});
	return;
}
function join_checked(){
	var id_dupl = document.getElementById("dupl_check_ok").value
	var name = document.getElementById("name").value
	var pwd = document.getElementById("pw").value
	var pwd_chk = document.getElementById("pw_check").value
	var email = document.getElementById("email").value
	
	if(id_dupl == 0){
		alert("ID 중복확인이 되지 않았습니다.");
		return;
	}
	if (name == "") {
		alert("닉네임을 입력해주세요.");
		return;
	}
	if (pwd == "") {
		alert("비밀번호를 입력해주세요.");
		return;
	}
	if (email == "") {
		alert("이메일을 입력해주세요.");
		return;
	}
	if (pwd != pwd_chk){
		alert("비밀번호가 일치하지 않습니다. 정확히 다시 입력해주세요.");
		return;
	}
	document.joinForm.action = "email_check.jsp";
	document.joinForm.submit();
	
}
</script>
</head>
<body>

<div class="jumbotron jumbotron-fluid" align="center">
  <div class="container">
    <h1 class="display-4">회원가입</h1>
    <p class="lead">익명게시판에 오신것을 환영합니다!</p>
  </div>
</div>

<div style="margin: 30px; padding-left: 30px; padding-right: 30px">
	<form id="joinForm" name="joinForm" method="post" accept-charset="UTF-8">
	  <div class="form-row"> 
	    <div class="form-group col-md-6">
	      <label>ID</label>
	      <input type="text" class="form-control" id="id" name="id" placeholder="아이디">
	    </div>
	    <div class="form-group col-md-6">
	    	<label><font color="white">ID</font></label><br>
	    	<button type="button" class="btn btn-success" id="dupl_check" onclick="id_dup_check()">중복확인</button>
	    	<label><font color="white">ID</font></label><br>
	    	<div id="is_id_dup" style="text-align: left;"></div>
	    </div>
	    <div class="form-group col-md-6">
		    <label>닉네임</label>
		    <input type="text" class="form-control" id="name" name="name" placeholder="닉네임">
	  	</div>
	    <div class="form-group col-md-6">
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
	  <input type="hidden" id="dupl_check_ok" value="0">
	  <button type="button" class="btn btn-primary btn-block" onclick="join_checked()">다음단계</button>
	  </div>
	  
	</form>
</div>

</body>
</html>