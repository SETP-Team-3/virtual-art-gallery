const signupManager = {
    init: function() {
        this.setupEventListeners();
        this.initializeTooltips();
    },

    setupEventListeners: function() {
        $('[data-bs-toggle="tooltip"]').tooltip();
        
        $('#role').change(function() {
            signupManager.handleRoleChange();
        });

        $('#signupForm').submit(function(event) {
            event.preventDefault();
            signupManager.handleFormSubmit();
        });
    },

    initializeTooltips: function() {
        $('[title]').tooltip();
    },

    handleRoleChange: function() {
        var role = $('#role').val();
        if (role === 'artist') {
            $('#artistFields').removeClass('d-none');
            $('#buyerFields').addClass('d-none');
        } else if (role === 'buyer') {
            $('#artistFields').addClass('d-none');
            $('#buyerFields').removeClass('d-none');
        } else {
            $('#artistFields').addClass('d-none');
            $('#buyerFields').addClass('d-none');
        }
    },

    handleFormSubmit: function() {
        let password = $('#password').val();
        let confirmPassword = $('#confirmPassword').val();
        if (password !== confirmPassword) {
            alert('Passwords do not match. Please try again');
            return;
        }

        let formData = new FormData();
        formData.append('name', $('#name').val());
        formData.append('email', $('#email').val());
        formData.append('password', password);
        formData.append('role', $('#role').val());
        formData.append('portfolio', $('#portfolio').val());
        formData.append('biography', $('#biography').val());
        formData.append('reason', $('#reason').val());
        formData.append('portrait', $('#portrait')[0].files[0]);
        formData.append('address', $('#address').val());
        formData.append('phone', $('#phone').val());
        formData.append('genre_ids', $('#userGenres').val());

        $.ajax({
            type: 'POST',
            url: `${contextPath}/signup/submit`,
            data: formData,
            processData: false,
            contentType: false,
            success: function(response) {
                if (response.status === 'success') {
                    $('#signupForm').hide();
                    $('#submissionAcknowledgement').removeClass('d-none');
                } else {
                    alert('Error: ' + response.error);
                }
            },
            error: function() {
                alert('An error occurred. Please try again');
            }
        });
    }
};

$(document).ready(function() {
    signupManager.init();
});
