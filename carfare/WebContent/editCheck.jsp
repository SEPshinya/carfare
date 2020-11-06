<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="common.*" import="java.sql.*"
	import="java.text.NumberFormat"%>
<%
	//使用する変数の宣言、初期値の設定
	CommonUpdData data = (CommonUpdData) request.getAttribute("data");

	String route_name = CommonDB.getRouteName(data.getRoute_no());
	String transit_name = CommonDB.getTransitName(data.getTransit_no());
	int price = Integer.parseInt(data.getPrice().replace(",", "")) * Integer.parseInt(data.getRoute_no());

	//Edit.javaで作成したアップデートデータクラスをセッションに追加
	request.getSession().setAttribute("upddata", data);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./css/editCheck.css">
<title>交通費登録システム：編集確認</title>
</head>
<body>
	<h2>交通費登録システム：編集画面</h2>
	<%
		/*
		入力された値を表示
		プルダウンメニューから取得された値は、
		CommonDB.getRouteName(getTransitName)を使用して各値名を取得
		*/
	%>
	<form action="./EditCheck" class="table">
		<table>
			<tr>
				<th>日付</th>
				<th>:</th>
				<td><%=data.getDay()%><input type="hidden" name="day"
					value="<%=data.getDay()%>"></td>
			</tr>
			<tr>
				<th>片道or往復</th>
				<th>:</th>
				<td><%=route_name%><input type="hidden" name="route_name"
					value="<%=route_name%>"></td>
			</tr>
			<tr>
				<th>交通機関</th>
				<th>:</th>
				<td><%=transit_name%><input type="hidden" name="transit_name"
					value="<%=transit_name%>"></td>
			</tr>
			<tr>
				<th>出発駅</th>
				<th>:</th>
				<td><%=data.getFrom_st()%><input type="hidden" name="from_st"
					value="<%=data.getFrom_st()%>"></td>
				<th class="to">－ 到着駅</th>
				<th>:</th>
				<td><%=data.getTo_st()%><input type="hidden" name="to_st"
					value="<%=data.getTo_st()%>"></td>
			</tr>
			<tr>
				<th>金額</th>
				<th>:</th>
				<td><%=data.getPrice().isEmpty() ? "0円": NumberFormat.getNumberInstance().format(price) + "円"%>
				<input type="hidden" name="price" value="<%=data.getPrice()%>"></td>
			</tr>
		</table>
		<br>
		<div>
			<input type="hidden" name="id" value="<%=data.getId()%>">
		</div>
		<div>
			<input type="submit" value="編集" class="leftbtn btn">
		</div>
		<div>
			<input type="submit" value="戻る" formaction="./edit.jsp"
				class="rightbtn btn">
		</div>
	</form>


</body>
</html>