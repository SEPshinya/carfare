<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" import="java.sql.ResultSet"%>
	<% ResultSet rs=(ResultSet)request.getAttribute("rs");%>
<% String nowPage=(String)request.getAttribute("nowPage"); %>
<% int np=(int)request.getAttribute("np"); %>
<% int role_id=(int)session.getAttribute("role_id"); %>
<% String Role_id = String.valueOf(role_id); %>
<% int listCnt=(int)request.getAttribute("listCnt");  %>
<% int maxPage=listCnt/10; %>
<%if(listCnt%10>0){
	maxPage=maxPage+1;
}%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>交通費登録システム:一覧画面</title>
<link rel="stylesheet" href="./css/list.css">
</head>

<body>


	<h1>交通費登録システム:一覧</h1>

	<form  method="GET">
		<input type="submit" value="新規登録" formaction="Add">

	</form>

	<form action="Excel" method="post">
		<input type="submit" value="Excelへ出力">
	</form>
	<%if(Role_id.equals("2")){%>
	<form action="useradd.jsp" method="post">
		<input type="submit" value="ユーザー新規登録">
	</form>
	<%} %>

<%
	rs=(ResultSet)request.getAttribute("rs");
%>
	<form >

		<table class="table1">
			<tr class="tr1">
				<td class="td1">No</td>
				<td class="td1">日付</td>
				<td class="td1">片道or往復</td>
				<td class="td1">交通機関</td>
				<td class="td1">出発駅</td>
				<td class="td1">到着駅</td>
				<td class="td1">金額</td>
				<td></td>
			</tr>

			<% while(rs.next()){ %>
			<form method="get" name="<%= rs.getInt("id")%>">
			<tr class="tr2">
				<td class="td1"><%=rs.getString("id")%><input type="hidden" name="id" value="<%=rs.getString("id")%>"></td>
				<td class="td1"><%=rs.getString("day").replace('-', '/')%><input type="hidden" name="day" value="<%=rs.getString("day").replace('-', '/')%>"></td>
				<td class="td1"><%=rs.getString("route_name")%><input type="hidden" name="route_name" value="<%=rs.getString("route_name")%>"></td>
				<td class="td1"><%=rs.getString("transit_name")%><input type="hidden" name="transit_name" value="<%=rs.getString("transit_name")%>"></td>
				<td class="td1"><%=rs.getString("from_st")%><input type="hidden" name="from_st" value="<%=rs.getString("from_st")%>"></td>
				<td class="td1"><%=rs.getString("to_st")%><input type="hidden" name="to_st" value="<%=rs.getString("to_st")%>"></td>
				<td class="td1"><%=rs.getString("price")%><input type="hidden" name="price" value="<%=rs.getString("price")%>"></td>

				<td><input type="submit" value="編集" formaction="edit.jsp"><input type="submit" value="削除" formaction="Delete.jsp"></td>
			</tr>
			</form>
			<% }%>
		</table>
	</form>
<form>
<% if(maxPage==1||maxPage==0){ %>
<table>
<tr>
<td>＜＜</td>
<td>＜</td>
<td>1</td>
<td>＞</td>
<td>＞＞</td>
</tr>
</table>
<%} else if(maxPage==2&&np==1){%>
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

<%} else if(maxPage==2&&np==2){%>
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

<%} else if(maxPage==3&&np==1){%>
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

<%} else if(maxPage==3&&np==2){%>
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

<%} else if(maxPage==3&&np==3){%>
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

<%} else if(maxPage==4&&np==1){%>
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

<%} else if(maxPage==4&&np==2){%>
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

<%} else if(maxPage==4&&np==3){%>
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
<%} else if(maxPage==4&&np==4){%>
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
<%}else if(maxPage>=5&&np==1){ %>
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
<%}else if(maxPage>=5&&np==2){ %>
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

<%}else if(maxPage>=5&&np==3){ %>
<table>
<tr>
<td><a href="List?page=1">＜＜</a></td>
<td><a href="List?page=<%=String.valueOf(np-1)%>">＜</a></td>
<td><a href="List?page=1">1</a></td>
<td><a href="List?page=2">2</a></td>
<td>3</td>
<td><a href="List?page=4">4</a></td>
<td><a href="List?page=5">5</a></td>
<td><a href="List?page=<%=String.valueOf(np+1)%>">＞</a></td>
<td><a href="List?page=<%=maxPage%>">＞＞</a></td>
</tr>
</table>

<%}else if(maxPage==np){%>
<table>
<tr>
<td><a href="List?page=1">＜＜</a></td>
<td><a href="List?page=<%=String.valueOf(np-1)%>">＜</a></td>
<td><a href="List?page=<%=String.valueOf(np-4)%>"><%=String.valueOf(np-4)%></a></td>
<td><a href="List?page=<%=String.valueOf(np-3)%>"><%=String.valueOf(np-3)%></a></td>
<td><a href="List?page=<%=String.valueOf(np-2)%>"><%=String.valueOf(np-2)%></a></td>
<td><a href="List?page=<%=String.valueOf(np-1)%>"><%=String.valueOf(np-1)%></a></td>
<td><%=String.valueOf(maxPage)%></td>
<td>＞</td>
<td>＞＞</td>
</tr>
</table>

<%}else if(maxPage-1==np){ %>
<table>
<tr>
<td><a href="List?page=1">＜＜</a></td>
<td><a href="List?page=<%=String.valueOf(np-1)%>">＜</a></td>
<td><a href="List?page=<%=String.valueOf(np-3)%>"><%=String.valueOf(np-3)%></a></td>
<td><a href="List?page=<%=String.valueOf(np-2)%>"><%=String.valueOf(np-2)%></a></td>
<td><a href="List?page=<%=String.valueOf(np-1)%>"><%=String.valueOf(np-1)%></a></td>
<td><%=String.valueOf(np)%></td>
<td><a href="List?page=<%=String.valueOf(maxPage)%>"><%=String.valueOf(maxPage)%></a></td>
<td><a href="List?page=<%=String.valueOf(np+1)%>">＞</a></td>
<td><a href="List?page=<%=maxPage%>">＞＞</a></td>
</tr>
</table>

<%}else{ %>
<table>
<tr>
<td><a href="List?page=1">＜＜</a></td>
<td><a href="List?page=<%=String.valueOf(np-1)%>">＜</a></td>
<td><a href="List?page=<%=String.valueOf(np-2)%>"><%=String.valueOf(np-2)%></a></td>
<td><a href="List?page=<%=String.valueOf(np-1)%>"><%=String.valueOf(np-1)%></a></td>
<td><%=String.valueOf(np)%></td>
<td><a href="List?page=<%=String.valueOf(np+1)%>"><%=String.valueOf(np+1)%></a></td>
<td><a href="List?page=<%=String.valueOf(np+2)%>"><%=String.valueOf(np+2)%></a></td>
<td><a href="List?page=<%=String.valueOf(np+1)%>">＞</a></td>
<td><a href="List?page=<%=maxPage%>">＞＞</a></td>
</tr>
</table>
<%}%>
</form>
	<form method="GET">
		<input type="submit" value="新規登録" formaction="Add">
	</form>

</body>
</html>
