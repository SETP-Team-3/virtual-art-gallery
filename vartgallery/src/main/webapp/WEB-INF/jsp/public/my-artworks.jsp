<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <c:import url="./meta.jsp" />
</head>
<body>
<c:import url="./my-artworks-modal-uploadartwork.jsp" />
<c:import url="./header.jsp" />

<main>
    <section class="vag-section vag-section-tan">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-10 text-center">
                    <h2 class="mb-5">My Artworks</h2>
                    <p class="mb-4">Here you can find all the artworks you have created and manage them as needed.</p>
                </div>
            </div>
        </div>
    </section>

    <section class="vag-section">
        <div class="container">
            <div class="row mb-4">
                <div class="col">
                    <h2 class="mb-3">Your Artwork Gallery</h2>
                    <button type="button" class="btn vag-btn-tan" data-bs-toggle="modal" data-bs-target="#uploadArtworkModal">Upload Artwork</button>
                </div>
            </div>
            <div class="row d-flex flex-wrap" id="artworkGallery">
                <c:forEach var="artwork" items="${artworks}">
                    <div class="col-6 col-md-3 mb-4 artwork-card" data-id="${artwork.id}" data-title="${artwork.title}">
                        <div class="card h-100">
                            <img src="${pageContext.request.contextPath}/artwork/${artwork.image}" class="card-img-top" alt="${artwork.title}">
                            <div class="card-body">
                                <h5 class="card-title">${artwork.title}</h5>
                                <p class="card-text">
                                    ${artwork.artistId.name}<br />
                                    <span class="vag-artwork-price">$${artwork.price}</span>
                                </p>
                                <c:forEach var="genre" items="${artwork.genres}">
                                    <span class="badge bg-secondary">${genre.name}</span>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <nav>
                <ul class="pagination justify-content-center" id="artworkPaginationControls">
                    <li class="page-item <c:if test="${currentArtworkPage == 1}">disabled</c:if>">
                        <a class="page-link bg-outline-secondary text-secondary" href="?page=${currentArtworkPage - 1}">Previous</a>
                    </li>
                    <c:forEach var="i" begin="1" end="${totalArtworkPages}">
                        <li class="page-item <c:if test="${currentArtworkPage == i}">active</c:if>">
                            <a class="page-link text-dark" href="?page=${i}">${i}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item <c:if test="${currentArtworkPage == totalArtworkPages}">disabled</c:if>">
                        <a class="page-link bg-outline-secondary text-secondary" href="?page=${currentArtworkPage + 1}">Next</a>
                    </li>
                </ul>
            </nav>
        </div>
    </section>
</main>

<c:import url="./footer.jsp" />
</body>
</html>
