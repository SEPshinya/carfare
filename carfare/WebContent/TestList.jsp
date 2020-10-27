<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" %>

    <%
	String np = (String)request.getParameter("np");


	%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<p>loginkey</p>
<%= request.getAttribute("loginkey")%>


<br>
<%//<input type="text" name="price" value="<%=(String)request.getParameter("np")%>
</body>
</html>