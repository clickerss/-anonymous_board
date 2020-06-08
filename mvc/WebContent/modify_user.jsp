<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	String id = (String)session.getAttribute("id");
	String name = (String)session.getAttribute("name");
	String email = (String)session.getAttribute("email");
	String sex = (String)session.getAttribute("sex");
%>
<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1">
<title>익명게시판</title>
<link href="./css/bootstrap.min.css" rel="stylesheet">
<link href="./css/custom.css" rel="stylesheet">
<script
    src="https://ajax.googleapis.com/ajax/libs/jquery/1.11.2/jquery.min.js"></script>
<script src="./js/bootstrap.min.js"></script>
<script type="text/javascript">
function modify_checked(){
	var name = document.getElementById("name").value
	var pwd = document.getElementById("pwd").value
	var pwd_chk = document.getElementById("pw_check").value
	var email = document.getElementById("email").value
	
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
		alert("비밀번호가 일치하지 않습니다.");
		return;
	}
	$.ajax({
		type : "post",
		url : "userCheck",
		cache : false,
		data : $("#modifyForm").serialize(),
		success : function(data){
			if(data.length > 7){
				document.modifyForm.action = "email_check_modify.jsp";
				document.modifyForm.submit();								
			}else{
				alert("비밀번호가 일치하지 않습니다.");
			}		
		}
	});
	
}

</script>
</head>
<body>

<div class="jumbotron jumbotron-fluid" align="center">
  <div class="container">
    <h1 class="display-4">회원정보 수정</h1>
  </div>
</div>

<div style="margin: 30px; padding-left: 30px; padding-right: 30px">
	<form id="modifyForm" name="modifyForm" method="post" accept-charset="UTF-8">
	  <div class="form-row"> 
	    <div class="form-group col-md-6">
	      <label>ID</label>
	      <input type="text" class="form-control" id="id" name="id" value="<%=id %>" readonly="readonly">
	    </div>
	    <div class="form-group col-md-6">
		    <label>닉네임</label>
		    <input type="text" class="form-control" id="name" name="name" value="<%= name%>">
	  	</div>	    
	    <div class="form-group col-md-6">
	      <label>Password</label>
	      <input type="password" class="form-control" id="pwd" name="pwd" placeholder="비밀번호">
	    </div>
	    <div class="form-group col-md-6">
	      <label>Password Check</label>
	      <input type="password" class="form-control" id="pw_check" name="pw_check" placeholder="비밀번호 확인">
	    </div>
	    <div class="form-group col-md-7">
	      <label>이메일</label>
	      <input type="email" class="form-control" id="email" name="email" value="<%=email%>">
	    </div>
	    <div class="form-group col-md-6">
	      <label>성별</label>
	      <%
	      	if(sex.length() == 4){
	      %>
	      <select id="sex" name="sex" class="form-control">
	        <option selected>male</option>
	        <option>female</option>
	      </select>
	      <%} else{ %>
	      <select id="sex" name="sex" class="form-control">
	        <option>male</option>
	        <option selected>female</option>
	      </select>
	      <%} %>
	    </div>
	 </div>
	  <hr>
	  <div class="form-group">
	  <input type="hidden" id="dupl_check_ok" value="0">
	  <button type="button" class="btn btn-primary btn-block" onclick="modify_checked()">다음단계</button>
	  </div>
	  
	</form>
</div>

</body>
</html>