package com.shopping.controller;

import com.shopping.dto.UserSessionDto;
import com.security.LoginUser;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.servlet.ModelAndView;

@Controller
@RequestMapping(value = "/shopping")
public class BoardPageController {

    @GetMapping(value = "/index.do")
    public ModelAndView home() {
        ModelAndView mav = new ModelAndView("index");
        return mav;
    }

    @GetMapping(value = "/test.do")
    public ModelAndView test() {
        ModelAndView mav = new ModelAndView("shop");
        return mav;
    }

    /**
     * 게시글 리스트
     */
    @GetMapping(value = "/list.do")
    public ModelAndView list(@LoginUser UserSessionDto user) {
        ModelAndView mav = new ModelAndView("list");

        if (user != null) {
            mav.addObject("user", user.getUsername());
            mav.addObject("role", user.getRole());
        }
        return mav;
    }

    /**
     * 게시글 생성
     */
    @GetMapping(value = "/write.do")
    public ModelAndView write(@RequestParam(required = false) final Long id, @LoginUser UserSessionDto user) {
        ModelAndView mav = new ModelAndView("write");
        if(id != null) {
            mav.addObject("id", id);
        } else {
            mav.addObject("id", 0);
        }

        if (user != null) {
            mav.addObject("user", user.getUsername());
            mav.addObject("role", user.getRole());
        }

        return mav;
    }

    /**
     * 게시글 상세 페이지
     */
    @GetMapping(value = "/view/{id}")
    public ModelAndView viewopen(@PathVariable final Long id, @LoginUser UserSessionDto user) {
        ModelAndView mav = new ModelAndView("view");
        mav.addObject("id", id);

        if (user != null) {
            mav.addObject("user", user.getUsername());
            mav.addObject("role", user.getRole());
            mav.addObject("userIdx", user.getId());
        }

        return mav;
    }
}
