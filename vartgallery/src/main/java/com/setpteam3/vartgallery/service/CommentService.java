package com.setpteam3.vartgallery.service;

import com.setpteam3.vartgallery.entity.Comment;
import com.setpteam3.vartgallery.repository.ArtworkRepository;
import com.setpteam3.vartgallery.repository.CommentRepository;
import com.setpteam3.vartgallery.repository.UserRepository;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class CommentService {
    private final CommentRepository commentRepository;
    private final UserRepository userRepository;
    private final ArtworkRepository artworkRepository;

    public CommentService(CommentRepository commentRepository, UserRepository userRepository, ArtworkRepository artworkRepository) {
        this.commentRepository = commentRepository;
        this.userRepository = userRepository;
        this.artworkRepository = artworkRepository;
    }

    /* public void addComment(int artworkId, String username, String content) {
        Comment comment = new Comment();
        comment.setArtwork(artworkRepository.findById(artworkId).orElseThrow(() -> new IllegalArgumentException("Artwork not found")));
        comment.setUser(userRepository.findByEmail(username).orElseThrow(() -> new IllegalArgumentException("User not found")));
        comment.setContent(content);
        commentRepository.save(comment);
    } */

    public List<Comment> getCommentsByArtworkId(int artworkId) {
        return commentRepository.findByArtworkId(artworkId);
    }
}
