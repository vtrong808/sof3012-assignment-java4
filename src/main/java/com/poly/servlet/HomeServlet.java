package com.poly.servlet;

import com.poly.dao.VideoDAO;
import com.poly.entity.Video;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.List;

@WebServlet("/home")
public class HomeServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // Dùng try-with-resources: Tự động đóng kết nối sau khi lấy xong list
        try (VideoDAO videoDAO = new VideoDAO()) {
            List<Video> list = videoDAO.findAll();
            req.setAttribute("items", list);
        } // Tới đây là videoDAO.close() tự được gọi, sạch sẽ bộ nhớ!

        req.getRequestDispatcher("/views/site/home.jsp").forward(req, resp);
    }
}