package group2.comp440.blog.config;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.annotation.AuthenticationPrincipal;
import org.springframework.security.core.userdetails.UserDetails;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import group2.comp440.blog.blog.Blog;
import group2.comp440.blog.blog.BlogRepository;
import group2.comp440.blog.comment.Comment;
import group2.comp440.blog.user.User;
import group2.comp440.blog.user.UserRepository;

@Controller
public class HomeController {
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private BlogRepository blogRepository;

    @GetMapping("/")
    public String index(Model model, @AuthenticationPrincipal UserDetails userDetails) {
        User currentUser = userRepository.findByUsername(userDetails.getUsername());
        model.addAttribute("user", currentUser);
        return "user/index";
    }

    @GetMapping("/blog")
    public String newBlog(RedirectAttributes redirectAttributes, @AuthenticationPrincipal UserDetails userDetails) {
        User currentUser = userRepository.findByUsername(userDetails.getUsername());
        List<Blog> blogs = blogRepository.getAllByUser(currentUser);
        int count = 0;
        Date date = new Date();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        String format = formatter.format(date);

        for (Blog i : blogs) {
            if (i.getDate_Posted().compareTo(format) == 0) {
                count++;
            }
            if (count == 2) {
                redirectAttributes.addFlashAttribute("message", "Can't create more than 2 blogs a day");
                redirectAttributes.addFlashAttribute("alertClass", "alert-danger");
                return "redirect:/";
            }
        }
        return "blog/index";
    }

    @PostMapping("/blog")
    public String postBlog(@RequestParam("subject") String subject, @RequestParam("description") String description,
            @RequestParam("tags") String tags,
            @AuthenticationPrincipal UserDetails userDetails, RedirectAttributes redirectAttributes) {
        User currentUser = userRepository.findByUsername(userDetails.getUsername());
        Date date = new Date();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        String format = formatter.format(date);
        Blog blog = new Blog();
        blog.setSubject(subject);
        blog.setDescription(description);
        blog.setTags(tags);
        blog.setUser(currentUser);
        blog.setDate_Posted(format);
        blogRepository.save(blog);

        return "redirect:/";
    }

    @GetMapping("/blogs")
    public String blogs(Model model) {
        model.addAttribute("blogs", blogRepository.findAll());
        return "blog/all_blogs";
    }

    @GetMapping("/blogs/{blog_id}/comment/new")
    public String comment(Model model, @PathVariable("blog_id") long blog_id) {
        Blog blog = blogRepository.findById(blog_id).get();
        model.addAttribute("blog", blog);
        model.addAttribute("comment", new Comment());
        return "comment/form";
    }

    @PostMapping("/blogs/{blog_id}/comment/post")
    public String postComment(Model model, Comment comment, @PathVariable("blog_id") long blog_id,
            RedirectAttributes redirectAttributes, @AuthenticationPrincipal UserDetails userDetails) {
        Blog blog = blogRepository.findById(blog_id).get();
        User currentUser = userRepository.findByUsername(userDetails.getUsername());

        if (!currentUser.getBlogs().contains(blog)) {

            blog.pushBackComment(comment);
            redirectAttributes.addFlashAttribute("message", "Successfully added a comment");
            redirectAttributes.addFlashAttribute("alertClass", "alert-success");
            return "redirect:/blogs/" + blog_id;
        } else {
            redirectAttributes.addFlashAttribute("message", "Can't add a comment on your blog");
            redirectAttributes.addFlashAttribute("alertClass", "alert-danger");
            return "redirect:/blogs";
        }

    }

    @GetMapping("/blogs/{blog_id}")
    public String viewBlog(Model model, @PathVariable("blog_id") long blog_id) {
        Blog blog = blogRepository.findById(blog_id).get();
        model.addAttribute("blog", blog);
        return "blog/view";
    }
}
