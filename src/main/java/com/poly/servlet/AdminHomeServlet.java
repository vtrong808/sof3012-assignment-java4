package com.poly.servlet;

import com.poly.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;

@WebServlet({"/admin", "/admin/home"})
public class AdminHomeServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Kiểm tra quyền truy cập (Bảo mật)
        User user = (User) req.getSession().getAttribute("user");

        if (user == null || !user.isAdmin()) {
            // Chưa đăng nhập hoặc không phải admin -> đuổi về trang chủ
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        // Nếu đúng là admin -> cho vào
        req.getRequestDispatcher("/views/admin/home.jsp").forward(req, resp);
    }
}