
package list;

import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.CommonDB;

/**
 * Servlet implementation class ListBL
 */
@WebServlet("/List")
public class List extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public List() {
		super();
		// TODO Auto-generated constructor stub
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		//セッションを使いLoginから飛ばされたuser_idを取得する
		//user_idによって表示させる内容が違うので
		HttpSession session = request.getSession();
		int user_id =(int) session.getAttribute("User_id");
		String URL = "jdbc:mysql://localhost:3306/carfare?serverTimezone=JST";
		String USERNAME = "root";
		String PASSWORD = "";

		int listCnt=0;
		/** ページング **/
		//ページ数取得
		String nowPage = request.getParameter("page");
		int limitSta = 0;

		//現在のページ
		if (nowPage == null) {
			nowPage = "1";
		}

		int np = Integer.parseInt(nowPage);
		request.setAttribute("np", np);
		if (np > 1) {
			//LIMIT句の値を求める　取得を始める件数　たとえばLimitが０だったらIDの若番から数えて１～１０件まで取得する
			limitSta = (np - 1) * 10;
		}

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connect = DriverManager.getConnection(URL, USERNAME, PASSWORD);
			Statement stmt = connect.createStatement();
			String getQuery ="SELECT count(*) AS count FROM transit_list WHERE user_id = "+user_id+" AND delete_flg = 0";
			ResultSet rs = stmt.executeQuery(getQuery);
			rs.next();
			listCnt = rs.getInt("count");
			request.setAttribute("listCnt", listCnt);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		//一覧に表示する値をDBから取得しResutSetに格納　SQLなどはCommonDBにすでに書いてあるのでそこから持ってきてる
		ResultSet rs = CommonDB.getTransitListAll(limitSta, user_id);
		request.setAttribute("rs", rs);

		/**交通手段一覧のページへ遷移**/
		getServletContext().getRequestDispatcher("/list.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub



	}
}