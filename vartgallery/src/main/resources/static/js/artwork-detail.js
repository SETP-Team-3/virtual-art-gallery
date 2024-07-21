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
        $.post("/add-to-cart", { artworkId: artworkId }, function(response) {
            if (response.success) {
                alert("Artwork added to cart!");
            } else {
                alert("Failed to add artwork to cart.");
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
