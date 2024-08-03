<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="modal fade" id="signinModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="signinModalLabel">Sign In</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form id="signinForm">
                    <div class="mb-3">
                        <label for="signinEmail" class="form-label">Email</label>
                        <input type="email" class="form-control" id="signinEmail" name="signinEmail" placeholder="Enter your email">
                    </div>
                    <div class="mb-4">
                        <label for="signinPassword" class="form-label">Password</label>
                        <input type="password" class="form-control" id="signinPassword" name="signinPassword" placeholder="Enter your password">
                    </div>
                    <div class="mb-3">
                        <button type="button" class="btn vag-btn-tan w-100" id="signinButton">Sign In</button>
                    </div>
                    <!-- <div class="d-flex justify-content-center">
                        <a href="#" class="vag-a-tan vag-text-point7rem">Forgot Password?</a>
                    </div> -->
                    <div class="d-flex justify-content-center text-danger" id="signinError" style="display: none;">
                        <p id="signinErrorMessage"></p>
                    </div>
                </form>
            </div>
            <div class="modal-footer">
                <div class="d-flex justify-content-center w-100">
                    <span class="vag-text-point7rem">Don't have an account? <a href="${pageContext.request.contextPath}/signup" class="vag-a-tan">Sign Up</a></span>
                </div>
            </div>
        </div>
    </div>
</div>

<div class="modal fade" id="userMenuModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title">User Menu</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <button class="btn btn-secondary w-100 mb-2" id="myProfileButton">My Profile</button>
                <button class="btn btn-secondary w-100 mb-2" id="myTransactionsButton">My Transactions</button>
                <c:if test="${sessionScope.user.role == 'artist'}">
                    <button class="btn btn-secondary w-100 mb-2" id="myArtworksButton">My Artworks</button>
                </c:if>
                <button class="btn btn-danger w-100" id="signoutButton">Sign Out</button>
            </div>
        </div>
    </div>
</div>

<header class="d-flex flex-column flex-md-row align-items-center p-3 px-md-4 bg-white border-bottom">
    <h5 class="my-0 me-auto"><a href="${pageContext.request.contextPath}/" class="text-decoration-none text-dark">VArtGallery</a></h5>
    <nav class="navbar navbar-expand-md navbar-light bg-white vag-headnav-container">
        <div class="d-flex w-100 justify-content-center d-md-none">
            <button class="navbar-toggler" type="button" data-bs-toggle="collapse" data-bs-target="#headNav">
                <span class="navbar-toggler-icon"></span>
            </button>
        </div>
        <div class="collapse navbar-collapse vag-navbar-collapse-center" id="headNav">
            <ul class="navbar-nav me-auto">
                <li class="nav-item"><a class="nav-link vag-a-tan" href="${pageContext.request.contextPath}/gallery">Gallery</a></li>
                <li class="nav-item"><a class="nav-link vag-a-tan" href="${pageContext.request.contextPath}/exhibitions">Exhibitions</a></li>
                <li class="nav-item"><a class="nav-link vag-a-tan" href="${pageContext.request.contextPath}/about">About Us</a></li>
                <c:if test="${not empty sessionScope.user}">
                    <li class="nav-item"><a class="btn vag-btn-tan" href="${pageContext.request.contextPath}/cart"><i class="bi bi-cart"></i> Cart</a></li>
                    <li class="nav-item"><button class="btn vag-btn-tan" data-bs-toggle="modal" data-bs-target="#userMenuModal"><i class="bi bi-person-circle"></i> Menu</button></li>
                </c:if>
                <c:if test="${empty sessionScope.user}">
                    <li class="nav-item"><button class="btn vag-btn-tan" data-bs-toggle="modal" data-bs-target="#signinModal"><i class="bi bi-person-circle"></i> Sign In</button></li>
                </c:if>
            </ul>
        </div>
    </nav>
</header>

<script src="${pageContext.request.contextPath}/js/header.js"></script>
