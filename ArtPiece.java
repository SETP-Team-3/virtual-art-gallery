import java.util.ArrayList;
import java.util.List;

public class ArtPiece {
    private int id;
    private String title;
    private String artist;
    private String medium;
    private String dimensions;
    private String pricing;
    private String description;
    private String imageSrc;
    private List<Integer> related;

    public ArtPiece(int id, String title, String artist, String medium, String dimensions, String pricing, String description, String imageSrc, List<Integer> related) {
        this.id = id;
        this.title = title;
        this.artist = artist;
        this.medium = medium;
        this.dimensions = dimensions;
        this.pricing = pricing;
        this.description = description;
        this.imageSrc = imageSrc;
        this.related = related;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getArtist() {
        return artist;
    }

    public String getMedium() {
        return medium;
    }

    public String getDimensions() {
        return dimensions;
    }

    public String getPricing() {
        return pricing;
    }

    public String getDescription() {
        return description;
    }

    public String getImageSrc() {
        return imageSrc;
    }

    public List<Integer> getRelated() {
        return related;
    }

    public static void main(String[] args) {
        List<ArtPiece> artPieces = new ArrayList<>();

        artPieces.add(new ArtPiece(1, "Title 1", "Artist 1", "Oil on Canvas", "24 x 36 inches", "$500", "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", "<https://via.placeholder.com/600>", List.of(2, 3, 4)));
        artPieces.add(new ArtPiece(2, "Title 2", "Artist 2", "Acrylic on Canvas", "18 x 24 inches", "$300", "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", "<https://via.placeholder.com/600>", List.of(1, 3, 4)));

        // Simulate loading art piece details
        int artPieceId = 1; // Example ID to load
        ArtPiece artPiece = artPieces.stream().filter(piece -> piece.getId() == artPieceId).findFirst().orElse(null);

        if (artPiece != null) {
            System.out.println("Title: " + artPiece.getTitle());
            System.out.println("Artist: " + artPiece.getArtist());
            System.out.println("Medium: " + artPiece.getMedium());
            System.out.println("Dimensions: " + artPiece.getDimensions());
            System.out.println("Pricing: " + artPiece.getPricing());
            System.out.println("Description: " + artPiece.getDescription());

            System.out.println("Related Art Pieces:");
            for (int relatedId : artPiece.getRelated()) {
                ArtPiece relatedArtPiece = artPieces.stream().filter(piece -> piece.getId() == relatedId).findFirst().orElse(null);
                if (relatedArtPiece != null) {
                    System.out.println(" - " + relatedArtPiece.getTitle() + " by " + relatedArtPiece.getArtist());
                }
            }
        }
    }
}

///////////////////////////////////////////////////////////////////////////////////////////////////////////


// ArtPiece.java
import java.util.ArrayList;
import java.util.List;

public class ArtPiece {
    private int id;
    private String title;
    private String artist;
    private String medium;
    private String dimensions;
    private String pricing;
    private String description;
    private String imageSrc;
    private List<Integer> related;

    public ArtPiece(int id, String title, String artist, String medium, String dimensions, String pricing, String description, String imageSrc, List<Integer> related) {
        this.id = id;
        this.title = title;
        this.artist = artist;
        this.medium = medium;
        this.dimensions = dimensions;
        this.pricing = pricing;
        this.description = description;
        this.imageSrc = imageSrc;
        this.related = related;
    }

    // Getters and Setters
    public int getId() {
        return id;
    }

    public String getTitle() {
        return title;
    }

    public String getArtist() {
        return artist;
    }

    public String getMedium() {
        return medium;
    }

    public String getDimensions() {
        return dimensions;
    }

    public String getPricing() {
        return pricing;
    }

    public String getDescription() {
        return description;
    }

    public String getImageSrc() {
        return imageSrc;
    }

    public List<Integer> getRelated() {
        return related;
    }

    public static void main(String[] args) {
        List<ArtPiece> artPieces = new ArrayList<>();

        artPieces.add(new ArtPiece(1, "Title 1", "Artist 1", "Oil on Canvas", "24 x 36 inches", "$500", "Lorem ipsum dolor sit amet, consectetur adipiscing elit.", "<https://via.placeholder.com/600>", List.of(2, 3, 4)));
        artPieces.add(new ArtPiece(2, "Title 2", "Artist 2", "Acrylic on Canvas", "18 x 24 inches", "$300", "Sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.", "<https://via.placeholder.com/600>", List.of(1, 3, 4)));

        // Simulate loading art piece details
        int artPieceId = 1; // Example ID to load
        ArtPiece artPiece = artPieces.stream().filter(piece -> piece.getId() == artPieceId).findFirst().orElse(null);

        if (artPiece != null) {
            System.out.println("Title: " + artPiece.getTitle());
            System.out.println("Artist: " + artPiece.getArtist());
            System.out.println("Medium: " + artPiece.getMedium());
            System.out.println("Dimensions: " + artPiece.getDimensions());
            System.out.println("Pricing: " + artPiece.getPricing());
            System.out.println("Description: " + artPiece.getDescription());

            System.out.println("Related Art Pieces:");
            for (int relatedId : artPiece.getRelated()) {
                ArtPiece relatedArtPiece = artPieces.stream().filter(piece -> piece.getId() == relatedId).findFirst().orElse(null);
                if (relatedArtPiece != null) {
                    System.out.println(" - " + relatedArtPiece.getTitle() + " by " + relatedArtPiece.getArtist());
                }
            }
        }
    }
}
