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
                    <h2 class="mb-5">My Transactions</h2>
                    <p class="mb-4">Review your past purchases and transaction history below.</p>
                </div>
            </div>
        </div>
    </section>

    <section class="vag-section">
        <div class="container">
            <div class="row justify-content-center">
                <div class="col-md-10">
                    <div class="card mb-4">
                        <div class="card-body">
                            <h5 class="card-title">Transaction History</h5>
                            <c:choose>
                                <c:when test="${empty transactions}">
                                    <p class="card-text">You have no transactions.</p>
                                </c:when>
                                <c:otherwise>
                                    <table class="table table-striped">
                                        <thead>
                                            <tr>
                                                <th scope="col">Transaction ID</th>
                                                <th scope="col">Date</th>
                                                <th scope="col">Artwork</th>
                                                <th scope="col">Amount</th>
                                            </tr>
                                        </thead>
                                        <tbody>
                                            <c:forEach var="transaction" items="${transactions}">
                                                <tr>
                                                    <td>${transaction.transactionId}</td>
                                                    <td>${transaction.transactionDate}</td>
                                                    <td>${transaction.artworkTitle}</td>
                                                    <td>$${transaction.amount}</td>
                                                </tr>
                                            </c:forEach>
                                        </tbody>
                                    </table>
                                </c:otherwise>
                            </c:choose>
                        </div>
                    </div>
                    <c:if test="${user.role == 'artist'}">
                        <div class="card mb-4">
                            <div class="card-body">
                                <h5 class="card-title">Artworks Sold</h5>
                                <c:choose>
                                    <c:when test="${empty artworksSold}">
                                        <p class="card-text">You have not sold any artworks.</p>
                                    </c:when>
                                    <c:otherwise>
                                        <table class="table table-striped">
                                            <thead>
                                                <tr>
                                                    <th scope="col">Artwork</th>
                                                    <th scope="col">Buyer</th>
                                                    <th scope="col">Price</th>
                                                </tr>
                                            </thead>
                                            <tbody>
                                                <c:forEach var="soldArtwork" items="${artworksSold}">
                                                    <tr>
                                                        <td>${soldArtwork.title}</td>
                                                        <td>${soldArtwork.buyerId.name}</td>
                                                        <td>$${soldArtwork.price}</td>
                                                    </tr>
                                                </c:forEach>
                                            </tbody>
                                        </table>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </c:if>
                </div>
            </div>
        </div>
    </section>
</main>

<c:import url="./footer.jsp" />
</body>
</html>
