<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <c:import url="./meta.jsp" />
    <script src="https://js.stripe.com/v3/"></script>
    <script src="${pageContext.request.contextPath}/js/checkout.js"></script>
    <style>
        .StripeElement {
            box-sizing: border-box;
            height: 40px;
            padding: 10px 12px;
            border: 1px solid #ced4da;
            border-radius: 4px;
            background-color: white;
            box-shadow: 0 1px 3px 0 #e6ebf1;
            transition: box-shadow 150ms ease;
        }

        .StripeElement--focus {
            box-shadow: 0 1px 3px 0 #cfd7df;
        }

        .StripeElement--invalid {
            border-color: #fa755a;
        }

        .StripeElement--webkit-autofill {
            background-color: #fefde5 !important;
        }

        .vag-card-container {
            max-width: 500px;
            margin: 0 auto;
        }

        .spinner {
            display: none;
            width: 50px;
            height: 50px;
            border: 6px solid #f3f3f3;
            border-top: 6px solid #3498db;
            border-radius: 50%;
            animation: spin 1s linear infinite;
            margin: 0 auto;
        }

        @keyframes spin {
            0% { transform: rotate(0deg); }
            100% { transform: rotate(360deg); }
        }
    </style>
</head>
<body>
<c:import url="./header.jsp" />

<main>
    <section class="vag-section">
        <div class="container">
            <div class="row justify-content-center mb-5">
                <div class="col-md-10">
                    <h2 class="mb-3 text-center">Checkout</h2>
                    <div id="unavailableArtworks" class="alert alert-danger vag-card-container" style="display:none;"></div>
                    <div class="card vag-card-container p-4" style="background-color: whitesmoke;">
                        <h3 class="mb-3">Order Summary</h3>
                        <table class="table">
                            <thead>
                                <tr>
                                    <th scope="col">Artwork</th>
                                    <th scope="col">Title</th>
                                    <th scope="col" class="text-end">Price</th>
                                </tr>
                            </thead>
                            <tbody>
                                <c:forEach var="artwork" items="${cart}">
                                    <tr>
                                        <td><img src="${pageContext.request.contextPath}/artwork/${artwork.image}" class="img-fluid rounded" style="max-width: 30px;"></td>
                                        <td>${artwork.title}</td>
                                        <td class="text-end">$${artwork.price}</td>
                                    </tr>
                                </c:forEach>
                            </tbody>
                        </table>
                        <div class="text-end mb-3">
                            <h3>Total: $<span>${total}</span></h3>
                        </div>
                    </div>
                    <div class="card vag-card-container p-4 mt-4" style="background-color: whitesmoke;">
                        <form id="paymentForm">
                            <div id="cardElement">
                                <!-- Stripe element inserted here -->
                            </div>
                            <button class="btn vag-btn-tan mt-3 w-100" id="submit">Pay</button>
                            <div id="cardErrors" role="alert" class="mt-3 text-center text-danger"></div>
                        </form>
                        <div id="paymentSuccess" style="display: none;" class="mt-3 text-center text-success">
                            <p>Payment Succeeded! Thank you for your purchase.</p>
                            <p>You will now be redirected back to the Home Page in 5 seconds...</p>
                        </div>
                        <div id="paymentFailed" style="display: none;" class="mt-3 text-center text-danger">
                            <p>Payment Failed. Please try again.</p>
                        </div>
                        <div class="spinner" id="spinner"></div>
                    </div>
                    <div class="mt-3 text-center">
                        <a id="backToCartBtn" href="${pageContext.request.contextPath}/cart" class="btn btn-secondary">Back to Cart</a>
                    </div>
                </div>
            </div>
        </div>
    </section>
</main>

<c:import url="./footer.jsp" />
</body>
</html>
