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

/**
 * Servlet implementation class Excel
 */
@WebServlet("/Excel")
public class Excel extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public Excel() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		response.setContentType("test/html; charset=UTF-8");
		request.setCharacterEncoding("UTF-8");
		HttpSession session = request.getSession();
		String user_name="あべさつき";//(String)session.getAttribute("user_name");
		int User_id=1;//(int)session.getAttribute("User_id");

		String id = request.getParameter("id");
		String day = request.getParameter("day");
		String route_name = request.getParameter("route_name");
		String transit_name = request.getParameter("transit_name");
		String from_st = request.getParameter("from_st");
		String to_st = request.getParameter("to_st");
		String price = request.getParameter("price");


		String URL = "jdbc:mysql://localhost:3306/carfare?serverTimezone=JST";
		String USERNAME = "root";
		String PASSWORD = "";
		int user_id = (int) session.getAttribute("User_id");

		//①書き込みたいシート、シートの生成
		Workbook wb = new XSSFWorkbook();

		//SELECT * FROM `transit_list` WHERE user_id =1 AND delete_flg=0;

		Sheet sheet1 = wb.createSheet();
		int n = 0;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connect = DriverManager.getConnection(URL, USERNAME, PASSWORD);
			Statement stmt = connect.createStatement();
			String getQuery = "SELECT * FROM transit_list INNER JOIN route ON transit_list.route_no = route.route_no INNER JOIN transit ON transit_list.transit_no =transit.transit_no WHERE user_id =" +user_id+ " AND delete_flg=0";
			ResultSet rs = stmt.executeQuery(getQuery);
			while (rs.next()) {

				Row row1 = sheet1.createRow(n);
				Cell cell1 = row1.createCell(0);//縦
				Cell cell2 = row1.createCell(1);
				Cell cell3 = row1.createCell(2);
				Cell cell4 = row1.createCell(3);
				Cell cell5 = row1.createCell(4);
				Cell cell6 = row1.createCell(5);
				Cell cell7 = row1.createCell(6);

				cell1.setCellValue(rs.getInt("id"));
				cell2.setCellValue(rs.getString("day"));
				cell3.setCellValue(rs.getString("route_name"));
				cell4.setCellValue(rs.getString("transit_name"));
				cell5.setCellValue(rs.getString("from_st"));
				cell6.setCellValue(rs.getString("to_st"));
				cell7.setCellValue(rs.getString("price"));
				n = n+1;
			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {

		}

		FileOutputStream out = null;
		String filename=""+ User_id +"交通費一覧_"+user_name;
		try {
			//ここに返します
			out = new FileOutputStream("C:\\Users\\abesatsuki1200\\Pictures\\" + filename + ".xlsx");

			//編集部分を書いて保存
			wb.write(out);

		} catch (IOException e) {
			System.out.println(e.toString());
		} finally {
			try {
				wb.close();
				out.close();
			} catch (IOException e) {
				System.out.println(e.toString());
			}
		}
		RequestDispatcher rd = request.getRequestDispatcher("/excelcheck.jsp");
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
