<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%request.setCharacterEncoding("UTF-8");%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>確認</title>
</head>
<body>

	<table>
      <tr>
        <th>入力されたパスワード:</th>
        <td><%= request.getAttribute("pass") %></td>
      </tr>
      <tr>
        <th>ハッシュ化されたパスワード</th>
        <td><%= request.getAttribute("loginKey") %></td>
      </tr>
      <tr>
      <th>userテーブルに登録されていたパスワード</th>
      <td><%= request.getAttribute("Key") %></td>
      </tr>
            <tr>
      <th></th>
      <td><%= request.getAttribute("message") %></td>
      </tr>
                  <tr>
      <th>ソルト</th>
      <td><%= request.getAttribute("salt") %></td>
      </tr>
     </table>
</body>
</html>