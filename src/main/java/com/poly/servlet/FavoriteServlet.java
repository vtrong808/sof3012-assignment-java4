package com.poly.servlet;

import com.poly.dao.FavoriteDAO;
import com.poly.entity.Favorite;
import com.poly.entity.User;
import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import java.io.IOException;
import java.util.List;

@WebServlet("/favorite")
public class FavoriteServlet extends HttpServlet {
    @Override
    protected void doGet(HttpServletRequest req, HttpServletResponse resp) throws ServletException, IOException {
        User user = (User) req.getSession().getAttribute("user");
        if (user == null) {
            resp.sendRedirect(req.getContextPath() + "/login");
            return;
        }

        FavoriteDAO dao = new FavoriteDAO();
        List<Favorite> list = dao.findByUserId(user.getId());

        req.setAttribute("favorites", list);
        req.getRequestDispatcher("/views/site/favorite.jsp").forward(req, resp);
    }
}