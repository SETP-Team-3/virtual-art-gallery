<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <c:import url="./meta.jsp" />
</head>
<body>
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
            <h2 class="mb-5">Artwork Gallery</h2>
            <div class="row mb-4">
                <div class="col-md-4">
                    <input type="text" id="artworkName" class="form-control" placeholder="Filter by Artwork Name">
                </div>
                <div class="col-md-4">
                    <input type="text" id="artistName" class="form-control" placeholder="Filter by Artist Name">
                </div>
                <div class="col-md-4">
                    <select id="artworkType" class="form-control">
                        <option value="">Filter by Artwork Type</option>
                        <option value="painting">Painting</option>
                        <option value="sculpture">Sculpture</option>
                        <option value="digital">Digital Art</option>
                    </select>
                </div>
            </div>
            <div class="row justify-content-center" id="artworkGallery">
                <div class="row">
                    <div class="col-6 col-md-3 mb-4 artwork-card" data-name="Artwork 1" data-artist="Artist Name" data-type="painting">
                        <div class="card">
                            <img src="${pageContext.request.contextPath}/artwork/image-01.jpg" class="card-img-top" alt="Artwork 1">
                            <div class="card-body">
                                <h5 class="card-title">Artwork 1</h5>
                                <p class="card-text">Artist Name</p>
                            </div>
                        </div>
                    </div>
                    <c:forEach var="artwork" items="${artworks}">
                        <div class="col-6 col-md-3 mb-4 artwork-card" data-name="${artwork.title}">
                            <div class="card">
                                <img src="${pageContext.request.contextPath}/artwork/image-01.jpg" class="card-img-top" alt="${artwork.title}">
                                <div class="card-body">
                                    <h5 class="card-title">${artwork.title}</h5>
                                    <p class="card-text">Artist Name</p>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </div>
    </section>
</main>

<c:import url="./footer.jsp" />
</body>
</html>
