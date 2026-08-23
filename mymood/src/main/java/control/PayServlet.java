package control;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.Moperation;

@WebServlet("/pay-servlet")
public class PayServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		Moperation mope = new Moperation();
		mope.pay(request.getSession());
		request.getRequestDispatcher("pay.jsp").forward(request, response);
	}
}