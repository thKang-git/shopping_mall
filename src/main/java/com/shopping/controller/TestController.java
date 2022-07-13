package com.shopping.controller;

import com.shopping.dto.AmazonS3Dto;
import com.shopping.mapper.AmazonS3Mapper;
import lombok.RequiredArgsConstructor;
import org.springframework.scheduling.annotation.EnableScheduling;
import org.springframework.scheduling.annotation.Scheduled;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.ResponseBody;

import java.util.*;
import java.util.function.Predicate;
import java.util.stream.Collectors;

@Controller
@EnableScheduling
@RequiredArgsConstructor
public class TestController {
    private final AmazonS3Mapper amazonS3Mapper;

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
    public String teststart() {

        List<AmazonS3Dto> fileName = amazonS3Mapper.selectFile(2096L);

        String name = fileName.get(0).getSaveName();

//        if (!fileName.isEmpty()) {
//            for (AmazonS3Dto arr : fileName) {
//                String name = arr.getSaveName();
//                System.out.println(name);
//            }
//        }
        return name;
    }



}
