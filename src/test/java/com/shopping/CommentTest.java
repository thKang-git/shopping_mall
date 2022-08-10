package com.shopping;

import com.shopping.domain.Comment;
import com.shopping.domain.CommentRepository;
import com.shopping.service.CommentService;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;

@SpringBootTest
public class CommentTest {

    @Autowired
    private CommentRepository commentRepository;
    private CommentService commentService;

    @Test
    void 테스트(){

        Comment param = Comment.builder()
                .boardIdx(2101L)
                .content("첫번째 댓글입니다.")
                .writer("어드민")
                .writerIdx(5)
                .deleteYn('N')
                .build();
        commentRepository.save(param);
    }

    @Test
    void 결과() {
        int count = (int) commentRepository.count();
        System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@");
        System.out.println(count);

        System.out.println("@@@@@@@@@@@@@@@@@@@@@@@@@@@@@");
        List<Comment> dtoList = commentRepository.findAll();

        System.out.println(dtoList);
    }

    @Test
    void 삭제() {
        Long re = commentService.delete(1L);
        System.out.println(re);
    }
    
    // 삭제까지 테스트 완료하였음. 컨트롤단에서 테스트 진행 해야함
}






