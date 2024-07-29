const loginManager = {
    init: function() {
        this.setupEventListeners();
    },

    setupEventListeners: function() {
        $('#loginButton').click(function() {
            loginManager.handleLogin();
        });
    },

    handleLogin: function() {
        $.ajax({
            type: 'POST',
            url: `${contextPath}/admin/login`,
            data: {
                loginEmail: $('#loginEmail').val(),
                loginPassword: $('#loginPassword').val()
            },
            success: function(response) {
                if (response.status === 'success') {
                    setTimeout(() => {
                        window.location.href = `${contextPath}/admin/dashboard`;
                    }, 100);
                } else {
                    $('#loginErrorMessage').text(response.error);
                    $('#loginError').show();
                }
            },
            error: function(jqXHR) {
                let errorMessage = 'An error occurred. Please try again.';
                if (jqXHR.responseJSON && jqXHR.responseJSON.error) {
                    errorMessage = jqXHR.responseJSON.error;
                }
                $('#loginErrorMessage').text(errorMessage);
                $('#loginError').show();
            }
        });
    }
};

$(document).ready(function() {
    loginManager.init();
});
