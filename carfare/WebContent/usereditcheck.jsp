<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%

%>
<!DOCTYPE html>
<html>
<head>
<link href="./css/user.css" rel="stylesheet"></link>
<meta charset="UTF-8">
<title>ユーザー編集</title>
</head>
<body>
	<h2>交通費登録システム：ユーザー編集（確認）</h2>
	<form method="post">
	<p class="aa">下記情報でアカウントを登録します</p>
		<table class="tableusereditcheck">
			<tr>
				<th></th>
				<td><input type=hidden value="<%=request.getAttribute("user_id")%>" name="user_id"><input
					type=hidden value="<%=request.getAttribute("Password")%>"
					name="Password" class="id"></td>
			</tr>
			<tr>
				<th>氏名:</th>
				<td><%=request.getAttribute("user_name")%><input type=hidden value="<%=request.getAttribute("user_name")%>" name="user_name" class="name">
				</td>
			</tr>
			<tr>
				<th>メールアドレス:</th>
				<td><%=request.getAttribute("address")%><input type=hidden
					value="<%=request.getAttribute("address")%>" name="address" class="address"><input
					type=hidden value="<%=request.getAttribute("addressCH")%>"
					name="addressCH" ></td>
			</tr>

			<tr>
				<th>役職:</th>
				<td><%=request.getAttribute("role_name")%><input type=hidden value="<%=request.getAttribute("role_id")%>" name="role_id" name="role">
				</td>
			</tr>
		</table>
		<br>
		<input type="submit" formaction="Usereditcheck" class="btn btn-border"value="登録"><input type="submit" class="btn btn-border"formaction="useredit.jsp" value="戻る">
	</form>


</body>
</html>


