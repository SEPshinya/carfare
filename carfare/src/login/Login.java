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
	    }else{
	    	message="ログイン失敗";
	    }
	    request.setAttribute("message", message);
	    request.setAttribute("loginKey", loginKey);
	    request.setAttribute("pass", pass);

	    getServletContext().getRequestDispatcher("/logincheck.jsp").forward(request, response);
	}

	/*
	 *
	 * パスワードをハッシュ化し、その値を比較してログイン可能かを判断する
	 * これをベースに形にしていく予定です
	 *
	 *  現在はcommonDBを使用せずLogin.Javanにコード書きこんでます（石橋君と用打ち合わせして実際はcommonDBを実装しての処理になります！）
	 *
	 *
	 *  【ログイン処理】
	 *
	 *  １.ログイン画面で入力したメアドを使い、UserテーブルからそのユーザーのID、ハッシュ化したパスワード、ソルトを持ってくる
	 *
	 *  ２.ログイン画面で入力したパスワードを、DBから取得したソルトを使いハッシュ化
	 *
	 *  ３.ログイン画面で入力したパスワードから生成されたハッシュ化した値と、
	 *     DBに格納されているpasswordの値を比較しログイン可能かを判断
	 *
	 *  ４.ログイン可能ならユーザーIDを一覧画面などに引き継ぐ（ロールIDなども引きつぐ？）
	 *
	 * 【もし、登録機能を作らなければいけなくなった場合】
	 * saltはaddressかuser_idをもとに乱数を生成しuserテーブルのsaltに格納
	 * また、パスワードを先ほど生成したsaltを使いハッシュ化して格納
	 * この処理でユーザーによって同じパスワードを使ったとしても生成されるハッシュ値が異なるようになる
	 *
	 *
	 * 	何か不明なところや指摘などがあればおねがいします
	 *
	 *
	 * 【その他】
	 * userテーブルのaddressは一意にしたほうがいいかもしれないです
	 *
	 *
	 * userテーブルのPasswordはハッシュ化するため桁数が足りなくなりそうですので、
	 * まだ何桁までにするとは決めてないのでサンプルのハッシュ値を格納できる範囲に広げてください
	 *
	 * userテーブルにsaltを格納するカラムを追加願いします（設計書のほうは自分のほうで書き換えておきます）
	 * こちらも同じく何桁になるかわからないので（略
	 *
	 * 【userのサンプルです】
	 *	INSERT INTO `user`(`user_id`, `address`, `password`, `role_id`, `salt`)
	 *	VALUES (1,"harashinya1192","11e95bc230ec51789ca5b027c5d52afecfba66fb3a150d63205d152370bb7d35",1,
	 *	"88d4266fd4e6338d13b845fcf289579d209c897823b9217da3e161936f031589")
	 *
	 *	【ログイン情報】
	 *	add   harashinya1192
	 *  pass  hara1192
	 *
	 */

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
		}
	}
