
package list;

import java.io.IOException;
import java.sql.ResultSet;

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
		int count =CommonDB.getTransitListCnt(user_id);
		request.setAttribute("listCnt", count);


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
		doGet(request, response);
	}
}