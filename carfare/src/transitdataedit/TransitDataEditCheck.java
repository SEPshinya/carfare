package transitdataedit;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import common.CommonDB;

/**
 * Servlet implementation class TransitDataEditCheck
 */
@WebServlet("/TransitDataEditCheck")
public class TransitDataEditCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public TransitDataEditCheck() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		int user_id = (int) request.getSession().getAttribute("User_id");
		String data_id = (String) request.getParameter("data_id");
		String transit_no = (String) request.getParameter("transit_no");
		String from_st = (String) request.getParameter("from_st");
		String to_st = (String) request.getParameter("to_st");
		String price = (String) request.getParameter("price");

		if (CommonDB.checkTransitData(transit_no, from_st, to_st, price, user_id))
			CommonDB.addTransitData(transit_no, from_st, to_st, price, user_id);

		CommonDB.updateTransitData(data_id, transit_no, from_st, to_st, price, user_id);

		request.removeAttribute("transit_no");
		request.removeAttribute("from_st");
		request.removeAttribute("to_st");
		request.removeAttribute("price");
		request.removeAttribute("data_id");

		getServletContext().getRequestDispatcher("/TransitdataList").forward(request, response);

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
