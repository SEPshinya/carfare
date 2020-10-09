package common;

public class CommonErrMsg {
	/**
	 * 	ログイン画面で使用
	 *	入力データのエラーチェック
	 **/
	public static String getLoginErr(String address, String password) {
		if (isBytes(address)) {
			return "メールアドレスに全角を使用しないでください";
		} else if (stringDigits(address) > 254) {
			return "メールアドレスは半角254文字以内で入力してください";
		}
		if (isBytes(password)) {
			return "パスワードに全角を使用しないでください";
		} else if (stringDigits(password) > 16) {
			return "メールアドレスは半角16文字以内で入力してください";
		}
		try {
			return CommonDB.isUser(address, password) ? "" : "メールアドレスもしくはパスワードが間違っているか入力されていません。";
		} catch (Exception e) {
			return "例外が発生しました:" + e.toString();
		}
	}

	/**
	 * 	登録、編集画面で使用
	 *	入力データのエラーチェック
	 **/
	public static String getErrMsg(String className, String value) {
		switch (className) {
		case "day":
			if (value.equals("")) {
				return "日付は必須項目です";
			}
			return value.matches("^\\d{4}/\\d{2}/\\d{2}$") ? "" : "日付は「yyyy/mm/dd」の形式で入力してください";
		case "route":
			return value.equals("") ? "片道or往復は必須項目です" : "";
		case "transit":
			return value.equals("") ? "交通機関は必須項目です" : "";
		case "from_st":
			if (value.equals("")) {
				return "";
			}
			return stringDigits(value) > 20 ? "出発駅は全角10文字以内で入力してください" : "";
		case "to_st":
			if (value.equals("")) {
				return "";
			}
			return stringDigits(value) > 20 ? "到着駅は全角10文字以内で入力してください" : "";
		case "price":
			if (value.equals("")) {
				return "";
			}
			return value.matches("[0-9]+") ? "" : "金額は数値で入力してください";
		default:
			return "";
		}
	}

	//入力データのバイトチャック
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