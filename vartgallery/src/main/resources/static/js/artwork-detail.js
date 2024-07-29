const artworkDetailManager = {
    init: function() {
        this.setupEventListeners();
    },

    setupEventListeners: function() {
        $(document).on('click', '#btnAddCartArtwork', this.handleAddToCart.bind(this));
        $(document).on('click', '#btnLikeArtwork', this.handleToggleLike.bind(this));
    },

    handleAddToCart: function(event) {
        const artworkId = $(event.target).data('artworkId');
        this.addToCart(artworkId);
    },

    handleToggleLike: function(event) {
        const artworkId = $(event.target).data('artworkId');
        this.toggleLike(artworkId);
    },

    addToCart: function(artworkId) {
        $.ajax({
            type: 'POST',
            url: `${contextPath}/cart/add`,
            data: { artworkId: artworkId },
            success: function(response) {
                if (response.status === 'success') {
                    alert('Artwork added to cart successfully');
                    location.reload();
                } else {
                    alert(response.error);
                }
            },
            error: function() {
                alert('An error occurred while adding artwork to cart');
            }
        });
    },

    toggleLike: function(artworkId) {
        $.post("/toggle-like", { artworkId: artworkId }, function(response) {
            if (response.success) {
                let likeButton = $("#btnLikeArtwork");
                if (response.liked) {
                    likeButton.text("Unlike");
                } else {
                    likeButton.text("Like");
                }
            } else {
                alert("Failed to update like status.");
            }
        });
    }
};

$(document).ready(function() {
    artworkDetailManager.init();
});
