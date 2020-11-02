package adduser;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UserAddcheck
 */
@WebServlet("/UserAddcheck")
public class UserAddcheck extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UserAddcheck() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		request.setCharacterEncoding("UTF-8");
		doGet(request, response);
		String user_name = request.getParameter("user_name");
		String address = request.getParameter("address");
		String salt = request.getParameter("salt");
		String loginkey = request.getParameter("loginkey");
		String role_id = request.getParameter("role_id");

		UserAddCommon.addUser(user_name, address, loginkey, role_id, salt);

		getServletContext().getRequestDispatcher("/List").forward(request, response);
	}

}
