<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Login</title>
</head>
<body>
<h1>Admin Login</h1>
<form method="post" action="/admin/login">
    <div>
        <label>Email:</label>
        <input type="text" name="username"/>
    </div>
    <div>
        <label>Password:</label>
        <input type="password" name="password"/>
    </div>
    <div>
        <button type="submit">Login</button>
    </div>
</form>
</body>
</html>
