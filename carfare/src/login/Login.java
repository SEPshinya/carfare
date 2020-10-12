package login;

import java.io.IOException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.CommonDB;
import common.CommonErrMsg;

@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public Login() {
		super();
	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");

		String address = request.getParameter("address");//ログイン画面で入力したアドレス
		String password = request.getParameter("password"); //PassWord

		String Key = null; //userパス
		String salt = null; //ソルト

		String ErrMsg = CommonErrMsg.getLoginErr(address, password);

		if (!ErrMsg.equals("")) {
			request.setAttribute("message", ErrMsg);
			getServletContext().getRequestDispatcher("/login.jsp").forward(request, response);
		}
		ResultSet rs = CommonDB.getUser(address);
		try {
			rs.next();
			salt = rs.getString("salt");
		} catch (SQLException e1) {
		}
		//ハッシュ化
		String loginKey = null;
		String saltpass = null;

		saltpass = salt + password;
		try {
			MessageDigest md = MessageDigest.getInstance("SHA-256");
			byte[] result = md.digest(saltpass.getBytes());
			loginKey = String.format("%040x", new BigInteger(1, result));
		} catch (Exception e) {
			e.printStackTrace();
		}
		ErrMsg=CommonErrMsg.getLoginErr(loginKey);
		if (!ErrMsg.equals("")) {
			request.setAttribute("message", ErrMsg);
			getServletContext().getRequestDispatcher("/login.jsp").forward(request, response);
		}
		int User_id=CommonDB.getUserId(address,loginKey);


	    HttpSession session = request.getSession();
	    session.setAttribute("User_id",User_id);



		getServletContext().getRequestDispatcher("/logincheck.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}
}
