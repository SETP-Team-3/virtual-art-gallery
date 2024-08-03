const manageUsersManager = {
    init: function() {
        this.setupEventListeners();
    },

    setupEventListeners: function() {
        this.setupViewButtonClickEvent();
        this.setupDeleteButtonClickEvent();
    },

    setupViewButtonClickEvent: function() {
        $('.vag-btn-viewuser').on('click', function() {
            const userId = $(this).data('user-id');
            manageUsersManager.fetchUserDetails(userId);
        });
    },

    setupDeleteButtonClickEvent: function() {
        $('.vag-btn-deleteuser').on('click', function() {
            const userId = $(this).data('user-id');
            if (confirm('Are you sure you want to delete this user?')) {
                manageUsersManager.deleteUser(userId);
            }
        });
    },

    fetchUserDetails: function(userId) {
        $.ajax({
            url: `${contextPath}/admin/user-details`,
            method: 'GET',
            data: { userId: userId },
            success: function(response) {
                manageUsersManager.populateUserDetailsModal(response);
                $('#userModal').modal('show');
            },
            error: function() {
                alert('Failed to fetch user details');
            }
        });
    },

    deleteUser: function(userId) {
        $.ajax({
            url: `${contextPath}/admin/delete-user`,
            method: 'POST',
            data: { userId: userId },
            success: function(response) {
                location.reload();
            },
            error: function() {
                alert('Failed to delete user.');
            }
        });
    },

    populateUserDetailsModal: function(user) {
        let htmlContent = `
            <div class="container">
                <p>
                    <strong>ID: ${user.id}</strong><br />
                    Name: ${user.name}<br />
                    Email: ${user.email}<br />
                    Role: ${user.role}<br />
                    Description: ${user.description || 'N/A'}<br />
                    Address: ${user.address || 'N/A'}<br />
                    Phone: ${user.phone || 'N/A'}
                </p>
            </div>`;

        $('#userDetails').html(htmlContent);
    }
};

$(document).ready(function() {
    manageUsersManager.init();
});