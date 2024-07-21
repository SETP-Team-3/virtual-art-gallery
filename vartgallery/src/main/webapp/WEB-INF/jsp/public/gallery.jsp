<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <c:import url="./meta.jsp" />
    <script src="${pageContext.request.contextPath}/js/multiselect-dropdown.js"></script>
    <script src="${pageContext.request.contextPath}/js/gallery.js"></script>
</head>
<body>
<c:import url="./gallery-modal-filterartwork.jsp" />
<c:import url="./gallery-modal-filterartist.jsp" />
<c:import url="./header.jsp" />

<main>
    <section class="vag-section vag-section-tan">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-10 text-center">
                    <h2 class="mb-5">Explore Our Extensive Art Collection</h2>
                    <p class="mb-4">Welcome to the VArtGallery's Gallery page. Here, you can browse through our extensive collection of artworks, ranging from classical paintings to modern digital art. Use the filters below to narrow down your search and find the perfect piece for your collection.</p>
                    <p class="mb-4">Whether you are a seasoned collector or a first-time buyer, our gallery offers a diverse selection to suit all tastes and preferences. Explore, discover, and be inspired by the finest art from around the world.</p>
                </div>
            </div>
        </div>
    </section>

    <section class="vag-section">
        <div class="container">
            <div class="row mb-4">
                <div class="col">
                    <h2 class="mb-3">Artwork Gallery</h2>
                    <button type="button" class="btn vag-btn-tan" data-bs-toggle="modal" data-bs-target="#artworkFilterModal">Filter Artworks</button>
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
                                    <span class="vag-artwork-price">${artwork.price}</span>
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
                    <li class="page-item"><button id="prevArtworkPage" class="page-link bg-outline-secondary text-secondary">Previous</button></li>
                    <li class="page-item disabled"><span id="currentArtworkPage" class="page-link text-dark">${currentArtworkPage}</span></li>
                    <li class="page-item"><button id="nextArtworkPage" class="page-link bg-outline-secondary text-secondary">Next</button></li>
                </ul>
            </nav>
        </div>
    </section>

    <section class="vag-section">
        <div class="container">
            <div class="row mb-4">
                <div class="col">
                    <h2 class="mb-3">Artist Gallery</h2>
                    <button type="button" class="btn vag-btn-tan" data-bs-toggle="modal" data-bs-target="#artistFilterModal">Filter Artists</button>
                </div>
            </div>
            <div class="row d-flex flex-wrap" id="artistGallery">
                <c:forEach var="artist" items="${artists}">
                    <div class="col-6 col-md-3 mb-4 artist-card" data-name="${artist.name}">
                        <div class="card">
                            <img src="${pageContext.request.contextPath}/portrait/${artist.portrait}" class="card-img-top" alt="${artist.name}">
                            <div class="card-body">
                                <h5 class="card-title">${artist.name}</h5>
                                <c:forEach var="genre" items="${artist.genres}">
                                    <span class="badge bg-secondary">${genre.name}</span>
                                </c:forEach>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
            <nav>
                <ul class="pagination justify-content-center" id="artistPaginationControls">
                    <li class="page-item"><button id="prevArtistPage" class="page-link bg-outline-secondary text-secondary">Previous</button></li>
                    <li class="page-item disabled"><span id="currentArtistPage" class="page-link text-dark">${currentArtistPage}</span></li>
                    <li class="page-item"><button id="nextArtistPage" class="page-link bg-outline-secondary text-secondary">Next</button></li>
                </ul>
            </nav>
        </div>
    </section>
</main>

<c:import url="./footer.jsp" />
</body>
</html>
