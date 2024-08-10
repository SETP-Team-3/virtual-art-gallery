package com.setpteam3.vartgallery;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableAsync;

@SpringBootApplication
@EnableAsync
public class VartgalleryApplication {
	public static void main(String[] args) {
		SpringApplication.run(VartgalleryApplication.class, args);
	}
}
