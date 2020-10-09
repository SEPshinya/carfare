package list;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;


@WebServlet("/List")
public class List extends HttpServlet {
	private static final long serialVersionUID = 1L;


	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		Connection connect=null;
		Statement stmt=null;
		PreparedStatement ps=null;
		ResultSet rs=null;
		//現在のページ
		String nowPage=null;
		//総件数
		int listCnt = 0;
		int limitSta=0;
		//表取得
		String SelectQuery="SELECT * FROM `transit_list` WHERE 1";

		//取得対象全件数
		String CntQuery="SELECT COUNT(*) count FROM transit_list";
		//String nowPage="";
		final String URL
	    = "jdbc:mysql://localhost:3306/carfare?serverTimezone=JST";
	    final String USER = "root";
	    final String PASS = "";

	    try {
	    	//Mysqlに繋げている（道順）
	    	//Class.forName("com.mysql.jdbc.Driver");
			stmt=connect.createStatement();
			rs = stmt.executeQuery(CntQuery);
			 rs.next();
			 listCnt = rs.getInt("id");
			 request.setAttribute("listCnt", listCnt);
	    } catch (SQLException e) {
			// TODO 自動生成された catch ブロック
			e.printStackTrace();
		}
	    // DBに接続
	    try {
			connect = DriverManager.getConnection(URL, USER, PASS);
		} catch (SQLException e) {
			e.printStackTrace();
		}

	  //引数のSQLを設定したものがps（変数）に入ってる、sqlの実行準備ができた
	    try {
			ps= connect.prepareStatement(SelectQuery);
			rs= ps.executeQuery();
		} catch (SQLException e) {
			// TODO 自動生成された catch ブロック
			e.printStackTrace();
		}
		request.setAttribute("Result",rs);




		nowPage = request.getParameter("page");
		if(nowPage==null) {
		nowPage="1";
		}
		int np =Integer.parseInt(nowPage);
		request.setAttribute("np", np);
		if(np>1) {
		limitSta=(np-1)*10;
		};








		//List.jspへ画面遷移
		getServletContext().getRequestDispatcher("/list.jsp").forward(request,response);






	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
