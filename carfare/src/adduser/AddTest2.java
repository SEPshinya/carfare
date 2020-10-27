package adduser;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

/**
 * Servlet implementation class Addtest2
 */
@WebServlet("/AddTest2")
public class AddTest2 extends HttpServlet {
	private static final long serialVersionUID = 1L;

    /**
     * @see HttpServlet#HttpServlet()
     */
    public AddTest2() {
        super();
        // TODO Auto-generated constructor stub
    }

	/**
	 * @see HttpServlet#doGet(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		request.setCharacterEncoding("UTF-8");
		String user_name = request.getParameter("user_name");
		String address = request.getParameter("address");
		String loginkey = request.getParameter("loginkey");
		String salt = request.getParameter("salt");
		String role_id = request.getParameter("role_id");

		response.setContentType("text/html; charset=UTF-8");
		PrintWriter out = response.getWriter();

		out.print("<p>user_name:"+user_name+"</p>");
		out.print("<p>address:"+address+"</p>");
		out.print("<p>loginKey:"+loginkey+"</p>");
		out.print("<p>salt:"+salt+"</p>");
		out.print("<p>role_id:"+role_id+"</p>");
		out.close();
	}

	/**
	 * @see HttpServlet#doPost(HttpServletRequest request, HttpServletResponse response)
	 */
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// TODO Auto-generated method stub
		doGet(request, response);
	}

}