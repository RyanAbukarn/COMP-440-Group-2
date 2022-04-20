package group2.comp440.blog;

import java.util.HashMap;

import org.springframework.boot.ApplicationRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.Bean;

import group2.comp440.blog.hobby.Hobby;
import group2.comp440.blog.hobby.HobbyRepository;

@SpringBootApplication
public class BlogApplication {

	public static void main(String[] args) {
		SpringApplication.run(BlogApplication.class, args);
	}

	@Bean
	public ApplicationRunner DDBInitializer(HobbyRepository hobbyRepository) {
		return (args) -> {
			System.out.println("running"); // debug
			// Create departments HashMap
			HashMap<Long, String> hobbies = new HashMap<Long, String>();

			hobbies.put(1L, "hiking");
			hobbies.put(2L, "swimming");
			hobbies.put(3L, "calligraphy");
			hobbies.put(4L, "bowling");
			hobbies.put(5L, "movie");
			hobbies.put(6L, "cooking");
			hobbies.put(7L, "dancing");

			// Check if Repo is full
			// If repo entries are greater than 0, delete and populate the repo
			System.out.println("Populating repo... hobbies");
			hobbies.forEach((id, h) -> {
				if (!hobbyRepository.existsById(id))
					hobbyRepository.save(new Hobby(id, h));
			});
		};

	}

}
