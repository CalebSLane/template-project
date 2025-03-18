package ca.calebsteelelane.template;

import org.junit.jupiter.api.Test;
import org.springframework.util.Assert;

/**
 * Unit Test class for TemplateController.
 */
public class TemplateControllerTest {

  @Test
  public void homeReturnsHelloWorld() {
    TemplateController controller = new TemplateController();
    Assert.hasText(controller.home(), "Hello World!");
  }
}
