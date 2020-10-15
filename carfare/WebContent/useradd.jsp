<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
	<%String getErr = (String) request.getAttribute("getErr");	%>
<!DOCTYPE html>
<html>
<head>
<link href="../login.css" rel="stylesheet"></link>
<meta charset="UTF-8">
<title>ログイン</title>
</head>
<body>
	<h1>交通費登録システム：ユーザー登録</h1>
	<form action="UserAdd" method="post">
		<table>
			<tr>
				<th>メールアドレス:</th>
				<td><input type="text" name="address"></td>
			</tr>
			<tr>
				<th>パスワード:</th>
				<td><input type="password" name="Password"></td>
			</tr>
			<tr>
				<th>パスワード(確認):</th>
				<td><input type="password" name="Password2"></td>
			</tr>
			<tr>
				<th>役職:</th>
				<td><select name="role" >
					<option value="3">役職を選択してください</option>
					<option value="1">一般</option>
					<option value="2">管理者</option>
					</select>
				</td>
			</tr>
			<tr>
				<th></th>
				<td><input type="submit" class="btn" value="登録"></td>
				<td><input type="submit" class="btn" value="キャンセル"></td>
			</tr>
		</table>
	</form>

<% if (getErr != null){ %>
	<%=getErr%>
	<%}%>

</body>
</html>