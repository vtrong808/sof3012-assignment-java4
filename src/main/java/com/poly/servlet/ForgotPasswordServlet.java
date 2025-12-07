package com.poly.servlet;

import com.poly.dao.UserDAO;
import com.poly.entity.User;
import com.poly.utils.XEmail;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet("/forgot-password")
public class ForgotPasswordServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        req.getRequestDispatcher("/views/site/forgot-password.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String username = req.getParameter("username");
        String email = req.getParameter("email");

        try (UserDAO dao = new UserDAO()) {
            User user = dao.findById(username);

            if (user == null) {
                req.setAttribute("message", "Tên tài khoản không tồn tại!");
            } else if (!user.getEmail().equalsIgnoreCase(email)) {
                req.setAttribute("message", "Email không khớp với tài khoản!");
            } else {
                // Gửi mật khẩu về mail
                String subject = "PolyOE - Lấy lại mật khẩu";
                String body = "Mật khẩu của bạn là: <b>" + user.getPassword() + "</b><br>Vui lòng đổi mật khẩu sau khi đăng nhập.";

                XEmail.send(email, subject, body);

                req.setAttribute("message", "Mật khẩu đã được gửi về email: " + email);
                req.setAttribute("type", "success");
            }
        } catch (Exception e) {
            req.setAttribute("message", "Lỗi hệ thống: " + e.getMessage());
            e.printStackTrace();
        }

        req.getRequestDispatcher("/views/site/forgot-password.jsp").forward(req, resp);
    }
}