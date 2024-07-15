<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>Admin Dashboard</title>
</head>
<body>
<h1>Admin Dashboard</h1>
<h2>All Artworks</h2>
<table border="1">
    <tr>
        <th>Title</th>
        <th>Description</th>
        <th>Artist</th>
        <th>Price</th>
    </tr>
    <c:forEach var="artwork" items="${artworks}">
        <tr>
            <td>${artwork.title}</td>
            <td>${artwork.description}</td>
            <td>${artwork.artistId.name}</td>
            <td>${artwork.price}</td>
        </tr>
    </c:forEach>
</table>
<a href="/admin/logout">Logout</a>
</body>
</html>
