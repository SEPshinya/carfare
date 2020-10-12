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
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		HttpSession session = request.getSession();
		int user_id = (int) session.getAttribute("user_id");

		int id = Integer.parseInt((String) request.getParameter("id"));
		String day = (String) request.getParameter("day");
		String route_no = (String) request.getParameter("route_no");
		String transit_no = (String) request.getParameter("transit_no");
		String from_st = (String) request.getParameter("from_st");
		String to_st = (String) request.getParameter("to_st");
		String price = (String) request.getParameter("price");

		request.setAttribute("day", day);
		request.setAttribute("route", route_no);
		request.setAttribute("transit", transit_no);
		request.setAttribute("from_st", from_st);
		request.setAttribute("to_st", to_st);
		request.setAttribute("price", price);
		request.setAttribute("user_id", user_id);

		CommonUpdData data = new CommonUpdData(id, day, route_no, transit_no, from_st, to_st, price, user_id);
		String errmsg = CommonErrMsg.getErrMsg(data);

		if (errmsg.equals("")) {
			getServletContext().getRequestDispatcher("/EditCheack.jsp").forward(request, response);
		} else {
			request.setAttribute("errmsg", errmsg);
			getServletContext().getRequestDispatcher("/TestInput2.jsp").forward(request, response);
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
