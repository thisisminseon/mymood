package control;

import java.io.IOException;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import model.Uoperation;

@WebServlet("/signup-servlet")
public class SignupServlet extends HttpServlet {

	private static final long serialVersionUID = 1L;

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {

		request.setCharacterEncoding("UTF-8");

		String userID = request.getParameter("userID");
		String password = request.getParameter("password");
		String nickname = request.getParameter("nickname");

		Uoperation uope = new Uoperation();
		String errorMsg = uope.signupProc(userID, password, nickname);

		if (errorMsg == null) {
			request.setAttribute("infoMsg", "会員登録が完了しました。ログインしてください。");
			request.getRequestDispatcher("login.jsp").forward(request, response);
		} else {
			request.setAttribute("errorMsg", errorMsg);
			request.setAttribute("userID", userID);
			request.setAttribute("nickname", nickname);
			request.getRequestDispatcher("signup.jsp").forward(request, response);
		}
	}
}