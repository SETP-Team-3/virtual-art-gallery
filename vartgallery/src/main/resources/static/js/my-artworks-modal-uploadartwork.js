const myArtworksModalUploadArtworkManager = {
    init: function() {
        this.setupEventListeners();
    },

    setupEventListeners: function() {
        $('#uploadArtworkBtn').click(function() {
            myArtworksModalUploadArtworkManager.handleUpload();
        });
    },

    handleUpload: function() {
        let formData = new FormData();
        formData.append('title', $('#artworkTitle').val());
        formData.append('genres', $('#artworkGenres').val());
        formData.append('description', $('#artworkDescription').val());
        formData.append('price', $('#artworkPrice').val());
        formData.append('image', $('#artworkImage')[0].files[0]);

        $.ajax({
            type: 'POST',
            url: `${contextPath}/my-artworks/upload`,
            data: formData,
            processData: false,
            contentType: false,
            cache: false,
            success: function(response) {
                if (response.status === 'success') {
                    $('#uploadArtworkModal').hide();
                    setTimeout(() => {
                        window.location.href = `${contextPath}/my-artworks`;
                    }, 100);
                } else {
                    $('#uploadErrorMessage').text(response.error);
                    $('#uploadError').show();
                }
            },
            error: function() {
                $('#uploadErrorMessage').text('An error occurred. Please try again.');
                $('#uploadError').show();
            }
        });
    }
};

$(document).ready(function() {
    myArtworksModalUploadArtworkManager.init();
});
