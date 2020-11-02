package adduser;

import java.io.IOException;
import java.math.BigInteger;
import java.security.MessageDigest;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class UserAdd
 */
@WebServlet("/UserAdd")
public class UserAdd extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public UserAdd() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String role_name="";

		String user_name = request.getParameter("name");
		String address = request.getParameter("address");
		String Password = request.getParameter("Password");
		String Password2 = request.getParameter("Password2");
		String role_id = request.getParameter("role");
		String salt = null;
		String loginkey = null;

		String errmsg = UserAddCommon.getErr(Password, Password2, address, role_id,user_name);

		if (errmsg != "") {
			request.setAttribute("getErr", errmsg);
			getServletContext().getRequestDispatcher("/useradd.jsp").forward(request, response);
		}

		try {
			MessageDigest md = MessageDigest.getInstance("SHA-256");
			byte[] result = md.digest(address.getBytes());
			salt = String.format("%040x", new BigInteger(1, result));
			String saltpass = salt + Password;
			byte[] result2 = md.digest(saltpass.getBytes());
			loginkey = String.format("%040x", new BigInteger(1, result2));
		} catch (Exception e) {
			e.printStackTrace();
		}
		if(role_id.equals("1")) {
			role_name="一般";
		}else {
			role_name="管理者";
		}

		request.setAttribute("role_name", role_name);
		request.setAttribute("user_name", user_name);
		request.setAttribute("address", address);
		request.setAttribute("salt", salt);
		request.setAttribute("loginkey", loginkey);
		request.setAttribute("role_id", role_id);
		getServletContext().getRequestDispatcher("/useraddcheck.jsp").forward(request, response);

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doGet(request, response);
	}

}
