<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.ResultSet"%>
<%
	request.setCharacterEncoding("UTF-8");
	String getErr = (String) request.getAttribute("getErr");
	ResultSet rs = (ResultSet) request.getAttribute("rs");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ユーザー編集</title>
</head>
<body>
	<h2>交通費登録システム：ユーザー編集</h2>
	<form action="UserEdit" method="post">
		<%
			if (rs != null) {
				while (rs.next()) {
		%>
		<table>
			<tr>
				<th>ユーザーID:</th>
				<td><%=rs.getInt("user_id")%><input type="hidden"
					value="<%=rs.getInt("user_id")%>" name="user_id"></td>
			</tr>
			<tr>
				<th>氏名:</th>
				<td><input type="text" name="user_name" class="name"
					value="<%=rs.getString("user_name")%>"></td>
			</tr>
			<tr>
				<th>メールアドレス:</th>
				<td><input type="text" name="address" class="address"
					value="<%=rs.getString("address")%>"><input type="hidden"
					name="addressCH" class="address"
					value="<%=rs.getString("address")%>"></td>
			</tr>
			<tr>
				<th>パスワード:</th>
				<td><input type="password" name="Password" class="pass"></td>
			</tr>
			<tr>
				<th>パスワード(確認):</th>
				<td><input type="password" name="Password2" class="pass"></td>
			</tr>
			<%
				int role_id = rs.getInt("role_id");
			%>
			<tr>
				<th>役職:</th>
				<td><select name="role_id" class="role">
						<option value="1">一般</option>
						<option value="2" <%if (role_id == 2) {%> selected <%}%>>管理者</option>
				</select></td>
			</tr>
			<tr>
				<td></td>
				<td><input type="submit" class="btn" formaction="UserEdit"
					value="確認"><input type="submit" class="btn"
					formaction="usersearch.jsp" value="戻る"></td>
			</tr>
		</table>
		<%
			}
		%>
		<%
			} else if (getErr=="") {
		%>
		<table>
			<tr>
				<th>ユーザーID:</th>
				<td><%=request.getAttribute("user_id")%><input type="hidden"
					value="<%=request.getAttribute("user_id")%>" name="user_id"></td>
			</tr>
			<tr>
				<th>氏名:</th>
				<td><input type="text" name="user_name" class="name"
					value="<%=request.getAttribute("user_name")%>"></td>
			</tr>
			<tr>
				<th>メールアドレス:</th>
				<td><input type="text" name="address" class="address"
					value="<%=request.getAttribute("address")%>"><input
					type="hidden" name="addressCH" class="address"
					value="<%=request.getAttribute("addressCH")%>"></td>
			</tr>
			<tr>
				<th>パスワード:</th>
				<td><input type="password" name="Password" class="pass"></td>
			</tr>
			<tr>
				<th>パスワード(確認):</th>
				<td><input type="password" name="Password2" class="pass"></td>
			</tr>
			<%
				String role_id = (String) request.getAttribute("role_id");
			%>
			<tr>
				<th>役職:</th>
				<td><select name="role_id" class="role">
						<option value="1">一般</option>
						<option value="2" <%if (role_id.equals("2")) {%>selected<%} %>>管理者</option>
				</select></td>
			</tr>

			<tr>
				<td></td>
				<td><input type="submit" class="btn" formaction="UserEdit"
					value="確認"><input type="submit" class="btn"
					formaction="usersearch.jsp" value="戻る"></td>
			</tr>
		</table>
		<%
			} else {
		%>
		<table>
			<tr>
				<th>ユーザーID:</th>
				<td><%=request.getParameter("user_id")%><input type="hidden"
					value="<%=request.getParameter("user_id")%>" name="user_id"></td>
			</tr>
			<tr>
				<th>氏名:</th>
				<td><input type="text" name="user_name" class="name"
					value="<%=request.getParameter("user_name")%>"></td>
			</tr>
			<tr>
				<th>メールアドレス:</th>
				<td><input type="text" name="address" class="address"
					value="<%=request.getParameter("address")%>"><input
					type="hidden" name="addressCH" class="address"
					value="<%=request.getParameter("addressCH")%>"></td>
			</tr>
			<tr>
				<th>パスワード:</th>
				<td><input type="password" name="Password" class="pass"></td>
			</tr>
			<tr>
				<th>パスワード(確認):</th>
				<td><input type="password" name="Password2" class="pass"></td>
			</tr>
			<%
				String role_id = (String) request.getParameter("role_id");
			%>
			<tr>
				<th>役職:</th>
				<td><select name="role_id" class="role">
						<option value="1">一般</option>
						<option value="2"<%if (role_id.equals("2")) {%>selected<%} %>>管理者</option>
				</select></td>
			</tr>

			<tr>
				<td></td>
				<td><input type="submit" class="btn" formaction="UserEdit"
					value="確認"><input type="submit" class="btn"
					formaction="usersearch.jsp" value="戻る"></td>
			</tr>
		</table>
		<%
			}
		%>

	</form>


	<%
		if (getErr != null) {
	%>
	<p class="erro"><%=getErr%></p>
	<%
		}
	%>