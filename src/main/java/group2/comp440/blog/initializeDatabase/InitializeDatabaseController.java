package group2.comp440.blog.initializeDatabase;

import javax.sql.DataSource;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.beans.factory.annotation.Qualifier;
import org.springframework.core.io.ClassPathResource;
import org.springframework.jdbc.datasource.init.DataSourceInitializer;
import org.springframework.jdbc.datasource.init.ResourceDatabasePopulator;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class InitializeDatabaseController {

    @Autowired
    private DataSource dataSource;

    @GetMapping("/initialize-database")
    public String initialize() {
        return "initialize_database/index";
    }

    @PostMapping("/initialize-database")
    public String postInitialize() {
        ResourceDatabasePopulator resourceDatabasePopulator = new ResourceDatabasePopulator(false, false, "UTF-8",
                new ClassPathResource(
                        "/Users/ryan/Documents/group_/comp444/src/main/java/group2/comp440/blog/initializeDatabase/university.sql"));
        resourceDatabasePopulator.execute(dataSource);
        return "redirect: users/initialize-database";
    }

}
