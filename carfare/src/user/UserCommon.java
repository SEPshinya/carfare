package user;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class UserCommon {
	private static final String URL = "jdbc:mysql://localhost:3306/carfare?serverTimezone=JST";
	private static final String USERNAME = "root";
	private static final String PASSWORD = "";

	//新規登録エラーチェック
	public static String getErr(String Password, String Password2, String address, String role_id, String user_name) {
		String ERRMSG_Pass01 = "パスワードを入力してください";
		String ERRMSG_Pass02 = "確認用パスワードを入力してください";
		String ERRMSG_Pass03 = "パスワードは半角16文字以内で入力してください";
		String ERRMSG_Pass04 = "パスワードは半角で入力してください";
		String ERRMSG_Pass05 = "パスワードが一致しません";
		String ERRMSG_Address01 = "メールアドレスは254文字以内で入力してください";
		String ERRMSG_Address02 = "メールアドレスは半角で入力してください";
		String ERRMSG_Address03 = "メールアドレスは必須項目です";
		String ERRMSG_Addserch = "このメールアドレスはほかのユーザーに使用されているため登録できません";
		String ERRMSG_Role01 = "役職を選択してください";
		String ERRMSG_Name01 = "氏名を入力してください";
		String ERRMSG_Name02 = "氏名は16文字以内で入力してください";
		String returnVal = "";

		if (user_name.getBytes().length == 0) { //未入力
			returnVal += ERRMSG_Name01 + "<BR>";
		} else if (stringDigits(user_name) > 16) {
			returnVal += ERRMSG_Name02 + "<BR>";
		}

		//アドレス
		if (address.getBytes().length == 0) { //未入力
			returnVal += ERRMSG_Address03 + "<BR>";
		} else if (isBytes(address)) {
			returnVal += ERRMSG_Address02 + "<BR>";
		}
		if (stringDigits(address) > 254) { //あどれす長杉
			returnVal += ERRMSG_Address01 + "<BR>";
		}
		//パスワード
		if (Password.getBytes().length == 0) { //未入力
			returnVal += ERRMSG_Pass01 + "<BR>";
		} else if (isBytes(Password)) {
			returnVal += ERRMSG_Pass04 + "<BR>"; //全角
		}

		if (stringDigits(Password) > 16) {
			returnVal += ERRMSG_Pass03 + "<BR>"; //16いない
		}
		if (Password2.getBytes().length == 0) { //pass2未入力
			returnVal += ERRMSG_Pass02 + "<BR>";
		}

		if (role_id.equals("3")) {
			returnVal += ERRMSG_Role01 + "<BR>";//役職未選択
		}
		if (addserch(address)) {
			returnVal += ERRMSG_Addserch + "<BR>";
		}
		if (!Password.equals(Password2)) {
			returnVal += ERRMSG_Pass05 + "<BR>";
		}
		return returnVal;
	}

	//ユーザー検索エラーチェック
	public static String searchErr(String user_id, String user_name) {
		String ERRMSG_ID01 = "IDを入力してください";
		String ERRMSG_ID02 = "IDは数字を入力してください";
		String ERRMSG_Name01 = "名前を入力してください";
		String ERRMSG_userserch = "ユーザーが見つかりません";
		String returnVal = "";

		if (user_name.getBytes().length == 0) { //未入力
			returnVal += ERRMSG_Name01 + "<BR>";
		}
		//ID
		if (user_id.getBytes().length == 0) { //未入力
			returnVal += ERRMSG_ID01 + "<BR>";
		} else if (!hecknumber(user_id)) {
			returnVal += ERRMSG_ID02 + "<BR>";
			return returnVal;

		}
		if (returnVal.equals("")) {

			if (!userserch(user_id, user_name)) {
				returnVal += ERRMSG_userserch + "<BR>";
			}
		}

		return returnVal;
	}

	//ユーザー編集エラーチェック
	public static String editErr(String Password, String Password2, String address, String addressCH,
			String user_name) {
		String ERRMSG_Pass01 = "パスワードを入力してください";
		String ERRMSG_Pass02 = "確認用パスワードを入力してください";
		String ERRMSG_Pass03 = "パスワードは16文字以内で入力してください";
		String ERRMSG_Pass04 = "パスワードは半角で入力してください";
		String ERRMSG_Pass05 = "パスワードが一致しません";
		String ERRMSG_Address01 = "メールアドレスは254文字以内で入力してください";
		String ERRMSG_Address02 = "メールアドレスは半角で入力してください";
		String ERRMSG_Address03 = "メールアドレスは必須項目です";
		String ERRMSG_Addserch = "このメールアドレスはほかのユーザーに使用されているため変更できません";
		String ERRMSG_Name01 = "氏名を入力してください";
		String ERRMSG_Name02 = "氏名は16文字以内で入力してください";
		String returnVal = "";
		if (user_name.getBytes().length == 0) { //未入力
			returnVal += ERRMSG_Name01 + "<BR>";
		} else if (stringDigits(user_name) > 16) {
			returnVal += ERRMSG_Name02 + "<BR>";
		}

		//アドレス
		if (address.getBytes().length == 0) { //未入力
			returnVal += ERRMSG_Address03 + "<BR>";
		} else if (isBytes(address)) {
			returnVal += ERRMSG_Address02 + "<BR>";
		}
		if (stringDigits(address) > 254) { //あどれす長杉
			returnVal += ERRMSG_Address01 + "<BR>";
		}
		//パスワード
		if (Password.getBytes().length == 0) { //未入力
			returnVal += ERRMSG_Pass01 + "<BR>";
		}
		if (isBytes(Password)) {
			returnVal += ERRMSG_Pass04 + "<BR>"; //全角
		}else if (stringDigits(Password) > 16) {
			returnVal += ERRMSG_Pass03 + "<BR>"; //16いない
		}
		if (Password2.getBytes().length == 0) { //pass2未入力
			returnVal += ERRMSG_Pass02 + "<BR>";
		} else if (!Password.equals(Password2)) {
			returnVal += ERRMSG_Pass05 + "<BR>";
		}

		if (!address.equals(addressCH)) {
			if (addserch(address)) {
				returnVal += ERRMSG_Addserch + "<BR>";
			}
		}

		return returnVal;

	}

	//アドレスが使用されていないかを調べる
	public static Boolean addserch(String address) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connect = DriverManager.getConnection(URL, USERNAME, PASSWORD);
			Statement stmt = connect.createStatement();
			String getQuery = "SELECT * FROM user " + "WHERE address=  '" + address + "';";
			return stmt.executeQuery(getQuery).next();
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		return false;
	}

	// IDと名前でユーザー検索
	public static Boolean userserch(String user_id, String user_name) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connect = DriverManager.getConnection(URL, USERNAME, PASSWORD);
			Statement stmt = connect.createStatement();
			String getQuery = "SELECT * FROM user WHERE user_id= \"" + user_id + "\" AND user_name = \"" + user_name
					+ "\";";
			return stmt.executeQuery(getQuery).next();
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		return false;
	}

	//ユーザー取得
	public static ResultSet userget(String user_id) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connect = DriverManager.getConnection(URL, USERNAME, PASSWORD);
			Statement stmt = connect.createStatement();
			String getQuery = "SELECT * FROM user WHERE user_id = \"" + user_id + "\";";
			return stmt.executeQuery(getQuery);
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		return null;
	}

	//ユーザ登録
	public static void addUser(String user_name, String address, String loginkey, String role_id, String salt) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connect = DriverManager.getConnection(URL, USERNAME, PASSWORD);
			Statement stmt = connect.createStatement();
			String InsQuery = "INSERT INTO `user` (`user_id`,`user_name`, `address`, `password`, `role_id`, `salt`) VALUES (NULL, '"
					+ user_name + "', '" + address + "', '" + loginkey + "', '" + role_id + "', '" + salt + "');";
			stmt.executeUpdate(InsQuery);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	//ユーザ編集登録
	public static void editUser(String user_id, String user_name, String address, String role_id, String loginkey,
			String salt) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connect = DriverManager.getConnection(URL, USERNAME, PASSWORD);
			Statement stmt = connect.createStatement();
			String InsQuery = "UPDATE `user` SET `user_name`=\"" + user_name + "\",`address`=\"" + address
					+ "\",`role_id`=" + role_id + ",`password`=\"" + loginkey + "\",`salt`=\"" + salt
					+ "\" WHERE user_id=" + user_id + ";";
			stmt.executeUpdate(InsQuery);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	//入力データが数字かチェック
	private static boolean hecknumber(String user_id) {
		try {
			Integer.parseInt(user_id);
			return true;
		} catch (NumberFormatException e) {
			return false;
		}
	}

	//入力データのバイトチェック（石橋君から借りてます）
	private static int stringDigits(String s) {
		char[] chars = s.toCharArray();
		int digits = 0;
		for (int i = 0; i < chars.length; i++) {
			digits += (String.valueOf(chars[i]).getBytes().length < 2) ? 1 : 2;
		}
		return digits;
	}

	//入力データがぜんかくかどうかを調べる
	private static boolean isBytes(String s) {
		char[] chars = s.toCharArray();
		boolean b = false;
		for (int i = 0; i < chars.length; i++) {
			if (!b) {
				b = String.valueOf(chars[i]).getBytes().length > 1;
			} else {
				break;
			}
		}
		return b;
	}

}
