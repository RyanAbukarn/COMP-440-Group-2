package group2.comp440.blog.config;

import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

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
import group2.comp440.blog.comment.CommentRepository;
import group2.comp440.blog.hobby.Hobby;
import group2.comp440.blog.hobby.HobbyRepository;
import group2.comp440.blog.tag.Tag;
import group2.comp440.blog.tag.TagRepository;
import group2.comp440.blog.user.User;
import group2.comp440.blog.user.UserRepository;

@Controller
public class HomeController {
    @Autowired
    private UserRepository userRepository;

    @Autowired
    private BlogRepository blogRepository;

    @Autowired
    private CommentRepository commentRepository;

    @Autowired
    private TagRepository tagRepository;

    @Autowired
    private HobbyRepository hobbyRepository;

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

        // Will try to work on later to optimize (code works for now)
        // we want data from String [] myData to be connect as tags of a blog
        // if the tag is already created, we only want to link the tag to the blog post
        // if the tag doesn't exist, create the tag and then link it to the blog post
        String[] myData = tags.split(",");
        List<Tag> tagsFromTable = tagRepository.findAll();
        List<String> names = new ArrayList<>();
        Set<Tag> blogTags = blog.getTags();
        for (Tag i : tagsFromTable) {
            names.add(i.getName());
        }
        for (String s : myData) {
            if (Character.isWhitespace(s.charAt(0))) {
                s = s.substring(1);
            }
            Tag e;
            if (names.contains(s.toLowerCase())) {
                e = tagRepository.getByName(s.toLowerCase());
            } else {
                e = new Tag();
                e.setName(s.toLowerCase());
                tagRepository.save(e);
            }
            blogTags.add(e);
        }
        blog.setTags(blogTags);

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
    public String comment(Model model, @PathVariable("blog_id") long blog_id,
            @AuthenticationPrincipal UserDetails userDetails,
            RedirectAttributes redirectAttributes) {
        Blog blog = blogRepository.findById(blog_id).get();
        User currentUser = userRepository.findByUsername(userDetails.getUsername());
        List<Comment> comments = commentRepository.getAllByUser(currentUser);
        Date date = new Date();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        String format = formatter.format(date);
        int count = 0;
        for (Comment i : comments) {
            if (i.getBlog() == blog) {
                redirectAttributes.addFlashAttribute("message", "Can't comment more then once on a post");
                redirectAttributes.addFlashAttribute("alertClass", "alert-danger");
                return "redirect:/blogs";
            }
            if (i.getDate_Posted().compareTo(format) == 0) {
                count++;
            }
            if (count == 3) {
                redirectAttributes.addFlashAttribute("message", "Can't create more than 3 comments a day");
                redirectAttributes.addFlashAttribute("alertClass", "alert-danger");
                return "redirect:/blogs";
            }

        }
        if (blog.getUser() == currentUser) {
            redirectAttributes.addFlashAttribute("message", "Can't add a comment on your blog");
            redirectAttributes.addFlashAttribute("alertClass", "alert-danger");
            return "redirect:/blogs";
        }
        model.addAttribute("blog", blog);
        model.addAttribute("comment", new Comment());
        return "comment/form";
    }

    @PostMapping("/blogs/{blog_id}/comment/post")
    public String postComment(Model model, Comment comment, @PathVariable("blog_id") long blog_id,
            RedirectAttributes redirectAttributes, @AuthenticationPrincipal UserDetails userDetails,
            @RequestParam("description") String description, @RequestParam("sentiment") Boolean sentiment) {
        Blog blog = blogRepository.findById(blog_id).get();
        User currentUser = userRepository.findByUsername(userDetails.getUsername());
        Date date = new Date();
        SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd");
        String format = formatter.format(date);
        if (!currentUser.getBlogs().contains(blog)) {
            comment.setDescription(description);
            comment.setSentiment(sentiment);
            comment.setUser(currentUser);
            comment.setBlog(blog);
            comment.setDate_Posted(format);
            commentRepository.save(comment);
            blog.pushBackComment(comment);
            blogRepository.save(blog);
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
        model.addAttribute("comments", blog.getComments());
        return "blog/view";
    }

    @GetMapping("users")
    public String users(Model model) {
        List<User> usersList = userRepository.findAll();
        model.addAttribute("users", usersList);
        return "user/all_users";
    }

    @GetMapping("users/{user_id}")
    public String viewUser(@PathVariable("user_id") long user_id, Model model,
            @AuthenticationPrincipal UserDetails userDetails) {
        User user = userRepository.findById(user_id).get();
        User currentUser = userRepository.findByUsername(userDetails.getUsername());
        model.addAttribute("followed", currentUser.hasFollowed(userRepository.findById(user_id).get()));
        model.addAttribute("user", user);
        return "user/view";
    }

    @GetMapping("users/{user_id}/follow")
    public String followUser(@PathVariable("user_id") long user_id, Model model,
            @AuthenticationPrincipal UserDetails userDetails) {
        User currentUser = userRepository.findByUsername(userDetails.getUsername());
        currentUser.pushBackFollower(userRepository.findById(user_id).get());
        userRepository.save(currentUser);
        return "redirect: users/" + user_id;
    }

    @GetMapping("users/{user_id}/unfollow")
    public String unFollowUser(@PathVariable("user_id") long user_id, Model model,
            @AuthenticationPrincipal UserDetails userDetails) {
        User currentUser = userRepository.findByUsername(userDetails.getUsername());
        currentUser.popBackFollower(userRepository.findById(user_id).get());
        userRepository.save(currentUser);
        return "redirect: users/" + user_id;
    }

    @GetMapping("/profile")
    public String getProfile(Model model, @AuthenticationPrincipal UserDetails userDetails) {
        User currentUser = userRepository.findByUsername(userDetails.getUsername());
        model.addAttribute("user", currentUser);

        List<Hobby> hobbies = hobbyRepository.findAll();
        HashMap<String, Boolean> userHobbies = new HashMap<String, Boolean>();
        for (Hobby userHobby : currentUser.getHobbies()) {
            userHobbies.put(userHobby.getName(), true);
        }
        model.addAttribute("userHobbies", userHobbies);
        model.addAttribute("hobbies", hobbies);
        return "user/edit_profile.html";
    }

    @PostMapping("/profile")
    public String getProfile(@RequestParam("hobbies") List<Long> hobbies, RedirectAttributes redirectAttributes,
            @AuthenticationPrincipal UserDetails userDetails) {
        User currentUser = userRepository.findByUsername(userDetails.getUsername());
        currentUser.getHobbies().clear();
        Set<Hobby> hobbySet = new HashSet<>(hobbyRepository.findAllById(hobbies));
        currentUser.setHobbies(hobbySet);
        userRepository.save(currentUser);
        redirectAttributes.addFlashAttribute("message", "Success");
        redirectAttributes.addFlashAttribute("alertClass", "alert-success");
        return "redirect:/profile";
    }
}
