package edit;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.CommonErrMsg;
import common.CommonUpdData;

/**
 * Servlet implementation class InputTest2
 */
@WebServlet("/Edit")
public class Edit extends HttpServlet {

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//ユーザーidの取得
		int user_id = (int) request.getSession().getAttribute("User_id");

		//入力値の取得
		int id = Integer.parseInt((String) request.getParameter("id"));
		String day = (String) request.getParameter("day");
		String route_no = (String) request.getParameter("route_no");
		String transit_no = (String) request.getParameter("transit_no");
		String from_st = (String) request.getParameter("from_st");
		String to_st = (String) request.getParameter("to_st");
		String price = (String) request.getParameter("price");

		//アップデートデータクラスの作成
		CommonUpdData data = new CommonUpdData(id, day, route_no, transit_no, from_st, to_st, price, user_id);
		//入力値にエラーが含まれていないかを調べる
		String errmsg = CommonErrMsg.getErrMsg(data);

		/**
		 * エラーがない
		 * 		→編集確認画面へ遷移
		 * 		  その時にアップデートデータクラスも持っていく
		 * エラーがある
		 * 		→編集画面へ遷移
		 * 		  その時にエラーメッセージも持っていく
		 **/
		if (errmsg.equals("")) {
			request.setAttribute("data", data);
			getServletContext().getRequestDispatcher("/editCheck.jsp").forward(request, response);
		} else {
			request.setAttribute("errmsg", errmsg);
			getServletContext().getRequestDispatcher("/edit.jsp").forward(request, response);
		}
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
