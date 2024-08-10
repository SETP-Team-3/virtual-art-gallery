const manageUsersManager = {
    init: function() {
        this.setupEventListeners();
    },

    setupEventListeners: function() {
        this.setupViewButtonClickEvent();
        this.setupDeleteButtonClickEvent();
        this.setupCreateUserFormSubmitEvent();
        this.setupEditButtonClickEvent();
        this.setupEditUserFormSubmitEvent();
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

    setupCreateUserFormSubmitEvent: function() {
        $('#createUserForm').submit(function(event) {
            event.preventDefault();
            const formData = new FormData(this);

            $.ajax({
                url: `${contextPath}/admin/user`,
                type: 'POST',
                data: formData,
                processData: false,
                contentType: false,
                success: function() {
                    alert('User created successfully');
                    location.reload();
                },
                error: function(xhr) {
                    if (xhr.status === 409) {
                        alert('Email already exists');
                    } else {
                        alert('Error creating user');
                    }
                }
            });
        });
    },

    setupEditButtonClickEvent: function() {
        $('.vag-btn-edituser').on('click', function() {
            const userId = $(this).data('user-id');
            $.ajax({
                url: `${contextPath}/admin/user/${userId}`,
                type: 'GET',
                success: function(user) {
                    $('#editUserId').val(user.id);
                    $('#editEmail').val(user.email);
                    $('#editRole').val(user.role);
                    $('#editName').val(user.name);
                    $('#editDescription').val(user.description);
                    $('#editAddress').val(user.address);
                    $('#editPhone').val(user.phone);
                },
                error: function() {
                    alert('Error fetching user details');
                }
            });
        });
    },

    setupEditUserFormSubmitEvent: function() {
        $('#editUserForm').submit(function(event) {
            event.preventDefault();
            const formData = new FormData(this);
            const userId = $('#editUserId').val();

            $.ajax({
                url: `${contextPath}/admin/user/${userId}`,
                type: 'PUT',
                data: formData,
                processData: false,
                contentType: false,
                success: function() {
                    alert('User updated successfully');
                    location.reload();
                },
                error: function() {
                    alert('Error updating user');
                }
            });
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
            url: `${contextPath}/admin/user/${userId}`,
            method: 'DELETE',
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
