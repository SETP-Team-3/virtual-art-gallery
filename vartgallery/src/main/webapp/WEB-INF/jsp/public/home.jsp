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
        <div id="carouselIndicators" class="carousel slide" data-bs-ride="carousel">
            <div class="carousel-indicators">
                <button type="button" data-bs-target="#carouselIndicators" data-bs-slide-to="0" class="active"></button>
                <button type="button" data-bs-target="#carouselIndicators" data-bs-slide-to="1"></button>
                <button type="button" data-bs-target="#carouselIndicators" data-bs-slide-to="2"></button>
            </div>
            <div class="carousel-inner">
                <div class="carousel-item active">
                    <img src="${pageContext.request.contextPath}/carousel-about-vartgallery.jpg" class="d-block w-100">
                    <div class="carousel-caption d-none d-md-block">
                        <h5>Welcome to VArtGallery</h5>
                        <p>Discover the essence of our gallery, where art meets innovation and creativity flourishes.</p>
                    </div>
                </div>
                <div class="carousel-item">
                    <img src="${pageContext.request.contextPath}/carousel-kids-paint-by-numbers.jpg" class="d-block w-100">
                    <div class="carousel-caption d-none d-md-block">
                        <h5>Kids Paint By Numbers</h5>
                        <p>Unleash your child's creativity with our engaging and fun paint-by-numbers kits, perfect for budding young artists.</p>
                    </div>
                </div>
                <div class="carousel-item">
                    <img src="${pageContext.request.contextPath}/carousel-asian-womens-fashion.jpg" class="d-block w-100">
                    <div class="carousel-caption d-none d-md-block">
                        <h5>Asian Women's Fashion</h5>
                        <p>Explore the fusion of traditional and contemporary styles in our latest collection celebrating Asian women's fashion.</p>
                    </div>
                </div>
            </div>
            <button class="carousel-control-prev" type="button" data-bs-target="#carouselIndicators" data-bs-slide="prev">
                <span class="carousel-control-prev-icon"></span>
                <span class="visually-hidden">Previous</span>
            </button>
            <button class="carousel-control-next" type="button" data-bs-target="#carouselIndicators" data-bs-slide="next">
                <span class="carousel-control-next-icon"></span>
                <span class="visually-hidden">Next</span>
            </button>
        </div>

        <section class="vag-section vag-section-tan">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-md-10 text-center">
                        <h2 class="mb-5">Discover the Finest Art</h2>
                        <p class="mb-4">At VArtGallery, we celebrate the fusion of timeless elegance and contemporary flair. Our curated collection features masterpieces from renowned artists and emerging talents, providing art enthusiasts with an exquisite selection of paintings, sculptures, and digital art.</p>
                        <p class="mb-4">Our mission is to connect discerning collectors with exceptional works of art that inspire and captivate. Each piece in our gallery is chosen for its quality, uniqueness, and ability to elevate any space.</p>
                        <p class="mb-4">Whether you are looking to add to your personal collection or seeking the perfect statement piece, VArtGallery offers a seamless and enriching experience, ensuring that every acquisition is a treasured addition.</p>
                    </div>
                </div>
            </div>
        </section>

        <section class="vag-section">
            <div class="container">
                <h2 class="mb-5">Featured Artworks</h2>
                <div class="row justify-content-center">
                    <c:forEach var="artwork" items="${featuredArtworks}">
                        <div class="col-6 col-md-3 mb-4">
                            <div class="card h-100">
                                <img src="${pageContext.request.contextPath}/artwork/${artwork.image}" class="card-img-top">
                                <div class="card-body">
                                    <h5 class="card-title">${artwork.title}</h5>
                                    <p class="card-text">${artwork.artistId.name}</p>
                                </div>
                            </div>
                        </div>
                    </c:forEach>
                </div>
            </div>
        </section>

        <section class="vag-section vag-section-whitesmoke">
            <div class="container">
                <h2 class="mb-5">Upcoming Exhibitions</h2>
                <div class="row justify-content-center">
                    <div class="col-md">
                        <div class="mb-4">
                            <h5>Modern Masters</h5>
                            <p>Join us for an exclusive showcase of works by the most influential modern artists of the 20th and 21st centuries. This exhibition highlights the groundbreaking contributions of artists who have redefined the boundaries of contemporary art.</p>
                        </div>
                        <div class="mb-4">
                            <h5>Art Beyond Borders</h5>
                            <p>Experience the diversity of global artistry in this unique exhibition that brings together works from emerging and established artists across the world. 'Art Beyond Borders' celebrates the rich cultural heritage and innovative expressions that transcend geographical boundaries.</p>
                        </div>
                        <div class="text-center">
                            <a href="${pageContext.request.contextPath}/exhibitions" class="btn vag-btn-tan">See All Exhibitions</a>
                        </div>
                    </div>
                </div>
            </div>
        </section>
    </main>

    <c:import url="./footer.jsp" />
</body>
</html>
