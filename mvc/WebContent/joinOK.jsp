<%@page import="com.jsp.users.UserDAOImpl"%>
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
request.setCharacterEncoding("UTF-8");

UserDAOImpl dao = new UserDAOImpl();


String id = request.getParameter("id");
String name = request.getParameter("name");
String pwd = request.getParameter("pw");
String email = request.getParameter("email");
String sex = request.getParameter("sex");

dao.insertUser(id, name, pwd, email, sex);
System.out.print("insertUser 빠져나옴");
%>


</body>
</html>