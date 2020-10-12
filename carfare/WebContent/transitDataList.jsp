<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.net.URLEncoder"%>
<%
request.setCharacterEncoding("UTF-8");
/** 登録、編集画面への遷移先アドレスは適当につけているので、ページ確認でき次第修正します。**/

/**入力値引継ぎ**/
String day=(String) request.getAttribute("day");
int route_no=(int) request.getAttribute("route_no");

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

/** 検索値 **/
//交通機関
String transit_no=(String)request.getAttribute("transit_no");
//出発駅
String from_st=(String)request.getAttribute("from_st");
//到着駅
String to_st=(String)request.getAttribute("to_st");

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
String menu=(String)request.getAttribute("menulist");
int menuNo= Integer.parseInt(menu);

/** ユーザーID **/
int user_id=(int)request.getAttribute("user_id");
String searchword="&from_st_encoded="+from_st_encoded+"&to_st_encoded="+to_st_encoded+"&transit_no="+transit_no;
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>交通手段一覧</title>
</head>
<body>
<p>交通費登録システム：交通手段一覧</p>




<!-- ここにページング -->
<form action="TransitdataList" method="get">
<%
//1ページのみ
if(maxPage==1 || maxPage==0 && now==1){
%>
＜＜
&nbsp;
＜
&nbsp;
1
&nbsp;
＞
&nbsp;
＞＞

<%
//2ページ分、1ページ目
}else if(maxPage==2 && now==1){
%>
＜＜
&nbsp;
＜
&nbsp;
<%=now %>
&nbsp;
<a href="TransitdataList?Page=<%=now+1%><%=searchword%>"><%=now+1%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now+1%><%=searchword%>"><%="＞"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=maxPage%><%=searchword%>"><%="＞＞"%></a>
<%
//2ページ分、最終ページ
}else if(maxPage==2 && now==maxPage){
%>
<a href="TransitdataList?Page=1<%=searchword%>"><%="＜＜"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-1%><%=searchword%>"><%="＜"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-1%><%=searchword%>"><%=now-1%></a>
&nbsp;
<%=now %>
&nbsp;
＞
&nbsp;
＞＞


<%
//3ページ分、1ページ目
}else if(maxPage==3 && now==1){
%>
＜＜
&nbsp;
＜
&nbsp;
<%=now %>
&nbsp;
<a href="TransitdataList?Page=<%=now+1%><%=searchword%>"><%=now+1%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now+2%><%=searchword%>"><%=now+2%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now+1%><%=searchword%>"><%="＞"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=maxPage%><%=searchword%>"><%="＞＞"%></a>

<%
//3ページ分、2ページ目
}else if(maxPage==3 && now==2){
%>
<a href="TransitdataList?Page=1<%=searchword%>"><%="＜＜"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-1%><%=searchword%>"><%="＜"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-1%><%=searchword%>"><%="1"%></a>
&nbsp;
<%=now %>
&nbsp;
<a href="TransitdataList?Page=<%=now+1%><%=searchword%>"><%=now+1%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now+1%><%=searchword%>"><%="＞"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=maxPage%><%=searchword%>"><%="＞＞"%></a>

<%
//3ページ分、最終ページ
}else if(maxPage==3 && now==maxPage){
%>
<a href="TransitdataList?Page=1<%=searchword%>"><%="＜＜"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-1%><%=searchword%>"><%="＜"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-2%><%=searchword%>"><%=now-2%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-1%><%=searchword%>"><%=now-1%></a>
&nbsp;
<%=now %>
&nbsp;
＞
&nbsp;
＞＞

<%
//4ページ分、1ページ目
}else if(maxPage==4 && now==1){
%>
＜＜
&nbsp;
＜
&nbsp;
<%=now %>
&nbsp;
<a href="TransitdataList?Page=<%=now+1%><%=searchword%>"><%=now+1%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now+2%><%=searchword%>"><%=now+2%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now+3%><%=searchword%>"><%=now+3%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now+1%><%=searchword%>"><%="＞"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=maxPage%><%=searchword%>"><%="＞＞"%></a>
<%
//4ページ分、2ページ目
}else if(maxPage==4 && now==2){
%>
<a href="TransitdataList?Page=1<%=searchword%>"><%="＜＜"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-1%><%=searchword%>"><%="＜"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-1%><%=searchword%>"><%="1"%></a>
&nbsp;
<%=now %>
&nbsp;
<a href="TransitdataList?Page=<%=now+1%><%=searchword%>"><%=now+1%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now+2%><%=searchword%>"><%=now+2%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now+1%><%=searchword%>"><%="＞"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=maxPage%><%=searchword%>"><%="＞＞"%></a>

<%//4ページ分、3ページ目
}else if(maxPage==4 && now==3){
%>
<a href="TransitdataList?Page=1<%=searchword%>"><%="＜＜"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-1%><%=searchword%>"><%="＜"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-2%><%=searchword%>"><%=now-2%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-1%><%=searchword%>"><%=now-1%></a>
&nbsp;
<%=now %>
&nbsp;
<a href="TransitdataList?Page=<%=now+1%><%=searchword%>"><%=now+1%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now+1%><%=searchword%>"><%="＞"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=maxPage%><%=searchword%>"><%="＞＞"%></a>

<%
//4ページ分、最終ページ
}else if(maxPage==4 && now==maxPage){
%>
<a href="TransitdataList?Page=1"><%="＜＜"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-1%><%=searchword%>"><%="＜"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-3%><%=searchword%>"><%=now-3%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-2%><%=searchword%>"><%=now-2%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-1%><%=searchword%>"><%=now-1%></a>
&nbsp;
<%=maxPage %>
&nbsp;
＞
&nbsp;
＞＞

<%
//複数ページ5以上、1ページ目
}else if(maxPage>4 && now==1){
%>
＜＜
&nbsp;
＜
&nbsp;
<%=now %>
&nbsp;
<a href="TransitdataList?Page=<%=now+1%><%=searchword%>"><%=now+1%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now+2%><%=searchword%>"><%=now+2%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now+3%><%=searchword%>"><%=now+3%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now+4%><%=searchword%>"><%=now+4%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now+1%><%=searchword%>"><%="＞"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=maxPage%><%=searchword%>"><%="＞＞"%></a>

<%
//複数ページ5以上、2ページ目
}else if(maxPage>4 && now==2){
%>
<a href="TransitdataList?Page=1<%=searchword%>"><%="＜＜"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-1%><%=searchword%>"><%="＜"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-1%><%=searchword%>"><%="1"%></a>
&nbsp;
<%=now %>
&nbsp;
<a href="TransitdataList?Page=<%=now+1%><%=searchword%>"><%=now+1%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now+2%><%=searchword%>"><%=now+2%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now+3%><%=searchword%>"><%=now+3%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now+1%><%=searchword%>"><%="＞"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=maxPage%><%=searchword%>"><%="＞＞"%></a>

<%
//複数ページ5以上最後から2ページ目
}else if(maxPage>4 && now ==maxPage-1){
%>
<a href="TransitdataList?Page=1<%=searchword%>"><%="＜＜"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-1%><%=searchword%>"><%="＜"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-3%><%=searchword%>"><%=now-3%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-2%><%=searchword%>"><%=now-2%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-1%><%=searchword%>"><%=now-1%></a>
&nbsp;
<%=now %>
&nbsp;
<a href="TransitdataList?Page=<%=now-1%><%=searchword%>"><%=now+1%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now+1%><%=searchword%>"><%="＞"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=maxPage%><%=searchword%>"><%="＞＞"%></a>
<%
//複数ページ5以上最後のページ
}else if(maxPage>4 && now == maxPage){
%>
<a href="TransitdataList?Page=1<%=searchword%>"><%="＜＜"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-1%><%=searchword%>"><%="＜"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-4%><%=searchword%>"><%=now-4%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-3%><%=searchword%>"><%=now-3%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-2%><%=searchword%>"><%=now-2%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-1%><%=searchword%>"><%=now-1%></a>
&nbsp;
<%=maxPage %>
&nbsp;
＞
&nbsp;
＞＞
<%
}else{
%>
<a href="TransitdataList?Page=1<%=searchword%>"><%="＜＜"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-1%><%=searchword%>"><%="＜"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-2%><%=searchword%>"><%=now-2%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-1%><%=searchword%>"><%=now-1%></a>
&nbsp;
<%=now %>
&nbsp;
<a href="TransitdataList?Page=<%=now+1%><%=searchword%>"><%=now+1%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now+2%><%=searchword%>"><%=now+2%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now+1%><%=searchword%>"><%="＞"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=maxPage%><%=searchword%>"><%="＞＞"%></a>
<%} %>
</form>





<!-- 交通手段一覧表示 -->
<form method="post">
<table border="1">
<tr>
<th>交通機関</th>
<th>出発駅</th>
<th>到着駅</th>
<th>金額</th>
<th></th>
</tr>

<%
while(rs.next()){
%>

<tr>
<!-- 交通し手段の値を表示 -->
<td><%=rs.getString("transit_name") %></td>
<td><%=rs.getString("from_st") %></td>
<td><%=rs.getString("to_st") %></td>
<td><%=rs.getString("price") %></td>

<!-- 選択した値を渡す用 -->
<input name="data_id" type="hidden" value=<%=rs.getString("data_id") %>>
<input name="transit_no" type="hidden" value=<%=rs.getString("transit_name") %>>
<input name="from_st" type="hidden" value=<%=rs.getString("from_st") %>>
<input name="to_st" type="hidden" value=<%=rs.getString("to_st") %>>
<input name="price" type="hidden" value=<%=rs.getString("price") %>>
<%
if(menuNo==1){
%>
<!-- 登録画面へ戻る -->
<input type="hidden" name="menulist" value="1">
<input type="hidden" name="user_id" value="<%=user_id%>">
<input type="hidden" name="day" value="<%=day%>">
<input type="hidden" name="route_no" value="<%=route_no%>">
<td><button type="submit" formaction="add.jsp">選択</button></td>

<%}else{ %>
<!-- 編集画面へ戻る -->
<input type="hidden" name="menulist" value="2">
<input type="hidden" name="user_id" value="<%=user_id%>">
<input type="hidden" name="day" value="<%=day%>">
<input type="hidden" name="route_no" value="<%=route_no%>">
<td><button type="submit" formaction="edit.jsp">選択</button></td>

<%
}
%>
</tr>
<%
}
%>
</table>
</form>





<!-- ここにページング -->
<form action="TransitdataList" method="get">
<%
//1ページのみ
if(maxPage==1 || maxPage==0 && now==1){
%>
＜＜
&nbsp;
＜
&nbsp;
1
&nbsp;
＞
&nbsp;
＞＞

<%
//2ページ分、1ページ目
}else if(maxPage==2 && now==1){
%>
＜＜
&nbsp;
＜
&nbsp;
<%=now %>
&nbsp;
<a href="TransitdataList?Page=<%=now+1%><%=searchword%>"><%=now+1%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now+1%><%=searchword%>"><%="＞"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=maxPage%><%=searchword%>"><%="＞＞"%></a>

<%
//2ページ分、最終ページ
}else if(maxPage==2 && now==maxPage){
%>
<a href="TransitdataList?Page=1<%=searchword%>"><%="＜＜"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-1%><%=searchword%>"><%="＜"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-1%><%=searchword%>"><%=now-1%></a>
&nbsp;
<%=now %>
&nbsp;
＞
&nbsp;
＞＞


<%
//3ページ分、1ページ目
}else if(maxPage==3 && now==1){
%>
＜＜
&nbsp;
＜
<%=now %>
&nbsp;
<a href="TransitdataList?Page=<%=now+1%><%=searchword%>"><%=now+1%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now+2%><%=searchword%>"><%=now+2%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now+1%><%=searchword%>"><%="＞"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=maxPage%><%=searchword%>"><%="＞＞"%></a>

<%
//3ページ分、2ページ目
}else if(maxPage==3 && now==2){
%>
<a href="TransitdataList?Page=1<%=searchword%>"><%="＜＜"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-1%><%=searchword%>"><%="＜"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-1%><%=searchword%>"><%="1"%></a>
&nbsp;
<%=now %>
&nbsp;
<a href="TransitdataList?Page=<%=now+1%><%=searchword%>"><%=now+1%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now+1%><%=searchword%>"><%="＞"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=maxPage%><%=searchword%>"><%="＞＞"%></a>

<%
//3ページ分、最終ページ
}else if(maxPage==3 && now==maxPage){
%>
<a href="TransitdataList?Page=1<%=searchword%>"><%="＜＜"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-1%><%=searchword%>"><%="＜"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-2%><%=searchword%>"><%=now-2%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-1%><%=searchword%>"><%=now-1%></a>
&nbsp;
<%=now %>
&nbsp;
＞
&nbsp;
＞＞

<%
//4ページ分、1ページ目
}else if(maxPage==4 && now==1){
%>
＜＜
&nbsp;
＜
&nbsp;
<%=now %>
&nbsp;
<a href="TransitdataList?Page=<%=now+1%><%=searchword%>"><%=now+1%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now+2%><%=searchword%>"><%=now+2%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now+3%><%=searchword%>"><%=now+3%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now+1%><%=searchword%>"><%="＞"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=maxPage%><%=searchword%>"><%="＞＞"%></a>

<%
//4ページ分、2ページ目
}else if(maxPage==4 && now==2){
%>
<a href="TransitdataList?Page=1<%=searchword%>"><%="＜＜"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-1%><%=searchword%>"><%="＜"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-1%><%=searchword%>"><%="1"%></a>
&nbsp;
<%=now %>
&nbsp;
<a href="TransitdataList?Page=<%=now+1%><%=searchword%>"><%=now+1%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now+2%><%=searchword%>"><%=now+2%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now+1%><%=searchword%>"><%="＞"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=maxPage%><%=searchword%>"><%="＞＞"%></a>

<%//4ページ分、3ページ目
}else if(maxPage==4 && now==3){
%>
<a href="TransitdataList?Page=1<%=searchword%>"><%="＜＜"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-1%><%=searchword%>"><%="＜"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-2%><%=searchword%>"><%=now-2%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-1%><%=searchword%>"><%=now-1%></a>
&nbsp;
<%=now %>
&nbsp;
<a href="TransitdataList?Page=<%=now+1%><%=searchword%>"><%=now+1%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now+1%><%=searchword%>"><%="＞"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=maxPage%><%=searchword%>"><%="＞＞"%></a>

<%
//4ページ分、最終ページ
}else if(maxPage==4 && now==maxPage){
%>
<a href="TransitdataList?Page=1<%=searchword%>"><%="＜＜"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-1%><%=searchword%>"><%="＜"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-3%><%=searchword%>"><%=now-3%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-2%><%=searchword%>"><%=now-2%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-1%><%=searchword%>"><%=now-1%></a>
&nbsp;
<%=maxPage %>
&nbsp;
＞
&nbsp;
＞＞

<%
//複数ページ5以上、1ページ目
}else if(maxPage>4 && now==1){
%>
＜＜
&nbsp;
＜
&nbsp;
<%=now %>
&nbsp;
<a href="TransitdataList?Page=<%=now+1%><%=searchword%>"><%=now+1%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now+2%><%=searchword%>"><%=now+2%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now+3%><%=searchword%>"><%=now+3%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now+4%><%=searchword%>"><%=now+4%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now+1%><%=searchword%>"><%="＞"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=maxPage%><%=searchword%>"><%="＞＞"%></a>

<%
//複数ページ5以上、2ページ目
}else if(maxPage>4 && now==2){
%>
<a href="TransitdataList?Page=1<%=searchword%>"><%="＜＜"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-1%><%=searchword%>"><%="＜"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-1%><%=searchword%>"><%="1"%></a>
&nbsp;
<%=now %>
&nbsp;
<a href="TransitdataList?Page=<%=now+1%><%=searchword%>"><%=now+1%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now+2%><%=searchword%>"><%=now+2%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now+3%><%=searchword%>"><%=now+3%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now+1%><%=searchword%>"><%="＞"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=maxPage%><%=searchword%>"><%="＞＞"%></a>

<%
//複数ページ5以上最後から2ページ目
}else if(maxPage>4 && now ==maxPage-1){
%>
<a href="TransitdataList?Page=1<%=searchword%>"><%="＜＜"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-1%><%=searchword%>"><%="＜"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-3%><%=searchword%>"><%=now-3%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-2%><%=searchword%>"><%=now-2%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-1%><%=searchword%>"><%=now-1%></a>
&nbsp;
<%=now %>
&nbsp;
<a href="TransitdataList?Page=<%=now+1%><%=searchword%>"><%=now+1%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now+1%><%=searchword%>"><%="＞"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=maxPage%><%=searchword%>"><%="＞＞"%></a>
<%
//複数ページ5以上最後のページ
}else if(maxPage>4 && now == maxPage){
%>
<a href="TransitdataList?Page=1<%=searchword%>"><%="＜＜"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-1%><%=searchword%>"><%="＜"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-4%><%=searchword%>"><%=now-4%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-3%><%=searchword%>"><%=now-3%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-2%><%=searchword%>"><%=now-2%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-1%><%=searchword%>"><%=now-1%></a>
&nbsp;
<%=maxPage %>
&nbsp;
＞
&nbsp;
＞＞
<%
}else{
%>
<a href="TransitdataList?Page=1<%=searchword%>"><%="＜＜"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-1%><%=searchword%>"><%="＜"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-2%><%=searchword%>"><%=now-2%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now-1%><%=searchword%>"><%=now-1%></a>
&nbsp;
<%=now %>
&nbsp;
<a href="TransitdataList?Page=<%=now+1%><%=searchword%>"><%=now+1%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now+2%><%=searchword%>"><%=now+2%></a>
&nbsp;
<a href="TransitdataList?Page=<%=now+1%><%=searchword%>"><%="＞"%></a>
&nbsp;
<a href="TransitdataList?Page=<%=maxPage%><%=searchword%>"><%="＞＞"%></a>
<%} %>
</form>





<!-- 戻るボタン表示 -->
<form method="post">
<%
if(menuNo==1){
%>
<!-- 登録画面へ戻る -->
<input type="hidden" name="menulist" value="1">
<input type="hidden" name="user_id" value="<%=user_id%>">
<input type="hidden" name="day" value="<%=day%>">
<input type="hidden" name="route_no" value="<%=route_no%>">
<button type="submit" formaction="add.jsp" >戻る</button>
<%
}else{
%>
<!-- 編集画面へ戻る -->
<input type="hidden" name="menulist" value="2">
<input type="hidden" name="user_id" value="<%=user_id%>">
<input type="hidden" name="day" value="<%=day%>">
<input type="hidden" name="route_no" value="<%=route_no%>">
<button type="submit" formaction="edit.jsp" >戻る</button>
<%
}
%>
</form>
</body>
</html>