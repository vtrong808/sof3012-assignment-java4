package com.poly.dao;

import com.poly.entity.Video;
import com.poly.utils.JpaUtils;
import jakarta.persistence.EntityManager;
import jakarta.persistence.TypedQuery;
import java.util.List;

public class VideoDAO implements AutoCloseable{
    private EntityManager em = JpaUtils.getEntityManager();

    @Override
    public void close() {
        if (em != null && em.isOpen()) {
            em.close();
        }
    }

    public List<Video> findAll() {
        // JPQL để lấy tất cả video đang hoạt động (Active = true)
        // Assignment yêu cầu sắp xếp giảm dần theo lượt xem (Slide 2.1 Page 6)
        String jpql = "SELECT v FROM Video v WHERE v.active = true ORDER BY v.views DESC";
        TypedQuery<Video> query = em.createQuery(jpql, Video.class);
        return query.getResultList();
    }
}