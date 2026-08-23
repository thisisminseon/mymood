package control;

import java.io.IOException;
import java.util.List;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import model.Moperation;
import model.Product;
import model.Store;

@WebServlet("/select-servlet")
public class SelectServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		HttpSession session = request.getSession();

		Moperation mope = new Moperation();
		Store store = mope.ensureStore(session);

		String category = request.getParameter("category");
		if (category == null || category.isEmpty()) {
			category = "all";
		}

		List<Product> listProd = store.getListProdByCategory(category);

		request.setAttribute("selectedCategory", category);
		request.setAttribute("listProd", listProd);
		request.getRequestDispatcher("select.jsp").forward(request, response);
	}
}