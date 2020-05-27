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
  					BoardDAOImpl dao = new BoardDAOImpl();
  					List<BoardDTO> list = dao.getPost_all();
  					SimpleDateFormat format1 = new SimpleDateFormat("h:mm a");
  					SimpleDateFormat format2 = new SimpleDateFormat("yyyy-MM-dd");
  					for(int i=0; i<list.size(); i++){
  						Date now = new Date();
  						Date bdate = list.get(i).getB_date();
  						System.out.println(bdate);
  						long calDate = now.getTime()-bdate.getTime();
  						long calDateDays = calDate / (1000*60*60*24);
  						String to = "";
  						if(calDateDays < 1){
  							to = format1.format(bdate);
  						}else{
  							to = format2.format(bdate);
  						}
  						
  				%>		
	  				<tr>
	  					<td><%=list.get(i).getB_no() %></td>
		  				<td><%=list.get(i).getTitle()%></td>
		  				<td style="text-align: center;"><%=list.get(i).getLikes()%></td>
		  				<td style="text-align: center;"><%=list.get(i).getUnlikes()%></td>
		  				<td style="text-align: center;"><%=list.get(i).getWriter_name()%></td>
		  				<td style="text-align: center;"><%=to%></td>
		  			</tr>
		  			
  				<%	}%>
  			</tbody>
  		</table>
	</div>
<div align="center">
	 
	<%
		int totalPost = dao.getCount();
		int postPerPg = 4;
		int totalPg;		
		int pgPerBlock = 5;
		int totalBlock;
		int now_pg = 1;
		int now_block = 1;
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
		ArrayList<int[]> blocks = new ArrayList<int[]>();
		
		for(int i=0; i<totalPg; i++){
			pages.add(i);
		}
		for(int i=0; i<totalPg; i++){
			
		}
		
		
		
		/* int[][] Blocks = new int[totalBlock][pgPerBlock];
		
		System.out.println(totalBlock);
		System.out.println(pgPerBlock);
		System.out.println(totalPg);
		
		for(int i=0; i<1; i++){
			int temp_totalPg = totalPg;
			
			for(int j=0; j<totalBlock; j++){
				
				for(int k=0; k<pgPerBlock; k++){
					if(temp_totalPg == 0){
						break;
					}
					Blocks[j][k] = k;
					temp_totalPg = temp_totalPg-1;
					System.out.println(temp_totalPg);
				}
				
			}
		} */
	%>
		
</div>

	
</body>
</html>

























