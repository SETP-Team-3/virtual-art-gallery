<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="modal fade" id="artistFilterModal" tabindex="-1">
    <script src="${pageContext.request.contextPath}/js/gallery-modal-filterartist.js"></script>
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
                <h5 class="modal-title" id="artistFilterModalLabel">Filter Artists</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="row mb-4">
                    <div class="col-12 mb-4">
                        <label for="artistName" class="form-label">Filter by Artist Name</label>
                        <input type="text" id="artistName" class="form-control" placeholder="Enter artist name">
                    </div>
                    <div class="col-12">
                        <label for="artistGenre" class="form-label" style="display: block;">Select artist genre</label>
                        <select id="artistGenre" class="form-control" multiple multiselect-search="true">
                            <c:forEach var="genre" items="${genres}">
                                <option value="${genre.id}">${genre.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" id="filterArtistBtn" class="btn vag-btn-tan">Apply Filters</button>
            </div>
        </div>
    </div>
</div>
