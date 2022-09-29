package com.shopping.controller;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStreamWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.Scanner;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import sun.net.www.http.HttpClient;

import java.net.URI;

@RestController
@RequestMapping("/pay")
public class PayApiController {

    @GetMapping("/success")
    public String success(@RequestParam(value = "paymentKey") String paymentKey,
                         @RequestParam(value = "orderId") String orderId,
                         @RequestParam(value = "amount") Long amount) throws IOException {
        System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@");
        System.out.println(paymentKey);
        System.out.println(orderId);
        System.out.println(amount);
        System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@");


        URL url = new URL("https://api.tosspayments.com/v1/payments/confirm");
        HttpURLConnection httpConn = (HttpURLConnection) url.openConnection();
        httpConn.setRequestMethod("POST");

        httpConn.setRequestProperty("Authorization", "Basic test_sk_O6BYq7GWPVvRj2Z0D44VNE5vbo1d");
        httpConn.setRequestProperty("Content-Type", "application/json");

        httpConn.setDoOutput(true);
        OutputStreamWriter writer = new OutputStreamWriter(httpConn.getOutputStream());
        writer.write("{\"paymentKey\":\""+paymentKey+"\",\"amount\":"+amount+",\"orderId\":\""+orderId+"\"}");
        writer.flush();
        writer.close();
        httpConn.getOutputStream().close();

        InputStream responseStream = httpConn.getResponseCode() / 100 == 2
                ? httpConn.getInputStream()
                : httpConn.getErrorStream();
        Scanner s = new Scanner(responseStream).useDelimiter("\\A");
        String response = s.hasNext() ? s.next() : "";
        System.out.println(response);


        return "성공";
    }

    @GetMapping("/fail")
    public String fall() {
        return "실패";
    }
}
