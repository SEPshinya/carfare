<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>ログイン</title>
</head>
<body>
<h1></h1>
    <form action="Login">
    <table>
      <tr>
        <th>メールアドレス:</th>
        <td><input type="text" name="address"></td>
      </tr>
      <tr>
        <th>パスワード:</th>
        <td><input type="password" name="password"></td>
      </tr>
     </table>
  		<input type="submit"  value="ログイン">
  	</form>
<% String getErr=(String)request.getAttribute("message"); %>
<%if(getErr!=null){ %>
<%=getErr%>
<%}%>

</body>
</html>