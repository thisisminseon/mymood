package control;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.Moperation;

@WebServlet("/buy-now-servlet")
public class BuyNowServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		String prodId = request.getParameter("prodId");

		Moperation mope = new Moperation();
		mope.buyNow(prodId, request.getSession());

		request.getRequestDispatcher("pay.jsp").forward(request, response);
	}
}