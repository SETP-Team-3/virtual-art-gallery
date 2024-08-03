<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="modal fade" id="accountModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">Account Menu</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <button class="btn btn-danger w-100" id="logoutButton">Logout</button>
            </div>
        </div>
    </div>
</div>

<header class="d-flex flex-column flex-md-row align-items-center p-3 px-md-4 bg-white border-bottom">
    <h5 class="my-0 me-auto"><a href="${pageContext.request.contextPath}/admin/dashboard" class="text-decoration-none text-dark">VArtGallery Admin</a></h5>
    <nav class="navbar navbar-expand-md navbar-light bg-white vag-headnav-container">
        <div class="d-flex w-100 justify-content-center d-md-none">
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#headNav">
                <span class="navbar-toggler-icon"></span>
            </button>
        </div>
        <div class="collapse navbar-collapse vag-navbar-collapse-center" id="headNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link vag-a-tan" href="${pageContext.request.contextPath}/admin/manage-artworks">Manage Artworks</a></li>
                <li class="nav-item"><a class="nav-link vag-a-tan" href="${pageContext.request.contextPath}/admin/manage-users">Manage Users</a></li>
                <li class="nav-item"><a class="nav-link vag-a-tan" href="${pageContext.request.contextPath}/admin/manage-transactions">Manage Transactions</a></li>
                <li class="nav-item"><a class="nav-link vag-a-tan" href="${pageContext.request.contextPath}/admin/pending-artworks">Approve Artworks</a></li>
                <li class="nav-item"><a class="nav-link vag-a-tan" href="${pageContext.request.contextPath}/admin/pending-users">Approve Account Signups</a></li>
                <li class="nav-item"><button class="btn vag-btn-tan" data-bs-toggle="modal" data-bs-target="#accountModal"><i class="bi bi-person-circle"></i> Account</button></li>
            </ul>
        </div>
    </nav>
</header>

<script src="${pageContext.request.contextPath}/js/adminheader.js"></script>
