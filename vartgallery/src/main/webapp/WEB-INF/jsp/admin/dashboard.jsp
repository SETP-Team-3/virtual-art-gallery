<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <c:import url="./adminmeta.jsp" />
</head>
<body>
<c:import url="./adminheader.jsp" />

<main>
    <section class="vag-section">
        <div class="container">
            <div class="row">
                <div class="col-md">
                    <h2>VArtGallery Dashboard</h2>
                </div>
            </div>
        </div>
    </section>

    <section class="vag-section">
        <div class="container">
            <h2 class="mb-3">Pending User Signups</h2>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Account Type</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="pendingUser" items="${pendingUsers}">
                        <tr>
                            <td>${pendingUser.name}</td>
                            <td>${pendingUser.email}</td>
                            <td>${pendingUser.role}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div>
                <a href="${pageContext.request.contextPath}/admin/pending-users" class="btn vag-btn-tan">See all new user account signups</a>
            </div>
        </div>
    </section>

    <section class="vag-section">
        <div class="container">
            <h2 class="mb-3">Pending Artwork Uploads</h2>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Username</th>
                        <th>Title</th>
                        <th>Collections</th>
                        <th>Price</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="pendingArtwork" items="${pendingArtworks}">
                        <tr>
                            <td>${pendingArtwork.artistId.name}</td>
                            <td>${pendingArtwork.title}</td>
                            <td>${pendingArtwork.description}</td>
                            <td>$${pendingArtwork.price}</td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
            <div>
                <a href="${pageContext.request.contextPath}/admin/pending-artworks" class="btn vag-btn-tan">See all pending uploaded artworks</a>
            </div>
        </div>
    </section>

    <section class="vag-section">
        <div class="container">
            <h2 class="mb-5">Manage Resources</h2>
            <div class="row justify-content-center mb-3">
                <div class="row">
                    <div class="col-sm-4 mb-4">
                        <a href="${pageContext.request.contextPath}/admin/manage-artworks" class="card">
                            <img src="${pageContext.request.contextPath}/artwork/image-01.jpg" class="card-img-top">
                            <div class="card-body">
                                <h5 class="card-title">Manage Artworks</h5>
                            </div>
                        </a>
                    </div>
                    <div class="col-sm-4 mb-4">
                        <a href="${pageContext.request.contextPath}/admin/manage-users" class="card">
                            <img src="${pageContext.request.contextPath}/artwork/image-01.jpg" class="card-img-top">
                            <div class="card-body">
                                <h5 class="card-title">Manage Users</h5>
                            </div>
                        </a>
                    </div>
                    <div class="col-sm-4 mb-4">
                        <a href="${pageContext.request.contextPath}/admin/manage-transactions" class="card">
                            <img src="${pageContext.request.contextPath}/artwork/image-01.jpg" class="card-img-top">
                            <div class="card-body">
                                <h5 class="card-title">Manage Transactions</h5>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
        </div>
    </section>
</main>

<c:import url="./adminfooter.jsp" />
</body>
</html>
