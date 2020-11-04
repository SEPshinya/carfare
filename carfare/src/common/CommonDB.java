package common;

import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;

public class CommonDB {

	private static final String URL = "jdbc:mysql://localhost:3306/carfare?serverTimezone=JST";
	private static final String USERNAME = "root";
	private static final String PASSWORD = "";

	/**
	 *	登録、編集画面でプルダウンメニュー作成時に使用
	 *	片道or往復
	 **/
	public static ResultSet getRouteAll() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String getQuery = "SELECT * FROM route ORDER BY route_no ASC;";
			return DriverManager.getConnection(URL, USERNAME, PASSWORD).createStatement().executeQuery(getQuery);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 *	登録確認、編集確認画面で表示する際に使用
	 *	片道or往復
	 **/
	public static String getRouteName(String route_no) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String getQuery = "SELECT route_name FROM route WHERE route_no = " + route_no + ";";
			ResultSet rs = DriverManager.getConnection(URL, USERNAME, PASSWORD)
					.createStatement().executeQuery(getQuery);
			rs.next();
			return rs.getString("route_name");
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
	public static ResultSet getTransitAll() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String getQuery = "SELECT * FROM transit ORDER BY transit_no ASC;";
			return DriverManager.getConnection(URL, USERNAME, PASSWORD).createStatement().executeQuery(getQuery);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 *	登録確認、編集確認画面で表示する際に使用
	 *	交通手段
	 **/
	public static String getTransitName(String transit_no) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String getQuery = "SELECT transit_name FROM transit WHERE transit_no = " + transit_no + ";";
			ResultSet rs = DriverManager.getConnection(URL, USERNAME, PASSWORD)
					.createStatement().executeQuery(getQuery);
			rs.next();
			return rs.getString("transit_name");
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 *	登録確認、編集確認画面で登録、編集実行前に使用
	 *	同じ交通手段があるかどうかを確認する
	 *	あればtrue、なければfalseを返す
	 **/
	public static boolean checkTransitData(String transit_no, String from_st, String to_st,
			String price, int user_id) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String getQuery = "SELECT * FROM transit_data "
					+ "WHERE transit_data.user_id = " + user_id + " "
					+ "AND transit_data.transit_no LIKE '" + transit_no + "' "
					+ "AND transit_data.from_st LIKE '" + from_st + "' "
					+ "AND transit_data.to_st LIKE '" + to_st + "' "
					+ "AND transit_data.price LIKE '" + price.replace(",", "") + "' "
					+ "AND transit_data.delete_flg = 0;";
			return DriverManager.getConnection(URL, USERNAME, PASSWORD).createStatement().executeQuery(getQuery).next();
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return false;
	}

	/**
	 *	登録確認、編集確認画面で登録、編集実行前に使用
	 *	交通手段があるかどうかを調べた後に実行
	 *	なかった場合に入力された値をtransit_dataDBに追加する
	 **/
	public static void addTransitData(String transit_no, String from_st, String to_st,
			String price, int user_id) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String InsQuery = "INSERT INTO `transit_data` (`data_id`, `transit_no`, `from_st`, `to_st`, `price`, `user_id`) VALUES (NULL, '"
					+ transit_no + "', '" + from_st + "', '" + to_st + "', '" + price + "', '" + user_id + "');";
			DriverManager.getConnection(URL, USERNAME, PASSWORD).createStatement().executeUpdate(InsQuery);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	/**
	 *	交通手段編集画面で使用
	 **/
	public static void updateTransitData(String data_id, String transit_no, String from_st, String to_st, String price,
			int user_id) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String UpdQuery = "UPDATE transit_data SET transit_no = '" + transit_no
					+ "', from_st = '" + from_st + "', to_st = '" + to_st
					+ "', price = '" + price.replace(",", "") + "' WHERE data_id = " + data_id + ";";
			DriverManager.getConnection(URL, USERNAME, PASSWORD).createStatement().executeUpdate(UpdQuery);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	/**
	 *	交通手段削除画面で使用
	 **/
	public static void deleteTransitData(int data_id) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String DelQuery = "UPDATE transit_data SET delete_flg = '1' WHERE data_id = " + data_id + ";";
			DriverManager.getConnection(URL, USERNAME, PASSWORD).createStatement().executeUpdate(DelQuery);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
	}

	/**
	 *	交通手段一覧画面から使用
	 *	交通機関、出発駅、到着駅を受け取り、LIKE句をかけて絞り込む
	 **/
	public static ResultSet getTransitDataAll(String transit_no, String from_st, String to_st,
			int user_id, int limitSta) {
		try {
			/**
			 * 受け取った値の確認
			 * 受け取った値がnullであれば空文字("")を代入
			 * そうでなければそのまま代入する
			 **/
			transit_no = (transit_no == null || transit_no.isEmpty()) ? "'%%' " : "'%" + transit_no + "%' ";
			from_st = (from_st == null || from_st.isEmpty()) ? "'%%' " : "'%" + from_st + "%' ";
			to_st = (to_st == null || to_st.isEmpty()) ? "'%%' " : "'%" + to_st + "%' ";
			Class.forName("com.mysql.cj.jdbc.Driver");
			String getQuery = "SELECT transit_data.data_id,transit_data.transit_no,transit.transit_name,transit_data.from_st,transit_data.to_st,transit_data.price "
					+ "FROM transit_data , transit "
					+ "WHERE transit_data.transit_no = transit.transit_no "
					+ "AND transit_data.user_id = " + user_id + " "
					+ "AND transit_data.transit_no LIKE " + transit_no + " "
					+ "AND transit_data.from_st LIKE " + from_st + " "
					+ "AND transit_data.to_st LIKE " + to_st + " "
					+ "AND transit_data.delete_flg = 0 "
					+ "ORDER BY transit_data.data_id ASC "
					+ "LIMIT " + limitSta + " , 10;";

			return DriverManager.getConnection(URL, USERNAME, PASSWORD).createStatement().executeQuery(getQuery);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 *	交通手段一覧画面から使用
	 *	交通機関、出発駅、到着駅を受け取り、LIKE句をかけて絞り込む
	 *	絞り込んだ件数を返す
	 **/
	public static int getTransitDataCnt(String transit_no, String from_st, String to_st, int user_id) {
		try {
			/**
			 * 受け取った値の確認
			 * 受け取った値がnullであれば空文字("")を代入
			 * そうでなければそのまま代入する
			 **/
			transit_no = (transit_no == null || transit_no.isEmpty()) ? "'%%' " : "'%" + transit_no + "%' ";
			from_st = (from_st == null || from_st.isEmpty()) ? "'%%' " : "'%" + from_st + "%' ";
			to_st = (to_st == null || to_st.isEmpty()) ? "'%%' " : "'%" + to_st + "%' ";
			Class.forName("com.mysql.cj.jdbc.Driver");
			String getQuery = "SELECT count(*) AS count "
					+ "FROM transit_data "
					+ "WHERE transit_data.user_id = " + user_id + " "
					+ "AND transit_data.transit_no LIKE " + transit_no + " "
					+ "AND transit_data.from_st LIKE " + from_st + " "
					+ "AND transit_data.to_st LIKE " + to_st + " "
					+ "AND transit_data.delete_flg = 0;";
			ResultSet rs = DriverManager.getConnection(URL, USERNAME, PASSWORD)
					.createStatement().executeQuery(getQuery);
			rs.next();
			return rs.getInt("count");
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return 0;
	}

	/**
	 *	一覧画面で使用
	 **/
	public static ResultSet getTransitListAll(int limitSta, int user_id) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String getQuery = "SELECT transit_list.id,transit_list.day,transit.transit_name,route.route_name, " +
					"transit_list.from_st,transit_list.to_st,transit_list.price " +
					"FROM transit_list,route,transit " +
					"WHERE transit_list.route_no = route.route_no " +
					"AND transit_list.transit_no = transit.transit_no " +
					"AND transit_list.user_id = " + user_id + " " +
					"AND transit_list.delete_flg = 0 " +
					"ORDER BY day ASC " +
					"LIMIT " + limitSta + " , 10;";
			return DriverManager.getConnection(URL, USERNAME, PASSWORD).createStatement().executeQuery(getQuery);
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
	public static int getTransitListCnt(int user_id) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String getQuery = "SELECT count(*) AS count " +
					"FROM transit_list " +
					"WHERE user_id = " + user_id + " " +
					"AND delete_flg = 0;";
			ResultSet rs = DriverManager.getConnection(URL, USERNAME, PASSWORD)
					.createStatement().executeQuery(getQuery);
			rs.next();
			return rs.getInt("count");
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return 0;
	}

	/**
	 *	ログイン画面で使用
	 *	ログイン時に入力された値を受け取る
	 *	一致するものがあれば ユーザー情報を返す
	 *	一致するものがなければ nullを返す
	 **/
	public static ResultSet getUser(String password, String address) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String getQuery = "SELECT * FROM user "
					+ "WHERE  address LIKE '" + address + "'"
					+ "AND password LIKE '" + password + "';";
			return DriverManager.getConnection(URL, USERNAME, PASSWORD).createStatement().executeQuery(getQuery);
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
	public static ResultSet getUser(String address) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String getQuery = "SELECT * FROM user WHERE address LIKE '" + address + "';";
			return DriverManager.getConnection(URL, USERNAME, PASSWORD).createStatement().executeQuery(getQuery);
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
	public static boolean isUser(String loginKey) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String getQuery = "SELECT * FROM user "
					+ "WHERE password LIKE '" + loginKey + "';";
			return DriverManager.getConnection(URL, USERNAME, PASSWORD).createStatement().executeQuery(getQuery).next();
		} catch (SQLException | ClassNotFoundException e) {
			e.printStackTrace();
		}
		return false;
	}

	/**
	 *	ログイン画面で使用
	 *	利用者分類表を返す
	 **/
	public static ResultSet getUserCategoryAll() {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String getQuery = "SELECT * FROM user_category ORDER BY role_id ASC;";
			return DriverManager.getConnection(URL, USERNAME, PASSWORD).createStatement().executeQuery(getQuery);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return null;
	}

	/**
	 *	ログイン画面で使用
	 *	それ以降は、ログイン画面で設定したセッションから取得
	 *
	 * 	現在利用しているユーザーidを取得する
	 *
	 * 	発見できなかった場合0を返す
	 **/
	public static int getUserId(String address, String password) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String getQuery = "SELECT user_id FROM user "
					+ "WHERE address LIKE '" + address + "' "
					+ "AND password LIKE '" + password + "';";
			ResultSet rs = DriverManager.getConnection(URL, USERNAME, PASSWORD)
					.createStatement().executeQuery(getQuery);
			rs.next();
			return rs.getInt("user_id");
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
		return 0;
	}

	/**
	 *	登録画面で使用
	 */
	public static void addDB(CommonAddData data) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String InsQuery = "INSERT INTO `transit_list` (`id`, `day`, `route_no`, `transit_no`, `from_st`, `to_st`, `price`, `user_id`, `delete_flg`) VALUES (NULL, '"
					+ data.getDay() + "', '" + data.getRoute_no() + "', '"
					+ data.getTransit_no() + "', '" + data.getFrom_st() + "', '"
					+ data.getTo_st() + "', '" + data.getPrice().replace(",", "") + "', '" + data.getUser_id()
					+ "', 0);";
			DriverManager.getConnection(URL, USERNAME, PASSWORD).createStatement().executeUpdate(InsQuery);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	/**
	 *	編集画面で使用
	 **/
	public static void updateDB(CommonUpdData data) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String UpdQuery = "UPDATE transit_list SET day = '" + data.getDay()
					+ "', route_no = '" + data.getRoute_no() + "', transit_no = '" + data.getTransit_no()
					+ "', from_st = '" + data.getFrom_st() + "', to_st = '" + data.getTo_st()
					+ "', price = '" + data.getPrice().replace(",", "") + "' WHERE id = " + data.getId();
			DriverManager.getConnection(URL, USERNAME, PASSWORD).createStatement().executeUpdate(UpdQuery);
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}
	}

	/**
	 *	削除画面で使用
	 **/
	public static void deleteDB(int id) {
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			String DelQuery = "UPDATE transit_list SET delete_flg = '1' WHERE id = " + id + ";";
			DriverManager.getConnection(URL, USERNAME, PASSWORD).createStatement().executeUpdate(DelQuery);
		} catch (ClassNotFoundException | SQLException e) {
			e.printStackTrace();
		}
	}

}
