package common;

import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

public class CommonDB {

	private static final String URL = "jdbc:mysql://localhost:3306/carfare?serverTimezone=JST";
	private static final String USERNAME = "root";
	private static final String PASSWORD = "";

	/**
	 *	登録、編集画面でプルダウンメニュー作成時に使用
	 *	片道or往復
	 **/
	public ResultSet getRouteAll() {
		try {
			//DBへ接続
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connect = DriverManager.getConnection(URL, USERNAME, PASSWORD);
			Statement stmt = connect.createStatement();
			String getQuery = "SELECT * FROM route ORDER BY route_no ASC;";
			ResultSet rs = stmt.executeQuery(getQuery);

			return rs;
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 *	登録、編集画面でプルダウンメニュー作成時に使用
	 *	交通手段
	 **/
	public ResultSet getTransitAll() {
		try {
			//DBへ接続
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connect = DriverManager.getConnection(URL, USERNAME, PASSWORD);
			Statement stmt = connect.createStatement();
			String getQuery = "SELECT * FROM transit ORDER BY transit_no ASC;";
			ResultSet rs = stmt.executeQuery(getQuery);
			return rs;
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 *	登録、編集画面から使用
	 *	交通機関、出発駅、到着駅を受け取り、LIKE句をかけて絞り込む
	 **/
	public ResultSet getTransitDataAll(String transit_no, String from_st, String to_st) {
		try {
			/**
			 * 受け取った値の確認
			 * 受け取った値がnullであれば空文字("")を代入
			 * そうでなければそのまま代入する
			 **/
			String transitNo = (transit_no == null) ? "" : "'%" + transit_no + "%'";
			String fromSt = (from_st == null) ? "" : "'%" + from_st + "%'";
			String toSt = (to_st == null) ? "" : "'%" + to_st + "%'";
			//DBへ接続
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connect = DriverManager.getConnection(URL, USERNAME, PASSWORD);
			Statement stmt = connect.createStatement();
			String getQuery = "SELECT * FROM transit_data"
					+ " WEHRE transit_no LIKE " + transitNo
					+ " AND from_st LIKE " + fromSt
					+ " AND to_st LIKE " + toSt
					+ " ORDER BY data_id ASC;";
			ResultSet rs = stmt.executeQuery(getQuery);
			return rs;
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 *	一覧画面で使用
	 **/
	public ResultSet getTransitListAll() {
		try {
			//DBへ接続
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connect = DriverManager.getConnection(URL, USERNAME, PASSWORD);
			Statement stmt = connect.createStatement();
			String getQuery = "SELECT * FROM transit_list ORDER BY day ASC;";
			ResultSet rs = stmt.executeQuery(getQuery);
			return rs;
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 *	ログイン画面で使用
	 *	ログイン時に入力された値を受け取る
	 *	一致するものがあれば ユーザー情報を返す
	 *	一致するものがなければ nullを返す
	 **/
	public ResultSet getUser(String address, String password) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connect = DriverManager.getConnection(URL, USERNAME, PASSWORD);
			Statement stmt = connect.createStatement();
			String getQuery = "SELECT * FROM user"
					+ " WHERE address LIKE " + address
					+ " AND password LIKE " + password + ";";
			ResultSet rs = stmt.executeQuery(getQuery);
			return rs;
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 *	ログイン画面で使用
	 *	ログイン時に入力された値を受け取る
	 *	一致するものがあれば trueを返す
	 *	一致するものがなければ falseを返す
	 **/
	public Boolean isUser(String address, String password) {
		try {
			return getUser(address, password).isLast();
		} catch (SQLException e) {
			e.printStackTrace();
		}
		return false;
	}

	/**
	 *	ログイン画面で使用
	 *	利用者分類表を返す
	 **/
	public ResultSet getUserCategoryAll() {
		try {
			//DBへ接続
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connect = DriverManager.getConnection(URL, USERNAME, PASSWORD);
			Statement stmt = connect.createStatement();
			String getQuery = "SELECT * FROM user_category ORDER BY role_id ASC;";
			ResultSet rs = stmt.executeQuery(getQuery);
			return rs;
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return null;
	}
}
