package com.shopping.controller;

import com.shopping.dto.BoardRequestDto;
import com.shopping.dto.BoardResponseDto;
import com.shopping.service.BoardService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping(value = "/api")
@RequiredArgsConstructor
public class BoardApiController {

    private final BoardService boardService;

    @PostMapping("/save")
    public Long save(@RequestBody final BoardRequestDto params) {
        return boardService.save(params);
    }

    @GetMapping("/boards")
    public List<BoardResponseDto> findAll() {
        return boardService.findAll();
    }

    @PatchMapping("/boards/{id}")
    public Long save(@PathVariable final Long id, @RequestBody final BoardRequestDto params) {
        return boardService.update(id, params);
    }

}
