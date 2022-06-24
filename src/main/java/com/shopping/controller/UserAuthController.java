package com.shopping.controller;

import com.shopping.dto.UserDto;
import com.shopping.dto.UserSessionDto;
import com.security.LoginUser;
import com.shopping.service.UserService;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/auth")
@RequiredArgsConstructor
public class UserAuthController {

    private final UserService userService;


    /**
     * 회원가입 page(현재는 login 페이지와 같이 사용중)
     */
    @GetMapping("/join")
    public String join() {
        return "user/user-join";
    }

    /**
     * 회원가입 api
     */
    @PostMapping("/joinProcapi")
    public String joinProc(UserDto userDto) {
        userService.join(userDto);
        return "redirect:/login";
    }

    /**
     * 로그인/회원가입 page
     */
    @GetMapping("/login")
    public String login() {
        return "user/user-login";
    }

    /**
     * 권한 없는 페이지
     */
    @GetMapping("/denied")
    public ModelAndView denied(@LoginUser UserSessionDto user, @RequestParam(value = "exception",required = false) String exception) {
        ModelAndView mav = new ModelAndView("user/denied");

        mav.addObject("user", user.getUsername());
        mav.addObject("role", user.getRole());
        mav.addObject("exception", exception);
        return mav;
    }

}
