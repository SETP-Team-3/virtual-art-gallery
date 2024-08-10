const myArtworksModalUploadArtworkManager = {
    init: function() {
        this.setupEventListeners();
        this.uploadSuccess = false;
    },

    setupEventListeners: function() {
        $('#uploadArtworkBtn').click(function() {
            myArtworksModalUploadArtworkManager.handleUpload();
        });

        $('#uploadArtworkModal').on('hide.bs.modal', function() {
            if (myArtworksModalUploadArtworkManager.uploadSuccess) {
                window.location.href = `${contextPath}/my-artworks`;
            }
        });

        $('#uploadArtworkModal').on('show.bs.modal', function() {
            myArtworksModalUploadArtworkManager.resetModal();
        });
    },

    handleUpload: function() {
        // Validate form inputs
        let title = $('#artworkTitle').val();
        let description = $('#artworkDescription').val();
        let dimension = $('#artworkDimension').val();
        let price = $('#artworkPrice').val();
        let image = $('#artworkImage')[0].files[0];

        if (!title || !description || !dimension || !price || !image) {
            $('#uploadErrorMessage').text('All fields except for genres are required');
            $('#uploadError').show();
            return;
        }

        // Hide error message if all inputs are valid
        $('#uploadError').hide();

        let formData = new FormData();
        formData.append('title', title);
        formData.append('genres', $('#artworkGenres').val());
        formData.append('description', description);
        formData.append('dimension', dimension);
        formData.append('price', price);
        formData.append('image', image);

        $.ajax({
            type: 'POST',
            url: `${contextPath}/my-artworks/upload`,
            data: formData,
            processData: false,
            contentType: false,
            cache: false,
            success: function(response) {
                if (response.status === 'success') {
                    $('#uploadForm').hide();
                    $('#uploadArtworkBtn').hide();
                    $('#uploadSuccessMessage').show();
                    myArtworksModalUploadArtworkManager.uploadSuccess = true;
                } else {
                    $('#uploadErrorMessage').text(response.error);
                    $('#uploadError').show();
                }
            },
            error: function() {
                $('#uploadErrorMessage').text('An error occurred. Please try again');
                $('#uploadError').show();
            }
        });
    },

    resetModal: function() {
        $('#uploadForm').show();
        $('#uploadArtworkBtn').show();
        $('#uploadSuccessMessage').hide();
        $('#uploadError').hide();
        $('#artworkTitle').val('');
        $('#artworkGenres').val([]);
        $('#artworkDescription').val('');
        $('#artworkDimension').val('');
        $('#artworkPrice').val('');
        $('#artworkImage').val('');
        this.uploadSuccess = false;
    }
};

$(document).ready(function() {
    myArtworksModalUploadArtworkManager.init();
});
