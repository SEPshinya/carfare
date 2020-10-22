package list;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class ListTest
 */
@WebServlet("/ListTest")
public class ListTest extends HttpServlet {
	private static final long serialVersionUID = 1L;

	/**
	 * @see HttpServlet#HttpServlet()
	 */
	public ListTest() {
		super();
		// TODO Auto-generated constructor stub
	}

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();

		//画面遷移だけを確かめたいとき
		out.println("遷移成功");

		//ページングの確認したいとき
		String nowPage = request.getParameter("page");
		out.println(nowPage);

		/* list.jspのページングの URL指定をListTestに変更するとListTest.javaに遷移するようになる
		 * <td><a href="List?page=3">3</a></td>
		 *              ↓↓↓
		 * 	<td><a href="ListTest?page=3">4</a></td>
		 * 	？page=3のリクエストで遷移したListTest.javaにページをとばして
		 *
		 * 	String nowPage = request.getParameter("page");
		 * 	で受け取って
		 *
		 * 	out.println(nowPage);
		 * 	で画面に出力
		 *
		 */
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