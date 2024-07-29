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
            <h2 class="mb-3">New Account Signups</h2>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Username</th>
                        <th>Account Type</th>
                    </tr>
                </thead>
                <tbody>
                    <tr>
                        <td>Robert Smith</td>
                        <td>Artist</td>
                    </tr>
                    <tr>
                        <td>JaninePaints</td>
                        <td>Buyer</td>
                    </tr>
                    <tr>
                        <td>sneakyuser</td>
                        <td>Buyer</td>
                    </tr>
                    <!-- Simulated entries -->
                    <tr>
                        <td>artist1234</td>
                        <td>Artist</td>
                    </tr>
                    <tr>
                        <td>buyerguy567</td>
                        <td>Buyer</td>
                    </tr>
                    <tr>
                        <td>modernartlover</td>
                        <td>Artist</td>
                    </tr>
                </tbody>
            </table>
            <div>
                <a href="#" class="btn vag-btn-tan">See all new account signups</a>
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
                    <c:forEach var="artwork" items="${pendingArtworks}">
                        <tr>
                            <td>${artwork.artist.name}</td>
                            <td>${artwork.title}</td>
                            <td>${artwork.description}</td>
                            <td>$${artwork.price}</td>
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
                        <div class="card">
                            <img src="${pageContext.request.contextPath}/artwork/image-01.jpg" class="card-img-top" alt="Artwork 1">
                            <div class="card-body">
                                <h5 class="card-title">Manage Artworks</h5>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-4 mb-4">
                        <div class="card">
                            <img src="${pageContext.request.contextPath}/artwork/image-01.jpg" class="card-img-top" alt="Artwork 2">
                            <div class="card-body">
                                <h5 class="card-title">Manage Users</h5>
                            </div>
                        </div>
                    </div>
                    <div class="col-sm-4 mb-4">
                        <div class="card">
                            <img src="${pageContext.request.contextPath}/artwork/image-01.jpg" class="card-img-top" alt="Artwork 3">
                            <div class="card-body">
                                <h5 class="card-title">Manage Payments</h5>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</main>

<c:import url="./adminfooter.jsp" />
</body>
</html>
