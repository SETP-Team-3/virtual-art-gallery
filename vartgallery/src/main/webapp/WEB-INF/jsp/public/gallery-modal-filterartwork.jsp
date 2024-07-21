<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<div class="modal fade" id="artworkFilterModal" tabindex="-1">
    <link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/15.5.1/nouislider.min.css">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/noUiSlider/15.5.1/nouislider.min.js"></script>
    <script src="${pageContext.request.contextPath}/js/gallery-modal-filterartwork.js"></script>
    <style>
        .noUi-target {
            width: 100%;
        }

        .noUi-connect {
            background: #9f8b70;
        }

        .multiselect-dropdown {
            border-radius: 6px !important;
            width: 100% !important;
            padding: .23rem .75rem !important;
        }

        .vag-pricerange-container {
            display: block;
        }

        .vag-pricerange-container label,
        .vag-pricerange-container input {
            display: block;
            width: 100%;
        }
    </style>

    <div class="modal-dialog">
        <div class="modal-content">
            <div class="modal-header">
                <h5 class="modal-title" id="artworkFilterModalLabel">Filter Artworks</h5>
                <button type="button" class="btn-close" data-bs-dismiss="modal"></button>
            </div>
            <div class="modal-body">
                <div class="row mb-4">
                    <div class="col-12 mb-4">
                        <label for="artworkTitle" class="form-label">Filter by Artwork Title</label>
                        <input type="text" id="artworkTitle" class="form-control" placeholder="Enter artwork title">
                    </div>
                    <div class="col-12 mb-4">
                        <label for="artworkArtist" class="form-label">Filter by Artist Name</label>
                        <input type="text" id="artworkArtist" class="form-control" placeholder="Enter artist name">
                    </div>
                    <div class="col-12 mb-4">
                        <div class="vag-pricerange-container">
                            <label class="mb-3">Price Range: <span id="priceRangeValue">$0 - $50,000</span></label>
                            <div id="artworkPriceRange"></div>
                        </div>
                    </div>
                    <div class="col-12">
                        <label for="artworkGenre" class="form-label" style="display: block;">Select artwork genre</label>
                        <select id="artworkGenre" class="form-control" multiple multiselect-search="true">
                            <c:forEach var="genre" items="${genres}">
                                <option value="${genre.id}">${genre.name}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>
            </div>
            <div class="modal-footer">
                <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
                <button type="button" id="filterArtworkBtn" class="btn vag-btn-tan">Apply Filters</button>
            </div>
        </div>
    </div>
</div>
