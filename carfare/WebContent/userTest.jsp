<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String loginkey = null;
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
	<p>遷移成功</p>

<p>name:  <%=request.getAttribute("user_name") %></p>
<p>address: <%=request.getAttribute("address") %></p>
<p>loginkey: <%=request.getAttribute("loginkey") %></p>
<p>role_name: <%=request.getAttribute("role_name") %></p>
<p>role_id: <%=request.getAttribute("role_id") %></p>






</body>
</html>