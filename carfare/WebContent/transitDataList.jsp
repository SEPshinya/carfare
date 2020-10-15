<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.sql.*" import="java.net.URLEncoder" import="java.text.NumberFormat"%>
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
String searchword="&from_st_encoded="+from_st_encoded+"&to_st_encoded="+to_st_encoded+"&transit_no="+transit_no+"&menulist="+menulist+"&id="+id+"&day="+day+"&price="+price;

String errmsg=(String)request.getAttribute("errmsg");

%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="transitDataList.css">
<title>交通手段一覧</title>
</head>
<body>
<p>交通費登録システム：交通手段一覧</p>

<div><%=id %></div>

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

<!-- 選択した値を渡す用 ->
<input name="data_id" type="hidden" value=<%=rs.getString("data_id") %>>-->
<input name="transit_no" type="hidden" value=<%=rs.getString("transit_no") %>>
<input name="from_st" type="hidden" value=<%=rs.getString("from_st") %>>
<input name="to_st" type="hidden" value=<%=rs.getString("to_st") %>>
<input name="price" type="hidden" value=<%=rs.getString("price") %>>
<%
if(menuNo==1){
%>
<!-- 登録画面へ戻る -->
<input type="hidden" name="menulist" value="<%=menulist%>">
<input type="hidden" name="day" value="<%=day%>">
<input type="hidden" name="route_no" value="<%=route_no%>">
<input type="hidden" name="errmsg" value="<%=errmsg%>">
<td><input class="selectbt" type="submit" formaction="Add" value="選択"></td>

<%}else{ %>
<!-- 編集画面へ戻る -->
<input type="hidden" name="menulist" value="<%=menulist%>">
<input type="hidden" name="day" value="<%=day%>">
<input type="hidden" name="route_no" value="<%=route_no%>">
<input type="hidden" name="errmsg" value="<%=errmsg%>">
<input type="hidden" name="id" value="<%=id%>">
<td><input class="selectbt" type="submit" formaction="edit.jsp" value="選択"></td>

<%
}
%>

</tr>
</form>
<%
}
%>
</table>








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
<form method="get">
<%
if(menuNo==1){
%>
<!-- 登録画面へ戻る -->
<input type="hidden" name="menulist" value="<%=menulist%>">
<input type="hidden" name="day" value="<%=day%>">
<input type="hidden" name="route_no" value="<%=route_no%>">
<input type="hidden" name="id" value="<%=id%>">
<input type="hidden" name="transit_no" value="<%=transit_no%>">
<input type="hidden" name="from_st" value="<%=from_st%>">
<input type="hidden" name="to_st" value="<%=to_st%>">
<input type="hidden" name="price" value="<%=price%>">
<input class="returnbt" type="submit" formaction="Add" value="戻る">
<%
}else{
%>
<!-- 編集画面へ戻る -->
<input type="hidden" name="menulist" value="<%=menulist%>">
<input type="hidden" name="day" value="<%=day%>">
<input type="hidden" name="route_no" value="<%=route_no%>">
<input type="hidden" name="id" value="<%=id%>">
<input type="hidden" name="transit_no" value="<%=transit_no%>">
<input type="hidden" name="from_st" value="<%=from_st%>">
<input type="hidden" name="to_st" value="<%=to_st%>">
<input type="hidden" name="price" value="<%=price%>">
<input class="returnbt" type="submit" formaction="edit.jsp"  value="戻る">
<%
}
%>
</form>
</body>
</html>