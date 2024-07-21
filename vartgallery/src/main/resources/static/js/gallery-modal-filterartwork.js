const galleryModalFilterArtworkManager = {
    init: function() {
        this.setupEventListeners();
        this.initializePriceRangeSlider();
        this.loadArtworks(1);
    },

    setupEventListeners: function() {
        $('#filterArtworkBtn').click(function() {
            galleryModalFilterArtworkManager.loadArtworks(1);
        });

        $('#prevArtworkPage').click(function() {
            const currentArtworkPage = parseInt($('#currentArtworkPage').text());
            if (currentArtworkPage > 1) {
                galleryModalFilterArtworkManager.loadArtworks(currentArtworkPage - 1);
            }
        });

        $('#nextArtworkPage').click(function() {
            const currentArtworkPage = parseInt($('#currentArtworkPage').text());
            galleryModalFilterArtworkManager.loadArtworks(currentArtworkPage + 1);
        });
    },

    initializePriceRangeSlider: function() {
        var priceRangeSlider = $('#artworkPriceRange')[0];
        var priceRangeValue = $('#priceRangeValue');

        noUiSlider.create(priceRangeSlider, {
            start: [0, 50000],
            connect: true,
            step: 1000,
            range: {
                'min': 0,
                'max': 50000
            },
            tooltips: [true, true],
            format: {
                to: function(value) {
                    return '$' + Math.round(value);
                },
                from: function(value) {
                    return Number(value.replace('$', ''));
                }
            }
        });

        priceRangeSlider.noUiSlider.on('update', function(values, handle) {
            priceRangeValue.html(values.join(' - '));
        });
    },

    loadArtworks: function(page) {
        var artworkTitle = $('#artworkTitle').val();
        var artworkArtist = $('#artworkArtist').val();
        var priceRange = $('#artworkPriceRange')[0].noUiSlider.get();
        var minPrice = priceRange[0].replace('$', '');
        var maxPrice = priceRange[1].replace('$', '');
        var artworkGenres = $('#artworkGenre').val();
        var pageSize = 8;

        var filters = {
            title: artworkTitle,
            artist: artworkArtist,
            minPrice: minPrice,
            maxPrice: maxPrice,
            genres: artworkGenres
        };

        $.ajax({
            url: `${contextPath}/gallery/filter-artworks?page=${page}&size=${pageSize}`,
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(filters),
            dataType: 'json',
            success: function(response) {
                var gallery = $('#artworkGallery');
                gallery.empty();

                $.each(response.content, function(index, artwork) {
                    var artworkGenres = '';
                    $.each(artwork.genres, function(i, genre) {
                        artworkGenres += `<span class="badge bg-secondary">${genre.name}</span> `;
                    });

                    var artworkCard = `
                        <div class="col-6 col-md-3 mb-4 artwork-card" data-id="${artwork.id}" data-title="${artwork.title}" style="cursor: pointer;">
                            <div class="card h-100">
                                <img src="${contextPath}/artwork/${artwork.image}" class="card-img-top" alt="${artwork.title}">
                                <div class="card-body">
                                    <h5 class="card-title">${artwork.title}</h5>
                                    <p class="card-text">${artwork.artistId.name}<br />
                                    <span class="vag-artwork-price">${artwork.price}</span>
                                    </p>
                                    ${artworkGenres}
                                </div>
                            </div>
                        </div>`;

                    gallery.append(artworkCard);
                });

                galleryModalFilterArtworkManager.formatAllPrices();
                galleryModalFilterArtworkManager.setupArtworkCardClickEvent();
                $('#currentArtworkPage').text(page);
                $('#prevArtworkPage').prop('disabled', response.first);
                $('#nextArtworkPage').prop('disabled', response.last);
            }
        });
    },

    setupArtworkCardClickEvent: function() {
        $('.artwork-card').click(function() {
            const artworkId = $(this).data('id');
            window.location.href = `${contextPath}/artwork-detail?id=${artworkId}`;
        });
    },

    formatAllPrices: function() {
        $('.vag-artwork-price').each(function() {
            var price = parseFloat($(this).text());
            $(this).text('$' + price.toFixed(2));
        });
    }
};

$(document).ready(function() {
    galleryModalFilterArtworkManager.init();
});
