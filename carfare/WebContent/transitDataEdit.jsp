<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="common.CommonDB" import="java.sql.*"%>
<%
	//使用する変数の宣言、初期値設定(List,transitDataList)
	String data_id = request.getParameter("data_id") == null ? "" : request.getParameter("data_id");
	String transit_name = request.getParameter("transit_name") == null ? ""
			: request.getParameter("transit_name");
	String transit_no = request.getParameter("transit_no") == null ? "0"
			: request.getParameter("transit_no");
	String from_st = request.getParameter("from_st") == null ? "" : request.getParameter("from_st");
	String to_st = request.getParameter("to_st") == null ? "" : request.getParameter("to_st");
	String price = request.getParameter("price") == null ? ""
			: request.getParameter("price").replace(",", "");
	String menulist = request.getParameter("menulist") == null ? "3" : request.getParameter("menulist");

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
<title>交通手段編集画面</title>
</head>
<body>
	<h2>交通費登録システム：交通手段編集画面</h2>
	<form action="TransitDataEdit" class="table">
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
		<table>
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
		<br> <input type="hidden" name="data_id" value="<%=data_id%>">
		<!-- 交通手段編集確認画面へ遷移 -->
		<div>
			<input type="submit" value="確認" class="leftbtn btn">
		</div>
	</form>
	<div>
		<!-- 一覧表示へ戻る -->
		<form action="TransitdataList">
			<input type="hidden" name="menulist" value="<%=menulist%>"> <input
				type="submit" value="戻る" class="rightbtn btn">
		</form>
	</div>

</body>
</html>