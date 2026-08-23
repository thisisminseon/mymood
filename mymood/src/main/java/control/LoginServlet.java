package control;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.Moperation;
import model.User;

@WebServlet("/login-servlet")
public class LoginServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		String userID = request.getParameter("userID");
		String password = request.getParameter("password");

		Moperation mope = new Moperation();
		boolean ok = mope.loginProc(userID, password, request.getSession());

		if (ok) {
			User loginUser = (User) request.getSession().getAttribute("loginUser");
			if (loginUser != null && loginUser.isAdmin()) {
				response.sendRedirect("admin-user-servlet");
			} else {
				response.sendRedirect("select-servlet");
			}
		} else {
			request.setAttribute("errorMsg", "ユーザIDまたはパスワードが正しくありません。");
			request.getRequestDispatcher("login.jsp").forward(request, response);
		}
	}
}