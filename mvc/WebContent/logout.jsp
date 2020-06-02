<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<%
response.setHeader("Cache-Control", "no-store");
response.setHeader("Pragma","no-cache");
response.setDateHeader("Expires",0);
if(request.getProtocol().equals("HTTP/1.1"))
	response.setHeader("Cache-Control","no-cache");
%>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
session.invalidate();
%>

<script type="text/javascript">
alert("로그아웃 되었습니다! 메인페이지로 이동합니다.");
window.location.replace("login_main.jsp");
/* window.location.href 로 하면 모바일에서 안먹힘 그리고 뒤로가기가 되서 보안상 취약*/
</script>
</body>
</html>