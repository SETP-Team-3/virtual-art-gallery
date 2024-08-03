<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <c:import url="./adminmeta.jsp" />
    <script src="${pageContext.request.contextPath}/js/manage-transactions.js"></script>
</head>
<body>
<div class="modal fade" id="transactionModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="transactionModalLabel">Transaction Details</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div id="transactionDetails"></div>
            </div>
        </div>
    </div>
</div>
<c:import url="./adminheader.jsp" />

<main>
    <section class="vag-section">
        <div class="container">
            <h2 class="mb-3">Manage Transactions</h2>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Transaction ID</th>
                        <th>User ID</th>
                        <th>Date</th>
                        <th>Total Amount</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="transaction" items="${transactions}">
                        <tr>
                            <td>${transaction[0]}</td>
                            <td>${transaction[1]}</td>
                            <td>${transaction[2]}</td>
                            <td>$${transaction[3]}</td>
                            <td>
                                <button type="button" class="btn btn-primary w-100 mb-2 vag-btn-tan vag-btn-viewtransaction" data-transaction-id="${transaction[0]}">View</button>
                            </td>
                        </tr>
                    </c:forEach>
                </tbody>
            </table>
        </div>
    </section>
</main>

<c:import url="./adminfooter.jsp" />
</body>
</html>
