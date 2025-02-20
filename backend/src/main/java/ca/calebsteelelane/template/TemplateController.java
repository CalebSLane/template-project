package ca.calebsteelelane.template;

import org.springframework.beans.factory.annotation.Value;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class TemplateController {

  @RequestMapping("/")
  String home() {
    return "Hello World!";
  }

  @RequestMapping("/secure")
  String secureHome() {
    return "Hello World!";
  }
}
