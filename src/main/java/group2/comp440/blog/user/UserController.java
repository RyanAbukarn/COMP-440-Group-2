package group2.comp440.blog.user;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.Authentication;
import org.springframework.security.core.context.SecurityContextHolder;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.authentication.logout.SecurityContextLogoutHandler;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;

@Controller
@RequestMapping("users")
public class UserController {
    @Autowired
    private UserRepository userRepository;

    @GetMapping("/login")
    public String login(){
        return "user/login";
    }

    @GetMapping("/logout")
    public String logout(HttpServletRequest request, HttpServletResponse response) {
        Authentication auth = SecurityContextHolder.getContext().getAuthentication();
        if (auth != null) {
            new SecurityContextLogoutHandler().logout(request, response, auth);
        }
        return "redirect:/users/login";
    }


    @GetMapping("/register")
    public String showRegistrationForm(Model model) {
        model.addAttribute("user", new User());
        model.addAttribute("error_email", false);
        model.addAttribute("error_username", false);
        model.addAttribute("error_password", false);
        return "user/registration_form";
    }

    @PostMapping("/register")
    public String processRegister(@ModelAttribute("user") User user, Model model) {
        if (user.isPasswordMatching() && 
            !userRepository.existsByUsername(user.getUsername()) &&
            !userRepository.existsByEmail(user.getEmail())){
            BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();
            String encodedPassword = passwordEncoder.encode(user.getPassword());
            user.setPassword(encodedPassword);
            
            userRepository.save(user);
            
            return "user/register_success";
        }
        if (!user.isPasswordMatching()){
            model.addAttribute("error_password", true);
        }
        if (userRepository.existsByUsername(user.getUsername())){
            model.addAttribute("error_username", true);
        }
        if (userRepository.existsByEmail(user.getEmail())){
            model.addAttribute("error_email", true);
        }
        model.addAttribute("user", user);
        return "user/registration_form";
    }
}
