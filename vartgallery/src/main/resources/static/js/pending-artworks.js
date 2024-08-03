const pendingArtworksManager = {
    init: function() {
        this.setupEventListeners();
    },

    setupEventListeners: function() {
        $('.vag-btn-approve').click(function() {
            const pendingArtworkId = $(this).data('id');
            pendingArtworksManager.handleApprove(pendingArtworkId);
        });

        $('.vag-btn-reject').click(function() {
            const pendingArtworkId = $(this).data('id');
            pendingArtworksManager.handleReject(pendingArtworkId);
        });
    },

    handleApprove: function(artworkId) {
        $.ajax({
            type: 'POST',
            url: `${contextPath}/admin/approve-artwork`,
            data: { artworkId: artworkId },
            success: function(response) {
                if (response.status === 'success') {
                    location.reload();
                } else {
                    alert('Error approving artwork: ' + response.error);
                }
            },
            error: function() {
                alert('An error occurred. Please try again');
            }
        });
    },

    handleReject: function(artworkId) {
        $.ajax({
            type: 'POST',
            url: `${contextPath}/admin/reject-artwork`,
            data: { artworkId: artworkId },
            success: function(response) {
                if (response.status === 'success') {
                    location.reload();
                } else {
                    alert('Error rejecting artwork: ' + response.error);
                }
            },
            error: function() {
                alert('An error occurred. Please try again');
            }
        });
    }
};

$(document).ready(function() {
    pendingArtworksManager.init();
});
