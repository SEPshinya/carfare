<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="common.*" import="java.sql.*"%>
<%
	String id = request.getParameter("id") == null ? "" : request.getParameter("id");
	String day = (String) request.getParameter("day") == null ? "" : request.getParameter("day");
	String route_name = (String) request.getParameter("route_name") == null ? ""
			: request.getParameter("route_name");
	String transit_name = (String) request.getParameter("transit_name") == null ? ""
			: request.getParameter("transit_name");
	String from_st = (String) request.getParameter("from_st") == null ? "" : request.getParameter("from_st");
	String to_st = (String) request.getParameter("to_st") == null ? "" : request.getParameter("to_st");
	String price = (String) request.getParameter("price") == null ? "" : request.getParameter("price");

	String menulist = (String) request.getParameter("menulist") == null ? ""
			: (String) request.getParameter("menulist");
	String errmsg = (String) request.getAttribute("errmsg") == null ? ""
			: (String) request.getParameter("errmsg");

	ResultSet route_rs = CommonDB.getRouteAll();
	ResultSet transit_rs = CommonDB.getRouteAll();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>交通費登録システム：編集</title>
</head>
<body>
	<h2>交通費登録システム：編集画面</h2>

	<%
		if (!errmsg.equals("")) {
	%>
	<p><%=errmsg%></p>
	<%
		}
	%>

	<form action="/Edit.java">
		<table>
			<tr>
				<th>日付</th>
				<th>:</th>
				<td><input type="text" name="day"></td>
			</tr>
			<tr>
				<th>片道or往復</th>
				<th>:</th>
				<td><select name="route_no">
						<%
							while (route_rs.next()) {
								if (route_rs.getString("route_name").equals(route_name)) {
						%>
						<option value="<%=route_rs.getString("route_no")%>" selected><%=route_rs.getString("route_name")%></option>
						<%
							} else {
						%>
						<option value="<%=route_rs.getString("route_no")%>"><%=route_rs.getString("route_name")%></option>
						<%
							}
							}
						%>
				</select></td>
			</tr>
			<tr>
				<td><input type="hidden" name="menulist" value="<%=menulist%>">
					<input type="submit" formaction="/TransitDataList"
					value="以前のデータを参照"></td>
			</tr>
			<tr>
				<th>交通機関</th>
				<th>:</th>
				<td><select name="transit_no">
						<%
							while (transit_rs.next()) {
								if (transit_rs.getString("transit_name").equals(transit_name)) {
						%>
						<option value="<%=transit_rs.getString("transit_no")%>" selected><%=transit_rs.getString("transit_name")%></option>
						<%
							} else {
						%>
						<option value="<%=transit_rs.getString("transit_no")%>"><%=transit_rs.getString("transit_name")%></option>
						<%
							}
							}
						%>
				</select></td>
			</tr>
			<tr>
				<th>出発駅</th>
				<th>:</th>
				<td><input type="text" name="from_st"></td>
				<th>到着駅</th>
				<th>:</th>
				<td><input type="text" name="to_st"></td>
			</tr>
			<tr>
				<th>運賃</th>
				<th>:</th>
				<td><input type="text" name="price"></td>
			</tr>
		</table>

		<input type="hidden" value="<%=id%>">
		<div>
			<input type="submit" value="確認">
		</div>

	</form>

	<div>
		<form action="./List.java">
			<input type="submit" value="戻る">
		</form>
	</div>

</body>
</html>