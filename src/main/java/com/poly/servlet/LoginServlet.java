package com.poly.servlet;

import com.poly.dao.UserDAO;
import com.poly.entity.User;
import com.poly.utils.JpaUtils;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/login")
public class LoginServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Tạo đường dẫn đăng nhập Google động từ biến trong GoogleUtils
        String googleLoginUrl = "https://accounts.google.com/o/oauth2/auth?scope=email%20profile"
                + "&redirect_uri=" + com.poly.utils.GoogleUtils.GOOGLE_REDIRECT_URI
                + "&response_type=code"
                + "&client_id=" + com.poly.utils.GoogleUtils.GOOGLE_CLIENT_ID;

        // Gửi đường dẫn này sang trang JSP
        req.setAttribute("googleUrl", googleLoginUrl);

        req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id");
        String password = req.getParameter("password");

        UserDAO dao = new UserDAO();
        User user = dao.findById(id);

        if (user != null && user.getPassword().equals(password)) {
            // Đăng nhập thành công -> Lưu vào Session
            HttpSession session = req.getSession();
            session.setAttribute("user", user);

            // Nếu là Admin -> Chuyển sang trang Admin, ngược lại về Trang chủ
            if (user.isAdmin()) {
                resp.sendRedirect(req.getContextPath() + "/admin");
            } else {
                resp.sendRedirect(req.getContextPath() + "/home");
            }
        } else {
            // Đăng nhập thất bại
            req.setAttribute("message", "Sai thông tin đăng nhập rồi bạn ơi!");
            req.getRequestDispatcher("/views/login.jsp").forward(req, resp);
        }
    }
}