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
        // Cấu hình phân trang
        int page = 1;
        int pageSize = 15; // Hiển thị 15 video mỗi trang

        // Lấy tham số page từ URL (ví dụ: /home?page=2)
        if (req.getParameter("page") != null) {
            try {
                page = Integer.parseInt(req.getParameter("page"));
            } catch (NumberFormatException e) {
                page = 1;
            }
        }

        try (VideoDAO dao = new VideoDAO()) {
            // 1. Tính tổng số trang
            long totalVideos = dao.count();
            int totalPages = (int) Math.ceil((double) totalVideos / pageSize);

            // Kiểm tra page hợp lệ (không nhỏ hơn 1, không lớn hơn totalPages)
            if (page < 1) page = 1;
            if (page > totalPages && totalPages > 0) page = totalPages;

            // 2. Lấy danh sách video của trang hiện tại
            List<Video> list = dao.findAll(page, pageSize);

            // 3. Đẩy dữ liệu sang JSP
            req.setAttribute("items", list);
            req.setAttribute("currentPage", page);
            req.setAttribute("totalPages", totalPages);

            req.getRequestDispatcher("/views/site/home.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendError(HttpServletResponse.SC_INTERNAL_SERVER_ERROR, e.getMessage());
        }
    }
}