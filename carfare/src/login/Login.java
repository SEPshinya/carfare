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
		String salt = null; //ソルト
		int role_id = 0;
		String user_name = "";

		//入力エラーチェック
		String ErrMsg = CommonErrMsg.getLoginErr(address, password);
		if (!ErrMsg.equals("")) {
			request.setAttribute("message", ErrMsg);
			getServletContext().getRequestDispatcher("/login.jsp").forward(request, response);
		}

		//DBからアドレスをもとにソルトを取得
		ResultSet rs = CommonDB.getUser(address);
		try {
			rs.next();
			salt = rs.getString("salt");
			role_id = rs.getInt("role_id");
			user_name = rs.getString("user_name");

		} catch (SQLException e1) {
		}

		//ハッシュ化
		String loginKey = null;//ハッシュ化されたパスワードが入ります
		String saltpass = null;//ソルトと入力されたパスワードを結合したものが入ります

		saltpass = salt + password;
		try {
			MessageDigest md = MessageDigest.getInstance("SHA-256");
			byte[] result = md.digest(saltpass.getBytes());
			loginKey = String.format("%040x", new BigInteger(1, result));
		} catch (Exception e) {
			e.printStackTrace();
		}
		//入力されたパスワードをハッシュ化し、userテーブルに格納されているパスワードと一致するか
		ErrMsg = CommonErrMsg.getLoginErr(loginKey);
		if (!ErrMsg.equals("")) {
			request.setAttribute("message", ErrMsg);
			getServletContext().getRequestDispatcher("/login.jsp").forward(request, response);
		}
		//アドレスとパスワードが格納されているものと一致したのでUser_idを取得しListへ遷移
		int User_id = CommonDB.getUserId(address, loginKey);
		//セッション！！
		HttpSession session = request.getSession();
		session.setAttribute("User_id", User_id);
		session.setAttribute("role_id", role_id);
		session.setAttribute("user_name", user_name);

		getServletContext().getRequestDispatcher("/List").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);

	}
}
