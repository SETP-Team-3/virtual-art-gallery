const headerManager = {
    init: function() {
        this.setupEventListeners();
    },

    setupEventListeners: function() {
        $('#signinButton').click(function() {
            headerManager.handleSignin();
        });

        $('#signoutButton').click(function() {
            headerManager.handleSignout();
        });

        $('#myProfileButton').click(function() {
            window.location.href = `${contextPath}/my-profile`;
        });

        $('#myTransactionsButton').click(function() {
            window.location.href = `${contextPath}/my-transactions`;
        });

        $('#myArtworksButton').click(function() {
            window.location.href = `${contextPath}/my-artworks`;
        });
    },

    handleSignin: function() {
        $.ajax({
            type: 'POST',
            url: `${contextPath}/sign/in`,
            data: {
                signinEmail: $('#signinEmail').val(),
                signinPassword: $('#signinPassword').val()
            },
            success: function(response) {
                if (response.status === 'success') {
                    $('#signinModal').hide();
                    setTimeout(() => {
                        window.location.href = `${contextPath}/`;
                    }, 500);
                } else {
                    $('#signinErrorMessage').text(response.error);
                    $('#signinError').show();
                }
            },
            error: function(jqXHR) {
                let errorMessage = 'An error occurred. Please try again.';
                if (jqXHR.responseJSON && jqXHR.responseJSON.error) {
                    errorMessage = jqXHR.responseJSON.error;
                }
                $('#signinErrorMessage').text(errorMessage);
                $('#signinError').show();
            }
        });
    },

    handleSignout: function() {
        $.ajax({
            type: 'POST',
            url: `${contextPath}/sign/out`,
            success: function(response) {
                if (response.status === 'success') {
                    $('#userMenuModal').hide();
                    setTimeout(() => {
                        window.location.href = `${contextPath}/`;
                    }, 500);
                }
            },
            error: function() {
                alert('Signout failed');
            }
        });
    }
};

$(document).ready(function() {
    headerManager.init();
});
