package com.poly.servlet;

import com.poly.dao.ReportDAO;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/admin/reports")
public class ReportServlet extends HttpServlet {

    @Override
    protected void service(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        ReportDAO reportDao = new ReportDAO();

        // tab: xác định đang xem bảng thống kê nào (favorites hay shares)
        String tab = req.getParameter("tab");
        // mode: xác định có đang mở modal chi tiết không
        String mode = req.getParameter("mode");
        String videoId = req.getParameter("id");

        if (tab == null) tab = "favorites"; // Mặc định

        try {
            // 1. LOGIC CHO TAB LƯỢT THÍCH
            if (tab.equals("favorites")) {
                List<Object[]> list = reportDao.getFavorites();
                req.setAttribute("items", list); // Dữ liệu bảng tổng hợp

                // Nếu có yêu cầu xem chi tiết -> Load dữ liệu Modal
                if ("detail".equals(mode) && videoId != null) {
                    req.setAttribute("modalData", reportDao.getFavoriteUsers(videoId));
                    req.setAttribute("showModal", "favoriteModal"); // Kích hoạt Modal
                }
            }
            // 2. LOGIC CHO TAB LƯỢT CHIA SẺ
            else if (tab.equals("shares")) {
                List<Object[]> list = reportDao.getVideoShares();
                req.setAttribute("items", list); // Dữ liệu bảng tổng hợp

                // Nếu có yêu cầu xem chi tiết -> Load dữ liệu Modal
                if ("detail".equals(mode) && videoId != null) {
                    req.setAttribute("modalData", reportDao.getShareFriends(videoId));
                    req.setAttribute("showModal", "shareModal"); // Kích hoạt Modal
                }
            }

        } catch (Exception e) {
            req.setAttribute("error", "Lỗi: " + e.getMessage());
            e.printStackTrace();
        }

        req.setAttribute("tab", tab);
        req.getRequestDispatcher("/views/admin/report.jsp").forward(req, resp);
    }
}