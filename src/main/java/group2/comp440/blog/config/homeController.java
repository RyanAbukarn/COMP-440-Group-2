package group2.comp440.blog.config;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import group2.comp440.blog.user.User;
import group2.comp440.blog.user.UserRepository;

@Controller
public class HomeController {
    @Autowired
    private UserRepository userRepository;
    @GetMapping("/")
    public String index(Model model, @AuthenticationPrincipal UserDetails userDetails){
        User currentUser = userRepository.findByUsername(userDetails.getUsername());
        model.addAttribute("user", currentUser);
        return "user/index";
    }
}
