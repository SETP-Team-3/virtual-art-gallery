<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <c:import url="./adminmeta.jsp" />
    <script src="${pageContext.request.contextPath}/js/pending-artworks.js"></script>
</head>
<body>
<c:import url="./adminheader.jsp" />

<main>
    <section class="vag-section">
        <div class="container">
            <h2 class="mb-3">Pending Artwork Uploads</h2>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Username</th>
                        <th>Title</th>
                        <th>Description</th>
                        <th>Price</th>
                        <th>Image</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="pendingArtwork" items="${pendingArtworks}">
                        <tr>
                            <td>${pendingArtwork.artistId.name}</td>
                            <td>${pendingArtwork.title}</td>
                            <td>${pendingArtwork.description}</td>
                            <td>$${pendingArtwork.price}</td>
                            <td><img src="${pageContext.request.contextPath}/artwork/${pendingArtwork.image}" width="100" /></td>
                            <td>
                                <button type="button" class="btn btn-success w-100 mb-2 vag-btn-approve" data-id="${pendingArtwork.id}">Approve</button>
                                <button type="button" class="btn btn-danger w-100 vag-btn-reject" data-id="${pendingArtwork.id}">Reject</button>
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
