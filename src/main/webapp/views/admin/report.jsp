<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>

<!DOCTYPE html>
<html lang="vi">
<head>
    <meta charset="UTF-8">
    <title>Báo cáo thống kê | Admin</title>
    <link rel="stylesheet" href="<c:url value='/css/bootstrap.min.css'/>">
    <link rel="stylesheet" href="<c:url value='/css/polyoe.css'/>">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.3/font/bootstrap-icons.min.css">
    <style>
        .nav-pills .nav-link { color: var(--adm-primary); font-weight: 600; }
        .nav-pills .nav-link.active { background-color: var(--adm-accent); color: white; }
    </style>
</head>
<body>

<jsp:include page="/views/common/admin-header.jsp" />

<div class="p-4">
    <h3 class="mb-4 fw-bold" style="color: var(--adm-primary);">
        <i class="bi bi-bar-chart-fill me-2"></i> BÁO CÁO & THỐNG KÊ
    </h3>

    <div class="card border-0 shadow-sm rounded-3">
        <div class="card-header bg-white border-bottom-0 pt-4 px-4">
            <ul class="nav nav-pills card-header-pills">
                <li class="nav-item">
                    <a class="nav-link ${tab == 'favorites' ? 'active' : ''}"
                       href="<c:url value='/admin/reports?tab=favorites'/>">
                        <i class="bi bi-heart-fill me-2"></i> Thống kê Lượt thích
                    </a>
                </li>
                <li class="nav-item">
                    <a class="nav-link ${tab == 'shares' ? 'active' : ''}"
                       href="<c:url value='/admin/reports?tab=shares'/>">
                        <i class="bi bi-share-fill me-2"></i> Thống kê Chia sẻ
                    </a>
                </li>
            </ul>
        </div>

        <div class="card-body px-4 pb-4">

            <c:if test="${tab == 'favorites'}">
                <div class="table-responsive">
                    <table class="table table-hover table-bordered align-middle">
                        <thead class="text-white text-center" style="background-color: var(--adm-primary);">
                        <tr>
                            <th>Tiêu đề Video</th>
                            <th>Tổng lượt thích</th>
                            <th>Mới nhất</th>
                            <th>Cũ nhất</th>
                            <th>Chi tiết</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${items}" var="item">
                            <tr>
                                <td class="fw-bold text-secondary">${item[0]}</td>
                                <td class="text-center fw-bold fs-5 text-primary">${item[1]}</td>
                                <td class="text-center text-muted"><fmt:formatDate value="${item[2]}" pattern="dd/MM/yyyy"/></td>
                                <td class="text-center text-muted"><fmt:formatDate value="${item[3]}" pattern="dd/MM/yyyy"/></td>
                                <td class="text-center">
                                    <a href="<c:url value='/admin/reports?tab=favorites&mode=detail&id=${item[4]}'/>"
                                       class="btn btn-sm btn-outline-primary rounded-pill px-3">
                                        <i class="bi bi-people"></i> Xem người thích
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>

            <c:if test="${tab == 'shares'}">
                <div class="table-responsive">
                    <table class="table table-hover table-bordered align-middle">
                        <thead class="text-white text-center" style="background-color: var(--adm-primary);">
                        <tr>
                            <th>Tiêu đề Video</th>
                            <th>Tổng lượt chia sẻ</th>
                            <th>Mới nhất</th>
                            <th>Cũ nhất</th>
                            <th>Chi tiết</th>
                        </tr>
                        </thead>
                        <tbody>
                        <c:forEach items="${items}" var="item">
                            <tr>
                                <td class="fw-bold text-secondary">${item[0]}</td>
                                <td class="text-center fw-bold fs-5 text-success">${item[1]}</td>
                                <td class="text-center text-muted"><fmt:formatDate value="${item[2]}" pattern="dd/MM/yyyy"/></td>
                                <td class="text-center text-muted"><fmt:formatDate value="${item[3]}" pattern="dd/MM/yyyy"/></td>
                                <td class="text-center">
                                    <a href="<c:url value='/admin/reports?tab=shares&mode=detail&id=${item[4]}'/>"
                                       class="btn btn-sm btn-outline-success rounded-pill px-3">
                                        <i class="bi bi-list-ul"></i> Xem chi tiết
                                    </a>
                                </td>
                            </tr>
                        </c:forEach>
                        </tbody>
                    </table>
                </div>
            </c:if>

        </div>
    </div>
</div>

<div class="modal fade" id="favoriteModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content border-0 shadow-lg">
            <div class="modal-header text-white" style="background-color: var(--adm-primary);">
                <h5 class="modal-title fw-bold"><i class="bi bi-heart-fill me-2"></i> DANH SÁCH NGƯỜI THÍCH</h5>
                <a href="<c:url value='/admin/reports?tab=favorites'/>" class="btn-close btn-close-white"></a>
            </div>
            <div class="modal-body bg-light p-0">
                <table class="table table-striped mb-0 align-middle">
                    <thead class="table-secondary">
                    <tr>
                        <th>Username</th>
                        <th>Họ và tên</th>
                        <th>Email</th>
                        <th>Ngày thích</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${modalData}" var="u">
                        <tr>
                            <td class="fw-bold">${u[0]}</td>
                            <td>${u[1]}</td>
                            <td>${u[2]}</td>
                            <td><fmt:formatDate value="${u[3]}" pattern="dd/MM/yyyy"/></td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty modalData}">
                        <tr><td colspan="4" class="text-center py-4 text-muted">Không có dữ liệu.</td></tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="shareModal" tabindex="-1" aria-hidden="true">
    <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
        <div class="modal-content border-0 shadow-lg">
            <div class="modal-header text-white" style="background-color: #198754;">
                <h5 class="modal-title fw-bold"><i class="bi bi-share-fill me-2"></i> CHI TIẾT LƯỢT CHIA SẺ</h5>
                <a href="<c:url value='/admin/reports?tab=shares'/>" class="btn-close btn-close-white"></a>
            </div>
            <div class="modal-body bg-light p-0">
                <table class="table table-striped mb-0 align-middle">
                    <thead class="table-success">
                    <tr>
                        <th>Người gửi</th>
                        <th>Email người gửi</th>
                        <th>Email người nhận</th>
                        <th>Ngày gửi</th>
                    </tr>
                    </thead>
                    <tbody>
                    <c:forEach items="${modalData}" var="s">
                        <tr>
                            <td class="fw-bold">${s[0]}</td>
                            <td>${s[1]}</td>
                            <td class="text-primary fw-bold">${s[2]}</td>
                            <td><fmt:formatDate value="${s[3]}" pattern="dd/MM/yyyy"/></td>
                        </tr>
                    </c:forEach>
                    <c:if test="${empty modalData}">
                        <tr><td colspan="4" class="text-center py-4 text-muted">Không có dữ liệu.</td></tr>
                    </c:if>
                    </tbody>
                </table>
            </div>
        </div>
    </div>
</div>

<jsp:include page="/views/common/admin-footer.jsp" />

<script src="<c:url value='/js/bootstrap.bundle.min.js'/>"></script>

<script>
    document.addEventListener("DOMContentLoaded", function() {
        var modalId = '${showModal}';
        if (modalId) {
            var myModal = new bootstrap.Modal(document.getElementById(modalId));
            myModal.show();
        }
    });
</script>
</body>
</html>