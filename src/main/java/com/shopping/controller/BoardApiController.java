package com.shopping.controller;

import com.paging.CommonParams;
import com.security.LoginUser;
import com.shopping.dto.BasketDto;
import com.shopping.dto.BoardRequestDto;
import com.shopping.dto.BoardResponseDto;
import com.shopping.dto.UserSessionDto;
import com.shopping.service.BoardService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.time.LocalDateTime;
import java.time.format.DateTimeFormatter;
import java.util.List;
import java.util.Map;
import java.util.Random;

@RestController
@RequestMapping(value = "/api")
@RequiredArgsConstructor
public class BoardApiController {

    private final BoardService boardService;

    /**
     * 게시글 저장
     */
    @PostMapping("/boards")
    public Long save(@RequestBody final BoardRequestDto params) {
        return boardService.save(params);
    }

    /**
     * 게시글 조회
     */
    @GetMapping("/boards")
    public Map<String, Object> findAll(final CommonParams params) {
        return boardService.findAll(params);
    }

    /**
     * 게시글 수정
     */
    @PatchMapping("/boards/{id}")
    public Long save(@PathVariable final Long id, @RequestBody final BoardRequestDto params) {
        return boardService.update(id, params);
    }

    /**
     * 게시글 상세보기
     */
    @GetMapping(value = "/boards/{id}")
    public BoardResponseDto findById(@PathVariable final Long id) {
        return boardService.findById(id);
    }

    /**
     * 게시글 삭제
     */
    @DeleteMapping(value = "/boards/{id}")
    public Long delete(@PathVariable final Long id) {
        return boardService.delete(id);
    }

    /**
     * 장바구니 등록
     */
    @PostMapping("/shopbasket")
    public String saveShopbasket(@RequestBody BasketDto basketDto) {

        boolean result = boardService.basketsave(basketDto);

        if (result == true) {
            return "등록완료";
        } else {
            return "등록실패";
        }
    }

    /**
     * 장바구니 갯수
     */
    @GetMapping("/shopbasketCount")
    public int shopbasketCount(@LoginUser UserSessionDto user) {
        int result = boardService.basketcount(user.getId());
        return result;
    }

    /**
     * 장바구니 삭제
     */
    @DeleteMapping("/shopbasket/{ordId}")
    public boolean deleteShopbasket(@PathVariable final List<Long> ordId) {
        System.out.println(ordId);
        return boardService.basketdelete(ordId);
    }

    /**
     * 주문번호 생성(PAY api 호출 시 주문번호가 필요함으로 서버쪽에서 먼저 생성 필요함)
     */
    @GetMapping("/make/ordNo")
    public String makeOrdNo() {
        //현재시간
        LocalDateTime now = LocalDateTime.now();
        DateTimeFormatter formatter = DateTimeFormatter.ofPattern("yyMMdd");
        String date = now.format(formatter);

        //랜덤 6자리
        int ordNo = (int)(Math.random() * (999999 - 100000 + 1)) + 100000;
        String random = Integer.toString(ordNo);

        //시간 + 랜덤
        String result = date + random;

        return result;
    }
}
