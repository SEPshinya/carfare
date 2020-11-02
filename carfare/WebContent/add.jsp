<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.*"%>
<%
	/** 登録か編集かの判断値**/
	String menulist = (String) request.getAttribute("menulist");

	/** もし値の受け渡しがある場合用**/
	//日付
	String day = (String) request.getAttribute("day");
	//片道or往復
	String route_no = (String) request.getAttribute("route_no");
	//交通機関
	String transit_no = (String) request.getAttribute("transit_no");
	//出発駅
	String from_st = (String) request.getAttribute("from_st");
	//到着駅
	String to_st = (String) request.getAttribute("to_st");
	//金額
	String price = (String) request.getAttribute("price");

	/** DBから「route」を取得する用 **/
	ResultSet rs = (ResultSet) request.getAttribute("rs");

	/** DBから「transit」を取得する用  **/
	ResultSet rs1 = (ResultSet) request.getAttribute("rs1");

	String errmsg = (String) request.getAttribute("errmsg");
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/add.css">
<title>交通費登録システム：登録</title>
</head>
<body>
	<h2>交通費登録システム：登録</h2>

	<form class="addlist" method="post">

		<div class="err">
			<%
				if (errmsg != null) {
			%>
			<%=errmsg%>
			<%
				}
			%>
		</div>

		<table>
			<tr>
				<th>日付：</th>
				<td>
					<%
						if (day != null) {
					%><input type="text" name="day" value="<%=day%>"> <%
 	} else {
 %> <input type="text" name="day"> <%
 	}
 %>
				</td>
			</tr>
			<tr>
				<th>片道or往復：</th>
				<td><select name="route_no">
						<%
							while (rs.next()) {
								if (rs.getString("route_no").equals(route_no)) {
						%>
						<option value="<%=rs.getString("route_no")%>" selected><%=rs.getString("route_name")%></option>
						<%
							} else {
						%>
						<option value="<%=rs.getString("route_no")%>"><%=rs.getString("route_name")%></option>
						<%
							}
							}
						%>
				</select></td>
			</tr>
			<tr>
				<th>&nbsp;</th>
				<td><input type="hidden" name="menulist" value="<%=menulist%>">
					<input class="transitdatabt" type="submit"
					formaction="TransitdataList" value="以前のデータを参照"></td>
			</tr>

			<tr>
				<th>交通機関：</th>
				<td><select name="transit_no">
						<%
							while (rs1.next()) {
								if (rs1.getString("transit_no").equals(transit_no)) {
						%>
						<option value="<%=rs1.getString("transit_no")%>" selected><%=rs1.getString("transit_name")%></option>
						<%
							} else {
						%>
						<option value="<%=rs1.getString("transit_no")%>"><%=rs1.getString("transit_name")%></option>
						<%
							}
							}
						%>
				</select></td>
			</tr>

			<tr>
				<th>出発駅：</th>
				<td>
					<%
						if (from_st != null) {
					%> <input type="text" name="from_st" value="<%=from_st%>">
					<%
						} else {
					%> <input type="text" name="from_st"> <%
 	}
 %>
				</td>


				<th>―到着駅：</th>

				<td>
					<%
						if (to_st != null) {
					%> <input type="text" name="to_st" value="<%=to_st%>"> <%
 	} else {
 %> <input type="text" name="to_st"> <%
 	}
 %>
				</td>
			</tr>

			<tr>
				<th>金額：</th>
				<td>
					<%
						if (price != null) {
					%><input type="text" name="price" value="<%=price%>"> <%
 	} else {
 %> <input type="text" name="price"> <%
 	}
 %>
				</td>
			</tr>

		</table>



		<br> <br> <input class="transitionbt" type="submit"
			formaction="Add" value="確認">
		<button class="transitionbt" type="submit" formaction="List"
			formmethod="get">戻る</button>

	</form>
</body>
</html>