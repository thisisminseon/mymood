package control;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.Order;
import model.OrderDao;
import model.User;
import model.UserDao;

@WebServlet("/mypage-servlet")
public class MypageServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		User loginUser = (User) session.getAttribute("loginUser");

		if (loginUser == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		OrderDao odao = new OrderDao();
		List<Order> listOrder = odao.selectByUser(loginUser.getUserid());

		request.setAttribute("listOrder", listOrder);
		request.getRequestDispatcher("mypage.jsp").forward(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		HttpSession session = request.getSession();
		User loginUser = (User) session.getAttribute("loginUser");

		if (loginUser == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		String action = request.getParameter("action");

		if ("hide".equals(action)) {
			OrderDao odao = new OrderDao();
			odao.hideOrder(request.getParameter("orderNo"), loginUser.getUserid());
			response.sendRedirect("mypage-servlet");
			return;
		}

		if ("withdraw".equals(action)) {
			UserDao udao = new UserDao();
			udao.updateStatus(loginUser.getUserid(), "withdrawn");
			session.invalidate();
			response.sendRedirect("login.jsp");
			return;
		}

		response.sendRedirect("mypage-servlet");
	}
}