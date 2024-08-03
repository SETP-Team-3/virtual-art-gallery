package com.setpteam3.vartgallery.service;

import com.setpteam3.vartgallery.entity.Exhibition;
import com.setpteam3.vartgallery.repository.ExhibitionRepository;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.List;
import java.util.stream.Collectors;

@Service
public class ExhibitionService {
    private final ExhibitionRepository exhibitionRepository;

    public ExhibitionService(ExhibitionRepository exhibitionRepository) {
        this.exhibitionRepository = exhibitionRepository;
    }

    public List<Exhibition> getAllExhibitions() {
        List<Exhibition> exhibitions = exhibitionRepository.findAll();
        return exhibitions.stream().map(this::setExhibitionStatus).collect(Collectors.toList());
    }

    private Exhibition setExhibitionStatus(Exhibition exhibition) {
        LocalDateTime now = LocalDateTime.now();
        if (exhibition.getExpoTimeStart() == null || exhibition.getExpoTimeEnd() == null) {
            exhibition.setStatus("Undefined");
        } else if (exhibition.getExpoTimeStart().isAfter(now)) {
            exhibition.setStatus("Upcoming");
        } else if (exhibition.getExpoTimeEnd().isBefore(now)) {
            exhibition.setStatus("Completed");
        } else {
            exhibition.setStatus("Ongoing");
        }
        return exhibition;
    }
}
