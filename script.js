// scripts.js
// JavaScript for handling like/dislike and comments

// Simulated data for demonstration
const artPieces = [
    {
        id: 1,
        title: "Title 1",
        artist: "Artist 1",
        medium: "Oil on Canvas",
        dimensions: "24 x 36 inches",
        pricing: "$500",
        description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit.",
        imageSrc: "<https://via.placeholder.com/600>",
        related: [2, 3, 4]
    },
    {
        id: 2,
        title: "Title 2",
        artist: "Artist 2",
        medium: "Acrylic on Canvas",
        dimensions: "18 x 24 inches",
        pricing: "$300",
        description: "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        imageSrc: "<https://via.placeholder.com/600>",
        related: [1, 3, 4]
    },
    // Add more art pieces as needed
];

// Function to load art piece details based on the ID
function loadArtPieceDetails(id) {
    const artPiece = artPieces.find(piece => piece.id === id);
    if (artPiece) {
        document.getElementById('art-piece-image').src = artPiece.imageSrc;
        document.getElementById('art-piece-title').innerText = artPiece.title;
        document.getElementById('art-piece-artist').innerText = artPiece.artist;
        document.getElementById('art-piece-medium').innerText = artPiece.medium;
        document.getElementById('art-piece-dimensions').innerText = artPiece.dimensions;
        document.getElementById('art-piece-pricing').innerText = artPiece.pricing;
        document.getElementById('art-piece-description').innerText = artPiece.description;

        // Load related art pieces
        const relatedContainer = document.getElementById('related-art-container');
        relatedContainer.innerHTML = '';
        artPiece.related.forEach(relatedId => {
            const relatedArtPiece = artPieces.find(piece => piece.id === relatedId);
            if (relatedArtPiece) {
                const relatedCard = `
                    <div class="col-md-4">
                        <div class="card">
                            <a href="art-piece-detail.html?id=${relatedArtPiece.id}">
                                <img src="${relatedArtPiece.imageSrc}" class="card-img-top" alt="Related Art Piece">
                            </a>
                            <div class="card-body text-center">
                                <h5 class="card-title">${relatedArtPiece.title}</h5>
                                <p class="card-text">${relatedArtPiece.artist}</p>
                            </div>
                        </div>
                    </div>
                `;
                relatedContainer.innerHTML += relatedCard;
            }
        });
    }
}

// Event listeners for like/dislike buttons
let likeCount = 0;
let dislikeCount = 0;

document.getElementById('like-button').addEventListener('click', () => {
    likeCount++;
    document.getElementById('like-count').innerText = likeCount;
});

document.getElementById('dislike-button').addEventListener('click', () => {
    dislikeCount++;
    document.getElementById('dislike-count').innerText = dislikeCount;
});

// Event listener for submitting comments
document.getElementById('submit-comment').addEventListener('click', () => {
    const commentInput = document.getElementById('comment-input');
    const commentText = commentInput.value.trim();
    if (commentText) {
        const comment = `
            <div class="comment mt-2">
                <p><strong>User:</strong> ${commentText}</p>
            </div>
        `;
        document.getElementById('comments-container').innerHTML += comment;
        commentInput.value = '';
    }
});

// Load art piece details on page load (assuming the ID is passed in the URL)
document.addEventListener('DOMContentLoaded', () => {
    const urlParams = new URLSearchParams(window.location.search);
    const artPieceId = parseInt(urlParams.get('id'), 10);
    if (artPieceId) {
        loadArtPieceDetails(artPieceId);
    }
});
