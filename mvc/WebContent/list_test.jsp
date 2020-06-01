<%@page import="com.jsp.board.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.jsp.board.BoardDAOImpl"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%
String name = (String)session.getAttribute("name");
BoardDAOImpl dao = new BoardDAOImpl();
int now_pg=0;
int postPerPg=10;

/* if(request.getParameter("now_pg") != null){
	now_pg = Integer.parseInt(request.getParameter("now_pg"));
}
if(request.getParameter("pgPerBlock") != null){
	now_pg = Integer.parseInt(request.getParameter("pgPerBlock"));
}

int totalPost = dao.getCount();
int postPerPg = Integer.parseInt(request.getParameter("postPerPg"));
int totalPg;		
int now_block = Integer.parseInt(request.getParameter("now_block"));

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
} */


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
				<%-- <tr>
					<td><%=list.get(i).getB_no()%></td>
					<td><%=list.get(i).getTitle()%></td>
					<td style="text-align: center;"><%=list.get(i).getLikes()%></td>
					<td style="text-align: center;"><%=list.get(i).getUnlikes()%></td>
					<td style="text-align: center;"><%=list.get(i).getWriter_name()%></td>
					<td style="text-align: center;"><%=list.get(i).getB_date()%></td>
				</tr> --%>
				asdf
			<%
				}
			%>
			
		</tbody>
	</table>
</div>
<%-- <nav aria-label="Page navigation example" >
	<ul class="pagination justify-content-center">	
		<li><button class="page-link">◀</button></li>	
		<%
			for(int i=0; i<blocks.get(now_block).size(); i++){
		%>
			<li class="page-item"><a class="page-link" href="list_test.jsp?now_pg=<%=i%>"><%=blocks.get(now_block).get(i)+1 %></a></li>
		<%
			}
		%>
		<li><button class="page-link">▶</button></li>	
	</ul>		
</nav> --%>
</body>
</html>