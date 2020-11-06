<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ユーザー編集</title>
</head>
<body>
	<h2>交通費登録システム：ユーザー編集（確認）</h2>
	<form method="post">
		<table>
			<tr>
				<th></th>
				<td><b>下記情報でアカウントを登録します</b><input type=hidden value="<%=request.getAttribute("user_id")%>"name="user_id"></td>
			</tr>
			<tr>
				<th>氏名:</th>
				<td><%=request.getAttribute("user_name")%><input type=hidden value="<%=request.getAttribute("user_name")%>"name="user_name"> </td>
			</tr>
			<tr>
				<th>メールアドレス:</th>
				<td><%=request.getAttribute("address")%><input type=hidden value="<%=request.getAttribute("address")%>" name="address"><input type=hidden value="<%=request.getAttribute("addressCH")%>" name="addressCH"></td>
			</tr>

			<tr>
				<th>役職:</th>
				<td><%=request.getAttribute("role_name")%><input type=hidden value="<%=request.getAttribute("role_id")%>" name="role_id"> </td>
			</tr>
			<tr>
				<th></th>
				<td><input type="submit"formaction="Usereditcheck" class="btn" value="登録"><input type="submit" class="btn" formaction="useredit.jsp" value="戻る"></td>
			</tr>
		</table>
	</form>


</body>
</html>


