<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <c:import url="./adminmeta.jsp" />
    <script src="${pageContext.request.contextPath}/js/manage-users.js"></script>
</head>
<body>
<div class="modal fade" id="userModal" tabindex="-1">
    <div class="modal-dialog modal-lg">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="userModalLabel">User Details</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div id="userDetails"></div>
            </div>
        </div>
    </div>
</div>
<c:import url="./adminheader.jsp" />

<main>
    <section class="vag-section">
        <div class="container">
            <h2 class="mb-3">Manage Users</h2>
            <table class="table table-bordered">
                <thead>
                    <tr>
                        <th>ID</th>
                        <th>Name</th>
                        <th>Email</th>
                        <th>Role</th>
                        <th>Actions</th>
                    </tr>
                </thead>
                <tbody>
                    <c:forEach var="user" items="${users}">
                        <tr>
                            <td>${user.id}</td>
                            <td>${user.name}</td>
                            <td>${user.email}</td>
                            <td>${user.role}</td>
                            <td>
                                <button type="button" class="btn btn-secondary w-100 mb-2 vag-btn-viewuser" data-user-id="${user.id}">View</button>
                                <button type="button" class="btn btn-danger w-100 vag-btn-deleteuser" data-user-id="${user.id}">Delete</button>
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
