<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>PolyOE - Trang chủ</title>
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/polyoe.css'/>">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="<c:url value='/css/polyoe.css'/>">
</head>
<body class="d-flex flex-column min-vh-100 bg-light">

<jsp:include page="/views/common/header.jsp" />

<div class="hero-banner text-center mb-4 shadow-sm">
    <div class="container py-4">
        <h1 class="display-5 fw-bold text-white">
            PHIM HAY <span class="text-cli-primary">MỖI NGÀY</span>
        </h1>
        <p class="lead text-white-50">Tuyển tập các tiểu phẩm hài đặc sắc nhất FPT Polytechnic</p>
    </div>
</div>

<div class="container mb-5">
    <div class="d-flex justify-content-between align-items-center mb-3">
        <h4 class="fw-bold border-start border-4 border-warning ps-3 text-uppercase" style="color: var(--cli-dark);">
            Video Bạn Yêu Thích
        </h4>
    </div>

    <div class="row g-4">
        <c:forEach items="${favorites}" var="item">
            <div class="col-12 col-md-6 col-lg-4">
                <div class="card movie-card h-100 shadow-sm">

                    <div class="position-relative">
                        <a href="<c:url value='/video/detail?id=${item.id}'/>">
                            <img src="${item.poster}"
                                 class="card-img-top"
                                 alt="${item.title}"
                                 onerror="this.src='https://placehold.co/600x400?text=No+Image'">
                        </a>
                        <div class="position-absolute bottom-0 end-0 bg-dark text-white px-2 py-1 opacity-75 small">
                            <i class="bi bi-eye"></i> ${item.views}
                        </div>
                    </div>

                    <div class="card-body">
                        <h5 class="card-title fw-bold text-truncate video-title">
                            <a href="<c:url value='/video/detail?id=${item.id}'/>" class="text-decoration-none">
                                    ${item.title}
                            </a>
                        </h5>
                        <p class="card-text text-muted small text-truncate">
                                ${not empty item.description ? item.description : 'Chưa có mô tả...'}
                        </p>
                    </div>

                    <div class="card-footer card-footer-custom bg-white d-flex justify-content-between align-items-center py-3">
                        <a href="<c:url value='/video/like?id=${item.id}'/>" class="btn btn-cli-primary btn-sm px-4 rounded-pill shadow-sm">
                            <i class="bi bi-hand-thumbs-up-fill"></i> Like
                        </a>

                        <a href="<c:url value='/video/share?videoId=${item.id}'/>"
                           class="btn btn-outline-secondary btn-sm px-4 rounded-pill shadow-sm">
                            <i class="bi bi-share-fill"></i> Share
                        </a>
                    </div>
                </div>
            </div>
        </c:forEach>

        <c:if test="${empty items}">
            <div class="col-12 text-center py-5">
                <p class="text-muted">Chưa có video nào được yêu thích cả bạn nhỉ?.</p>
            </div>
        </c:if>
    </div>

    <nav aria-label="Page navigation" class="mt-5">
        <ul class="pagination justify-content-center">
            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                <a class="page-link" href="<c:url value='/home?page=1'/>">
                    <i class="bi bi-skip-start-fill"></i>
                </a>
            </li>

            <li class="page-item ${currentPage == 1 ? 'disabled' : ''}">
                <a class="page-link" href="<c:url value='/home?page=${currentPage - 1}'/>">
                    <i class="bi bi-chevron-double-left"></i>
                </a>
            </li>

            <li class="page-item active"><a class="page-link" href="#">1</a></li>
            <li class="page-item"><a class="page-link" href="#">2</a></li>
            <li class="page-item"><a class="page-link" href="#">3</a></li>

            <li class="page-item">
                <a class="page-link" href="<c:url value='/home?page=${currentPage + 1}'/>">
                    <i class="bi bi-chevron-double-right"></i>
                </a>
            </li>

            <li class="page-item">
                <a class="page-link" href="<c:url value='/home?page=max'/>">
                    <i class="bi bi-skip-end-fill"></i>
                </a>
            </li>
        </ul>
    </nav>
</div>

<jsp:include page="/views/common/footer.jsp" />

<script src="<c:url value='/js/bootstrap.bundle.min.js'/>"></script>

<script>
    function setShareId(id) {
        document.getElementById('shareVideoId').value = id;
    }
</script>
</body>
</html>