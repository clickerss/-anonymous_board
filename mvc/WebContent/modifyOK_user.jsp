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
String pwd = request.getParameter("pwd");
String email = request.getParameter("email");
String sex = request.getParameter("sex");

dao.modifyUser(id, name, pwd, email, sex);
System.out.print("insertUser 빠져나옴");
session.invalidate();
response.sendRedirect("login_main.jsp");
%>
</body>
</html>