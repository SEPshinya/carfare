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
	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		//editCheckで作成したセッションデータの取得
		CommonUpdData data = (CommonUpdData) request.getSession().getAttribute("upddata");
		request.getSession().removeAttribute("upddata");

		//一覧表示を上書きする前に入力された交通手段が未登録かどうかを調べる
		if (!(CommonDB.checkTransitData(data.getTransit_no(), data.getFrom_st(), data.getTo_st(), data.getPrice(),
				data.getUser_id())))
			//未登録のものだったらtransit_dataDBに新規登録
			CommonDB.addTransitData(data.getTransit_no(), data.getFrom_st(), data.getTo_st(), data.getPrice(),
					data.getUser_id());

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
