package common;

public class CommonAddData {
	/**
	 *	クラス外から値を参照させないために
	 *	修飾子を全てprivateにする
	 **/
	private final String day;
	private final String route_no;
	private final String transit_no;
	private final String from_st;
	private final String to_st;
	private final String price;
	private final int user_id;

	/**
	 *	値をセットするのは、
	 *	インスタンスを生成したときのみとする
	 **/
	public CommonAddData(String day, String route_no, String transit_no,
			String from_st, String to_st, String price, int user_id) {
		this.day = day;
		this.route_no = route_no;
		this.transit_no = transit_no;
		this.from_st = from_st;
		this.to_st = to_st;
		this.price = price;
		this.user_id = user_id;
	}

	/**
	 *	各フィールドのゲッター
	 *	値を取り出す際に使用
	 **/
	public String getDay() {
		return day;
	}

	public String getRoute_no() {
		return route_no;
	}

	public String getTransit_no() {
		return transit_no;
	}

	public String getFrom_st() {
		return from_st;
	}

	public String getTo_st() {
		return to_st;
	}

	public String getPrice() {
		return price;
	}

	public int getUser_id() {
		return user_id;
	}
}
