<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="common.*" import="java.sql.*"
	import="java.text.NumberFormat"%>
<%
	//値取得
	String data_id = (String) request.getAttribute("data_id") == null ? ""
			: (String) request.getAttribute("data_id");
	String transit_no = (String) request.getAttribute("transit_no") == null ? ""
			: (String) request.getAttribute("transit_no");
	String from_st = (String) request.getAttribute("from_st") == null ? ""
			: (String) request.getAttribute("from_st");
	String to_st = (String) request.getAttribute("to_st") == null ? ""
			: (String) request.getAttribute("to_st");
	String price = (String) request.getAttribute("price") == null ? ""
			: (String) request.getAttribute("price");

	//CommonDBを使って選択された交通機関名を取得
	String transit_name = CommonDB.getTransitName(transit_no);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="./css/editCheck.css">
<title>交通手段編集確認画面</title>
</head>
<body>
	<h2>交通費登録システム：交通手段編集画面</h2>
	<form action="./TransitDataEditCheck" class="table">
		<table>
			<tr>
				<th>交通機関</th>
				<th>:</th>
				<td><%=transit_name%><input type="hidden" name="transit_name"
					value="<%=transit_name%>"></td>
			</tr>
			<tr>
				<th>出発駅</th>
				<th>:</th>
				<td><%=from_st%><input type="hidden" name="from_st"
					value="<%=from_st%>"></td>
				<th class="to">－ 到着駅</th>
				<th>:</th>
				<td><%=to_st%><input type="hidden" name="to_st"
					value="<%=to_st%>"></td>
			</tr>
			<tr>
				<th>金額</th>
				<th>:</th>
				<td><%=NumberFormat.getNumberInstance().format(Integer.parseInt(price)) + "円"%>
					<input type="hidden" name="price" value="<%=price%>"></td>
			</tr>
		</table>
		<br>
		<div>
			<!-- 一覧表示へ遷移 -->
			<input type="hidden" name="data_id" value="<%=data_id%>"> <input
				type="hidden" name="menulist" value="3"> <input
				type="hidden" name="transit_no" value="<%=transit_no%>">
		</div>
		<div>
			<input type="submit" value="編集" class="leftbtn btn">
		</div>
		<div>
			<!-- 交通手段編集画面へもどる -->
			<input type="submit" value="戻る" formaction="./transitDataEdit.jsp"
				class="rightbtn btn">
		</div>
	</form>

</body>
</html>