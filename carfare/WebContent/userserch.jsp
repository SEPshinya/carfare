<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ユーザー検索</title>
</head>
<body>
	<h2>交通費登録システム：ユーザー検索</h2>
	<form action="UserSerch">
		<table>
			<tr>
				<th>ユーザーID:</th>
				<td><input type="text" name="user_id" ></td>
			</tr>
			<tr>
				<th>氏名:</th>
				<td><input type="text" name="user_name"></td>
			</tr>
			<tr>
				<th></th>
				<td ><input type="submit" value="検索"></td>
			</tr>
		</table>

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