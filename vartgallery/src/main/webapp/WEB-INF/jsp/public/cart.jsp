<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <c:import url="./meta.jsp" />
    <script src="${pageContext.request.contextPath}/js/cart.js"></script>
</head>
<body>
<c:import url="./header.jsp" />

<main>
    <section class="vag-section">
        <div class="container">
            <div class="row justify-content-center mb-5">
                <div class="col-md-10">
                    <h2 class="mb-3">My Cart</h2>
                    <div class="table-responsive">
                        <table class="table">
                            <thead>
                                <tr>
                                    <th scope="col">Artwork</th>
                                    <th scope="col">Title</th>
                                    <th scope="col">Price</th>
                                    <th scope="col" class="text-end">Action</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="artwork" items="${cart}">
                                    <tr>
                                        <td><img src="${pageContext.request.contextPath}/artwork/${artwork.image}" class="img-fluid rounded" style="max-width: 100px;"></td>
                                        <td>${artwork.title}</td>
                                        <td>$${artwork.price}</td>
                                        <td class="text-end"><button class="btn btn-danger btn-sm vag-cart-btnremove" data-cart-item-id="${artwork.id}">Remove</button></td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                    </div>
                    <div class="text-end">
                        <h3>Total: <span class="vag-cart-total">
                            <c:set var="total" value="0" />
                            <c:forEach var="artwork" items="${cart}">
                                <c:set var="total" value="${total + artwork.price}" />
                            </c:forEach>
                            $${total}
                        </span></h3>
                        <button class="btn vag-btn-tan" id="btnCheckout">Proceed to Checkout</button>
                    </div>
                </div>
            </div>
        </div>
    </section>
</main>

<c:import url="./footer.jsp" />
</body>
</html>
