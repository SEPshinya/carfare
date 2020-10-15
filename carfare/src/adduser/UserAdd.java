package adduser;

import java.io.IOException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.SQLException;
import java.sql.Statement;

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
		response.setContentType("text/html; charset=UTF-8");

		String address = request.getParameter("address");
		String Password = request.getParameter("Password");
		String Password2 = request.getParameter("Password2");
		String role_id = request.getParameter("role");
		String salt = null;
		String loginkey = null;
		String URL = "jdbc:mysql://localhost:3306/carfare?serverTimezone=JST";
		String USERNAME = "root";
		String PASSWORD = "";

		String errmsg = UserAddCommon.getErr(Password, Password2, address, role_id);

		if (errmsg != null) {
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
		if (errmsg == null) {
			try {
				Class.forName("com.mysql.cj.jdbc.Driver");
				Connection connect = DriverManager.getConnection(URL, USERNAME, PASSWORD);
				Statement stmt = connect.createStatement();
				String InsQuery = "INSERT INTO `user` (`user_id`, `address`, `password`, `role_id`, `salt`) VALUES (NULL, '"
						+ address + "', '" + loginkey + "', '" + role_id + "', '" + salt + "');";
				stmt.executeUpdate(InsQuery);
			} catch (SQLException e) {
				e.printStackTrace();
			} catch (ClassNotFoundException e) {
				e.printStackTrace();
			}
		}
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