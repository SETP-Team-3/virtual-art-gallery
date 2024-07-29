const cartManager = {
    init: function() {
        this.setupEventListeners();
        this.updateCheckoutButtonState();
    },

    setupEventListeners: function() {
        $(document).on('click', '.vag-cart-btnremove', this.handleRemoveFromCart.bind(this));
        $(document).on('click', '#btnCheckout', this.handleCheckout.bind(this));
    },

    handleRemoveFromCart: function(event) {
        const artworkId = $(event.target).data('cart-item-id');
        this.removeFromCart(artworkId);
    },

    handleCheckout: function(event) {
        window.location.href = `${contextPath}/checkout`;
    },

    removeFromCart: function(artworkId) {
        $.ajax({
            type: 'POST',
            url: `${contextPath}/cart/remove`,
            data: { artworkId: artworkId },
            success: function(response) {
                if (response.status === 'success') {
                    $(`button[data-cart-item-id="${artworkId}"]`).closest('tr').remove();
                    cartManager.updateTotal();
                    cartManager.updateCheckoutButtonState();
                } else {
                    alert(response.error);
                }
            },
            error: function() {
                alert('An error occurred while removing item from cart');
            }
        });
    },

    updateTotal: function() {
        let total = 0;
        $('tbody tr').each(function() {
            const price = parseFloat($(this).find('td:nth-child(3)').text().replace('$', ''));
            total += price;
        });
        $('.vag-cart-total').text(`$${total.toFixed(2)}`);
    },

    updateCheckoutButtonState: function() {
        const cartIsEmpty = $('tbody tr').length === 0;
        $('#btnCheckout').prop('disabled', cartIsEmpty);
    }
};

$(document).ready(function() {
    cartManager.init();
});
