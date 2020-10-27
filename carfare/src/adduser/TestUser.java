package adduser;

import java.io.IOException;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Addtest
 */
@WebServlet("/TestUser")
public class TestUser extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public TestUser() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String role_name="";
		String role_id ="1";
		if(role_id.equals("1")) {
			role_name="一般";
		}else {
			role_name="管理者";
		}
		request.setAttribute("user_name","テスト");
		//request.setAttribute("address", "test@yahoo.co.jp");
		request.setAttribute("role_id", role_id);
		request.setAttribute("role_name", role_name);
		//request.setAttribute("loginkey", 12345);
		//request.setAttribute("salt", "saltTest");



		String user_name = request.getParameter("name");
		String address = request.getParameter("address");
		String Password = request.getParameter("password");
		String Password2 = request.getParameter("Password2");

		String errmsg = UserAddCommon.getErr(Password, Password2, address, role_id,user_name);

		if (errmsg != "") {
			request.setAttribute("getErr", errmsg);
			getServletContext().getRequestDispatcher("/useradd.jsp").forward(request, response);
		}

		// result.jsp にページ遷移
		getServletContext().getRequestDispatcher("/useraddcheck.jsp").forward(request, response);

		//String user_name = request.getParameter("name");
		//String address = request.getParameter("address");
		//String Password = request.getParameter("password");
		//String Password2 = request.getParameter("Password2");


		//response.setContentType("text/html; charset=UTF-8");
		//PrintWriter out = response.getWriter();

		//out.print("<p>user_name:"+user_name+"</p>");
		//out.print("<p>address:"+address+"</p>");
		//out.print("<p>password:"+Password+"</p>");
		//out.print("<p>password2:"+Password2+"</p>");
		//out.print("<p>role_id:"+role_id+"</p>");
		//out.close();
		//out.print("<p>name</p>");

	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}
