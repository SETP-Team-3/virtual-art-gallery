<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <c:import url="./adminmeta.jsp" />
    <script src="${pageContext.request.contextPath}/js/manage-users.js"></script>
</head>
<body>
<!-- View User Modal -->
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

<!-- Create User Modal -->
<div class="modal fade" id="createUserModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="createUserModalLabel">Create User</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form id="createUserForm">
                    <div class="mb-3">
                        <label for="createEmail" class="form-label">Email <span class="text-danger">*</span></label>
                        <input type="email" class="form-control" id="createEmail" name="email" required>
                    </div>
                    <div class="mb-3">
                        <label for="createPassword" class="form-label">Password <span class="text-danger">*</span></label>
                        <input type="password" class="form-control" id="createPassword" name="password" required>
                    </div>
                    <div class="mb-3">
                        <label for="createRole" class="form-label">Role <span class="text-danger">*</span></label>
                        <select class="form-control" id="createRole" name="role" required>
                            <option value="buyer">Buyer</option>
                            <option value="artist">Artist</option>
                            <option value="admin">Admin</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="createName" class="form-label">Name <span class="text-danger">*</span></label>
                        <input type="text" class="form-control" id="createName" name="name" required>
                    </div>
                    <div class="mb-3">
                        <label for="createDescription" class="form-label">Description</label>
                        <textarea class="form-control" id="createDescription" name="description"></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="createPortrait" class="form-label">Profile Picture <span class="text-danger">*</span></label>
                        <input type="file" class="form-control" id="createPortrait" name="portrait" accept="image/*" required>
                    </div>
                    <div class="mb-3">
                        <label for="createAddress" class="form-label">Address</label>
                        <input type="text" class="form-control" id="createAddress" name="address">
                    </div>
                    <div class="mb-3">
                        <label for="createPhone" class="form-label">Phone</label>
                        <input type="text" class="form-control" id="createPhone" name="phone">
                    </div>
                    <button type="submit" class="btn btn-primary">Create User</button>
                </form>
            </div>
        </div>
    </div>
</div>

<!-- Edit User Modal -->
<div class="modal fade" id="editUserModal" tabindex="-1">
    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="editUserModalLabel">Edit User</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <form id="editUserForm">
                    <input type="hidden" id="editUserId" name="id">
                    <div class="mb-3">
                        <label for="editEmail" class="form-label">Email</label>
                        <input type="email" class="form-control" id="editEmail" name="email" required>
                    </div>
                    <div class="mb-3">
                        <label for="editPassword" class="form-label">Password</label>
                        <input type="password" class="form-control" id="editPassword" name="password">
                    </div>
                    <div class="mb-3">
                        <label for="editRole" class="form-label">Role</label>
                        <select class="form-control" id="editRole" name="role" required>
                            <option value="buyer">Buyer</option>
                            <option value="artist">Artist</option>
                            <option value="admin">Admin</option>
                        </select>
                    </div>
                    <div class="mb-3">
                        <label for="editName" class="form-label">Name</label>
                        <input type="text" class="form-control" id="editName" name="name" required>
                    </div>
                    <div class="mb-3">
                        <label for="editDescription" class="form-label">Description</label>
                        <textarea class="form-control" id="editDescription" name="description"></textarea>
                    </div>
                    <div class="mb-3">
                        <label for="editPortrait" class="form-label">Profile Picture</label>
                        <input type="file" class="form-control" id="editPortrait" name="portrait" accept="image/*">
                    </div>
                    <div class="mb-3">
                        <label for="editAddress" class="form-label">Address</label>
                        <input type="text" class="form-control" id="editAddress" name="address">
                    </div>
                    <div class="mb-3">
                        <label for="editPhone" class="form-label">Phone</label>
                        <input type="text" class="form-control" id="editPhone" name="phone">
                    </div>
                    <button type="submit" class="btn btn-primary">Save Changes</button>
                </form>
            </div>
        </div>
    </div>
</div>


<c:import url="./adminheader.jsp" />

<main>
    <section class="vag-section">
        <div class="container">
            <h2 class="mb-3">Manage Users</h2>
            <button class="btn btn-success mb-3" data-bs-toggle="modal" data-bs-target="#createUserModal">Create User</button>
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
                            <td class="d-flex">
                                <button type="button" class="btn btn-secondary flex-fill me-1 vag-btn-viewuser" data-user-id="${user.id}">View</button>
                                <button type="button" class="btn btn-primary flex-fill me-1 vag-btn-edituser" data-user-id="${user.id}" data-bs-toggle="modal" data-bs-target="#editUserModal">Edit</button>
                                <button type="button" class="btn btn-danger flex-fill vag-btn-deleteuser" data-user-id="${user.id}">Delete</button>
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
