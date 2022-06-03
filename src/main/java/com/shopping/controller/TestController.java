package com.shopping.controller;

import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.sql.Timestamp;
import java.text.SimpleDateFormat;
import java.util.*;
import java.util.function.Predicate;
import java.util.stream.Collectors;
import java.util.stream.Stream;

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


    @GetMapping(value = "/test1")
    @ResponseBody
    public List<String> sda() {

        List<String> oldList = Arrays.asList("1", "2", "3", "4");
        List<String> newList = Arrays.asList("3", "4", "5", "6");

        List<String> resultList1 = oldList.stream()
                .filter(old -> newList.stream().noneMatch(Predicate.isEqual(old)))
                .collect(Collectors.toList());

        System.out.println(resultList1); // [1, 2]

        return resultList1;
    }

    @GetMapping(value = "/test")
    @ResponseBody
    public Stream teststart() {

        String[] str = {"apple", "banana", "pear", "kiwi", "orange", "apple"};

        return Arrays.stream(str)
                .filter(c -> c.length() < 6)
                .distinct()
                .map(q -> q.toUpperCase())
                .sorted();
    }



}
