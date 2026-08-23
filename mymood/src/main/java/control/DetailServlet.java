package control;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.Product;
import model.Store;

@WebServlet("/detail-servlet")
public class DetailServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();
		Store store = (Store) session.getAttribute("store");

		if (store == null) {
			response.sendRedirect("login.jsp");
			return;
		}

		String id = request.getParameter("id");
		Product prod = store.findById(id);

		if (prod == null) {
			response.sendRedirect("select-servlet");
			return;
		}

		request.setAttribute("detailProd", prod);
		request.getRequestDispatcher("detail.jsp").forward(request, response);
	}
}