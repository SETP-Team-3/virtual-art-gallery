package com.setpteam3.vartgallery.controller;

import com.setpteam3.vartgallery.service.ExhibitionService;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("/exhibitions")
public class ExhibitionsController {
    private final ExhibitionService exhibitionService;

    public ExhibitionsController(ExhibitionService exhibitionService) {
        this.exhibitionService = exhibitionService;
    }

    @GetMapping
    public String viewExhibitions(Model model) {
        model.addAttribute("exhibitions", exhibitionService.getAllExhibitions());
        return "public/exhibitions";
    }
}
