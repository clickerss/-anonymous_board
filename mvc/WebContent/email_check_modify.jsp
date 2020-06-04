<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
	response.setCharacterEncoding("UTF-8");
%>
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
<script type="text/javascript">
	function check(){
		var code = document.getElementById('code').value;
		var c_check = document.getElementById('code_check').value;
		alert(code+','+c_check);
		if(code==c_check){
			document.getElementById('code_check_result').value=1;
			alert("인증이 완료 되었습니다!")
			document.getElementById('check_button').disabled = 'disabled';
			document.getElementById('code_button').disabled = 'disabled';
			return
		}else{
			alert("인증번호가 올바르지 않습니다. 재확인 부탁드립니다.")
			return
		}
	}
	
	function check2(){
		var checked = document.getElementById('code_check_result').value;
		
		if(checked==1){
			alert("수정 완료! 메인페이지로 이동합니다 재로그인 부탁드립니다.")
			document.emailCheckForm.action = "modifyOK_user.jsp";
			document.emailCheckForm.submit();
		} else{
			alert("이메일 인증을 하지 않으셨습니다. 이메일 인증 먼저 부탁드립니다!");
		}
	}
	
	function alertt() {
		alert("메일이 방송되었습니다. 장시간 메일이 오지 않을 경우 다시한번 클릭하여 재전송 부탁드립니다.")
	}
</script>

<%
	String id = request.getParameter("id");
	String name = request.getParameter("name");
	String pwd = request.getParameter("pwd");
	String email = request.getParameter("email");
	String sex = request.getParameter("sex");
	String code = (String)request.getAttribute("code");
	System.out.println(name);
%>
<div class="jumbotron jumbotron-fluid" align="center">
  <div class="container">
    <h1 class="display-4">이메일 인증</h1>
    <p class="lead">정보 수정을 위해 이메일인증을 진행 부탁드립니다.</p>
  </div>
</div>
<div style="margin: 30px; padding-left: 30px; padding-right: 30px">
	<form id="emailCheckForm" name="emailCheckForm" method="post" accept-charset="UTF-8">	  
	  <div class="form-row">
	  	  <div class="form-group col-md-12">
		  	  <div class="card shadow-sm p-3 mb-5 bg-white rounded">
		  		<div class="card-body">
		  		<p class="font-italic text-secondary">입력하신 <span class="badge badge-light"><%=email %></span> 메일주소 확인 후 맞으시다면<br></p>
		  		<p class="font-italic text-secondary">인증번호 발송 버튼을 클릭하여 인증번호 확인 후 인증확인 부탁드립니다</p>
		  		</div>
		  	  </div>
		  </div>
		  <div class="form-group col-md-4">
		  	<input type="text" class="form-control" id="code_check" name="code_check">
		  </div>
		  
		  <input type="hidden" value="<%=id%>" id="id" name="id">
		  <input type="hidden" value="<%=name%>" id="name" name="name">
		  <input type="hidden" value="<%=pwd%>" id="pwd" name="pwd">
		  <input type="hidden" value="<%=email%>" id="email" name="email">
		  <input type="hidden" value="<%=sex%>" id="sex" name="sex">
		  <input type="hidden" value="<%=code%>" id="code" name="code">
		  
		  <div class="form-group col-md">
		  	<button class="btn btn-info" type="submit" formaction="send" id="code_button" onclick="alertt()">인증번호 발송</button>
		  	<button class="btn btn-success" type="button" onclick="check()" id="check_button">인증확인</button>
		  </div>
	  </div>
	  <hr>
	  <div class="form-group">
	  <input type="hidden" value="0" id="code_check_result">
	  <input type="hidden" value="email_check_modify.jsp" id="url" name="url">
	  <button type="button" class="btn btn-primary btn-block" onclick="check2()">수정 완료</button>
	  </div>	  
	</form>
</div>

</body>
</html>