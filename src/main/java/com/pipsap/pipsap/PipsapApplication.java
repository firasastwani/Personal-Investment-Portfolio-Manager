package com.pipsap.pipsap;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.scheduling.annotation.EnableScheduling;

@SpringBootApplication
@EnableScheduling
public class PipsapApplication {

	public static void main(String[] args) {
		SpringApplication.run(PipsapApplication.class, args);
	}

}
