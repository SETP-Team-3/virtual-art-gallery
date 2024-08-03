const manageArtworksManager = {
    init: function() {
        this.setupEventListeners();
    },

    setupEventListeners: function() {
        this.setupViewButtonClickEvent();
        this.setupDeleteButtonClickEvent();
    },

    setupViewButtonClickEvent: function() {
        $('.vag-btn-viewartwork').on('click', function() {
            const artworkId = $(this).data('artwork-id');
            manageArtworksManager.fetchArtworkDetails(artworkId);
        });
    },

    setupDeleteButtonClickEvent: function() {
        $('.vag-btn-deleteartwork').on('click', function() {
            const artworkId = $(this).data('artwork-id');
            if (confirm('Are you sure you want to delete this artwork?')) {
                manageArtworksManager.deleteArtwork(artworkId);
            }
        });
    },

    fetchArtworkDetails: function(artworkId) {
        $.ajax({
            url: `${contextPath}/admin/artwork-details`,
            method: 'GET',
            data: { artworkId: artworkId },
            success: function(response) {
                manageArtworksManager.populateArtworkDetailsModal(response);
                $('#artworkModal').modal('show');
            },
            error: function() {
                alert('Failed to fetch artwork details');
            }
        });
    },

    deleteArtwork: function(artworkId) {
        $.ajax({
            url: `${contextPath}/admin/delete-artwork`,
            method: 'POST',
            data: { artworkId: artworkId },
            success: function(response) {
                location.reload();
            },
            error: function() {
                alert('Failed to delete artwork.');
            }
        });
    },

    populateArtworkDetailsModal: function(artwork) {
        let genres = artwork.genres.map(genre => genre.name).join(', ');

        let htmlContent = `
            <div class="container">
                <p>
                    <strong>ID: ${artwork.id}</strong><br />
                    Title: ${artwork.title}<br />
                    Artist Email: ${artwork.artistId.email}<br />
                    Buyer Email: ${artwork.buyerId ? artwork.buyerId.email : 'N/A'}<br />
                    Price: $${artwork.price}<br />
                    Status: ${artwork.status}<br />
                    Genres: ${genres}<br />
                    Description: ${artwork.description}<br />
                    Created At: ${artwork.createdAt}<br />
                    Updated At: ${artwork.updatedAt}
                </p>
            </div>`;

        $('#artworkDetails').html(htmlContent);
    }
};

$(document).ready(function() {
    manageArtworksManager.init();
});
