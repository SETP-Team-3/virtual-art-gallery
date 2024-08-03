const galleryManager = {
    init: function() {
        this.setupEventListeners();
    },

    setupEventListeners: function() {
        galleryManager.setupArtworkCardClickEvent();
        galleryManager.setupArtistCardClickEvent();
    },

    setupArtworkCardClickEvent: function() {
        $('.artwork-card').click(function() {
            const artworkId = $(this).data('id');
            window.location.href = `${contextPath}/artwork-detail?id=${artworkId}`;
        });
    },

    setupArtistCardClickEvent: function() {
        $('.artist-card').click(function() {
            const artistId = $(this).data('artist-id');
            window.location.href = `${contextPath}/artist-detail?id=${artistId}`;
        });
    }
};

$(document).ready(function() {
    galleryManager.init();
});
