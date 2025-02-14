package ca.calebsteelelane.template;

import org.junit.jupiter.api.Test;
import org.springframework.util.Assert;

/**
 * Test class for TemplateApplication.
 */
public class TemplateApplicationTests {

  @Test
  public void main() {
    TemplateApplication.main(new String[] {});
  }

  @Test
  public void homeReturnsHelloWorld() {
    TemplateApplication app = new TemplateApplication();
    Assert.hasText(app.home(), "Hello World!");
  }
}
