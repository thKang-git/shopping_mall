package com.shopping.controller;

import com.shopping.dto.CommentDto;
import com.shopping.service.CommentService;
import lombok.RequiredArgsConstructor;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequiredArgsConstructor
@RequestMapping("/comment")
public class CommentController {

    private final CommentService commentService;


    /**
     * 댓글 조회
     */
    @GetMapping(value = "/{boardIdx}")
    public List<CommentDto> findAll(@PathVariable("boardIdx") Long boardIdx) {
        return commentService.findAllList(boardIdx);
    }

    /**
     * 댓글 등록
     */
    @PostMapping(value = "/save")
    public Long save(@RequestBody CommentDto commentDto) {
        return commentService.save(commentDto);
    }

    /**
     * 댓글 수정
     */
    @PatchMapping(value = "/{id}")
    public Long update(@PathVariable("id") Long id, @RequestBody CommentDto commentDto) {
        return commentService.update(id, commentDto);
    }

    /**
     * 댓글 삭제
     */
    @DeleteMapping(value = "/{id}")
    public Long delete(@PathVariable("id") Long id){
        return commentService.delete(id);
    }
}
