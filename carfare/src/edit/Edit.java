package edit;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.CommonErrMsg;
import common.CommonUpdData;

/**
 * Servlet implementation class InputTest2
 */
@WebServlet("/Edit")
public class Edit extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Edit() {
		super();
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//ユーザーidの取得
		HttpSession session = request.getSession();
		int user_id = (int) session.getAttribute("User_id");

		//入力値の取得
		int id = Integer.parseInt((String) request.getParameter("id"));
		String day = (String) request.getParameter("day");
		String route_no = (String) request.getParameter("route_no");
		String transit_no = (String) request.getParameter("transit_no");
		String from_st = (String) request.getParameter("from_st");
		String to_st = (String) request.getParameter("to_st");
		String price = (String) request.getParameter("price");

		//入力されたデータを次のjspへ渡す
		request.setAttribute("day", day);
		request.setAttribute("route_no", route_no);
		request.setAttribute("transit_no", transit_no);
		request.setAttribute("from_st", from_st);
		request.setAttribute("to_st", to_st);
		request.setAttribute("price", price);
		request.setAttribute("user_id", user_id);

		//アップデートデータクラスの作成
		CommonUpdData data = new CommonUpdData(id, day, route_no, transit_no, from_st, to_st, price, user_id);
		//入力値にエラーが含まれていないかを調べる
		String errmsg = CommonErrMsg.getErrMsg(data);

		/**
		 * エラーメッセージにテキストが入っていない
		 * 		→編集確認画面へ遷移
		 * 		  その時にアップデートデータクラスも持っていく
		 *
		 * エラーメッセージにテキストが入ってる
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
