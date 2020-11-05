<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="common.*" import="java.sql.*"%>
<%
String transit_name=CommonDB.getTransitName(request.getParameter("transit_no"));
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/transitDataDelete.css">
<title>Insert title here</title>
</head>
<body>
<form class="deletelist" action="TransitDataDelete" method="post">
		<p>下記交通情報を削除します。よろしいですか？</p>
		<table>
			<tr>
				<th>交通機関:</th>
				<td><%=transit_name%></td>
			</tr>
			<tr>
				<th>出発駅:</th>
				<td><%=request.getParameter("from_st")%></td>
				<th class="to">―到着駅:</th>
				<td><%=request.getParameter("to_st")%></td>
			</tr>
			<tr>
				<th>金額:</th>
				<td><%=request.getParameter("price")%>円</td>
			</tr>
		</table>
		<br>
		<input type="hidden" value=<%=request.getParameter("data_id")%> name="data_id">
		<input type="hidden" value="3" name="menulist">
	<input type="submit" value="削除" class="btn"> <input type="submit"value="戻る" formaction="TransitdataList" class="btn">
	</form>
</body>
</html>