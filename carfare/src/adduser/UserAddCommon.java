package adduser;

public class UserAddCommon {

	public static String getErr(String Password, String Password2, String address, String role_id) {
		String ERRMSG_Pass01 = "パスワードを入力してください";
		String ERRMSG_Pass02 = "確認用パスワードを入力してください";
		String ERRMSG_Address01 = "メールアドレスは254文字以内で入力してください";
		String ERRMSG_Address02 = "メールアドレスは必須項目です";
		String returnVal = null;

		if (Password.getBytes().length == 0) {
			returnVal += ERRMSG_Pass01 + "<BR>";
		}

		if (Password2.getBytes().length == 0) {
			returnVal += ERRMSG_Pass02 + "<BR>";
		}

		if(stringDigits(address) > 254) {
			returnVal += ERRMSG_Address01 + "<BR>";
		}else if (address.getBytes().length == 0) {
			returnVal += ERRMSG_Address02 + "<BR>";
		}

		if(stringDigits(address) > 254) {
			returnVal += ERRMSG_ADDRESS02 + "<BR>";
		}

		return returnVal;
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
