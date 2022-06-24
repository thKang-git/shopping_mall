package com.shopping.controller;

import com.paging.CommonParams;
import com.shopping.dto.BoardRequestDto;
import com.shopping.dto.BoardResponseDto;
import com.shopping.service.BoardService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;
import java.util.Map;

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
}
