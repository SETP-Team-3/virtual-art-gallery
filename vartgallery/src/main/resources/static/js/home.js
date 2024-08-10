const homeManager = {
    init: function() {
        this.setupEventListeners();
    },

    setupEventListeners: function() {
        homeManager.setupArtworkCardClickEvent();
    },

    setupArtworkCardClickEvent: function() {
        $('.artwork-card').click(function() {
            const artworkId = $(this).data('id');
            window.location.href = `${contextPath}/artwork-detail?id=${artworkId}`;
        });
    }
};

$(document).ready(function() {
    homeManager.init();
});
