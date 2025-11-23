package com.poly.servlet;

import com.poly.dao.VideoDAO;
import com.poly.entity.Video;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List; // Nhớ import List

@WebServlet("/video/detail")
public class VideoDetailServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        String id = req.getParameter("id"); // Lấy ID từ URL (vd: ?id=V01)

        try (VideoDAO dao = new VideoDAO()) {
            // 1. Lấy thông tin chi tiết của video hiện tại
            Video video = dao.findById(id);

            // Nếu không tìm thấy video (null) -> Đá về trang chủ
            if (video == null) {
                resp.sendRedirect(req.getContextPath() + "/home");
                return;
            }

            req.setAttribute("video", video);

            // 2. Lấy danh sách video khác cho phần "Có thể bạn thích" (Sidebar)
            List<Video> list = dao.findAll();

            // (Optional) Loại bỏ video đang xem khỏi danh sách gợi ý cho đỡ trùng
            // list.removeIf(v -> v.getId().equals(id));

            req.setAttribute("items", list); // Đẩy list sang JSP

            // 3. Tăng lượt xem (Logic kinh điển)
            // video.setViews(video.getViews() + 1);
            // dao.update(video); // Cần thêm hàm update trong VideoDAO nếu muốn dùng

            req.getRequestDispatcher("/views/site/video-detail.jsp").forward(req, resp);
        } catch (Exception e) {
            e.printStackTrace();
            resp.sendRedirect(req.getContextPath() + "/home");
        }
    }
}