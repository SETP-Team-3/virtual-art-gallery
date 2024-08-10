<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <c:import url="./meta.jsp" />
    <script src="${pageContext.request.contextPath}/js/artist-detail.js"></script>
</head>
<body>
<c:import url="./header.jsp" />

<main>
    <section class="vag-section">
        <div class="container">
            <div class="row justify-content-center mb-5">
                <div class="col-md-5">
                    <img src="${pageContext.request.contextPath}/portrait/${artist.portrait}" alt="${artist.name}" class="img-fluid rounded mb-4">
                </div>
                <div class="col-md-7">
                    <div class="mb-5">
                        <h2 class="mb-0">${artist.name}</h2>
                        <p><em>${artist.description}</em></p>
                        <c:forEach var="genre" items="${artist.genres}">
                            <span class="badge bg-secondary">${genre.name}</span>
                        </c:forEach>
                    </div>
                </div>
            </div>

            <div class="row justify-content-center mb-5">
                <div class="col-md-12">
                    <h3>Artworks by ${artist.name}</h3>
                    <div class="row d-flex flex-wrap">
                        <c:forEach var="artwork" items="${artworks}">
                            <div class="col-6 col-md-3 mb-4 artwork-card" data-id="${artwork.id}" data-title="${artwork.title}" style="cursor: pointer">
                                <div class="card h-100">
                                    <img src="${pageContext.request.contextPath}/artwork/${artwork.image}" class="card-img-top" alt="${artwork.title}">
                                    <div class="card-body">
                                        <h5 class="card-title">${artwork.title}</h5>
                                        <p class="card-text">
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
                </div>
            </div>
            <nav>
                <ul class="pagination justify-content-center" id="artworkPaginationControls">
                    <li class="page-item <c:if test="${currentArtworkPage == 1}">disabled</c:if>">
                        <a class="page-link bg-outline-secondary text-secondary" href="?id=${artist.id}&page=${currentArtworkPage - 1}">Previous</a>
                    </li>
                    <c:forEach var="i" begin="1" end="${totalArtworkPages}">
                        <li class="page-item <c:if test="${currentArtworkPage == i}">active</c:if>">
                            <a class="page-link text-dark" href="?id=${artist.id}&page=${i}">${i}</a>
                        </li>
                    </c:forEach>
                    <li class="page-item <c:if test="${currentArtworkPage == totalArtworkPages}">disabled</c:if>">
                        <a class="page-link bg-outline-secondary text-secondary" href="?id=${artist.id}&page=${currentArtworkPage + 1}">Next</a>
                    </li>
                </ul>
            </nav>
        </div>
    </section>
</main>

<c:import url="./footer.jsp" />
</body>
</html>
