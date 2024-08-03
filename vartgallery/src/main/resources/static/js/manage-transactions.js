const manageTransactionsManager = {
    init: function() {
        this.setupEventListeners();
    },

    setupEventListeners: function() {
        this.setupViewButtonClickEvent();
    },

    setupViewButtonClickEvent: function() {
        $('.vag-btn-viewtransaction').on('click', function() {
            const transactionId = $(this).data('transaction-id');
            manageTransactionsManager.fetchTransactionDetails(transactionId);
        });
    },

    fetchTransactionDetails: function(transactionId) {
        $.ajax({
            url: `${contextPath}/admin/transaction-details`,
            method: 'GET',
            data: { transactionId: transactionId },
            success: function(response) {
                manageTransactionsManager.populateTransactionDetailsModal(response);
                $('#transactionModal').modal('show');
            },
            error: function() {
                alert('Failed to fetch transaction details');
            }
        });
    },

    populateTransactionDetailsModal: function(transactions) {
        let transactionRows = '';

        transactions.forEach(transaction => {
            transactionRows += `
                <tr>
                    <td>${transaction.artworkTitle}</td>
                    <td>$${transaction.amount}</td>
                </tr>`;
        });

        let htmlContent = `
            <div class="container">
                <p><strong>Transaction ID: ${transactions[0].transactionId}</strong></p>
                <p>
                    User Email: ${transactions[0].userEmail}<br />
                    Date: ${transactions[0].transactionDate}<br />
                    Total Amount: $${transactions.reduce((total, transaction) => total + parseFloat(transaction.amount), 0)}
                </p>
                <table class="table table-bordered mt-3">
                    <thead>
                        <tr>
                            <th>Artwork Title</th>
                            <th>Price</th>
                        </tr>
                    </thead>
                    <tbody>
                        ${transactionRows}
                    </tbody>
                </table>
            </div>`;

        $('#transactionDetails').html(htmlContent);
    }
};

$(document).ready(function() {
    manageTransactionsManager.init();
});
