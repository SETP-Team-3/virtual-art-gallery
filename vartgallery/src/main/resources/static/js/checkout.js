const checkoutManager = {
    init: function() {
        var stripePublicKey = 'your_stripe_public_key';
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
        $('#cardErrors').hide();
        $('#unavailableArtworks').hide();
    },

    handleFormSubmit: async function(event) {
        event.preventDefault();
        $('#spinner').show();
        $('#cardElement').hide();
        $('#submit').hide();
        $('#backToCartBtn').hide();
        $('#cardErrors').hide();
        const { error, paymentMethod } = await this.stripe.createPaymentMethod('card', this.cardElement);

        if (error) {
            this.showError(error.message);
            $('#spinner').hide();
            $('#cardElement').show();
            $('#submit').show();
            $('#backToCartBtn').show();
        } else {
            const clientSecret = await this.fetchClientSecret();
            if (clientSecret) {
                this.confirmPayment(clientSecret, paymentMethod.id);
            } else {
                $('#spinner').hide();
                $('#cardElement').show();
                $('#submit').show();
                $('#backToCartBtn').show();
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

            if (!response.ok) {
                const errorData = await response.json();
                console.log("Error Response:", errorData);
                if (errorData.status === 'error') {
                    this.handleUnavailableArtworks(errorData.unavailableArtworks);
                    return null;
                }
            }

            const data = await response.json();
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
            $('#spinner').hide();
            $('#cardElement').show();
            $('#submit').show();
            $('#paymentFailed').show();
            $('#backToCartBtn').show();
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
                $('#spinner').hide();
                $('#paymentSuccess').show();
                $('#paymentForm').hide();
                $('#backToCartBtn').hide();
                setTimeout(() => {
                    window.location.href = `${contextPath}/`;
                }, 5000);
            } else {
                this.showError('Failed to finalize purchase. Please try again.');
                $('#spinner').hide();
                $('#cardElement').show();
                $('#submit').show();
                $('#paymentFailed').show();
                $('#backToCartBtn').show();
            }
        } catch (error) {
            this.showError('Failed to finalize purchase. Please try again.');
            $('#spinner').hide();
            $('#cardElement').show();
            $('#submit').show();
            $('#paymentFailed').show();
            $('#backToCartBtn').show(); 
        }
    },

    showError: function(message) {
        const errorElement = document.getElementById('cardErrors');
        errorElement.textContent = message;
    },

    handleUnavailableArtworks: function(unavailableArtworks) {
        $('#submit').hide();
        let message = 'Some artworks are no longer available. Please remove these artworks from your cart and try again:\n';
        unavailableArtworks.forEach(artwork => {
            message += `- ${artwork.title}\n`;
        });
        const unavailableArtworksElement = document.getElementById('unavailableArtworks');
        unavailableArtworksElement.textContent = message;
        unavailableArtworksElement.style.display = 'block';

        unavailableArtworks.forEach(artwork => {
            $(`tr:has(td:contains(${artwork.title}))`).remove();
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
