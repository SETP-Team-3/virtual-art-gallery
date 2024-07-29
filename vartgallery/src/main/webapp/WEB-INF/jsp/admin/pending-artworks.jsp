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
                    <c:forEach var="artwork" items="${pendingArtworks}">
                        <tr>
                            <td>${artwork.artist.name}</td>
                            <td>${artwork.title}</td>
                            <td>${artwork.description}</td>
                            <td>$${artwork.price}</td>
                            <td><img src="${pageContext.request.contextPath}/artwork/${artwork.image}" width="100" /></td>
                            <td>
                                <form action="${pageContext.request.contextPath}/admin/approve-artwork" method="post" style="display:inline;">
                                    <input type="hidden" name="artworkId" value="${artwork.id}" />
                                    <button type="submit" class="btn btn-success">Approve</button>
                                </form>
                                <form action="${pageContext.request.contextPath}/admin/reject-artwork" method="post" style="display:inline;">
                                    <input type="hidden" name="artworkId" value="${artwork.id}" />
                                    <input type="text" name="reason" placeholder="Reason for rejection" required />
                                    <button type="submit" class="btn btn-danger">Reject</button>
                                </form>
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
