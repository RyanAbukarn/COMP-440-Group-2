package group2.comp440.blog.initializeDatabase;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.ClassPathResource;
import org.springframework.jdbc.datasource.init.ResourceDatabasePopulator;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

@Controller
public class InitializeDatabaseController {

    @Autowired
    private DataSource dataSource;

    @GetMapping("/initialize-database")
    public String initialize() {
        return "initialize_database/index";
    }

    @PostMapping("/initialize-database")
    public String postInitialize(RedirectAttributes redirectAttributes) {
        ResourceDatabasePopulator resourceDatabasePopulator = new ResourceDatabasePopulator(false, false, "UTF-8",
                new ClassPathResource("/university.sql"));
        resourceDatabasePopulator.execute(dataSource);
        redirectAttributes.addFlashAttribute("message", "Successfully added the initialize database");
        redirectAttributes.addFlashAttribute("alertClass", "alert-success");
        return "redirect:/initialize-database";
    }

}
