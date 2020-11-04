package common;

import java.util.Arrays;

public class CommonErrMsg {
	/**
	 * 	ログイン画面で使用
	 * 	入力データのエラーチェック
	 * 	入力された値が入力条件に当てはまるかを調べる
	 **/
	public static String getLoginErr(String address, String password) {
		String errmsg = "";
		if (address.isEmpty() || password.isEmpty()) {
			return errmsg += "メールアドレスもしくはパスワードが入力されていません。<br>";
		}
		if (isBytes(address)) {
			errmsg += "メールアドレスに全角を使用しないでください<br>";
		} else if (stringDigits(address) > 254) {
			errmsg += "メールアドレスは半角254文字以内で入力してください<br>";
		}
		if (isBytes(password)) {
			errmsg += "パスワードに全角を使用しないでください<br>";
		} else if (stringDigits(password) > 16) {
			errmsg += "パスワードは半角16文字以内で入力してください<br>";
		}
		return errmsg;
	}

	/**
	 * 	ログイン画面で使用
	 * 	入力データのパスワードチェック
	 * 	ハッシュ化されたパスワードをもとにユーザーが登録されているか否かを調べる
	 **/
	public static String getLoginErr(String loginKey) {
		try {
			return CommonDB.isUser(loginKey) ? "" : "メールアドレスもしくはパスワードが間違っています。";
		} catch (Exception e) {
			return "例外が発生しました:" + e.toString();
		}
	}

	/**
	 * 	登録、編集画面で使用
	 *	入力データのエラーチェック
	 **/
	public static String getErrMsg(CommonAddData data) {
		String errmsg = "";
		//String[] dateData … 入力された日付データを年、月、日、マッチ用データの4つに分ける
		//dateData[0] … 年のデータが入っている 01等のデータの先頭の0は消える
		//dateData[1] … 月のデータが入っている 01等のデータの先頭の0は消える
		//dateData[2] … 日のデータが入っている 01等のデータの先頭の0は消える
		//dateData[3] … マッチ用データが入っている
		String[] dateData = dateData(data.getDay());
		//matchdata …　
		//		^[0-9]{" + 入力値の年の部分の値.length()
		//			+ "}/[0-9]{"+ 入力値の月の部分の値.length()
		//				+ "}/[0-9]{" + 入力値の日の部分の値.length() + "}$
		//ex)「^[0-9]{4}/[0-9]{1}/[0-9]{2}$」
		//		4桁の数字 + /(スラッシュ) + 1桁の数字 + / + 2桁の数字という意味になる
		String matchdata = "^[0-9]{" + dateData[0].length()
				+ "}/[0-9]{" + dateData[1].length()
				+ "}/[0-9]{" + dateData[2].length() + "}$";
		if (data.getDay().isEmpty()) {
			errmsg += "日付は必須項目です<br>";
		} else if (!(dateData[3].matches(matchdata) && chackDayData(data.getDay()))) {
			if (!(chackDayData(data.getDay()))) {
				errmsg += "日付を正式な範囲で入力してください<br>";
			} else {
				errmsg += "日付は「yyyy/mm/dd」の形式で入力してください<br>";
			}
		}
		if (stringDigits(data.getFrom_st()) > 20) {
			errmsg += "出発駅は全角10文字以内で入力してください<br>";
		}
		if (stringDigits(data.getTo_st()) > 20) {
			errmsg += "到着駅は全角10文字以内で入力してください<br>";
		}
		if (!data.getPrice().isEmpty()) {
			//編集画面から接続された場合getPrice()の値に「,」(カンマ)が含まれる可能性があるため、
			//.replace(",","")で値からカンマを抜く
			if (!(data.getPrice().replace(",", "").matches("[0-9]+"))) {
				errmsg += "金額は数値で入力してください<br>";
			} else if (stringDigits(data.getPrice().replace(",", "")) > 9) {
				errmsg += "金額は9桁以内で入力してください<br>";
			}
		}
		return errmsg;
	}

	public static String getErrMsg(String from_st, String to_st, String price) {
		String errmsg = "";
		if (from_st.isEmpty())
			errmsg += "出発駅は必須項目です<br>";
		else if (stringDigits(from_st) > 20)
			errmsg += "出発駅は全角10文字以内で入力してください<br>";

		if (to_st.isEmpty())
			errmsg += "到着駅は必須項目です<br>";
		else if (stringDigits(to_st) > 20)
			errmsg += "到着駅は全角10文字以内で入力してください<br>";

		if (price.isEmpty())
			errmsg += "金額は必須項目です<br>";
		else if (!(price.replace(",", "").matches("[0-9]+")))
			errmsg += "金額は数値で入力してください<br>";
		else if (stringDigits(price.replace(",", "")) > 9)
			errmsg += "金額は9桁以内で入力してください<br>";
		return errmsg;
	}

	//入力データのバイト数を調べる
	private static int stringDigits(String s) {
		char[] chars = s.toCharArray();
		int digits = 0;
		for (int i = 0; i < chars.length; i++) {
			digits += (String.valueOf(chars[i]).getBytes().length < 2) ? 1 : 2;
		}
		return digits;
	}

	//入力データの全角判定をする
	//全角があればfalseを返す
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

	//入力データが正しい日付のものか調べる
	private static boolean chackDayData(String date) {
		String[] dateData = dateData(date);
		return ismonth(dateData[1]) && isday(createdays(dateData[0], dateData[1]), dateData[2]);
	}

	//対応した月の日付表を渡す
	private static int[] createdays(String nendata, String monthdata) {
		int[] days;
		if (nendata.isEmpty() || monthdata.isEmpty())
			return days = new int[0];
		char[] chars = nendata.toCharArray();
		for (char c : chars)
			if (isString(c))
				return days = new int[0];
		chars = monthdata.toCharArray();
		for (char c : chars)
			if (isString(c))
				return days = new int[0];
		int month = Integer.parseInt(monthdata);
		int lastday = 0;
		switch (month) {
		case 1:
		case 3:
		case 5:
		case 7:
		case 8:
		case 10:
		case 12:
			lastday = 31;
			break;
		case 2:
			lastday = (Integer.parseInt(nendata) % 4 == 0) ? 29 : 28;
			break;
		case 4:
		case 6:
		case 9:
		case 11:
			lastday = 30;
			break;
		default:
			return days = new int[0];
		}
		days = new int[lastday];
		for (int i = 1; i <= lastday; i++)
			days[i - 1] = i;
		return days;
	}

	//入力された日付の「日」が正しいかどうか
	private static boolean isday(int[] list, String daydata) {
		if (daydata.isEmpty())
			return true;
		char[] chars = daydata.toCharArray();
		for (char c : chars)
			if (isString(c))
				return true;
		int day = Integer.parseInt(daydata);
		if (day == 0)
			return false;
		for (int listdays : list)
			if (listdays == day)
				return true;
		return false;
	}

	//入力された日付の「月」が正しいかどうか
	private static boolean ismonth(String monthdata) {
		if (monthdata.isEmpty())
			return true;
		char[] chars = monthdata.toCharArray();
		for (char c : chars)
			if (isString(c))
				return true;
		int month = Integer.parseInt(monthdata);
		if (month == 0)
			return false;
		for (int i = 1; i <= 12; i++)
			if (i == month)
				return true;
		return false;
	}

	//日付データを受け取り、「/」までの値を各変数にいれる
	//入れた変数をString型の配列に入れて返す
	private static String[] dateData(String date) {
		String[] dayData = new String[4];
		if (date.isEmpty()) {
			Arrays.fill(dayData, "");
			return dayData;
		}
		char[] chars = date.toCharArray();
		int flg = 0;
		String nen = "";
		String month = "";
		String day = "";
		int cnt = 0;
		for (Character c : chars) {
			if (c.equals('/')) {
				cnt++;
				continue;
			}
			if (isString(c))
				flg = 1;
			switch (cnt) {
			case 0:
				nen += c;
				break;
			case 1:
				month += c;
				break;
			case 2:
				day += c;
				break;
			}
		}
		dayData[0] = (flg == 0) ? "" + Integer.parseInt(nen.isEmpty() ? "-1" : nen) : nen;
		dayData[1] = (flg == 0) ? "" + Integer.parseInt(month.isEmpty() ? "-1" : month) : month;
		dayData[2] = (flg == 0) ? "" + Integer.parseInt(day.isEmpty() ? "-1" : day) : day;
		dayData[3] = dayData[0] + "/" + dayData[1] + "/" + dayData[2];
		return dayData;
	}

	//dateDataで使用
	//日付データ内に文字列があるかを探すための対象
	private static boolean isString(char c) {
		String match = "" + c;
		return !match.matches("^[0-9]*$");
	}

}