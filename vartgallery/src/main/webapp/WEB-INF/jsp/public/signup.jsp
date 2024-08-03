<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <c:import url="./meta.jsp" />
    <script src="${pageContext.request.contextPath}/js/multiselect-dropdown.js"></script>
    <script src="${pageContext.request.contextPath}/js/signup.js"></script>
    <style>
        .multiselect-dropdown {
            border-radius: 6px !important;
            width: 100% !important;
            padding: .23rem .75rem !important;
        }
    </style>
</head>
<body>
<c:import url="./header.jsp" />

<main>
    <section class="vag-section vag-section-tan">
        <div class="container">
            <div class="row justify-content-center mb-3">
                <div class="col-md-10 text-center">
                    <h2 class="mb-5">Join Us!</h2>
                    <p class="mb-4">Interested in joining our exclusive art community? Please fill out the form below. Your application will be reviewed, and we will contact you upon approval. Thank you for your patience and interest in high-quality, reputable art.</p>
                </div>
            </div>
        </div>
    </section>

    <section class="vag-section">
        <div class="container">
            <div class="row justify-content-center mb-3">
                <div class="col-md-10">
                    <form id="signupForm" enctype="multipart/form-data">
                        <div class="mb-3">
                            <label for="name" class="form-label">Name <span class="text-danger">*</span></label>
                            <input type="text" class="form-control" id="name" required>
                        </div>
                        <div class="mb-3">
                            <label for="email" class="form-label">Email <span class="text-danger">*</span></label>
                            <input type="email" class="form-control" id="email" required>
                        </div>
                        <div class="mb-3">
                            <label for="portrait" class="form-label">Profile Picture <span class="text-danger">*</span></label>
                            <input type="file" class="form-control" id="portrait" accept="image/*" required>
                        </div>
                        <div class="mb-3">
                            <label for="address" class="form-label">Address</label>
                            <textarea class="form-control" id="address" rows="3"></textarea>
                        </div>
                        <div class="mb-3">
                            <label for="phone" class="form-label">Phone</label>
                            <input type="text" class="form-control" id="phone">
                        </div>
                        <div class="mb-3">
                            <label for="password" class="form-label">Password <span class="text-danger">*</span></label>
                            <input type="password" class="form-control" id="password" required>
                        </div>
                        <div class="mb-3">
                            <label for="confirmPassword" class="form-label">Confirm Password <span class="text-danger">*</span></label>
                            <input type="password" class="form-control" id="confirmPassword" required>
                        </div>
                        <div class="mb-3">
                            <label for="role" class="form-label">I'm joining as <span class="text-danger">*</span></label>
                            <select class="form-control" id="role" required>
                                <option value="">Select</option>
                                <option value="artist">an artist</option>
                                <option value="buyer">a buyer</option>
                            </select>
                        </div>
                        <div id="artistFields" class="d-none">
                            <div class="mb-3">
                                <label for="portfolio" class="form-label">Portfolio Link <span class="tooltip-icon" data-bs-toggle="tooltip" title="Optional but will increase the chances of approval">ⓘ</span></label>
                                <input type="text" class="form-control" id="portfolio">
                            </div>
                            <div class="mb-3">
                                <label for="biography" class="form-label">Biography <span class="tooltip-icon" data-bs-toggle="tooltip" title="Optional but will increase the chances of approval">ⓘ</span></label>
                                <textarea class="form-control" id="biography" rows="3"></textarea>
                            </div>
                            <div class="mb-3">
                                <label for="userGenres" class="form-label" style="display: block;">Genres</label>
                                <select id="userGenres" class="form-control" multiple multiselect-search="true">
                                    <c:forEach var="genre" items="${genres}">
                                        <option value="${genre.id}">${genre.name}</option>
                                    </c:forEach>
                                </select>
                            </div>
                        </div>
                        <div id="buyerFields" class="d-none">
                            <div class="mb-3">
                                <label for="reason" class="form-label">Reason for Joining <span class="tooltip-icon" data-bs-toggle="tooltip" title="Optional but will increase the chances of approval">ⓘ</span></label>
                                <textarea class="form-control" id="reason" rows="3"></textarea>
                            </div>
                        </div>
                        <button type="submit" class="btn vag-btn-tan">Submit</button>
                    </form>
                    <div id="submissionAcknowledgement" class="d-none text-center mt-5">
                        <p class="text-success">Your signup request has been submitted successfully. We will review your application and contact you upon approval. Thank you for your patience!</p>
                    </div>
                </div>
            </div>
        </div>
    </section>
</main>

<c:import url="./footer.jsp" />
</body>
</html>
