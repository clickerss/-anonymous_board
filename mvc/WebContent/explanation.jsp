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
	<% 
	StringBuilder sb = new StringBuilder();
	StringBuilder sb2 = new StringBuilder();
	if(name == null){
		sb.append("<div id=\"login\">");
		sb.append("<button class=\"btn btn-outline-primary\" data-target=\"#layerpop\" data-toggle=\"modal\" id=\"login_button\">로그인</button>");
		sb.append("</div>");
		sb2.append("<li class=\"nav-item\">");
		sb2.append("<a class=\"nav-link\" data-target=\"#layerpop\" data-toggle=\"modal\" id=\"login_button\">내정보</a>");
		sb2.append("</li>");		
	}else{
		sb.append("<div id=\"logout\">");
		sb.append("<small class=\"text-muted jg\"><b>"+name+"</b>님 반갑습니다!</small>");
		sb.append("<a class=\"btn btn-default\" href=\"./logout.jsp\" id=\"logout_button\"><span class=\"badge badge-secondary\">로그아웃</span></a>");
		sb.append("</div>");
		sb2.append("<li class=\"nav-item\">");
		sb2.append("<a class=\"nav-link\" href=\"myPage.jsp\">내 정보</a>");
		sb2.append("</li>");
	}
	
	%>
	<nav class="navbar navbar-expand-lg navbar-light bg-light" id="up">
	  <a class="navbar-brand ng" href="login_main.jsp"><b>익명 게시판</b></a>
	  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
	    <span class="navbar-toggler-icon"></span>
	  </button>
	  <div class="collapse navbar-collapse" id="navbarNav">
	    <ul class="navbar-nav">
	      <li class="nav-item active">
	        <a class="nav-link" href="login_main.jsp">Home <span class="sr-only">(current)</span></a>
	      </li>
	      <li class="nav-item">
	        <a class="nav-link" href="board.jsp">게시판</a>
	      </li>
	      <%=sb2 %>
	      <li class="nav-item">
	        <a class="nav-link disabled" href="explanation.jsp">사이트 설명</a>
	      </li>
	    </ul>
	  </div>
	</nav>



<br><br><br>
<ul class="nav nav-tabs"id="home">
  <li class="nav-item">
    <a class="nav-link" href="#home">Home 화면</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="#join">회원가입 화면</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="#login">로그인/로그아웃 화면</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="#board">게시판 화면</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="#mypage">마이페이지 화면</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="#up">▲ 맨 위로</a>
  </li>
</ul>
<h2> Home 화면 </h2>
<pre>
	1. 회원가입 버튼
	
	2. 로그인, 로그아웃 버튼
		- 네비게이션 우측 하단에 div를 생성해놓고 jsp를 활용
		- 세션값("name")이 null일 경우 로그인 모달창 활성화 버튼을
		    생성하는 태그를 StringBuilder 변수에 저장
		- 세션값("name")이 null이 아닐경우  "(사용자name)님 환영합니다"
		    및 로그아웃 버튼을 StringBuilder 변수에 저장
		- StringBuilder 변수를 미리 만들어둔 div에서 출력
		
	3. 로고이미지
		- Bootstrap에 carousel slide를 활용
		- icon8 사이트에서 동일 사이즈 이미지 2장 주소 복사
		- 2000ms마다 사진이 토글되도록 설정
</pre><br><br><br><br><br>
<ul class="nav nav-tabs" id="join">
  <li class="nav-item">
    <a class="nav-link" href="#home">Home 화면</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="#join">회원가입 화면</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="#login">로그인/로그아웃 화면</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="#board">게시판 화면</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="#mypage">마이페이지 화면</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="#up">▲ 맨 위로</a>
  </li>
</ul>
<h2> 회원가입 화면 </h2>
<pre>
	1. ajax로 ID 중복체크
	2. javascript로 input 누락 시 submit이 되지 않고 각각의 경고창 발생
	3. 이메일 인증화면으로 데이터 전송
	4. 이메일인증
		- activation.jar, javax.mail.jar 설치
		- 이메일 전송할 계정 보안수준 설정
		- random 함수로 임의 코드 생성 및 input hidden에 저장
		- 이용자가 입력한 code와 저장된 code의 일치여부 확인
		- dao에 구현해놓은 insert 메서드를 jsp에서 호출하여 db에 저장
</pre><br><br><br><br><br>
<ul class="nav nav-tabs" id="login">
  <li class="nav-item">
    <a class="nav-link" href="#home">Home 화면</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="#join">회원가입 화면</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="#login">로그인/로그아웃 화면</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="#board">게시판 화면</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="#mypage">마이페이지 화면</a>    
  </li>
  <li class="nav-item">
    <a class="nav-link" href="#up">▲ 맨 위로</a>
  </li>
</ul>
<h2> 로그인 / 로그아웃 화면 </h2>
<pre>
	1. 로그인 : modal창 안에 form을 만들고 버튼에 ajax를 호출하는 함수를 onclick으로 설정
			  jsp <-> servlet(userCheck) <-> DAO(dao내부의 userchk메서드)

	2. userCheck 서블릿 : dao.userchk에서 얻은 boolean값을 활용하여
						true일 경우 회원 정보를 session에 set한다음 main화면 주소를 담고
						false일 경우 로그인 실패라는 String을 담아서 송신함
			
	3. UserDAO.usercheck 메서드 : 파라미터로 id, pwd를 받아서 db접속 후 유저테이블에
								해당 아이디와 비밀번호가 있는지 조회 후 
								executeQuery값에 따라 boolean값을 리턴
				
	4. jsp : 서블릿에서 받은 json 값을 토대로 if 문을 활용해서
			 정보가 불일치 할 경우 경고 모달창을 띄우고
			정보가 일치할 경우 메인페이지로 이동하는 로직 실행
</pre><br><br><br><br><br>
<ul class="nav nav-tabs" id="board">
  <li class="nav-item">
    <a class="nav-link" href="#home">Home 화면</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="#join">회원가입 화면</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="#login">로그인/로그아웃 화면</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="#board">게시판 화면</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="#mypage">마이페이지 화면</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="#up">▲ 맨 위로</a>
  </li>
</ul>
<h2> 게시판 화면 </h2>
<pre>
	1. 글 목록 및 페이징 로직
		1) BoardDAO.getCount 메서드 : 게시판 테이블에 총 몇개의 게시글이 있는지 확인하여 int로 리턴해주는 메서드
		2) jsp에서 BoardDAO.getCount메서드를 활용하여 총 게시물 수를 변수에 저장
		3) 한 페이지당 몇개의 게시물을 보여줄건지, 한 블럭당 몇개의 페이지가 있을건지 결정하여 변수에 상수값 저장
		 
		 (!) 블럭이란? 페이지들의 묶음으로서 예를들어 블럭당 5페이지 씩 보이게 설정한다고 하면
			< 1,2,3,4,5 >, <6,7,8,9,10> ...이런 식으로 나타나게됨
			
		4) 총게시물, 페이지당 게시물, 블럭당 페이지
		     위의 3가지 확정된 값을 이용하여 총 블럭갯수, 총 페이지를 계산
			(단순히 total에서 per 값을 나누면 오차가 발생하므로 나머지값이 딱 안떨어질 경우 결과값에 +1을 해줌)
			
		5) 페이지를 1~totalPage 까지 하나씩 list에 넣고
		6) 이 list를 subList하여 blocks라는 2차원 배열 생성 후 add하여 페이징 객체 구현
		7) nowPage라는 int 변수를 만들어서 현재 페이지가 어디인지를 변수에 저장할수 있게함
		8) nowBlock이라는 int 변수를 만들어 현재 블록이 어디인지를 변수에 저장
		9) back과 forward라는 int 변수를 만들어 블록 이동 시 활용하게끔 구현
		10) jsp를 활용해 blocks.get(now_block)의 사이즈만큼 for문을 돌려서 페이지 버튼 생성			
		
		11) BoardDAO.getPost_all 메서드 : now_pg, postPerPg 두개의 파라미터를 받아서 
										쿼리문 작성시 limit에 해당 값들을 넣어서 
										원하는 페이지의 게시물만 리턴하게끔 구현
										
		12) jsp에서 getPost_all메서드의 리턴값을 list라는 변수에 저장하고
		       이 변수의 사이즈 만큼 for문을 돌려서 tr > td 생성 
		
			(!) 이때 date 칼럼은 SimpleDateFormat과 Date의 now 함수를 활용하여 
				오늘 날짜와 작성 날짜를 비교하여
				같은 날에 작성된 게시물의 경우 시:분 으로 format하고
				다른 날(즉, 최신글이 아닌 어제 혹은 그 이전)에 작성된 게시물은 년년년년-월월-일일 형태로 format 구현
			
		13) td > a 태그안에 상세보기화면.jsp경로에 get방식 파라미터를 추가하여 
			게시물 클릭 시 post_view.jsp?b_no=? 식으로 이동하게끔 구현


	2. 게시글 상세보기 화면
		1) BoardDAO.getPost_bno 메서드 : 파라미터로 게시물의 고유번호를 받아서 해당 게시물의 
					제목,내용,작성자,작성일, 조회수,댓글수,좋아요수,싫어요수를 
					게시물DTO에 set하여 게시물DTO객체 리턴
		2) jsp에서 위의 메서드를 호출하여 객체의 정보들을 출력
		3) 좋아요 버튼과 싫어요 버튼
			- db에 liketable과 unliketable을 따로 만들어서 컬럼 2개(게시물번호, 유저id)를 생성한다
			- 이렇게 하는 이유는 좋아요를 한사람이 여러개를 찍는것을 방지하기위해
			- 좋아요 업데이트 시 먼저 테이블에 해당 유저의 id값을 갖는 row가 있는지 조회 후
			- 있을 경우 delete쿼리를 없을경우 insert쿼리를 실행함
		4) 수정 / 삭제
			- 우선 jsp로 세션("id")을 변수 id에 저장, jsp 변수 id 를 javascript 변수 id 에 저장
			- jquery를 이용하여 id 가 "null"일 경우 수정버튼, 삭제버튼 hide() 하게끔 구현
			
			- 삭제 : ajax로 deletePost 서블릿에서 BoardDAO.deletePost 메서드를 호출하여
				      삭제 진행 후 다시 jsp로 boolean값 송신, 
				   true = location.replace로 게시글목록 jsp로 이동,
				   false = 삭제실패 경고창발생
				   
			- 수정 : 게시글의 정보를 담고있는 hidden input들의 정보를 modify_post.jsp로 submit
				   modify_post.jsp에서 b_no와 title, contents 3가지를 request받아서
				   modifyPostForm의 input에 default value로 출력
				     버튼을 누르면 정합성 insert와 동일한 정합성 검사 후 ajax로 modifyPost와 통신하여
				   update table 한 후 성공되면 location.replace = document.referrer;를 이용하여
				     뒤로가기 이후 새로고침하여 post_view.jsp 화면에서 수정된 글의 제목과 본문을 확인할 수 있음
				
		5) 댓글작성
			-ajax를 활용하여 insertCmt 서블릿에 댓글form에 있는 댓글을 전송하여 댓글 테이블에 insert
		6) 댓글목록
			-게시글 가져오는 로직에서 페이지 대신에 b_no를 매개변수로 입력하여 해당 게시글에대한
			-모든 댓글들을 list객체에 담고 list의 사이즈만큼 작성자,작성일,댓글내용을 출력
</pre><br><br><br><br><br>
<ul class="nav nav-tabs" id="mypage">
  <li class="nav-item">
    <a class="nav-link" href="#home">Home 화면</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="#join">회원가입 화면</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="#login">로그인/로그아웃 화면</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="#board">게시판 화면</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="#mypage">마이페이지 화면</a>
  </li>
  <li class="nav-item">
    <a class="nav-link" href="#up">▲ 맨 위로</a>
  </li>
</ul>
<h2> 마이페이지 화면 </h2>
<pre>
	1. 회원정보 :  jsp에서 UserDAO.getUser 메서드를 활용하여 
				session의 id 값을 파라미터로 넣어서
				리턴값들(닉네임, id, email 등등...)을 출력
				
	2. 좋아요/싫어요/댓글 갯수 : UserDAO.countLk,countUnlk,countCmt 메서드들을 호출해서 리턴값을 출력
	
	3. 나의 글 목록 : BoardDAO.getPost_writer 메서드를 활용하여 
				   유저 id 를 파라미터로 넣어서 리턴값을 list에 담고 
				  for문을 이용하여 하나씩 출력 
</pre>
<br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br><br>
<div align="center">
	<h1>감사합니다!</h1>
</div>
<br><br><br><br><br><br><br><br><br>




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