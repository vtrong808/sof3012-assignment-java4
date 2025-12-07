package com.poly.servlet;

import com.poly.dao.ShareDAO;
import com.poly.dao.VideoDAO;
import com.poly.entity.Share;
import com.poly.entity.User;
import com.poly.entity.Video;
import com.poly.utils.XEmail;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;

import java.io.IOException;
import java.util.Date;

@WebServlet("/video/share")
public class ShareServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        resp.sendRedirect(req.getContextPath() + "/home");
    }

    @Override
    protected void doPost(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        try {
            // 1. Kiểm tra đăng nhập
            User user = (User) req.getSession().getAttribute("user");
            if (user == null) {
                resp.sendRedirect(req.getContextPath() + "/login");
                return;
            }

            // 2. Lấy dữ liệu
            String videoId = req.getParameter("videoId");
            String emailTo = req.getParameter("email");

            // 3. Xử lý Database (Lưu lịch sử Share)
            try (ShareDAO shareDao = new ShareDAO();
                 VideoDAO videoDao = new VideoDAO()) {

                Video video = videoDao.findById(videoId);
                if (video != null) {
                    Share share = new Share();
                    share.setUser(user);
                    share.setVideo(video);
                    share.setEmails(emailTo);
                    share.setShareDate(new Date());

                    shareDao.create(share); // Lưu vào DB

                    // 4. Gửi Email
                    String subject = "Chia sẻ video hay từ PolyOE";
                    String link = req.getRequestURL().toString().replace("share", "detail?id=" + videoId);
                    String body = String.format(
                            "Xin chào,<br><br>" +
                                    "Bạn của bạn là <b>%s</b> (%s) muốn chia sẻ video <b>%s</b> với bạn.<br>" +
                                    "Click vào đây để xem ngay: <a href='%s'>Xem Video</a><br><br>" +
                                    "Chúc bạn xem phim vui vẻ!",
                            user.getFullname(), user.getEmail(), video.getTitle(), link
                    );

                    XEmail.send(emailTo, subject, body);

                    req.getSession().setAttribute("message", "Đã gửi video và lưu lịch sử thành công!");
                }
            }

        } catch (Exception e) {
            e.printStackTrace();
            req.getSession().setAttribute("error", "Lỗi: " + e.getMessage());
        }

        // 5. Quay lại trang cũ
        String referer = req.getHeader("Referer");
        resp.sendRedirect(referer != null ? referer : req.getContextPath() + "/home");
    }
}