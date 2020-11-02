<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.sql.*"%>
<%
	request.setCharacterEncoding("UTF-8");
%>
<%
	ResultSet rs = (ResultSet) request.getAttribute("rs");
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" type="text/css" href="./css/user.css">
<title>交通費登録システム：削除</title>
</head>
<body>
	<form action="Delete">
		<p>下記交通情報を削除します。よろしいですか？</p>
		<table>
			<tr>
				<th>日付:</th>
				<td><%=request.getParameter("day")%></td>
			</tr>
			<tr>
				<th>片道or往復:</th>
				<td><%=request.getParameter("route_name")%></td>
			</tr>
			<tr>
				<th>交通機関:</th>
				<td><%=request.getParameter("transit_name")%></td>
			</tr>
			<tr>
				<th>出発駅:</th>
				<td><%=request.getParameter("from_st")%></td>
				<th>到着駅:</th>
				<td><%=request.getParameter("to_st")%></td>
			</tr>
			<tr>
				<th>金額:</th>
				<td><%=request.getParameter("price")%>円</td>
			</tr>

		</table>
		<table>
			<tr>
				<th></th>
				<td><input type="submit" value="削除" class="btn"> <input
					type="submit" value="戻る" formaction="List" class="btn"></td>
			</tr>
		</table>
		<input type="hidden" value=<%=request.getParameter("id")%> name="id">
	</form>

</body>
</html>