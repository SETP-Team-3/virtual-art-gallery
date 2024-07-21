<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <c:import url="./meta.jsp" />
    <script src="${pageContext.request.contextPath}/js/artwork-detail.js"></script>
</head>
<body>
<c:import url="./header.jsp" />

<main>
    <section class="vag-section">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-12 mb-5 text-center">
                    <h2 class="mb-5">${artwork.title}</h2>
                    <img src="${pageContext.request.contextPath}/artwork/${artwork.image}" alt="${artwork.title}" class="img-fluid mb-4">
                    <h4>Artist: ${artwork.artistId.name}</h4>
                    <p>Price: <span class="vag-artwork-price">${artwork.price}</span></p>
                    <p>${artwork.description}</p>
                    <c:forEach var="genre" items="${artwork.genres}">
                        <span class="badge bg-secondary">${genre.name}</span>
                    </c:forEach>
                </div>
                <div class="col-md-12 mb-3 text-center">
                    <c:if test="${artwork.status != 'sold'}">
                        <button class="btn vag-btn-tan" id="btnAddCartArtwork" data-artwork-id="${artwork.id}">Add to Cart</button>
                    </c:if>
                </div>
                <div class="col-md-12 mb-3 text-center">
                    <button class="btn btn-outline-secondary" id="btnLikeArtwork" data-artwork-id="${artwork.id}">
                        <c:if test="${artwork.liked}">Unlike</c:if>
                        <c:if test="${!artwork.liked}">Like</c:if>
                    </button>
                </div>
                <div class="col-md-12 text-center comment-section">
                    <h4>Comments</h4>
                    <form id="comment-form" method="post" action="${pageContext.request.contextPath}/add-comment">
                        <div class="form-group">
                            <textarea class="form-control" name="comment" rows="4" placeholder="Add your comment..."></textarea>
                        </div>
                        <input type="hidden" name="artworkId" value="${artwork.id}">
                        <button type="submit" class="btn vag-btn-tan mt-2">Submit</button>
                    </form>
                    <div id="comments-list" class="mt-4">
                        <c:forEach var="comment" items="${artwork.comments}">
                            <div class="comment">
                                <p><strong>${comment.user.name}:</strong> ${comment.content}</p>
                            </div>
                        </c:forEach>
                    </div>
                </div>
            </div>
        </div>
    </section>
</main>

<c:import url="./footer.jsp" />
</body>
</html>
