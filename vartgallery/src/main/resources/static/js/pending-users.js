const pendingUsersManager = {
    init: function() {
        this.setupEventListeners();
    },

    setupEventListeners: function() {
        $('.vag-btn-approve').click(function() {
            const pendingUsersId = $(this).data('id');
            pendingUsersManager.handleApprove(pendingUsersId);
        });

        $('.vag-btn-reject').click(function() {
            const pendingUsersId = $(this).data('id');
            pendingUsersManager.handleReject(pendingUsersId);
        });
    },

    handleApprove: function(userId) {
        $.ajax({
            type: 'POST',
            url: `${contextPath}/admin/approve-user`,
            data: { userId: userId },
            success: function(response) {
                if (response.status === 'success') {
                    location.reload();
                } else {
                    alert('Error approving user: ' + response.error);
                }
            },
            error: function() {
                alert('An error occurred. Please try again');
            }
        });
    },

    handleReject: function(userId) {
        $.ajax({
            type: 'POST',
            url: `${contextPath}/admin/reject-user`,
            data: { userId: userId },
            success: function(response) {
                if (response.status === 'success') {
                    location.reload();
                } else {
                    alert('Error rejecting user: ' + response.error);
                }
            },
            error: function() {
                alert('An error occurred. Please try again.');
            }
        });
    }
};

$(document).ready(function() {
    pendingUsersManager.init();
});
