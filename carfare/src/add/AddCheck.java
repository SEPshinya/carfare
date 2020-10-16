package add;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.CommonAddData;
import common.CommonDB;



/**
 * Servlet implementation class AddCheck
 */
@WebServlet("/AddCheck")
public class AddCheck extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddCheck() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.getWriter().append("Served at: ").append(request.getContextPath());
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		String menulist=request.getParameter("menulist");
		String day=request.getParameter("day");
		String route_no=request.getParameter("route_no");
		String transit_no=request.getParameter("transit_no");
		String from_st=request.getParameter("from_st");
		String to_st=request.getParameter("to_st");
		String price=request.getParameter("price");

		/** ユーザーID取得 **/
		HttpSession session = request.getSession();
		int user_id=(int)session.getAttribute("User_id");

		CommonAddData data = new CommonAddData(day, route_no, transit_no, from_st, to_st, price, user_id);

		CommonDB.addDB(data);

		if (!(CommonDB.checkTransitData(transit_no, from_st, to_st, price, user_id))) {
			 CommonDB.addTransitData(transit_no, from_st, to_st, price, user_id);
		}

		//フォワード
		RequestDispatcher rd =
		        request.getRequestDispatcher("/List");
		        rd.forward(request,response);

	}

}
