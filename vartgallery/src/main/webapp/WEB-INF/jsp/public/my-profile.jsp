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
                    <h2 class="mb-5">My Profile</h2>
                    <p class="mb-4">Welcome to your profile page.</p>
                </div>
            </div>
        </div>
    </section>

    <section class="vag-section">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-8">
                    <div class="mb-4">
                        <div class="card-body text-center">
                            <img src="${pageContext.request.contextPath}/portrait/${user.portrait}" alt="${user.name}" class="img-fluid rounded-circle mb-4" style="width: 150px; height: 150px;">
                            <h3>${user.name}</h3>
                            <p class="text-muted">${user.email}</p>
                            <p class="text-muted">${user.phone}</p>
                        </div>
                    </div>
                    <div class="card mb-4">
                        <div class="card-body">
                            <h5 class="card-title">Description</h5>
                            <p class="card-text">${user.description}</p>
                        </div>
                    </div>
                    <div class="card mb-4">
                        <div class="card-body">
                            <h5 class="card-title">Address</h5>
                            <p class="card-text">${user.address}</p>
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