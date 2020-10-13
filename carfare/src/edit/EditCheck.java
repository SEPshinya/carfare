package edit;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.CommonDB;
import common.CommonUpdData;

/**
 * Servlet implementation class EditCheck
 */
@WebServlet("/EditCheck")
public class EditCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public EditCheck() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//editCheckで作成したセッションデータの取得
		CommonUpdData data = (CommonUpdData) request.getSession().getAttribute("upddata");

		//上で取得したアップデートデータクラスを使用して編集用のSQLを実行
		CommonDB.updateDB(data);

		//一覧画面へ遷移
		getServletContext().getRequestDispatcher("/List").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
