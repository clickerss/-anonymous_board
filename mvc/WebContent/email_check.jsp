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
	var random = function(){
		var ran = Math.floor(Math.random()*(99999-10000))+10000;
		document.getElementById("code").value = ran
	}
</script>
<%!
	public int getRandom(){
	int random=0;
	random=(int)Math.floor((Math.random()*(99999-10000))+10000);
	return random;
}
%> 
<%
	String id = request.getParameter("id");
	String name = request.getParameter("name");
	String pw = request.getParameter("pw");
	String email = request.getParameter("email");
	String sex = request.getParameter("sex");
	String code = request.getParameter("code");
	System.out.println(name);
%>
<div class="jumbotron jumbotron-fluid" align="center">
  <div class="container">
    <h1 class="display-4">회원가입</h1>
    <p class="lead">익명게시판에 오신것을 환영합니다!</p>
  </div>
</div>
<div style="margin: 30px; padding-left: 30px; padding-right: 30px">
	<form action="send" id="emailCheckForm" method="post" accept-charset="UTF-8">	  
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
		  <input type="hidden" value="<%=pw%>" id="pw" name="pw">
		  <input type="hidden" value="<%=email%>" id="email" name="email">
		  <input type="hidden" value="<%=sex%>" id="sex" name="sex">
		  <input type="hidden" value="<%=getRandom()%>" id="code" name="code">
		  
		  <div class="form-group col-md">
		  	<button class="btn btn-info" type="submit" >인증번호 발송</button>
		  	<button class="btn btn-success">인증확인</button>
		  </div>
	  </div>
	  <hr>
	  <div class="form-group">
	  <input type="hidden" value="0">	    
	  <button type="submit" formaction="#" class="btn btn-primary btn-block">다음단계</button>
	  </div>	  
	</form>
	
	<%=id %>
	<%=name %>
	<%=pw %>
	<%=email %>
	<%=sex %>
	<%=code %>
</div>

</body>
</html>