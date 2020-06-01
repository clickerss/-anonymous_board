<%@page import="java.awt.print.Paper"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.util.Date"%>
<%@page import="com.jsp.board.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.jsp.board.BoardDAOImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String name = (String)session.getAttribute("name");
BoardDAOImpl dao = new BoardDAOImpl();

int now_pg;
int postPerPg=5;
int now_block;
int totalBlock;
int totalPg;
int pgPerBlock = 4;
int totalPost = dao.getCount();

if(totalPost%postPerPg > 0){
	totalPg = totalPost/postPerPg +1;
}else{
	totalPg = totalPost/postPerPg;
}
if(totalPg%pgPerBlock > 0){
	totalBlock = totalPg/pgPerBlock+1;
}else{
	totalBlock = totalPg/pgPerBlock;
}

if(request.getParameter("now_pg") != null){
	now_pg = Integer.parseInt(request.getParameter("now_pg"));
}else{
	now_pg = 0;
}
if(request.getParameter("postPerPg") != null){
	postPerPg = Integer.parseInt(request.getParameter("postPerPg"));
}
if(request.getParameter("now_block") != null){
	now_block = Integer.parseInt(request.getParameter("now_block"));

	if(Integer.parseInt(request.getParameter("now_block")) < 0){
		now_block = 0;
	}
	if(Integer.parseInt(request.getParameter("now_block")) >= totalBlock-1){
		now_block = totalBlock-1;
	}
}else{
	now_block=0;
}
int back = now_block-1;
int forward = now_block+1;
if(forward > totalBlock-1){
	forward = totalBlock-1;
}


		


List<BoardDTO> a = dao.getPost_all(now_pg, pgPerBlock);

List<Integer> pages = new ArrayList<>();
ArrayList<List<Integer>> blocks = new ArrayList<List<Integer>>();

// 전체 글 수에서 페이지당 글수를 나눠서 0으로 딱 떨어지면 나눈값이 totalPg
// 만약 나눴을때 값이 남을 경우 나눈값+1 이 totalPg
if(totalPost%postPerPg > 0){
	totalPg = totalPost/postPerPg +1;
}else{
	totalPg = totalPost/postPerPg;
}

// 블록당 페이지수보다 전체 페이지수가 적을경우
// 블록당 페이지수를 전체페이지수로 대입
if(totalPg<pgPerBlock){
	pgPerBlock = totalPg;
}

for(int i=0; i<totalPg; i++){
	pages.add(i);
}

int count = 1;
while(true){			
	if(pgPerBlock*count > totalPg){
		blocks.add(pages.subList(pgPerBlock*count-pgPerBlock, totalPg));
		break;
		
	}else if(pgPerBlock*count < totalPg){
		blocks.add(pages.subList(pgPerBlock*count-pgPerBlock, pgPerBlock*count));
		
	}else if(pgPerBlock*count == totalPg){
		blocks.add(pages.subList(pgPerBlock*count-pgPerBlock, totalPg));
		break;
	}	
	count++;
} 


%>

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
  <a class="navbar-brand" href="#">익명 게시판</a>
  <button class="navbar-toggler" type="button" data-toggle="collapse" data-target="#navbarNav" aria-controls="navbarNav" aria-expanded="false" aria-label="Toggle navigation">
    <span class="navbar-toggler-icon"></span>
  </button>
  <div class="collapse navbar-collapse" id="navbarNav">
    <ul class="navbar-nav">
      <li class="nav-item active">
        <a class="nav-link" href="#">Home <span class="sr-only">(current)</span></a>
      </li>
      <li class="nav-item">
        <a class="nav-link" href="#">게시판</a>
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
	sb.append(name+"님 반갑습니다!");
	sb.append("<a class=\"btn btn-default\" href=\"./logout.jsp\" id=\"logout_button\"><span class=\"badge badge-secondary\">로그아웃</span></a>");
	sb.append("</div>");
}

%>

<div align="right" style="margin-right: 10px" id="login_logout_button">
	<%=sb %>
</div>	
<div>
	<table class="table table-sm">
 			<thead>
   			<tr>
		      <th style="width: 5%">#</th>
		      <th style="width: 40%; text-align: center;">title</th>
		      <th style="width: 5%; text-align: center;">like</th>
		      <th style="width: 5%; text-align: center;">cmt</th>
		      <th style="width: 20%; text-align: center;">writer</th>
		      <th style="width: 25%; text-align: center;">date</th>
		    </tr>
 			</thead>
 			<tbody>
			<% 					
				List<BoardDTO> list = dao.getPost_all(now_pg, postPerPg);
				SimpleDateFormat format1 = new SimpleDateFormat("h:mm a");
				SimpleDateFormat format2 = new SimpleDateFormat("yyyy-MM-dd");

 				for(int i=0; i<list.size(); i++){
 					Date now = new Date();
 					Date bdate = list.get(i).getB_date();
 					System.out.println(bdate);
 					long calDate = now.getTime()-bdate.getTime();
 					long calDateDays = calDate / (1000*60*60*24);
 					System.out.println(calDate);
 					String to = "";
 					if(calDateDays < 1){
 						to = format1.format(bdate);
 					}else{
 						to = format2.format(bdate);
 					}
 						
 			%>		
  				<tr>
  					<td><%=list.get(i).getB_no() %></td>
	  				<td><a href="post_view.jsp?b_no=<%=list.get(i).getB_no()%>"><%=list.get(i).getTitle()%></a></td>
	  				<td style="text-align: center;"><%=list.get(i).getLikes()%></td>
	  				<td style="text-align: center;"><%=list.get(i).getCmt()%></td>
	  				<td style="text-align: center;"><%=list.get(i).getWriter_name()%></td>
	  				<td style="text-align: center;"><%=to%></td>
	  			</tr>
  			
			<%	}%>
			</tbody>
	</table>
</div>
<nav aria-label="Page navigation example" >
	<ul class="pagination justify-content-center">	
		<li><a class="page-link" href="board.jsp?now_block=<%=back%>">◀</a></li>	
		<%
			for(int i=0; i<blocks.get(now_block).size(); i++){
		%>
			<li class="page-item"><a class="page-link" href="board.jsp?now_block=<%=now_block%>&now_pg=<%=blocks.get(now_block).get(i)%>"><%=blocks.get(now_block).get(i)+1 %></a></li>
		<%
			}
		%>
		<li><a class="page-link" href="board.jsp?now_block=<%=forward%>&now_pg=<%=blocks.get(forward).get(0)%>">▶</a></li>	
	</ul>		
</nav>
</body>
</html>

























