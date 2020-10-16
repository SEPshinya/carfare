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

import org.apache.poi.ss.usermodel.BorderStyle;
import org.apache.poi.ss.usermodel.Cell;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.FillPatternType;
import org.apache.poi.ss.usermodel.Font;
import org.apache.poi.ss.usermodel.IndexedColors;
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
		String user_name = (String) session.getAttribute("user_name");
		int User_id = (int) session.getAttribute("User_id");

		String URL = "jdbc:mysql://localhost:3306/carfare?serverTimezone=JST";
		String USERNAME = "root";
		String PASSWORD = "";
		int user_id = (int) session.getAttribute("User_id");

		//①書き込みたいシート、シートの生成
		Workbook wb = new XSSFWorkbook();

		Sheet sheet1 = wb.createSheet();
		int n = 1;
		try {
			Class.forName("com.mysql.cj.jdbc.Driver");
			Connection connect = DriverManager.getConnection(URL, USERNAME, PASSWORD);
			Statement stmt = connect.createStatement();
			String getQuery = "SELECT * FROM transit_list INNER JOIN route ON transit_list.route_no = route.route_no INNER JOIN transit ON transit_list.transit_no =transit.transit_no WHERE user_id ="
					+ user_id + " AND delete_flg=0 ORDER BY day ASC";
			ResultSet rs = stmt.executeQuery(getQuery);
			//excelの横幅を指定（0=1行目、4000幅）
			sheet1.setColumnWidth(0, 4000);
			sheet1.setColumnWidth(1, 3000);
			sheet1.setColumnWidth(2, 3000);
			sheet1.setColumnWidth(3, 4000);
			sheet1.setColumnWidth(4, 4000);
			sheet1.setColumnWidth(5, 2000);

			//セルのスタイルを変更するためのオブジェクト
			CellStyle cellstyle1 = wb.createCellStyle();

			//フォントオブジェクトを生成
			Font font = wb.createFont();

			//文字の太さを設定
			font.setBold(true);

			//罫線の表示
			cellstyle1.setBorderLeft(BorderStyle.THIN); //左罫線（通常線）
			cellstyle1.setBorderRight(BorderStyle.THIN); //右罫線（通常線）
			cellstyle1.setBorderTop(BorderStyle.THIN); //上罫線（通常線）
			cellstyle1.setBorderBottom(BorderStyle.THIN); //下罫線（通常線）
			cellstyle1.setFillForegroundColor(IndexedColors.PALE_BLUE.index); //色の指定
			cellstyle1.setFillPattern(FillPatternType.SOLID_FOREGROUND);
			cellstyle1.setFont(font); //設定した太さをcellstyle1に適用



			Row row0 = sheet1.createRow(0);
			Cell cell0 = row0.createCell(0);
			cell0.setCellValue("日付");

			Cell cell01 = row0.createCell(1);
			cell01.setCellValue("片道or往復");

			Cell cell02 = row0.createCell(2);
			cell02.setCellValue("交通機関");

			Cell cell03 = row0.createCell(3);
			cell03.setCellValue("出発駅");

			Cell cell04 = row0.createCell(4);
			cell04.setCellValue("到着駅");

			Cell cell05 = row0.createCell(5);
			cell05.setCellValue("金額");

			cell0.setCellStyle(cellstyle1);
			cell01.setCellStyle(cellstyle1);
			cell02.setCellStyle(cellstyle1);
			cell03.setCellStyle(cellstyle1);
			cell04.setCellStyle(cellstyle1);
			cell05.setCellStyle(cellstyle1);

			while (rs.next()) {

				CellStyle cellstyle = wb.createCellStyle();
				cellstyle.setBorderLeft(BorderStyle.THIN); //左罫線（通常線）
				cellstyle.setBorderRight(BorderStyle.THIN); //右罫線（通常線）
				cellstyle.setBorderTop(BorderStyle.THIN); //上罫線（通常線）
				cellstyle.setBorderBottom(BorderStyle.THIN); //下罫線（通常線）

				Row row = sheet1.createRow(n);
				Cell cell1 = row.createCell(0);
				Cell cell2 = row.createCell(1);
				Cell cell3 = row.createCell(2);
				Cell cell4 = row.createCell(3);
				Cell cell5 = row.createCell(4);
				Cell cell6 = row.createCell(5);

				cell1.setCellStyle(cellstyle);
				cell2.setCellStyle(cellstyle);
				cell3.setCellStyle(cellstyle);
				cell4.setCellStyle(cellstyle);
				cell5.setCellStyle(cellstyle);
				cell6.setCellStyle(cellstyle);

				cell1.setCellValue(rs.getString("day"));
				cell2.setCellValue(rs.getString("route_name"));
				cell3.setCellValue(rs.getString("transit_name"));
				cell4.setCellValue(rs.getString("from_st"));
				cell5.setCellValue(rs.getString("to_st"));
				cell6.setCellValue(rs.getString("price") + "円" );
				n = n + 1;

			}
		} catch (SQLException e) {
			e.printStackTrace();
		} catch (ClassNotFoundException e) {

		}

		FileOutputStream out = null;
		String filename = "" + User_id + "交通費一覧_" + user_name;
		try {
			//ここに返します C:\TransitFile\
			out = new FileOutputStream("C:\\TransitFile\\" + filename + ".xlsx");

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

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
