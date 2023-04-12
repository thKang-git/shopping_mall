package com.shopping.dto;

import lombok.Data;

import java.time.LocalDateTime;
import java.util.List;

@Data
public class OrderInfo {

    //order_m 주문정보m
    private int ord_id;                 //주문 기본키
    private String ord_no;              //주문번호
    private int user_id;                //회원번호
    private int price_sum;              //총 결제금액
    private String address;             //주소
    private LocalDateTime created_date; //생성일시


    //order_dtl 주문상세
    private List<Long> board_idx;             //상품번호
    private List<Integer> qty;                    //수량
    private List<Integer> price;                  //결제금액
}
