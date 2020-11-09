<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<link href="./css/user.css" rel="stylesheet"></link>
<meta charset="UTF-8">
<title>ユーザー検索</title>
</head>
<body>
	<h2>交通費登録システム：ユーザー編集（検索）</h2>
	<form action="UserSearch">
		<table class="tablesearch">
			<tr>
				<th>ユーザーID:</th>
				<td><input type="text" name="user_id" class="id"></td>
			</tr>
			<tr>
				<th>氏名:</th>
				<td><input type="text" name="user_name" class="name"></td>
			</tr>
		</table>
		<br>
		<br>
		<input type="submit" value="検索" class="btn btn-border"><input type="submit" class="btn btn-border btn2" formaction="List" value="戻る">

	</form>
<br>
<br>
<%
		String getErr = (String) request.getAttribute("getErr");
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