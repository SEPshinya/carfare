<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<!DOCTYPE html>
<html>
<head>
<link href="./css/user.css" rel="stylesheet"></link>
<meta charset="UTF-8">
<title>ログイン</title>
</head>
<body>
	<h2>交通費登録システム：ログイン</h2>
	<form action="./Login" method="post">

		<table>
			<tr>
				<th>メールアドレス:</th>
				<td><input type="text" name="address" class="address"></td>
			</tr>
			<tr>
				<th>パスワード:</th>
				<td><input type="password" name="password" class="pass"></td>
			</tr>
			<tr>
				<th></th>
				<td><input type="submit" formaction="Login" class="btn1" value="ログイン"></td>
			</tr>
		</table>
	</form>

<%
		String getErr = (String) request.getAttribute("message");
	%>
	<%
		if (getErr != null) {
	%>
	<p class="erro"><%=getErr%></p>
	<%
		}
	%>

</body>
</html>