<%@page import="com.jsp.board.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.jsp.board.BoardDAOImpl"%>
<%@page import="java.util.ArrayList"%>
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
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script type="text/javascript">
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
			<%
				List<BoardDTO> list = dao.getPost_all(now_pg, postPerPg);
				for(int i=0; i<list.size(); i++){
			%>
				<tr>
					<td><%=list.get(i).getB_no()%></td>
					<td><%=list.get(i).getTitle()%></td>
					<td style="text-align: center;"><%=list.get(i).getLikes()%></td>
					<td style="text-align: center;"><%=list.get(i).getUnlikes()%></td>
					<td style="text-align: center;"><%=list.get(i).getWriter_name()%></td>
					<td style="text-align: center;"><%=list.get(i).getB_date()%></td>
				</tr>
				
			<%
				}
			%>
			
		</tbody>
	</table>
</div>
<nav aria-label="Page navigation example" >
	<ul class="pagination justify-content-center">	
		<li><a class="page-link" href="list_test.jsp?now_block=<%=back%>">◀</a></li>	
		<%
			for(int i=0; i<blocks.get(now_block).size(); i++){
		%>
			<li class="page-item"><a class="page-link" href="list_test.jsp?now_block=<%=now_block%>&now_pg=<%=blocks.get(now_block).get(i)%>"><%=blocks.get(now_block).get(i)+1 %></a></li>
		<%
			}
		%>
		<li><a class="page-link" href="list_test.jsp?now_block=<%=forward%>&now_pg=<%=blocks.get(forward).get(0)%>">▶</a></li>	
	</ul>		
</nav>
[<%=blocks.get(0).get(0)%>]
[<%=blocks.get(1).get(0)%>]
[<%=blocks.get(2).get(0)%>]
<%=totalPg %>
<%=totalBlock %>
</body>
</html>