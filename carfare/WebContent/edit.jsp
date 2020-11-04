<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="common.CommonDB" import="java.sql.*"%>
<%
	//使用する変数の宣言、初期値設定(List,transitDataList)
	String id = request.getParameter("id") == null ? "" : request.getParameter("id");
	String day = request.getParameter("day") == null ? "" : request.getParameter("day");
	String route_name = request.getParameter("route_name") == null ? ""
			: request.getParameter("route_name");
	String route_no = request.getParameter("route_no") == null ? "0"
			: request.getParameter("route_no");
	String transit_name = request.getParameter("transit_name") == null ? ""
			: request.getParameter("transit_name");
	String transit_no = request.getParameter("transit_no") == null ? "0"
			: request.getParameter("transit_no");
	String from_st = request.getParameter("from_st") == null ? "" : request.getParameter("from_st");
	String to_st = request.getParameter("to_st") == null ? "" : request.getParameter("to_st");
	String price = request.getParameter("price") == null ? ""
			: request.getParameter("price").replace(",", "");
	String menulist = request.getParameter("menulist") == null ? "2" : request.getParameter("menulist");

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

	<div class="errmsg">
		<%
			//入力された値に対してエラーがあればエラー文を表示する
			if (!(errmsg.equals(""))) {
		%>
		<%=errmsg%><br>
		<%
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
								if (route_rs.getString("route_name").equals(route_name) ||
										route_rs.getInt("route_no") == Integer.parseInt(route_no)) {
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
			<!-- 交通手段一覧画面へ遷移 -->
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
				<th>金額</th>
				<th>:</th>
				<td><input type="text" name="price" value="<%=price%>"></td>
			</tr>
			<tr>
				<th></th>
				<th></th>
				<td>※金額は片道分のみ。</td>
			</tr>
		</table>
		<br> <input type="hidden" name="id" value="<%=id%>">
		<!-- 編集確認画面へ遷移 -->
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