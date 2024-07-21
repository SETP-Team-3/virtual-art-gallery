const galleryModalFilterArtistManager = {
    init: function() {
        this.setupEventListeners();
        this.loadArtists(1);
    },

    setupEventListeners: function() {
        $('#filterArtistBtn').click(function() {
            galleryModalFilterArtistManager.loadArtists(1);
        });

        $('#prevArtistPage').click(function() {
            const currentArtistPage = parseInt($('#currentArtistPage').text());
            if (currentArtistPage > 1) {
                galleryModalFilterArtistManager.loadArtists(currentArtistPage - 1);
            }
        });

        $('#nextArtistPage').click(function() {
            const currentArtistPage = parseInt($('#currentArtistPage').text());
            galleryModalFilterArtistManager.loadArtists(currentArtistPage + 1);
        });
    },

    loadArtists: function(page) {
        var artistName = $('#artistName').val();
        var artistGenres = $('#artistGenre').val();
        var pageSize = 8;

        var filters = {
            name: artistName,
            genres: artistGenres
        };

        $.ajax({
            url: `${contextPath}/gallery/filter-artists?page=${page}&size=${pageSize}`,
            type: 'POST',
            contentType: 'application/json',
            data: JSON.stringify(filters),
            dataType: 'json',
            success: function(response) {
                var gallery = $('#artistGallery');
                gallery.empty();

                $.each(response.content, function(index, artist) {
                    var artistGenres = '';
                    $.each(artist.genres, function(i, genre) {
                        artistGenres += `<span class="badge bg-secondary">${genre.name}</span> `;
                    });

                    var artistCard = `
                        <div class="col-6 col-md-3 mb-4 artist-card" data-name="${artist.name}">
                            <div class="card h-100">
                                <img src="${contextPath}/portrait/${artist.portrait}" class="card-img-top" alt="${artist.name}">
                                <div class="card-body">
                                    <h5 class="card-title">${artist.name}</h5>
                                    ${artistGenres}
                                </div>
                            </div>
                        </div>`;

                    gallery.append(artistCard);
                });
                
                $('#currentArtistPage').text(page);
                $('#prevArtistPage').prop('disabled', response.first);
                $('#nextArtistPage').prop('disabled', response.last);
            }
        });
    }
};

$(document).ready(function() {
    galleryModalFilterArtistManager.init();
});
