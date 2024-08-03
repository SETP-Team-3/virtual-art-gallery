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
                    <h2 class="mb-5">Exhibitions</h2>
                    <p class="mb-4">Discover the latest exhibitions at our gallery.</p>
                </div>
            </div>
        </div>
    </section>

    <section class="vag-section">
        <div class="container">
            <div class="row">
                <c:forEach var="exhibition" items="${exhibitions}">
                    <div class="col-md-4 mb-4">
                        <div class="card h-100">
                            <img src="${pageContext.request.contextPath}/exhibitions/${exhibition.image}" class="card-img-top" alt="${exhibition.name}">
                            <div class="card-body">
                                <h5 class="card-title">${exhibition.name}</h5>
                                <p class="card-text">${exhibition.description}</p>
                                <p class="card-text mb-0" style="font-size: small"><strong>Status:</strong> ${exhibition.status}</p>
                                <c:if test="${exhibition.expoTimeStart != null && exhibition.expoTimeEnd != null}">
                                    <p class="card-text mb-0" style="font-size: small"><strong>Start Time:</strong> ${exhibition.expoTimeStart}</p>
                                    <p class="card-text mb-0" style="font-size: small"><strong>End Time:</strong> ${exhibition.expoTimeEnd}</p>
                                </c:if>
                                <p class="card-text" style="font-size: small"><strong>Space:</strong> ${exhibition.expoSpace}</p>
                            </div>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </div>
    </section>
</main>

<c:import url="./footer.jsp" />
</body>
</html>
