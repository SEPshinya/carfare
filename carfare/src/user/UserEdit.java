package user;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UserEdit
 */
@WebServlet("/UserEdit")
public class UserEdit extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UserEdit() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String user_id = request.getParameter("user_id");
		String user_name = request.getParameter("user_name");
		String addressCH = request.getParameter("addressCH");
		String address = request.getParameter("address");
		String Password = request.getParameter("Password");
		String Password2 = request.getParameter("Password2");
		String role_id = request.getParameter("role_id");
		String role_name = null;

		String getErr = UserCommon.editErr(Password,Password2,address, addressCH,user_name);

		request.setAttribute("user_id", user_id);
		request.setAttribute("user_name", user_name);
		request.setAttribute("address", address);
		request.setAttribute("addressCH", addressCH);
		request.setAttribute("role_id", role_id);

		if (getErr != "") {
			request.setAttribute("getErr", getErr);
			getServletContext().getRequestDispatcher("/useredit.jsp").forward(request, response);
		}

		if(role_id.equals("1")) {
			role_name="一般";
		}else {
			role_name="管理者";
		}
		request.setAttribute("role_name", role_name);
		getServletContext().getRequestDispatcher("/usereditcheck.jsp").forward(request, response);


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
