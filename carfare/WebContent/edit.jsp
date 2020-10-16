<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="common.CommonDB" import="java.sql.*"%>
<%
	//使用する変数の宣言、初期値設定(List,transitDataList)
	String id = request.getParameter("id") == null ? "" : request.getParameter("id");
	String day = (String) request.getParameter("day") == null ? "" : request.getParameter("day");
	String route_name = (String) request.getParameter("route_name") == null ? ""
			: request.getParameter("route_name");
	String transit_name = (String) request.getParameter("transit_name") == null ? ""
			: request.getParameter("transit_name");
	String transit_no = (String) request.getParameter("transit_no") == null ? "0"
			: request.getParameter("transit_no");
	String from_st = (String) request.getParameter("from_st") == null ? "" : request.getParameter("from_st");
	String to_st = (String) request.getParameter("to_st") == null ? "" : request.getParameter("to_st");
	String price = (String) request.getParameter("price") == null ? "" : request.getParameter("price");
	String menulist = (String) request.getParameter("menulist") == null ? "2"
			: (String) request.getParameter("menulist");

	//使用する変数の宣言、初期値設定(Edit)
	String errmsg = (String) request.getAttribute("errmsg") == null ? ""
			: (String) request.getAttribute("errmsg");

	//使用する変数の宣言、初期値設定(プルダウンメニュー作成)
	ResultSet route_rs = CommonDB.getRouteAll();
	ResultSet transit_rs = CommonDB.getTransitAll();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./css/edit.css">
<title>交通費登録システム：編集</title>

</head>
<body>
	<h2>交通費登録システム：編集画面</h2>

	<div>
		<%
			//入力された値に対してエラーがあればエラー文を表示する
			if (!(errmsg.equals(""))) {
		%>
		<%=errmsg%>
		<%
			} else {
			}
		%>
	</div>


	<%
		//一覧表示に表示されていた値をinputの中へうめこむ
	%>
	<form action="./Edit" class="table">
		<table>
			<tr>
				<th>日付</th>
				<th>:</th>
				<td><input type="text" name="day" value="<%=day%>"></td>
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
				<th></th>
				<th></th>
				<td><input type="hidden" name="menulist" value="<%=menulist%>">
					<input type="submit" formaction="./TransitdataList"
					value="以前のデータを参照" class="btn"></td>
			</tr>
			<tr>
				<th>交通機関</th>
				<th>:</th>
				<td><select name="transit_no">
						<%
							while (transit_rs.next()) {
								if (transit_rs.getString("transit_name").equals(transit_name) ||
										transit_rs.getInt("transit_no") == Integer.parseInt(transit_no)) {
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
				<td><input type="text" name="from_st" value="<%=from_st%>"></td>
				<th class="to">－ 到着駅</th>
				<th>:</th>
				<td><input type="text" name="to_st" value="<%=to_st%>"></td>
			</tr>
			<tr>
				<th>運賃</th>
				<th>:</th>
				<td><input type="text" name="price" value="<%=price%>"></td>
			</tr>
		</table>
		<br>

		<input type="hidden" name="id" value="<%=id%>">
		<div>
			<input type="submit" value="確認" class="leftbtn btn">
		</div>

	</form>
	<div>
		<!-- 一覧表示へ戻る -->
		<form action="./List">
			<input type="submit" value="戻る" class="rightbtn btn">
		</form>
	</div>

</body>
</html>