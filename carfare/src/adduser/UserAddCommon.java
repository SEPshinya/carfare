package adduser;

import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;

public class UserAddCommon{
	 public static String getErr(String Password,String Password2,String address, String role_id) {
		 List<String> eMsgCodes;
		 String ERRMSG_NAME01="名前は全角20文字以内で入力してください";
		 String ERRMSG_NAME02="名前は必須項目です";
		 String ERRMSG_ADDRESS01="住所は全角40文字以内で入力してください";
		 String ERRMSG_ADDRESS02="住所は必須項目です";
		 String ERRMSG_TEL01="電話番号は「000-0000-0000」の形式で入力してください";
		 String returnVal=null;

		 if(name.getBytes().length>40) {
			 returnVal+=ERRMSG_NAME01+"<BR>";
		 }

		 if(name.getBytes().length==0) {
			 returnVal+=ERRMSG_NAME02 +"<BR>";
		 }

		 if(address.getBytes().length>80) {
			 returnVal+=ERRMSG_ADDRESS01 + "<BR>";
		 }

		 if(address.getBytes().length==0) {
			 returnVal+=ERRMSG_ADDRESS02 +"<BR>";
			 }

	        Pattern p = Pattern.compile("^[0-9]{3}-[0-9]{4}-[0-9]{4}$");
	        Matcher m = p.matcher(tel);
	        if(m.find()!=true) {
		    	returnVal+=ERRMSG_TEL01+"<BR>";
	        }

		 return returnVal;
	 }

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
}