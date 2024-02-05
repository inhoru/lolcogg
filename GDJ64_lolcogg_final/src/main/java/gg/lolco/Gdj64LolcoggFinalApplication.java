package gg.lolco;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.builder.SpringApplicationBuilder;
import org.springframework.boot.web.servlet.support.SpringBootServletInitializer;


@SpringBootApplication
public class Gdj64LolcoggFinalApplication extends SpringBootServletInitializer{

	public static void main(String[] args) {
		SpringApplication.run(Gdj64LolcoggFinalApplication.class, args);
	}
	
	@Override
	protected SpringApplicationBuilder configure(SpringApplicationBuilder builder) {
		return builder.sources(Gdj64LolcoggFinalApplication.class);
	}

}
