<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	String getErr = (String) request.getAttribute("getErr");
%>

<%
	String user_name = request.getParameter("user_name");
	String address = request.getParameter("address");
	String loginkey = null;
	String role_name = request.getParameter("role_name");
	String role_id = request.getParameter("role_id");
%>



<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title></title>
</head>
<body>
	<form action="Login" method="post">
		<table>
			<tr>
				<th>address: </th>
				<td><input type="text"  name="address" class="user_name"></td>
				<th>password:</th>
				<td><input type="password"  name="password" class="pass"></td>
			</tr>
	        <tr>
				<td></td>
				<td><input type="submit" class="btn" formaction="Login"
					value="確認">
			</tr>
		</table>





	</form>
</body>
</html>