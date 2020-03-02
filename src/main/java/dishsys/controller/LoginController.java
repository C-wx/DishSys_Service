package dishsys.controller;

import dishsys.bean.Merchant;
import dishsys.dto.Result;
import dishsys.service.MerchantService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;
import org.springframework.web.servlet.view.RedirectView;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import java.util.Objects;

/**
 * @Explain: 登录控制器
 */
@Controller
public class LoginController {

    @Autowired
    private MerchantService merchantService;

    /**
     * @Explain 跳转登录页
     */
    @RequestMapping("/toLogin")
    public String toLogin() {
        return "login";
    }

    @ResponseBody
    @RequestMapping("/doLogin")
    public Object doLogin(Merchant merchant, HttpSession session) {
        Merchant loginMerchant = merchantService.getByPhoneAndPwd(merchant);
        if (!session.getAttribute("img_session_code").toString().equalsIgnoreCase(merchant.getVeryCode())) {
            return Result.error("验证码不正确,请重新输入");
        } else if (Objects.isNull(loginMerchant)) {
            return Result.error("用户名或密码错误");
        } else {
            session.setAttribute("LOGIN_USER",loginMerchant);
            return Result.success();
        }
    }

    @GetMapping("/logout")
    public ModelAndView logout(HttpServletRequest request) {
        request.getSession().removeAttribute("LOGIN_USER");
        request.getSession().invalidate();
        return new ModelAndView(new RedirectView("/toLogin"));
    }
}
