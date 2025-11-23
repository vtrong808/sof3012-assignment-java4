package com.poly.dao;

import com.poly.entity.User;
import com.poly.utils.JpaUtils;
import jakarta.persistence.EntityManager;
import jakarta.persistence.EntityTransaction;
import jakarta.persistence.TypedQuery;
import java.util.List;

public class UserDAO implements AutoCloseable{
    // Mỗi lần tạo DAO sẽ lấy một EntityManager từ JpaUtils
    private EntityManager em = JpaUtils.getEntityManager();

    // Khi đối tượng DAO bị hủy, đóng kết nối luôn cho gọn
    @Override
    public void close() {
        if (em != null && em.isOpen()) {
            em.close();
        }
    }

    // 1. Thêm mới User (Dùng cho chức năng Đăng ký)
    public void create(User entity) {
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.persist(entity);
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw new RuntimeException(e);
        }
    }

    // 2. Cập nhật User (Dùng cho chức năng Đổi mật khẩu, Cập nhật thông tin)
    public void update(User entity) {
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            em.merge(entity);
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw new RuntimeException(e);
        }
    }

    // 3. Xóa User (Dùng cho Admin)
    public void delete(String id) {
        EntityTransaction trans = em.getTransaction();
        try {
            trans.begin();
            User entity = em.find(User.class, id);
            if (entity != null) {
                em.remove(entity);
            }
            trans.commit();
        } catch (Exception e) {
            trans.rollback();
            throw new RuntimeException(e);
        }
    }

    // 4. Tìm theo ID (Dùng cho Đăng nhập, Quên mật khẩu)
    public User findById(String id) {
        return em.find(User.class, id);
    }

    // 5. Lấy tất cả User (Dùng cho Admin quản lý user)
    public List<User> findAll() {
        String jpql = "SELECT u FROM User u";
        TypedQuery<User> query = em.createQuery(jpql, User.class);
        return query.getResultList();
    }
}