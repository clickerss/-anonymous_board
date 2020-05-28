<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<%
String name = (String)session.getAttribute("name");
System.out.println(name);
session.invalidate();
System.out.println(name);
%>

<script type="text/javascript">
alert("로그아웃 되었습니다! 메인페이지로 이동합니다.");
window.location.replace("login_main.jsp");
/* window.location.href 로 하면 모바일에서 안먹힘 그리고 뒤로가기가 되서 보안상 취약*/
</script>
</body>
</html>