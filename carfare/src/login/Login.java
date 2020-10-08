package login;

//import common.CommonDB;
import java.io.IOException;
import java.math.BigInteger;
import java.security.MessageDigest;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.sql.SQLException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

@WebServlet("/Login")
public class Login extends HttpServlet {
	private static final long serialVersionUID = 1L;
    public Login() {
        super();
        // TODO Auto-generated constructor stub
    }

	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
	    ResultSet rs=null;
	    PreparedStatement ps=null;
	    String message=null;

	    //ログイン画面で入力したアドレス
	    String address =request.getParameter("address");

	    //ログイン画面で入力したパスワード
	    String pass=request.getParameter("pass");

	    //DBから取得したソルト
	    String salt = null;

	    //DBから取得したハッシュ化済みパスワード
	    String Key=null;

	    //ログイン画面から入力されたパスワードとソルトを組み合わせたもの
	    String saltpass=null;

	    //取得したパスワードをソルト化してハッシュ化したもの
	    String loginKey=null;

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connect = (Connection) DriverManager.getConnection("jdbc:mysql://localhost:3306/carfare?characterEncoding=UTF-8&serverTimezone=JST", "root", "");
			String getQuery = "SELECT * FROM user "+ "WHERE address LIKE '" + address + "';";
			ps=connect.prepareStatement(getQuery);
			rs=ps.executeQuery();
			//rs=CommonDB.getUser(address);
			rs.next();
			Key=rs.getString("password");
			salt=rs.getString("salt");
			request.setAttribute("salt", salt);
			request.setAttribute("Key", Key);

		} catch (SQLException e) {
			e.printStackTrace();

		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		//ハッシュ化
		//入力されたパスワードと取得したソルトを結合
		saltpass=salt+pass;

		//結合したものをハッシュ化
	    try {
	    MessageDigest md = MessageDigest.getInstance("SHA-256");
        byte[] result = md.digest(saltpass.getBytes());
        loginKey = String.format("%040x", new BigInteger(1, result));
	    }catch (Exception e){
	    	e.printStackTrace();
    }
//比較
	    if(loginKey.equals(Key)) {
	    	message="ログイン成功";
	    	//user_id取得
	    }else{
	    	message="ログイン失敗";
	    }
	    request.setAttribute("message", message);
	    request.setAttribute("loginKey", loginKey);
	    request.setAttribute("pass", pass);

	    getServletContext().getRequestDispatcher("/logincheck.jsp").forward(request, response);
	}


	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		}
	}
