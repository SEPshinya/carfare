package transitdata;

import java.io.IOException;
import java.net.URLDecoder;
import java.sql.ResultSet;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import common.CommonDB;

/**
 * Servlet implementation class TransitdataList
 */
@WebServlet("/TransitdataList")
public class TransitdataList extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public TransitdataList() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		request.setCharacterEncoding("UTF-8");
		response.setContentType("text/html; charset=UTF-8");

		String errmsg=request.getParameter("errmsg");

		/** ユーザーID取得 **/
		HttpSession session = request.getSession();
		int user_id=(int)session.getAttribute("User_id");

		/** 登録か編集かの登録値の受け渡し**/
		String menulist =request.getParameter("menulist");


		/** 入力値引継ぎ**/
		String day=request.getParameter("day");
		String route_no=request.getParameter("route_no");
		String price=request.getParameter("price");

		String id=request.getParameter("id");



		/** ページング  **/
		//ページ数取得
		String Page = request.getParameter("page");

		//現在のページ
		String nowPage = "";
		if (Page != null) {
			nowPage = Page;
		} else {
			nowPage = "1";
		}
		int now = Integer.parseInt(nowPage);

		//LIMIT句の値
		int limitSta = (now - 1) * 10;
		;

		/** 検索値の取得**/
		//交通機関No
		String transit_no =(String) request.getParameter("transit_no");
		//int transit_no=Integer.parseInt(transit_no_int);

		if (transit_no == null) {
			transit_no ="";
		}

		//出発駅
		String from_st = request.getParameter("from_st");

		if (from_st == null) {
			from_st ="";
		}

		//出発駅（エンコード版）
		String from_st_encoded=request.getParameter("from_st_encoded");
		//String from_st_encoded="%E6%8A%BC%E4%B8%8A";

		//エンコードからデコードへ変換
		if(from_st_encoded!=null) {
			from_st= URLDecoder.decode(from_st_encoded, "UTF-8");
		}

		//到着駅
		String to_st = request.getParameter("to_st");

		if (to_st == null) {
			to_st ="";
		}

		//到着駅（エンコード版）
		String to_st_encoded=request.getParameter("to_st_encoded");

		//エンコードからデコードへ変換
		if(to_st_encoded!=null) {
			to_st= URLDecoder.decode(to_st_encoded, "UTF-8");
		}

		/** DBの取得 **/
		//Transit_dataを取得(総数取得)
		int listCnt = CommonDB.getTransitDataCnt(transit_no, from_st, to_st, user_id);

		//Transit_dataを取得(一覧取得)
		ResultSet rs = CommonDB.getTransitDataAll(transit_no, from_st, to_st, user_id ,limitSta);

		/** 送る用の値 **/

		//登録か編集かの判断値
		request.setAttribute("menulist", menulist);

		//エラー
		request.setAttribute("errmsg", errmsg);

		//入力値引継ぎ
		request.setAttribute("day",day);
		request.setAttribute("route_no", route_no);

		request.setAttribute("id", id);


		//request.setAttribute("user_id",user_id);

		//ページング関連
		String listC = String.valueOf(listCnt);
		String noww = String.valueOf(now);
		request.setAttribute("listCnt", listC);
		request.setAttribute("page", noww);

		//交通手段一覧取得用
		request.setAttribute("rs", rs);

		//検索値
		request.setAttribute("price", price);
		request.setAttribute("transit_no", transit_no);
		request.setAttribute("from_st", from_st);
		request.setAttribute("to_st", to_st);

		/**交通手段一覧のページへ遷移**/
		RequestDispatcher rd = request.getRequestDispatcher("/transitDataList.jsp");
		rd.forward(request, response);


	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub

		doGet(request, response);
	}

}
