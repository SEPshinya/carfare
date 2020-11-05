<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.net.URLEncoder" import="java.text.NumberFormat" import="common.*"%>
<%
request.setCharacterEncoding("UTF-8");
/** 登録、編集画面への遷移先アドレスは適当につけているので、ページ確認でき次第修正します。**/

/**入力値引継ぎ**/
String day=(String) request.getAttribute("day");

String route_no=(String) request.getAttribute("route_no");

String price=(String) request.getAttribute("price");

String id=(String)request.getAttribute("id");


NumberFormat nf = NumberFormat.getNumberInstance();



/**ページング用**/
//総ページ数
String listCnt =(String) request.getAttribute("listCnt");
//現在のページ
String nowPage =(String) request.getAttribute("page");

//Stringからintへ
int listC= Integer.parseInt(listCnt);
int now= Integer.parseInt(nowPage);

//ページ数設定
int maxPage=listC/10;
if(listC%10 !=0){
	maxPage=maxPage+1;
}

int start=0;
int end=0;

//件数0の場合
if(listC==0){
maxPage=1;
}

/** 検索値 **/
//交通機関
String transit_no=(String)request.getAttribute("transit_no");

//出発駅
String from_st=(String)request.getAttribute("from_st");
//到着駅
String to_st=(String)request.getAttribute("to_st");

/** エンコード **/
//出発駅エンコード
String from_st_encoded=null;
if(from_st!=null){
	from_st_encoded=URLEncoder.encode(from_st, "UTF-8");
}

//到着駅エンコード
String to_st_encoded=null;
if(to_st!=null){
	to_st_encoded=URLEncoder.encode(to_st, "UTF-8");
}


/** DBから「transit_data」を取得する用 **/
ResultSet rs= (ResultSet) request.getAttribute("rs");


/** 登録か編集かの判断値（名前は仮仕様）**/

String menulist=(String)request.getAttribute("menulist");
int menuNo= Integer.parseInt(menulist);

/** url  id day price **/
String searchword="&from_st_encoded="+from_st_encoded+"&to_st_encoded="+to_st_encoded+"&transit_no="+transit_no+"&menulist="+menulist+"&id="+id+"&day="+day+"&price="+price+"&menulist="+menulist+"&route_no="+route_no;

/** DBから「transit_data」を取得する用 **/
ResultSet rs1=CommonDB.getTransitAll();

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/transitDataList.css">
<title>交通手段一覧</title>
</head>
<body>
<h2>交通費登録システム：交通手段一覧</h2>

<!-- 検索 -->
<%if(menuNo==3 ){ %>
<form action="TransitdataList" method="get">
<table class="search" border="1">

<tr>
<td>交通機関：<select name="transit_no"><option value=""></option>
					<%
						while (rs1.next()) {
					%>
					<option value="<%=rs1.getString("transit_no")%>"><%=rs1.getString("transit_name")%></option>
					<%
						}

					%>
				</select></td>
<td>出発駅：<input type="text" name="from_st"></td>
<td>到着駅：<input type="text" name="to_st"></td>
<td><input type="hidden" name="menulist" value="3"><input type="submit" value="検索"></td>
</tr>
</table>
</form>
<%} %>

<!-- ここにページング -->
<form  class="paging" action="TransitdataList" method="get">
<ul>
			<li>
				<% if (now == 1) { %>
					<a><%="<<"%></a>
				<% } else { %>
					<a href="TransitdataList?page=1<%=searchword%>"><%="<<"%></a>
				<% } %>
			</li>
			<li>
				<% if (now == 1) { %>
				<a><%="<"%></a>
				<% } else { %> <a href="TransitdataList?page=<%=now - 1%><%=searchword%>"><%="<"%></a>
				<% } %>
			</li>
			<%
				if (maxPage <= 5) {
					start = 1;
					end = maxPage;
				} else if (now == maxPage || now == maxPage - 1) {
					start = maxPage - 4;
					end = maxPage;
				} else if (now >= 3) {
					start = now - 2;
					end = now + 2;
				} else {
					start = 1;
					end = 5;
				}
				for (int i = start; i <= end; i++) {
			%>
			<li>
				<% if (now == i) { %>
					<a><%=i%></a>
				<% } else { %>
					<a href="TransitdataList?page=<%=i%><%=searchword%>"><%=i%></a>
				<% } %>
			</li>
			<%
				}
			%>
			<li>
				<% if (now == maxPage) { %>
					<a><%=">"%></a>
				<% } else { %>
					<a href="TransitdataList?page=<%=now + 1%><%=searchword%>"><%=">"%></a>
					<% } %>
			</li>
			<li>
				<% if (now == maxPage) { %>
					<a><%=">>"%></a>
				<% } else { %>
					<a href="TransitdataList?page=<%=maxPage%><%=searchword%>"><%=">>"%></a>
				<% }  %>
			</li>
		</ul>

</form>



<!-- 交通手段一覧表示 -->
<table class="transitListCss" border="1">
<tr bgcolor="#D7EEFF">
<th class="transitname">交通機関</th>
<th class="fromst">出発駅</th>
<th class="tost">到着駅</th>
<th class="price">金額</th>
<th class="select"></th>
</tr>
<%
while(rs.next()){
%>
<form name="<%=rs.getString("data_id") %>"  method="get">
<tr>
<!-- 交通し手段の値を表示 -->
<td><%=rs.getString("transit_name") %></td>
<td><%=rs.getString("from_st") %></td>
<td><%=rs.getString("to_st") %></td>
<td><%int Price=Integer.parseInt(rs.getString("price"));%><%=nf.format(Price)%>円</td>

<!-- 選択した値を渡す用 -->
<input name="data_id" type="hidden" value=<%=rs.getString("data_id") %>>
<input name="transit_no" type="hidden" value=<%=rs.getString("transit_no") %>>
<input name="from_st" type="hidden" value=<%=rs.getString("from_st") %>>
<input name="to_st" type="hidden" value=<%=rs.getString("to_st") %>>
<input name="price" type="hidden" value=<%=rs.getString("price") %>>

<!-- 持ってきた値を送る用 -->
<input type="hidden" name="menulist" value="<%=menulist%>">
<input type="hidden" name="day" value="<%=day%>">
<input type="hidden" name="route_no" value="<%=route_no%>">

<td>
<%
if(menuNo==1){
%>
<!-- 登録画面へ持っていく -->

<input class="selectbt" type="submit" formaction="Add" value="選択">


<%}else if(menuNo==2){ %>
<!-- 編集画面へ持っていく -->

<input type="hidden" name="id" value="<%=id%>">
<input class="selectbt" type="submit" formaction="edit.jsp" value="選択">

<%
}else{
%>
<!-- 交通手段一覧からアクセスされてる場合 -->

<input class="selectbt3" type="submit" formaction="transitDataEdit.jsp" value="編集" >
<input class="selectbt3" type="submit" formaction="transitDataDelete.jsp" value="削除" >

<%
}
%>
</td>
</tr>
</form>
<%
}
%>
</table>








<!-- ここにページング -->
<form class="paging" action="TransitdataList" method="get">
<ul>
			<li>
				<% if (now == 1) { %>
					<a><%="<<"%></a>
				<% } else { %>
					<a href="TransitdataList?page=1<%=searchword%>"><%="<<"%></a>
				<% } %>
			</li>
			<li>
				<% if (now == 1) { %>
				<a><%="<"%></a>
				<% } else { %> <a href="TransitdataList?page=<%=now - 1%><%=searchword%>"><%="<"%></a>
				<% } %>
			</li>
			<%
				if (maxPage <= 5) {
					start = 1;
					end = maxPage;
				} else if (now == maxPage || now == maxPage - 1) {
					start = maxPage - 4;
					end = maxPage;
				} else if (now >= 3) {
					start = now - 2;
					end = now + 2;
				} else {
					start = 1;
					end = 5;
				}
				for (int i = start; i <= end; i++) {
			%>
			<li>
				<% if (now == i) { %>
					<a><%=i%></a>
				<% } else { %>
					<a href="TransitdataList?page=<%=i%><%=searchword%>"><%=i%></a>
				<% } %>
			</li>
			<%
				}
			%>
			<li>
				<% if (now == maxPage) { %>
					<a><%=">"%></a>
				<% } else { %>
					<a href="TransitdataList?page=<%=now + 1%><%=searchword%>"><%=">"%></a>
					<% } %>
			</li>
			<li>
				<% if (now == maxPage) { %>
					<a><%=">>"%></a>
				<% } else { %>
					<a href="TransitdataList?page=<%=maxPage%><%=searchword%>"><%=">>"%></a>
				<% }  %>
			</li>
		</ul>

</form>





<!-- 戻るボタン表示 -->
<form method="get">

<!-- 送りかえす値 -->
<input type="hidden" name="menulist" value="<%=menulist%>">
<input type="hidden" name="day" value="<%=day%>">
<input type="hidden" name="route_no" value="<%=route_no%>">
<input type="hidden" name="id" value="<%=id%>">
<input type="hidden" name="transit_no" value="<%=transit_no%>">
<input type="hidden" name="from_st" value="<%=from_st%>">
<input type="hidden" name="to_st" value="<%=to_st%>">
<input type="hidden" name="price" value="<%=price%>">

<%
if(menuNo==1){
%>
<!-- 登録画面へ戻る -->
<input class="returnbt" type="submit" formaction="Add" value="戻る">
<%
}else if(menuNo==2){
%>
<!-- 編集画面へ戻る -->
<input class="returnbt" type="submit" formaction="edit.jsp"  value="戻る">
<%
}else {
%>
<input class="returnbt" type="submit" formaction="List"  value="戻る">
<%
}
%>
</form>
</body>
</html>