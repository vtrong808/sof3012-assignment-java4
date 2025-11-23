package com.poly.dao;

import com.poly.entity.Favorite;
import com.poly.utils.JpaUtils;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import java.util.List;

public class FavoriteDAO implements AutoCloseable{
    private EntityManager em = JpaUtils.getEntityManager();

    @Override
    public void close() {
        if (em != null && em.isOpen()) {
            em.close();
        }
    }

    // Lấy danh sách video yêu thích của User
    public List<Favorite> findByUserId(String userId) {
        String jpql = "SELECT f FROM Favorite f WHERE f.user.id = :uid";
        TypedQuery<Favorite> query = em.createQuery(jpql, Favorite.class);
        query.setParameter("uid", userId);
        return query.getResultList();
    }

    // Like/Unlike logic
    public void likeOrUnlike(String userId, String videoId) {
        String jpql = "SELECT f FROM Favorite f WHERE f.user.id = :uid AND f.video.id = :vid";
        TypedQuery<Favorite> query = em.createQuery(jpql, Favorite.class);
        query.setParameter("uid", userId);
        query.setParameter("vid", videoId);

        List<Favorite> list = query.getResultList();

        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            if (list.isEmpty()) {
                // Chưa like -> Thêm mới
                // Lưu ý: Ở đây cần set User và Video object vào Favorite,
                // để đơn giản tôi giả sử ông đã có constructor hoặc set logic bên Servlet
                // Đoạn này tôi để logic bên Servlet xử lý cho dễ hiểu hơn nhé.
            } else {
                // Đã like -> Xóa (Unlike)
                em.remove(list.get(0));
            }
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw e;
        }
    }

    // Hàm tạo cơ bản
    public void create(Favorite entity) {
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(entity);
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw e;
        }
    }

    // Hàm xóa theo object
    public void delete(Favorite entity) {
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.remove(entity);
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw e;
        }
    }

    // Tìm Favorite theo User và Video
    public Favorite findOne(String userId, String videoId) {
        String jpql = "SELECT f FROM Favorite f WHERE f.user.id = :uid AND f.video.id = :vid";
        TypedQuery<Favorite> query = em.createQuery(jpql, Favorite.class);
        query.setParameter("uid", userId);
        query.setParameter("vid", videoId);
        List<Favorite> list = query.getResultList();
        return list.isEmpty() ? null : list.get(0);
    }
}