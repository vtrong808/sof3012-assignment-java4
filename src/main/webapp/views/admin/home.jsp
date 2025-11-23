<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Quản trị viên - Dashboard</title>
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="<c:url value='/css/polyoe.css'/>">
</head>
<body>

<jsp:include page="/views/common/admin-header.jsp" />

<div class="admin-content p-4 w-100">

    <div class="welcome-box p-4 mb-4 shadow-sm">
        <h2 class="fw-bold" style="color: var(--adm-primary);">
            Chào mừng trở lại, Admin!
            <i class="bi bi-emoji-sunglasses text-warning"></i>
        </h2>
        <p class="text-muted mb-0">Đây là trung tâm điều khiển của hệ thống PolyOE.</p>
    </div>

    <div class="row g-4 mb-4">
        <div class="col-md-3">
            <div class="card stat-card p-3 h-100">
                <div class="d-flex align-items-center">
                    <div class="icon-box me-3" style="background-color: var(--adm-pink-light); color: var(--adm-primary);">
                        <i class="bi bi-people-fill"></i>
                    </div>
                    <div>
                        <p class="mb-0 text-muted small text-uppercase fw-bold">Người dùng</p>
                        <h4 class="fw-bold mb-0" style="color: var(--adm-accent);">152</h4>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card stat-card p-3 h-100">
                <div class="d-flex align-items-center">
                    <div class="icon-box me-3" style="background-color: #ffebee; color: #d32f2f;">
                        <i class="bi bi-film"></i>
                    </div>
                    <div>
                        <p class="mb-0 text-muted small text-uppercase fw-bold">Tổng Video</p>
                        <h4 class="fw-bold mb-0 text-danger">85</h4>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card stat-card p-3 h-100">
                <div class="d-flex align-items-center">
                    <div class="icon-box me-3" style="background-color: #e3f2fd; color: #1976d2;">
                        <i class="bi bi-eye-fill"></i>
                    </div>
                    <div>
                        <p class="mb-0 text-muted small text-uppercase fw-bold">Tổng lượt xem</p>
                        <h4 class="fw-bold mb-0 text-primary">12.5K</h4>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-3">
            <div class="card stat-card p-3 h-100">
                <div class="d-flex align-items-center">
                    <div class="icon-box me-3" style="background-color: #f3e5f5; color: #7b1fa2;">
                        <i class="bi bi-heart-fill"></i>
                    </div>
                    <div>
                        <p class="mb-0 text-muted small text-uppercase fw-bold">Lượt yêu thích</p>
                        <h4 class="fw-bold mb-0" style="color: #7b1fa2;">3,402</h4>
                    </div>
                </div>
            </div>
        </div>
    </div>

    <div class="row g-4">
        <div class="col-md-8">
            <div class="card stat-card h-100">
                <div class="card-header bg-white border-0 py-3">
                    <h6 class="mb-0 fw-bold" style="color: var(--adm-primary);">Video được xem nhiều nhất</h6>
                </div>
                <div class="card-body">
                    <div class="table-responsive">
                        <table class="table table-hover align-middle">
                            <thead class="table-light">
                            <tr>
                                <th>Tên Video</th>
                                <th>Lượt xem</th>
                                <th>Trạng thái</th>
                            </tr>
                            </thead>
                            <tbody>
                            <tr>
                                <td>Java Programming 101</td>
                                <td>1,500</td>
                                <td><span class="badge bg-success">Active</span></td>
                            </tr>
                            <tr>
                                <td>Spring Boot Tutorial</td>
                                <td>2,300</td>
                                <td><span class="badge bg-success">Active</span></td>
                            </tr>
                            <tr>
                                <td>Angular vs React</td>
                                <td>9,999</td>
                                <td><span class="badge bg-secondary">Inactive</span></td>
                            </tr>
                            </tbody>
                        </table>
                    </div>
                </div>
            </div>
        </div>

        <div class="col-md-4">
            <div class="card stat-card h-100" style="background-color: var(--adm-primary); color: white;">
                <div class="card-body d-flex flex-column justify-content-center align-items-center text-center">
                    <i class="bi bi-envelope-paper-heart display-1 mb-3" style="color: var(--adm-highlight);"></i>
                    <h4>Email Marketing</h4>
                    <p class="text-white-50">Gửi thông báo video mới cho 152 người dùng?</p>
                    <button class="btn w-100 fw-bold" style="background-color: var(--adm-highlight); color: white;">Gửi ngay</button>
                </div>
            </div>
        </div>
    </div>

    <jsp:include page="/views/common/admin-footer.jsp" />

    <script src="<c:url value='/js/bootstrap.bundle.min.js'/>"></script>
</body>
</html>