<%@ page pageEncoding="UTF-8" contentType="text/html; charset=UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>PolyOE - Online Entertainment</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.1/font/bootstrap-icons.css">
    <style>
        .video-card img { height: 180px; object-fit: cover; }
        .video-card:hover { transform: translateY(-5px); transition: 0.3s; box-shadow: 0 4px 15px rgba(0,0,0,0.2); }
    </style>
</head>
<body class="bg-light">

<!-- HEADER / NAVBAR -->
<nav class="navbar navbar-expand-lg navbar-dark bg-dark sticky-top">
    <div class="container">
        <a class="navbar-brand fw-bold" href="#"><i class="bi bi-film"></i> PolyOE</a>
        <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#navbarNav">
            <span class="navbar-toggler-icon"></span>
        </button>
        <div class="collapse navbar-collapse" id="navbarNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link active" href="#">Trang chủ</a></li>
                <li class="nav-item"><a class="nav-link" href="#">Yêu thích</a></li>
            </ul>
            <form class="d-flex me-3">
                <input class="form-control me-2" type="search" placeholder="Tìm phim..." aria-label="Search">
                <button class="btn btn-outline-success" type="submit">Tìm</button>
            </form>
            <div class="d-flex">
                <!-- Logic hiển thị khi chưa đăng nhập / đã đăng nhập -->
                <a href="#" class="btn btn-primary btn-sm me-2">Đăng nhập</a>
                <a href="#" class="btn btn-warning btn-sm">Đăng ký</a>
            </div>
        </div>
    </div>
</nav>

<!-- BANNER / HERO SECTION -->
<header class="bg-white py-5 mb-4 shadow-sm">
    <div class="container text-center">
        <h1 class="display-4 fw-bold">Chào mừng đến với PolyOE</h1>
        <p class="lead text-muted">Kho giải trí trực tuyến hàng đầu dành cho sinh viên FPT Polytechnic</p>
    </div>
</header>

<!-- MAIN CONTENT: LIST VIDEO -->
<div class="container mb-5">
    <h3 class="border-start border-5 border-primary ps-2 mb-4">Phim Mới Cập Nhật</h3>
    <div class="row row-cols-1 row-cols-md-4 g-4">

        <!-- Card Video Mẫu (Vòng lặp forEach sẽ đặt ở đây khi có data) -->
        <c:forEach begin="1" end="8" var="i">
            <div class="col">
                <div class="card h-100 video-card border-0 shadow-sm">
                    <img src="https://placehold.co/600x400?text=Video+Poster+${i}" class="card-img-top" alt="...">
                    <div class="card-body">
                        <h5 class="card-title text-truncate">Tiêu đề Video Demo Số ${i}</h5>
                        <p class="card-text small text-muted">Lượt xem: 1.2K</p>
                    </div>
                    <div class="card-footer bg-white border-top-0 d-flex justify-content-between">
                        <button class="btn btn-danger btn-sm"><i class="bi bi-heart"></i> Like</button>
                        <button class="btn btn-success btn-sm"><i class="bi bi-share"></i> Share</button>
                    </div>
                </div>
            </div>
        </c:forEach>

    </div>

    <!-- Pagination -->
    <nav class="mt-4">
        <ul class="pagination justify-content-center">
            <li class="page-item disabled"><a class="page-link" href="#">Trước</a></li>
            <li class="page-item active"><a class="page-link" href="#">1</a></li>
            <li class="page-item"><a class="page-link" href="#">2</a></li>
            <li class="page-item"><a class="page-link" href="#">3</a></li>
            <li class="page-item"><a class="page-link" href="#">Sau</a></li>
        </ul>
    </nav>
</div>

<!-- FOOTER -->
<footer class="bg-dark text-white text-center py-3 mt-auto">
    <div class="container">
        <p class="mb-0">&copy; 2024 PolyOE - Java 4 Assignment. Designed by You.</p>
    </div>
</footer>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>