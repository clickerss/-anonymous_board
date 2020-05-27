<%@page import="com.jsp.board.BoardDTO"%>
<%@page import="java.util.List"%>
<%@page import="com.jsp.board.BoardDAOImpl"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
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
  						BoardDAOImpl dao = new BoardDAOImpl();
  						List<BoardDTO> list = dao.getPost_all();
  						for(int i=0; i<list.size(); i++){
  					%>
	  					<tr>
	  						<td><%=list.get(i).getB_no() %></td>
		  					<td><%=list.get(i).getTitle()%></td>
		  					<td style="text-align: center;"><%=list.get(i).getLikes()%></td>
		  					<td style="text-align: center;"><%=list.get(i).getUnlikes()%></td>
		  					<td style="text-align: center;"><%=list.get(i).getWriter_name()%></td>
		  					<td style="text-align: center;"><%=list.get(i).getB_date()%></td>
		  				</tr>
		  				
  					<%	}%>
  				
  			</tbody>
  		</table>
	</div>
</body>
</html>