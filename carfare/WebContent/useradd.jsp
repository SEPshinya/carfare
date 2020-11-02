<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	String getErr = (String) request.getAttribute("getErr");
%>
<!DOCTYPE html>
<html>
<head>
<link href="./css/user.css" rel="stylesheet"></link>
<meta charset="UTF-8">
<title>ユーザー新規登録</title>
</head>
<body>
	<h2>交通費登録システム：ユーザー登録</h2>
	<form action="AddCheck" method="post">
		<table>
			<tr>
				<th>氏名:</th>
				<td><input type="text" name="name" class="name"></td>
			</tr>
			<tr>
				<th>メールアドレス:</th>
				<td><input type="text" name="address" class="address"></td>
			</tr>
			<tr>
				<th>パスワード:</th>
				<td><input type="password" name="Password" class="pass"></td>
			</tr>
			<tr>
				<th>パスワード(確認):</th>
				<td><input type="password" name="Password2" class="pass"></td>
			</tr>
			<tr>
				<th>役職:</th>
				<td><select name="role" class="role">
						<option value="3">役職を選択してください</option>
						<option value="1">一般</option>
						<option value="2">管理者</option>
				</select></td>
			</tr>

			<tr>
				<td></td>
				<td><input type="submit" class="btn" formaction="UserAdd" value="確認"><input type="submit" class="btn" formaction="List" value="戻る"></td>
			</tr>
		</table>
	</form>

	<%
		if (getErr != null) {
	%>
	<p class="erro"><%=getErr%></p>
	<%
		}
	%>

</body>
</html>