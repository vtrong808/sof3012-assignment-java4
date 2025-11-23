package com.poly.servlet;

import com.poly.dao.FavoriteDAO;
import com.poly.entity.Favorite;
import com.poly.entity.User;
import com.poly.entity.Video;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.Date;

@WebServlet("/video/like")
public class LikeVideoServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        // 1. Kiểm tra đăng nhập
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        // 2. Lấy Video ID
        String videoId = req.getParameter("id");
        if (videoId == null) {
            resp.sendRedirect(req.getContextPath() + "/home");
            return;
        }

        // 3. Xử lý Like/Unlike
        FavoriteDAO dao = new FavoriteDAO();
        Favorite favorite = dao.findOne(user.getId(), videoId);

        if (favorite == null) {
            // Chưa like -> Tạo mới
            favorite = new Favorite();
            favorite.setUser(user);

            Video video = new Video(); // Hibernate chỉ cần ID để link
            video.setId(videoId);
            favorite.setVideo(video);

            favorite.setLikeDate(new Date());
            dao.create(favorite);
        } else {
            // Đã like -> Xóa (Unlike)
            dao.delete(favorite);
        }

        // 4. Quay lại trang cũ (Home hoặc Detail)
        String referer = req.getHeader("Referer");
        resp.sendRedirect(referer != null ? referer : req.getContextPath() + "/home");
    }
}