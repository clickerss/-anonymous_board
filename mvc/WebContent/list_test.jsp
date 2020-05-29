<%@page import="com.jsp.board.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.jsp.board.BoardDAOImpl"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String name = (String)session.getAttribute("name");
BoardDAOImpl dao = new BoardDAOImpl();

int totalPost = dao.getCount();
int postPerPg = 10;
int totalPg;		
int pgPerBlock = 4;
int totalBlock;
int now_pg = 0;
int now_block = 0;
int last_block_pg;

// 전체 글 수에서 페이지당 글수를 나눠서 0으로 딱 떨어지면 나눈값이 totalPg
// 만약 나눴을때 값이 남을 경우 나눈값+1 이 totalPg
if(totalPost%postPerPg > 0){
	totalPg = totalPost/postPerPg +1;
}else{
	totalPg = totalPost/postPerPg;
}

// 위의 로직의 논리를 페이지와 페이지블록에 적용해서
// totalBlock을 구하는 로직
if(totalPg%pgPerBlock > 0){
	totalBlock = totalPg/pgPerBlock+1;
}else{
	totalBlock = totalPg/pgPerBlock;
}

// 블록당 페이지수보다 전체 페이지수가 적을경우
// 블록당 페이지수를 전체페이지수로 대입
if(totalPg<pgPerBlock){
	pgPerBlock = totalPg;
}


// 마지막 블록의 페이지수를 정의하는 로직
if(totalPg%pgPerBlock != 0){
	last_block_pg = totalPg%pgPerBlock;
}else{
	last_block_pg = pgPerBlock;
}

List<Integer> pages = new ArrayList<>();
ArrayList<List<Integer>> blocks = new ArrayList<List<Integer>>();

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
for(int i=0; i<blocks.size(); i++){
	System.out.println(blocks.get(i));
	for(int j=0; j<blocks.get(i).size(); j++){
		System.out.println(blocks.get(i).get(j));
	}
}
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
function login_check() {
	$.ajax({
		type : "post",
		url : "getPost",
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
			<tr>
				<td>test</td>
				<td>test</td>
				<td style="text-align: center;">test</td>
				<td style="text-align: center;">test</td>
				<td style="text-align: center;">test</td>
				<td style="text-align: center;">test</td>
			</tr>
		</tbody>
	</table>
</div>
<nav aria-label="Page navigation example" >
	<ul class="pagination justify-content-center">	
		<li><button class="page-link">◀</button></li>	
		<%
			for(int i=0; i<blocks.get(now_block).size(); i++){
		%>
			<li class="page-item"><button class="page-link" value=""><%=blocks.get(now_block).get(i)+1 %></button></li>
		<%
			}
		%>
		<li><button class="page-link">▶</button></li>	
	</ul>		
</nav>
</body>
</html>