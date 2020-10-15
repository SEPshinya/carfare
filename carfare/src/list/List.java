
package list;

import java.io.FileOutputStream;
import java.io.IOException;
import java.sql.Connection;
import java.sql.DriverManager;
import java.sql.ResultSet;
import java.sql.SQLException;
import java.sql.Statement;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.Row;
import org.apache.poi.ss.usermodel.Sheet;
import org.apache.poi.ss.usermodel.Workbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;

import common.CommonDB;

/**
 * Servlet implementation class ListBL
 */
@WebServlet("/List")
public class List extends HttpServlet {
	private static final long serialVersionUID = 1L;

	public List() {
		super();
		// TODO Auto-generated constructor stub
	}

	public void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		//セッションを使いLoginから飛ばされたuser_idを取得する
		//user_idによって表示させる内容が違うので
		HttpSession session = request.getSession();
		String URL = "jdbc:mysql://localhost:3306/carfare?serverTimezone=JST";
		String USERNAME = "root";
		String PASSWORD = "";
		int user_id =1;//(int) session.getAttribute("User_id");
		int listCnt=0;
		/** ページング **/
		//ページ数取得
		String nowPage = request.getParameter("page");
		int limitSta = 0;

		//現在のページ
		if (nowPage == null) {
			nowPage = "1";
		}

		int np = Integer.parseInt(nowPage);
		request.setAttribute("np", np);
		if (np > 1) {
			//LIMIT句の値を求める　取得を始める件数　たとえばLimitが０だったらIDの若番から数えて１～１０件まで取得する
			limitSta = (np - 1) * 10;
		}

		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connect = DriverManager.getConnection(URL, USERNAME, PASSWORD);
			Statement stmt = connect.createStatement();
			String getQuery ="SELECT count(*) AS count FROM transit_list WHERE user_id = "+user_id+" AND delete_flg = 0";
			ResultSet rs = stmt.executeQuery(getQuery);
			rs.next();
			listCnt = rs.getInt("count");
			request.setAttribute("listCnt", listCnt);

		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {
			e.printStackTrace();
		}

		//一覧に表示する値をDBから取得しResutSetに格納　SQLなどはCommonDBにすでに書いてあるのでそこから持ってきてる
		ResultSet rs = CommonDB.getTransitListAll(limitSta, user_id);
		request.setAttribute("rs", rs);

		/**交通手段一覧のページへ遷移**/
		getServletContext().getRequestDispatcher("/list.jsp").forward(request, response);
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	public void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub

		response.setContentType("test/html; charset=UTF-8");
    	request.setCharacterEncoding("UTF-8");
    	HttpSession session = request.getSession();

    	String id=request.getParameter("id");
    	String day=request.getParameter("day");
    	String route_name=request.getParameter("route_name");
    	String transit_name=request.getParameter("transit_name");
    	String from_st=request.getParameter("from_st");
    	String to_st=request.getParameter("to_st");
    	String price=request.getParameter("price");
    	String filename=(String)session.getAttribute("user_name");


    	Workbook wb = new XSSFWorkbook();

		//①書き込みたいシート、シートの生成
		Sheet sheet1 = wb.createSheet();

		//②どこの行？※1列目=0、行の生成
		Row row1=sheet1.createRow(0);

		//③どこの列？、セルの生成
		Cell cell1=row1.createCell(0);

		//④書き込みたいこと、値のセット
		cell1.setCellValue(id);

		Row row2=sheet1.createRow(1);
		Cell cell2=row2.createCell(0);
		cell2.setCellValue(day);


		FileOutputStream out =null;

		try {
			//ここに返します
			out=new FileOutputStream("C:\\Users\\abesatsuki1200\\Pictures\\"+filename+".xlsx");

			//編集部分を書いて保存
			wb.write(out);

		}catch(IOException e) {
			System.out.println(e.toString());
		}finally {
			try {
				wb.close();
				out.close();
			}catch(IOException e) {
				System.out.println(e.toString());
			}


	}
		RequestDispatcher rd = request.getRequestDispatcher("/test.jsp");
		rd.forward(request, response);

	}
}