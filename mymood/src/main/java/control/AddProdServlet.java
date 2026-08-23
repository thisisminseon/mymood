package control;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.Moperation;

@WebServlet("/add-prod-servlet")
public class AddProdServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		String prodId = request.getParameter("prodId");
		String category = request.getParameter("category");

		Moperation mope = new Moperation();
		mope.addProd(prodId, request.getSession());

		response.sendRedirect("select-servlet?category=" + category);
	}
}