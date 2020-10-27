<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");
	String day = (String) request.getParameter("day");
	String route_name = (String) request.getParameter("route_name");
	String transit_name = (String) request.getParameter("transit_name");
	String transit_no = (String) request.getParameter("transit_no");
	String from_st = (String) request.getParameter("from_st");
	String to_st = (String) request.getParameter("to_st");
	String price = (String) request.getParameter("price");
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>

	<h1>遷移成功</h1>
	<input type="text" name="day" value="<%=day%>">
	<br>
	<input type="text" name="route_name" value="<%=route_name%>">
	<br>
	<input type="text" name="transit_name" value="<%=transit_name%>">
	<br>
	<input type="text" name="from_st" value="<%=from_st%>">
	<br>
	<input type="text" name="to_st" value="<%=to_st%>">
	<br>
	<input type="text" name="price" value="<%=price%>">






</body>
</html>