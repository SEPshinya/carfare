package user;

import java.io.IOException;
import java.io.PrintWriter;
import java.math.BigInteger;
import java.security.MessageDigest;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Usereditcheck
 */
@WebServlet("/Usereditcheck")
public class Usereditcheck extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Usereditcheck() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		String user_id = request.getParameter("user_id");
		String user_name = request.getParameter("user_name");
		String address = request.getParameter("address");
		String Password = request.getParameter("Password");
		String role_id = request.getParameter("role_id");
		String salt = null;
		String loginkey = null;
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();

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
		UserCommon.editUser(user_id, user_name,address,loginkey,role_id,salt);

		out.println("<META http-equiv=\"Refresh\" content=\"3;URL=List\">");
		out.println("<H2>ユーザーの変更が完了しました</H2>");
		out.println("<p>３秒後に一覧画面へ遷移します</p>");
		out.close();
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
