<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.ResultSet"
	import="java.text.NumberFormat"%>
<%
	ResultSet rs = (ResultSet) request.getAttribute("rs");
%>
<%
	String nowPage = (String) request.getAttribute("nowPage");
%>
<%
	int np = (int) request.getAttribute("np");
%>
<%
	int role_id = (int) session.getAttribute("role_id");
%>
<%
	String Role_id = String.valueOf(role_id);
%>
<%
	int listCnt = (int) request.getAttribute("listCnt");
%>
<%
	int maxPage = listCnt / 10;
%>
<%
	NumberFormat nf = NumberFormat.getNumberInstance();
%>
<%
	if (listCnt % 10 > 0) {
		maxPage = maxPage + 1;
	}
%>
<%
	request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html>
<head>
<link href="./css/list.css" rel="stylesheet"></link>
<meta charset="UTF-8">
<title>交通費登録システム:一覧画面</title>

</head>
<body>

	<h2>交通費登録システム:一覧</h2>
	<table>
		<tr>
			<td><form method="GET" class="newbtn btn">
					<input type="submit" value="新規登録" formaction="Add" class="btn">
				</form></td>

			<%
				if (Role_id.equals("2")) {
			%>
			<td>
				<form action="useradd.jsp" method="post" class="userbtn">
					<input type="submit" value="ユーザー新規登録" class="btn">
				</form>
			</td>
			<%
				}
			%>
		</tr>
		<tr>
			<td>
				<div class="Excelbtn" style="float: right;">
					<form action="Excel" method="post">
						<input type="submit" value="Excelへ出力" class="btn">
					</form>
				</div></td>

			<td>
				<form action="TransitdataList" method="post">
				<input type="hidden"value=3 name="menulist" >
				<input type="submit" value="交通手段一覧">
				</form>
			</td>
		</tr>
	</table>

	<br>

	<%
		rs = (ResultSet) request.getAttribute("rs");
	%>

	<form class="page">
		<%
			if (maxPage == 1 || maxPage == 0) {
		%>
		<table>
			<tr>
				<td>＜＜</td>
				<td>＜</td>
				<td>1</td>
				<td>＞</td>
				<td>＞＞</td>
			</tr>
		</table>
		<%
			} else if (maxPage == 2 && np == 1) {
		%>
		<table>
			<tr>
				<td>＜＜</td>
				<td>＜</td>
				<td>1</td>
				<td><a href="List?page=2">2</a></td>
				<td><a href="List?page=2">＞</a></td>
				<td><a href="List?page=2">＞＞</a></td>
			</tr>
		</table>

		<%
			} else if (maxPage == 2 && np == 2) {
		%>
		<table>
			<tr>
				<td><a href="List?page=1">＜</a></td>
				<td><a href="List?page=1">＜＜</a></td>
				<td><a href="List?page=1">1</a></td>
				<td>2</td>
				<td>＞</td>
				<td>＞＞</td>
			</tr>
		</table>

		<%
			} else if (maxPage == 3 && np == 1) {
		%>
		<table>
			<tr>
				<td>＜＜</td>
				<td>＜</td>
				<td>1</td>
				<td><a href="List?page=2">2</a></td>
				<td><a href="List?page=3">3</a></td>
				<td><a href="List?page=2">＞</a></td>
				<td><a href="List?page=3">＞＞</a></td>
			</tr>
		</table>

		<%
			} else if (maxPage == 3 && np == 2) {
		%>
		<table>
			<tr>
				<td><a href="List?page=1">＜＜</a></td>
				<td><a href="List?page=1">＜</a></td>
				<td><a href="List?page=1">1</a></td>
				<td>2</td>
				<td><a href="List?page=3">3</a></td>
				<td><a href="List?page=3">＞</a></td>
				<td><a href="List?page=3">＞＞</a></td>
			</tr>
		</table>

		<%
			} else if (maxPage == 3 && np == 3) {
		%>
		<table>
			<tr>
				<td><a href="List?page=1">＜＜</a></td>
				<td><a href="List?page=2">＜</a></td>
				<td><a href="List?page=1">1</a></td>
				<td><a href="List?page=2">2</a></td>
				<td>3</td>
				<td>＞</td>
				<td>＞＞</td>
			</tr>
		</table>

		<%
			} else if (maxPage == 4 && np == 1) {
		%>
		<table>
			<tr>
				<td>＜＜</td>
				<td>＜</td>
				<td>1</td>
				<td><a href="List?page=2">2</a></td>
				<td><a href="List?page=3">3</a></td>
				<td><a href="List?page=4">4</a></td>
				<td><a href="List?page=2">＞</a></td>
				<td><a href="List?page=4">＞＞</a></td>
			</tr>
		</table>

		<%
			} else if (maxPage == 4 && np == 2) {
		%>
		<table>
			<tr>
				<td><a href="List?page=1">＜＜</a></td>
				<td><a href="List?page=1">＜</a></td>
				<td><a href="List?page=1">1</a></td>
				<td>2</td>
				<td><a href="List?page=3">3</a></td>
				<td><a href="List?page=4">4</a></td>
				<td><a href="List?page=3">＞</a></td>
				<td><a href="List?page=4">＞＞</a></td>
			</tr>
		</table>

		<%
			} else if (maxPage == 4 && np == 3) {
		%>
		<table>
			<tr>
				<td><a href="List?page=1">＜＜</a></td>
				<td><a href="List?page=2">＜</a></td>
				<td><a href="List?page=1">1</a></td>
				<td><a href="List?page=2">2</a></td>
				<td>3</td>
				<td><a href="List?page=4">4</a></td>
				<td><a href="List?page=4">＞</a></td>
				<td><a href="List?page=4">＞＞</a></td>
			</tr>
		</table>
		<%
			} else if (maxPage == 4 && np == 4) {
		%>
		<table>
			<tr>
				<td><a href="List?page=1">＜＜</a></td>
				<td><a href="List?page=2">＜</a></td>
				<td><a href="List?page=1">1</a></td>
				<td><a href="List?page=2">2</a></td>
				<td><a href="List?page=3">3</a></td>
				<td>4</td>
				<td>＞</td>
				<td>＞＞</td>
			</tr>
		</table>
		<%
			} else if (maxPage >= 5 && np == 1) {
		%>
		<table>
			<tr>
				<td>＜＜</td>
				<td>＜</td>
				<td>1</td>
				<td><a href="List?page=2">2</a></td>
				<td><a href="List?page=3">3</a></td>
				<td><a href="List?page=4">4</a></td>
				<td><a href="List?page=5">5</a></td>
				<td><a href="List?page=2">＞</a></td>
				<td><a href="List?page=<%=maxPage%>">＞＞</a></td>
			</tr>
		</table>
		<%
			} else if (maxPage >= 5 && np == 2) {
		%>
		<table>
			<tr>
				<td><a href="List?page=1">＜＜</a></td>
				<td><a href="List?page=1">＜</a></td>
				<td><a href="List?page=1">1</a></td>
				<td>2</td>
				<td><a href="List?page=3">3</a></td>
				<td><a href="List?page=4">4</a></td>
				<td><a href="List?page=5">5</a></td>
				<td><a href="List?page=3">＞</a></td>
				<td><a href="List?page=<%=maxPage%>">＞＞</a></td>
			</tr>
		</table>

		<%
			} else if (maxPage >= 5 && np == 3) {
		%>
		<table>
			<tr>
				<td><a href="List?page=1">＜＜</a></td>
				<td><a href="List?page=<%=String.valueOf(np - 1)%>">＜</a></td>
				<td><a href="List?page=1">1</a></td>
				<td><a href="List?page=2">2</a></td>
				<td>3</td>
				<td><a href="List?page=4">4</a></td>
				<td><a href="List?page=5">5</a></td>
				<td><a href="List?page=<%=String.valueOf(np + 1)%>">＞</a></td>
				<td><a href="List?page=<%=maxPage%>">＞＞</a></td>
			</tr>
		</table>

		<%
			} else if (maxPage == np) {
		%>
		<table>
			<tr>
				<td><a href="List?page=1">＜＜</a></td>
				<td><a href="List?page=<%=String.valueOf(np - 1)%>">＜</a></td>
				<td><a href="List?page=<%=String.valueOf(np - 4)%>"><%=String.valueOf(np - 4)%></a></td>
				<td><a href="List?page=<%=String.valueOf(np - 3)%>"><%=String.valueOf(np - 3)%></a></td>
				<td><a href="List?page=<%=String.valueOf(np - 2)%>"><%=String.valueOf(np - 2)%></a></td>
				<td><a href="List?page=<%=String.valueOf(np - 1)%>"><%=String.valueOf(np - 1)%></a></td>
				<td><%=String.valueOf(maxPage)%></td>
				<td>＞</td>
				<td>＞＞</td>
			</tr>
		</table>

		<%
			} else if (maxPage - 1 == np) {
		%>
		<table>
			<tr>
				<td><a href="List?page=1">＜＜</a></td>
				<td><a href="List?page=<%=String.valueOf(np - 1)%>">＜</a></td>
				<td><a href="List?page=<%=String.valueOf(np - 3)%>"><%=String.valueOf(np - 3)%></a></td>
				<td><a href="List?page=<%=String.valueOf(np - 2)%>"><%=String.valueOf(np - 2)%></a></td>
				<td><a href="List?page=<%=String.valueOf(np - 1)%>"><%=String.valueOf(np - 1)%></a></td>
				<td><%=String.valueOf(np)%></td>
				<td><a href="List?page=<%=String.valueOf(maxPage)%>"><%=String.valueOf(maxPage)%></a></td>
				<td><a href="List?page=<%=String.valueOf(np + 1)%>">＞</a></td>
				<td><a href="List?page=<%=maxPage%>">＞＞</a></td>
			</tr>
		</table>

		<%
			} else {
		%>
		<table>
			<tr>
				<td><a href="List?page=1">＜＜</a></td>
				<td><a href="List?page=<%=String.valueOf(np - 1)%>">＜</a></td>
				<td><a href="List?page=<%=String.valueOf(np - 2)%>"><%=String.valueOf(np - 2)%></a></td>
				<td><a href="List?page=<%=String.valueOf(np - 1)%>"><%=String.valueOf(np - 1)%></a></td>
				<td><%=String.valueOf(np)%></td>
				<td><a href="List?page=<%=String.valueOf(np + 1)%>"><%=String.valueOf(np + 1)%></a></td>
				<td><a href="List?page=<%=String.valueOf(np + 2)%>"><%=String.valueOf(np + 2)%></a></td>
				<td><a href="List?page=<%=String.valueOf(np + 1)%>">＞</a></td>
				<td><a href="List?page=<%=maxPage%>">＞＞</a></td>
			</tr>
		</table>
		<%
			}
		%>
	</form>
	<br>

	<form>
		<table class="table1">
			<tr class="tr1" style="background-color: #99CCFF;">
				<td class="td1"><b>日付</b></td>
				<td class="td1"><b>片道or往復</b></td>
				<td class="td1"><b>交通機関</b></td>
				<td class="td1"><b>出発駅</b></td>
				<td class="td1"><b>到着駅</b></td>
				<td class="td1"><b>金額</b></td>
				<td></td>
			</tr>

			<%
				while (rs.next()) {
			%>
			<form method="get" name="<%=rs.getInt("id")%>">
				<tr class="tr2">
					<input type="hidden" name="id" value="<%=rs.getString("id")%>">
					<td class="td1"><%=rs.getString("day").replace('-', '/')%><input
						type="hidden" name="day"
						value="<%=rs.getString("day").replace('-', '/')%>"></td>
					<td class="td1"><%=rs.getString("route_name")%><input
						type="hidden" name="route_name"
						value="<%=rs.getString("route_name")%>"></td>
					<td class="td1"><%=rs.getString("transit_name")%><input
						type="hidden" name="transit_name"
						value="<%=rs.getString("transit_name")%>"></td>
					<td class="td1"><%=rs.getString("from_st")%><input
						type="hidden" name="from_st" value="<%=rs.getString("from_st")%>"></td>
					<td class="td1"><%=rs.getString("to_st")%><input type="hidden"
						name="to_st" value="<%=rs.getString("to_st")%>"></td>
					<td class="td1">
						<%
							String route_name = rs.getString("route_name");
						%> <%
 	int Price = Integer.parseInt(rs.getString("price"));
 %> <!-- route_name に入ってる文字列が往復と等しい場合にPriceを二倍する --> <%
 	if (route_name.equals("往復")) {
 %> <%
 	Price = Price * 2;
 %> <%
 	}
 %> <%=nf.format(Price)%>円 <!-- priceの受け渡しは片道料金を飛ばす --> <input
						type="hidden" name="price"
						value="<%=nf.format(Integer.parseInt(rs.getString("price")))%>">
					</td>

					<td class="td2"><input type="submit" value="編集"
						formaction="edit.jsp" style="background-color: #C0C0C0;"
						class="btn1"><input type="submit" value="削除"
						formaction="Delete.jsp" style="background-color: #C0C0C0;"
						class="btn1"></td>
				</tr>
			</form>
			<%
				}
			%>
		</table>
	</form>

	<br>
	<form class="page">
		<%
			if (maxPage == 1 || maxPage == 0) {
		%>
		<table>
			<tr>
				<td>＜＜</td>
				<td>＜</td>
				<td>1</td>
				<td>＞</td>
				<td>＞＞</td>
			</tr>
		</table>
		<%
			} else if (maxPage == 2 && np == 1) {
		%>
		<table>
			<tr>
				<td>＜＜</td>
				<td>＜</td>
				<td>1</td>
				<td><a href="List?page=2">2</a></td>
				<td><a href="List?page=2">＞</a></td>
				<td><a href="List?page=2">＞＞</a></td>
			</tr>
		</table>

		<%
			} else if (maxPage == 2 && np == 2) {
		%>
		<table>
			<tr>
				<td><a href="List?page=1">＜</a></td>
				<td><a href="List?page=1">＜＜</a></td>
				<td><a href="List?page=1">1</a></td>
				<td>2</td>
				<td>＞</td>
				<td>＞＞</td>
			</tr>
		</table>

		<%
			} else if (maxPage == 3 && np == 1) {
		%>
		<table>
			<tr>
				<td>＜＜</td>
				<td>＜</td>
				<td>1</td>
				<td><a href="List?page=2">2</a></td>
				<td><a href="List?page=3">3</a></td>
				<td><a href="List?page=2">＞</a></td>
				<td><a href="List?page=3">＞＞</a></td>
			</tr>
		</table>

		<%
			} else if (maxPage == 3 && np == 2) {
		%>
		<table>
			<tr>
				<td><a href="List?page=1">＜＜</a></td>
				<td><a href="List?page=1">＜</a></td>
				<td><a href="List?page=1">1</a></td>
				<td>2</td>
				<td><a href="List?page=3">3</a></td>
				<td><a href="List?page=3">＞</a></td>
				<td><a href="List?page=3">＞＞</a></td>
			</tr>
		</table>

		<%
			} else if (maxPage == 3 && np == 3) {
		%>
		<table>
			<tr>
				<td><a href="List?page=1">＜＜</a></td>
				<td><a href="List?page=2">＜</a></td>
				<td><a href="List?page=1">1</a></td>
				<td><a href="List?page=2">2</a></td>
				<td>3</td>
				<td>＞</td>
				<td>＞＞</td>
			</tr>
		</table>

		<%
			} else if (maxPage == 4 && np == 1) {
		%>
		<table>
			<tr>
				<td>＜＜</td>
				<td>＜</td>
				<td>1</td>
				<td><a href="List?page=2">2</a></td>
				<td><a href="List?page=3">3</a></td>
				<td><a href="List?page=4">4</a></td>
				<td><a href="List?page=2">＞</a></td>
				<td><a href="List?page=4">＞＞</a></td>
			</tr>
		</table>

		<%
			} else if (maxPage == 4 && np == 2) {
		%>
		<table>
			<tr>
				<td><a href="List?page=1">＜＜</a></td>
				<td><a href="List?page=1">＜</a></td>
				<td><a href="List?page=1">1</a></td>
				<td>2</td>
				<td><a href="List?page=3">3</a></td>
				<td><a href="List?page=4">4</a></td>
				<td><a href="List?page=3">＞</a></td>
				<td><a href="List?page=4">＞＞</a></td>
			</tr>
		</table>

		<%
			} else if (maxPage == 4 && np == 3) {
		%>
		<table>
			<tr>
				<td><a href="List?page=1">＜＜</a></td>
				<td><a href="List?page=2">＜</a></td>
				<td><a href="List?page=1">1</a></td>
				<td><a href="List?page=2">2</a></td>
				<td>3</td>
				<td><a href="List?page=4">4</a></td>
				<td><a href="List?page=4">＞</a></td>
				<td><a href="List?page=4">＞＞</a></td>
			</tr>
		</table>
		<%
			} else if (maxPage == 4 && np == 4) {
		%>
		<table>
			<tr>
				<td><a href="List?page=1">＜＜</a></td>
				<td><a href="List?page=2">＜</a></td>
				<td><a href="List?page=1">1</a></td>
				<td><a href="List?page=2">2</a></td>
				<td><a href="List?page=3">3</a></td>
				<td>4</td>
				<td>＞</td>
				<td>＞＞</td>
			</tr>
		</table>
		<%
			} else if (maxPage >= 5 && np == 1) {
		%>
		<table>
			<tr>
				<td>＜＜</td>
				<td>＜</td>
				<td>1</td>
				<td><a href="List?page=2">2</a></td>
				<td><a href="List?page=3">3</a></td>
				<td><a href="List?page=4">4</a></td>
				<td><a href="List?page=5">5</a></td>
				<td><a href="List?page=2">＞</a></td>
				<td><a href="List?page=<%=maxPage%>">＞＞</a></td>
			</tr>
		</table>
		<%
			} else if (maxPage >= 5 && np == 2) {
		%>
		<table>
			<tr>
				<td><a href="List?page=1">＜＜</a></td>
				<td><a href="List?page=1">＜</a></td>
				<td><a href="List?page=1">1</a></td>
				<td>2</td>
				<td><a href="List?page=3">3</a></td>
				<td><a href="List?page=4">4</a></td>
				<td><a href="List?page=5">5</a></td>
				<td><a href="List?page=3">＞</a></td>
				<td><a href="List?page=<%=maxPage%>">＞＞</a></td>
			</tr>
		</table>

		<%
			} else if (maxPage >= 5 && np == 3) {
		%>
		<table>
			<tr>
				<td><a href="List?page=1">＜＜</a></td>
				<td><a href="List?page=<%=String.valueOf(np - 1)%>">＜</a></td>
				<td><a href="List?page=1">1</a></td>
				<td><a href="List?page=2">2</a></td>
				<td>3</td>
				<td><a href="List?page=4">4</a></td>
				<td><a href="List?page=5">5</a></td>
				<td><a href="List?page=<%=String.valueOf(np + 1)%>">＞</a></td>
				<td><a href="List?page=<%=maxPage%>">＞＞</a></td>
			</tr>
		</table>

		<%
			} else if (maxPage == np) {
		%>
		<table>
			<tr>
				<td><a href="List?page=1">＜＜</a></td>
				<td><a href="List?page=<%=String.valueOf(np - 1)%>">＜</a></td>
				<td><a href="List?page=<%=String.valueOf(np - 4)%>"><%=String.valueOf(np - 4)%></a></td>
				<td><a href="List?page=<%=String.valueOf(np - 3)%>"><%=String.valueOf(np - 3)%></a></td>
				<td><a href="List?page=<%=String.valueOf(np - 2)%>"><%=String.valueOf(np - 2)%></a></td>
				<td><a href="List?page=<%=String.valueOf(np - 1)%>"><%=String.valueOf(np - 1)%></a></td>
				<td><%=String.valueOf(maxPage)%></td>
				<td>＞</td>
				<td>＞＞</td>
			</tr>
		</table>

		<%
			} else if (maxPage - 1 == np) {
		%>
		<table>
			<tr>
				<td><a href="List?page=1">＜＜</a></td>
				<td><a href="List?page=<%=String.valueOf(np - 1)%>">＜</a></td>
				<td><a href="List?page=<%=String.valueOf(np - 3)%>"><%=String.valueOf(np - 3)%></a></td>
				<td><a href="List?page=<%=String.valueOf(np - 2)%>"><%=String.valueOf(np - 2)%></a></td>
				<td><a href="List?page=<%=String.valueOf(np - 1)%>"><%=String.valueOf(np - 1)%></a></td>
				<td><%=String.valueOf(np)%></td>
				<td><a href="List?page=<%=String.valueOf(maxPage)%>"><%=String.valueOf(maxPage)%></a></td>
				<td><a href="List?page=<%=String.valueOf(np + 1)%>">＞</a></td>
				<td><a href="List?page=<%=maxPage%>">＞＞</a></td>
			</tr>
		</table>

		<%
			} else {
		%>
		<table>
			<tr>
				<td><a href="List?page=1">＜＜</a></td>
				<td><a href="List?page=<%=String.valueOf(np - 1)%>">＜</a></td>
				<td><a href="List?page=<%=String.valueOf(np - 2)%>"><%=String.valueOf(np - 2)%></a></td>
				<td><a href="List?page=<%=String.valueOf(np - 1)%>"><%=String.valueOf(np - 1)%></a></td>
				<td><%=String.valueOf(np)%></td>
				<td><a href="List?page=<%=String.valueOf(np + 1)%>"><%=String.valueOf(np + 1)%></a></td>
				<td><a href="List?page=<%=String.valueOf(np + 2)%>"><%=String.valueOf(np + 2)%></a></td>
				<td><a href="List?page=<%=String.valueOf(np + 1)%>">＞</a></td>
				<td><a href="List?page=<%=maxPage%>">＞＞</a></td>
			</tr>
		</table>
		<%
			}
		%>
		</form>
				<form action="TransitdataList" method="post">
				<input type="hidden"value=3 name="menulist" >
				<input type="submit" value="交通手段一覧">
				</form>

</body>
</html>
