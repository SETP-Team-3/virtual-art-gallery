package com.setpteam3.vartgallery.service;

import com.setpteam3.vartgallery.entity.Artwork;
import com.setpteam3.vartgallery.entity.PendingArtwork;
import com.setpteam3.vartgallery.entity.PendingUser;
import com.setpteam3.vartgallery.entity.User;
import org.springframework.mail.SimpleMailMessage;
import org.springframework.mail.javamail.JavaMailSender;
import org.springframework.scheduling.annotation.Async;
import org.springframework.stereotype.Service;

@Service
public class EmailService {
    private final JavaMailSender mailSender;

    public EmailService(JavaMailSender mailSender) {
        this.mailSender = mailSender;
    }

    @Async
    public void sendApprovalEmail(User user, PendingArtwork pendingArtwork) {
        String to = user.getEmail();
        String subject = "Artwork Approved";
        String content = String.format(
                "Dear %s,\n\nYour artwork titled '%s' has been approved and is now live on VArtGallery.\n\nBest regards,\nVArtGallery Team",
                user.getName(), pendingArtwork.getTitle()
        );

        sendEmail(to, subject, content);
    }

    @Async
    public void sendRejectionEmail(User user, PendingArtwork pendingArtwork) {
        String to = user.getEmail();
        String subject = "Artwork Rejected";
        String content = String.format(
                "Dear %s,\n\nYour artwork titled '%s' has been rejected.\n\nBest regards,\nVArtGallery Team",
                user.getName(), pendingArtwork.getTitle()
        );

        sendEmail(to, subject, content);
    }

    @Async
    public void sendAccountApprovalEmail(PendingUser pendingUser) {
        String to = pendingUser.getEmail();
        String subject = "Account Approved";
        String content = String.format(
                "Dear %s,\n\nYour VArtGallery %s account request has been approved and you may now sign in to the app.\n\nBest regards,\nVArtGallery Team",
                pendingUser.getName(), pendingUser.getRole()
        );

        sendEmail(to, subject, content);
    }

    @Async
    public void sendAccountRejectionEmail(PendingUser pendingUser) {
        String to = pendingUser.getEmail();
        String subject = "Account Rejected";
        String content = String.format(
                "Dear %s,\n\nYour VArtGallery %s account request has been rejected.\n\nBest regards,\nVArtGallery Team",
                pendingUser.getName(), pendingUser.getRole()
        );

        sendEmail(to, subject, content);
    }

    @Async
    public void sendBuyerArtworkPurchasedEmail(User buyer, Artwork artwork) {
        String to = buyer.getEmail();
        String subject = "Artwork Purchase Confirmation";
        String content = String.format(
                "Dear %s,\n\nThank you for purchasing the artwork titled '%s'. Your purchase was successful.\n\nBest regards,\nVArtGallery Team",
                buyer.getName(), artwork.getTitle()
        );

        sendEmail(to, subject, content);
    }

    @Async
    public void sendArtistArtworkPurchasedEmail(User artist, Artwork artwork) {
        String to = artist.getEmail();
        String subject = "Artwork Sold Notification";
        String content = String.format(
                "Dear %s,\n\nYour artwork titled '%s' has been purchased.\n\nBest regards,\nVArtGallery Team",
                artist.getName(), artwork.getTitle()
        );

        sendEmail(to, subject, content);
    }

    private void sendEmail(String to, String subject, String content) {
        SimpleMailMessage message = new SimpleMailMessage();
        message.setTo(to);
        message.setSubject(subject);
        message.setText(content);
        mailSender.send(message);
    }
}
