<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" import="java.text.NumberFormat"%>

<%
/** 登録か編集かの判断値**/
String menulist=(String)request.getAttribute("menulist");

/** もし値の受け渡しがある場合用**/
//日付
String day=(String) request.getAttribute("day");
//片道or往復
String route_no=(String) request.getAttribute("route_no");
String route_name=(String) request.getAttribute("route_name");
//交通機関
String transit_no=(String)request.getAttribute("transit_no");
String transit_name=(String)request.getAttribute("transit_name");
//出発駅
String from_st=(String)request.getAttribute("from_st");
//到着駅
String to_st=(String)request.getAttribute("to_st");
//金額
String price=(String)request.getAttribute("price");

/** 金額 処理変更**/
int Price=0;
if(price.isEmpty()){
price="0";
}else{
	Price=Integer.parseInt(price);
}
NumberFormat nf = NumberFormat.getNumberInstance();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<link rel="stylesheet" href="css/add.css">
<title>登録確認</title>
</head>
<body>
<h2>交通費登録システム：登録</h2>

<form class="addlist"  method="post">

<table>
<tr>
<th>日付：</th>
<td><%=day%></td>
</tr>

<tr>
<th>片道or往復：</th>
<td><%=route_name%></td>
</tr>

<tr>
<th>交通機関：</th>
<td><%=transit_name%></td>
</tr>

<tr>
<th>出発駅：</th>
<td><%=from_st%></td>
<th class="to">―到着駅：</th>
<td><%=to_st%></td>
</tr>

<tr>
<th>金額：</th>
<td><%if(Price==0){%>
<%=price %>
<%}else{ %>
<%=nf.format(Price)%>
<%
}
%>
円</td>
</tr>

</table>

<br>
<!-- hidden用 -->
<input type="hidden" name="menulist" value="<%=menulist%>">
<input type="hidden" name="day" value="<%=day%>">
<input type="hidden" name="route_no" value="<%=route_no%>">
<input type="hidden" name="transit_no" value="<%=transit_no%>">
<input type="hidden" name="from_st" value="<%=from_st%>">
<input type="hidden" name="to_st" value="<%=to_st%>">
<input type="hidden" name="price" value="<%=price%>">

<dt>&nbsp;</dt>
<dd>
<input class="transitionbt" type="submit" formaction="AddCheck" value="登録">
<input class="transitionbt" type="submit" formaction="Add" formmethod="get" value="戻る">
</dd>
</dl>
</form>
</body>
</html>