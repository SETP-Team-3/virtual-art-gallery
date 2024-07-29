const adminHeaderManager = {
    init: function() {
        this.setupEventListeners();
    },

    setupEventListeners: function() {
        $('#logoutButton').click(function() {
            adminHeaderManager.handleLogout();
        });
    },

    handleLogout: function() {
        $.ajax({
            type: 'POST',
            url: `${contextPath}/admin/logout`,
            success: function(response) {
                if (response.status === 'success') {
                    $('#accountModal').hide();
                    setTimeout(() => {
                        window.location.href = `${contextPath}/admin/login`;
                    }, 500);
                }
            },
            error: function() {
                alert('Logout failed');
            }
        });
    }
};

$(document).ready(function() {
    adminHeaderManager.init();
});
