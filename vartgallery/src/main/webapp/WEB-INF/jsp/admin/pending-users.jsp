<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <c:import url="./adminmeta.jsp" />
    <script src="${pageContext.request.contextPath}/js/pending-users.js"></script>
</head>
<body>
<c:import url="./adminheader.jsp" />

<main>
    <section class="vag-section">
        <div class="container">
            <h2 class="mb-3">Pending User Signups</h2>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>Email</th>
                        <th>Role</th>
                        <th>Name</th>
                        <th>Description</th>
                        <th>Portfolio</th>
                        <th>Portrait</th>
                        <th>Address</th>
                        <th>Phone</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="pendingUser" items="${pendingUsers}">
                        <tr>
                            <td>${pendingUser.email}</td>
                            <td>${pendingUser.role}</td>
                            <td>${pendingUser.name}</td>
                            <td>${pendingUser.description}</td>
                            <td>${pendingUser.portfolio}</td>
                            <td><img src="${pageContext.request.contextPath}/portrait/${pendingUser.portrait}" width="100" alt=""/></td>
                            <td>${pendingUser.address}</td>
                            <td>${pendingUser.phone}</td>
                            <td>
                                <button type="button" class="btn btn-success w-100 mb-2 vag-btn-approve" data-id="${pendingUser.id}">Approve</button>
                                <button type="button" class="btn btn-danger w-100 vag-btn-reject" data-id="${pendingUser.id}">Reject</button>
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
