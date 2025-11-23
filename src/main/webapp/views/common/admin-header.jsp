<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<link rel="stylesheet" href="<c:url value='/css/polyoe.css'/>">

<!-- Navbar Top -->
<nav class="navbar navbar-expand navbar-dark bg-adm-primary border-bottom" style="border-color: #9A1750 !important;">
    <div class="container-fluid">
        <a class="navbar-brand fw-bold ps-3" href="#" style="color: #EE4C7C;">
            <i class="bi bi-shield-lock-fill"></i> PolyOE Admin
        </a>

        <ul class="navbar-nav ms-auto">
            <li class="nav-item dropdown">
                <a class="nav-link dropdown-toggle text-light" href="#" role="button" data-bs-toggle="dropdown">
                    <img src="https://ui-avatars.com/api/?name=Admin&background=EE4C7C&color=fff" class="rounded-circle" width="30"> Quản trị viên
                </a>
                <ul class="dropdown-menu dropdown-menu-end shadow">
                    <li><a class="dropdown-item" href="<c:url value='/home'/>"><i class="bi bi-house"></i> Xem trang chủ</a></li>
                    <li><hr class="dropdown-divider"></li>
                    <li><a class="dropdown-item text-danger" href="<c:url value='/logout'/>"><i class="bi bi-box-arrow-right"></i> Đăng xuất</a></li>
                </ul>
            </li>
        </ul>
    </div>
</nav>

<div class="d-flex">
    <!-- Sidebar -->
    <div class="admin-sidebar d-none d-md-block pt-3">
        <div class="px-3 mb-3 text-uppercase small fw-bold" style="color: #EE4C7C;">Quản lý chính</div>
        <nav class="nav flex-column">
            <a class="nav-link active" href="<c:url value='/admin'/>"><i class="bi bi-speedometer2 me-2"></i> Dashboard</a>
            <a class="nav-link" href="<c:url value='/admin/video'/>"><i class="bi bi-film me-2"></i> Quản lý Video</a>
            <a class="nav-link" href="<c:url value='/admin/user'/>"><i class="bi bi-people me-2"></i> Quản lý Người dùng</a>
        </nav>

        <div class="px-3 mb-3 mt-4 text-uppercase small fw-bold" style="color: #EE4C7C;">Thống kê</div>
        <nav class="nav flex-column">
            <a class="nav-link" href="#"><i class="bi bi-bar-chart me-2"></i> Lượt thích</a>
            <a class="nav-link" href="#"><i class="bi bi-share me-2"></i> Lượt chia sẻ</a>
        </nav>
    </div>