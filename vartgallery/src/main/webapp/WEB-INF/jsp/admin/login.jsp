<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <c:import url="./adminmeta.jsp" />
    <script src="${pageContext.request.contextPath}/js/login.js"></script>
    <style>
        body.vag-login {
            min-height: 100vh;
            display: flex;
            align-items: center;
            justify-content: center;
            background-color: whitesmoke;
            margin: 0;
        }

        body.vag-login main {
            display: flex;
            align-items: center;
            justify-content: center;
            width: 100%;
        }

        .vag-login-container {
            background-color: white;
            border: 1px solid #dee2e6;
            padding: 2rem;
            border-radius: 5px;
            box-shadow: 0 0.125rem 0.25rem rgba(0, 0, 0, 0.075);
            max-width: 400px;
            width: 100%;
        }

        .vag-login-container .btn {
            width: 100%;
        }
    </style>
</head>
<body class="vag-login">

<main>
    <div class="vag-login-container">
        <form action="${pageContext.request.contextPath}/admin/login" method="post">
            <div class="mb-3">
                <label for="loginEmail" class="form-label">Email</label>
                <input type="email" class="form-control" id="loginEmail" name="loginEmail" placeholder="Enter your email">
            </div>
            <div class="mb-4">
                <label for="loginPassword" class="form-label">Password</label>
                <input type="password" class="form-control" id="loginPassword" name="loginPassword" placeholder="Enter your password">
            </div>
            <div class="mb-3">
                <button type="button" class="btn vag-btn-tan w-100" id="loginButton">Login</button>
            </div>
            <div class="d-flex justify-content-center text-danger" id="loginError" style="display: none;">
                <p id="loginErrorMessage"></p>
            </div>
        </form>
    </div>
</main>
</body>
</html>
