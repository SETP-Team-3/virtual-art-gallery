<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <c:import url="./adminmeta.jsp" />
    <script src="${pageContext.request.contextPath}/js/manage-artworks.js"></script>
</head>
<body>
<div class="modal fade" id="artworkModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="artworkModalLabel">Artwork Details</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div id="artworkDetails"></div>
            </div>
        </div>
    </div>
</div>
<c:import url="./adminheader.jsp" />

<main>
    <section class="vag-section">
        <div class="container">
            <h2 class="mb-3">Manage Artworks</h2>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Title</th>
                        <th>Artist Email</th>
                        <th>Buyer Email</th>
                        <th>Price</th>
                        <th>Status</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="artwork" items="${artworks}">
                        <tr>
                            <td>${artwork.id}</td>
                            <td>${artwork.title}</td>
                            <td>${artwork.artistId.email}</td>
                            <td>${artwork.buyerId != null ? artwork.buyerId.email : 'N/A'}</td>
                            <td>$${artwork.price}</td>
                            <td>${artwork.status}</td>
                            <td>
                                <button type="button" class="btn btn-secondary w-100 mb-2 vag-btn-viewartwork" data-artwork-id="${artwork.id}">View</button>
                                <button type="button" class="btn btn-danger w-100 vag-btn-deleteartwork" data-artwork-id="${artwork.id}">Delete</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </section>
</main>

<c:import url="./adminfooter.jsp" />
</body>
</html>
