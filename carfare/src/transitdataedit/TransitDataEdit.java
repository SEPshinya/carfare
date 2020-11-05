package transitdataedit;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.CommonErrMsg;

/**
 * Servlet implementation class TransitDataEdit
 */
@WebServlet("/TransitDataEdit")
public class TransitDataEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public TransitDataEdit() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		//入力値の取得
		String data_id = (String) request.getParameter("data_id");
		String transit_no = (String) request.getParameter("transit_no");
		String from_st = (String) request.getParameter("from_st");
		String to_st = (String) request.getParameter("to_st");
		String price = (String) request.getParameter("price");
		String errmsg = CommonErrMsg.getErrMsg(from_st, to_st, price);

		//値を次に画面に渡す
		request.setAttribute("data_id", data_id);
		request.setAttribute("transit_no", transit_no);
		request.setAttribute("from_st", from_st);
		request.setAttribute("to_st", to_st);
		request.setAttribute("price", price);

		//errmsgが空の場合は交通手段編集確認画面へ、そうでない場合は交通手段編集画面へ
		if (errmsg.equals("")) {
			getServletContext().getRequestDispatcher("/transitDataEditCheck.jsp").forward(request, response);
		} else {
			request.setAttribute("errmsg", errmsg);
			getServletContext().getRequestDispatcher("/transitDataEdit.jsp").forward(request, response);
		}
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
