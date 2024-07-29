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
            <div class="row justify-content-center mb-5">
                <div class="col-md-5">
                    <img src="${pageContext.request.contextPath}/artwork/${artwork.image}" alt="${artwork.title}" class="img-fluid rounded mb-4">
                </div>
                <div class="col-md-7">
                    <div class="mb-5">
                        <h2 class="mb-0">${artwork.title}</h2>
                        <p><em>${artwork.artistId.name}</em></p>
                        <p class="mb-0">${artwork.description}</p>
                        <c:forEach var="genre" items="${artwork.genres}">
                            <span class="badge bg-secondary">${genre.name}</span>
                        </c:forEach>
                    </div>
                    <div>
                        <h3>Price: $<span class="vag-artwork-price">${artwork.price}</span></h3>
                        <c:if test="${artwork.status != 'sold' && artwork.price > 0 && not empty sessionScope.user && !isInCart}">
                            <button class="btn vag-btn-tan" id="btnAddCartArtwork" data-artwork-id="${artwork.id}">Add to Cart</button>
                        </c:if>
                        <c:if test="${isInCart}">
                            <button class="btn vag-btn-tan" disabled>Already in Cart</button>
                        </c:if>
                    </div>
                </div>
            </div>

            <div class="row justify-content-center mb-5">
                <div class="col-md-12 mb-3 text-center">
                    <button class="btn btn-outline-secondary vag-text-point7rem" id="btnLikeArtwork" data-artwork-id="${artwork.id}">
                        <c:if test="${artwork.liked}"><i class="bi bi-star"></i> 1619 Likes</c:if>
                        <c:if test="${!artwork.liked}"><i class="bi bi-star-fill"></i> 1620 Likes</c:if>
                    </button>
                    <button class="btn btn-outline-secondary vag-text-point7rem" id="btnCommentArtwork" data-artwork-id="x">
                        <i class="bi bi-chat"></i> 42 Comments
                    </button>
                </div>

                <div class="col-md-12 text-center" style="background-color: whitesmoke;">
                    <div id="comments-list" class="mt-4">
                        <div class="card mb-3">
                            <div class="card-body">
                                <p><strong>Alice:</strong> Hello</p>
                            </div>
                        </div>
                        <div class="card mb-3">
                            <div class="card-body">
                                <p><strong>User 1:</strong> This is a simulated comment number 1.</p>
                            </div>
                        </div>
                        <div class="card mb-3">
                            <div class="card-body">
                                <p><strong>Alice:</strong> Hello</p>
                            </div>
                        </div>
                        <div class="card mb-3">
                            <div class="card-body">
                                <p><strong>User 1:</strong> This is a simulated comment number 1.</p>
                            </div>
                        </div>
                        <div class="card mb-3">
                            <div class="card-body">
                                <p><strong>Alice:</strong> Hello</p>
                            </div>
                        </div>
                        <div class="card mb-3">
                            <div class="card-body">
                                <p><strong>User 1:</strong> This is a simulated comment number 1.</p>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </section>
</main>

<c:import url="./footer.jsp" />
</body>
</html>
