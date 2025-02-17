package ca.calebsteelelane.template;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Main application class for the Template application.
 */
@RestController
@SpringBootApplication
public class TemplateApplication {

  @RequestMapping("/")
  String home() {
    return "Hello World!";
  }

  @RequestMapping("/secure")
  String secureHome() {
    return "Hello Secure World!";
  }

  public static void main(String[] args) {
    SpringApplication.run(TemplateApplication.class, args);
  }
}
