<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="modal fade" id="uploadArtworkModal" tabindex="-1">
    <script src="${pageContext.request.contextPath}/js/multiselect-dropdown.js"></script>
    <script src="${pageContext.request.contextPath}/js/my-artworks-modal-uploadartwork.js"></script>
    <style>
        .multiselect-dropdown {
            border-radius: 6px !important;
            width: 100% !important;
            padding: .23rem .75rem !important;
        }
    </style>

    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="uploadArtworkModalLabel">Upload Artwork</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="row mb-4">
                    <div class="col-12 mb-4">
                        <label for="artworkTitle" class="form-label">Title</label>
                        <input type="text" id="artworkTitle" class="form-control" required>
                    </div>
                    <div class="col-12 mb-4">
                        <label for="artworkGenres" class="form-label" style="display: block;">Genres</label>
                        <select id="artworkGenres" class="form-control" multiple multiselect-search="true">
                            <c:forEach var="genre" items="${genres}">
                                <option value="${genre.id}">${genre.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="col-12 mb-4">
                        <label for="artworkDescription" class="form-label">Description</label>
                        <textarea class="form-control" id="artworkDescription" rows="3" required></textarea>
                    </div>
                    <div class="col-12 mb-4">
                        <label for="artworkPrice" class="form-label">Price</label>
                        <input type="number" class="form-control" id="artworkPrice" step="0.01" min="0.00" max="50000.00" required>
                    </div>
                    <div class="col-12">
                        <label for="artworkImage" class="form-label">Upload Artwork</label>
                        <input type="file" class="form-control" id="artworkImage" accept="image/*" required>
                    </div>
                    <div class="col-12 d-flex justify-content-center text-danger" id="uploadError" style="display: none;">
                        <p id="uploadErrorMessage"></p>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" id="uploadArtworkBtn" class="btn vag-btn-tan">Upload</button>
            </div>
        </div>
    </div>
</div>
