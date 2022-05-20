package com.shopping.controller;

import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.Date;

@Controller
@EnableScheduling
public class TestController {

    @GetMapping(value = "/")
    @ResponseBody
    @Scheduled(cron = "0 0 0 * * *")
    public String scheduled() {
        System.out.println("현재 시간은 " + new Date());

        return "Hello world!!";
    }

}
