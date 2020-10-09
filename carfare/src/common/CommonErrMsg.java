package common;

public class CommonErrMsg {
	/**
	 * テストコミット
	 * */

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
		return address.equals("") || password.equals("") ? "メールアドレスもしくはパスワードが入力されていません。" : "";
	}

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