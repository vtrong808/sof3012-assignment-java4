package com.poly.servlet;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;

@WebServlet("/video/share")
public class ShareServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Hiển thị form share
        String videoId = req.getParameter("videoId");
        req.setAttribute("videoId", videoId);
        req.getRequestDispatcher("/views/site/share.jsp").forward(req, resp);
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Xử lý gửi email (Giai đoạn sau sẽ code gửi mail thật)
        // Hiện tại in ra console chơi
        String email = req.getParameter("email");
        String videoId = req.getParameter("videoId");
        System.out.println("Gửi video " + videoId + " tới " + email);

        req.setAttribute("message", "Đã gửi video thành công!");
        req.getRequestDispatcher("/views/site/share.jsp").forward(req, resp);
    }
}