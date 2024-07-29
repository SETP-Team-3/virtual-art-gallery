const checkoutManager = {
    init: function() {
        var stripePublicKey = 'pk_test_51KTJiPDKUSJEksT0iKqtfCfV0xcVK8MG3dNzySrUyTrBsbgWkW9sgaOmKv6bTrHuonRMUapmIbnIBnN5yFuoAixO00ISnEbgz4';
        this.stripe = Stripe(stripePublicKey);
        this.elements = this.stripe.elements();
        this.cardElement = this.elements.create('card');
        this.cardElement.mount('#cardElement');
        this.setupEventListeners();
    },

    setupEventListeners: function() {
        $('#paymentForm').on('submit', this.handleFormSubmit.bind(this));
        $('#submit').on('click', this.resetMessages.bind(this));
    },

    resetMessages: function() {
        $('#paymentSuccess').hide();
        $('#paymentFailed').hide();
    },

    handleFormSubmit: async function(event) {
        event.preventDefault();
        const { error, paymentMethod } = await this.stripe.createPaymentMethod('card', this.cardElement);

        if (error) {
            this.showError(error.message);
        } else {
            const clientSecret = await this.fetchClientSecret();
            if (clientSecret) {
                this.confirmPayment(clientSecret, paymentMethod.id);
            }
        }
    },

    fetchClientSecret: async function() {
        try {
            const response = await fetch(`${contextPath}/charge`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                }
            });

            const data = await response.json();
            if (data.status === 'error') {
                this.handleUnavailableArtworks(data.unavailableArtworks);
                return null;
            }
            return data.clientSecret;
        } catch (error) {
            this.showError('Failed to fetch client secret. Please try again.');
            return null;
        }
    },

    confirmPayment: async function(clientSecret, paymentMethodId) {
        const { error } = await this.stripe.confirmCardPayment(clientSecret, {
            payment_method: paymentMethodId
        });

        if (error) {
            this.showError(error.message);
            $('#paymentFailed').show();
        } else {
            this.finalizePurchase();
        }
    },

    finalizePurchase: async function() {
        try {
            const response = await fetch(`${contextPath}/finalizePurchase`, {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                }
            });

            const data = await response.json();
            if (data.status === 'success') {
                $('#paymentSuccess').show();
                $('#paymentForm').hide();
                $('#backToCartBtn').hide();
                setTimeout(() => {
                    window.location.href = `${contextPath}/`;
                }, 2000);
            } else {
                this.showError('Failed to finalize purchase. Please try again.');
                $('#paymentFailed').show();
            }
        } catch (error) {
            this.showError('Failed to finalize purchase. Please try again.');
            $('#paymentFailed').show();
        }
    },

    showError: function(message) {
        const errorElement = document.getElementById('cardErrors');
        errorElement.textContent = message;
    },

    handleUnavailableArtworks: function(unavailableArtworks) {
        let message = 'Some artworks are no longer available:\n';
        unavailableArtworks.forEach(artwork => {
            message += `- ${artwork.title}\n`;
        });
        this.showError(message);
        unavailableArtworks.forEach(artwork => {
            $(`button[data-cart-item-id="${artwork.id}"]`).closest('tr').remove();
        });
        this.updateTotal();
    },

    updateTotal: function() {
        let total = 0;
        $('tbody tr').each(function() {
            const price = parseFloat($(this).find('td:nth-child(3)').text().replace('$', ''));
            total += price;
        });
        $('.vag-cart-total').text(`$${total.toFixed(2)}`);
    }
};

$(document).ready(function() {
    checkoutManager.init();
});
