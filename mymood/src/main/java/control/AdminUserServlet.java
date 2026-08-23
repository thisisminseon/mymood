package control;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.Uoperation;
import model.User;

@WebServlet("/admin-user-servlet")
public class AdminUserServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		User loginUser = (User) session.getAttribute("loginUser");

		if (loginUser == null || !loginUser.isAdmin()) {
			response.sendRedirect("login.jsp");
			return;
		}

		Uoperation uope = new Uoperation();
		List<User> listUser = uope.listUsers();

		request.setAttribute("listUser", listUser);
		request.getRequestDispatcher("admin-user.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		HttpSession session = request.getSession();
		User loginUser = (User) session.getAttribute("loginUser");

		if (loginUser == null || !loginUser.isAdmin()) {
			response.sendRedirect("login.jsp");
			return;
		}

		String targetId = request.getParameter("targetId");
		String action = request.getParameter("action");

		Uoperation uope = new Uoperation();

		if ("suspend".equals(action)) {
			uope.suspendUser(targetId);
		} else if ("activate".equals(action)) {
			uope.activateUser(targetId);
		} else if ("withdraw".equals(action)) {
			uope.withdrawUser(targetId);
		}

		response.sendRedirect("admin-user-servlet");
	}
}