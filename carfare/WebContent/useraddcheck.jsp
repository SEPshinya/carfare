<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ユーザ登録確認</title>
</head>
<body>
	<h1>交通費登録システム：ユーザー登録(確認)</h1>
	<form action="UserAddcheck" method="post">
		<table>
			<tr>
				<th>氏名:</th>
				<td><%= request.getAttribute("user_name") %></td>
			</tr>
			<tr>
				<th>メールアドレス:</th>
				<td><%= request.getAttribute("address") %></td>
			</tr>

			<tr>
				<th>役職:</th>
				<td><%= request.getAttribute("role_name") %></td>
			</tr>
			<tr>
				<th></th>
				<td><input type="submit" class="btn" value="登録"></td>
				<td><input type="submit" class="btn" value="キャンセル"></td>
			</tr>
		</table>
		<input type=hidden value="<%= request.getAttribute("user_name") %>" name="user_name">
		<input type=hidden value="<%= request.getAttribute("address") %>" name="address">
		<input type=hidden value="<%= request.getAttribute("loginkey") %>" name="loginkey">
		<input type=hidden value="<%= request.getAttribute("role_id") %>" name="role_id">
		<input type=hidden value="<%= request.getAttribute("salt") %>" name="salt">
	</form>

</body>
</html>