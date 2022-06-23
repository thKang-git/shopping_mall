package com.shopping;

import com.shopping.domain.Board;
import com.shopping.domain.BoardRepository;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.util.List;
import java.util.stream.Stream;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
public class BoardTest {

    @Autowired
    BoardRepository boardRepository;

    @Test
    void save() {

        Board parms = Board.builder()
                .title("3번 상품입니다.")
                .price(12000)
                .content("이 상품은 테스트 입니다.")
                .hits(0)
                .useyn('Y')
                .deleteYn('N')
                .build();

        boardRepository.save(parms);
    }

    @Test
    void findAll() {
        long boardCount = boardRepository.count();

        List<Board> boardList = boardRepository.findAll();
        System.out.println(boardCount);
    }

    @Test
    void delete() {
        Board board = boardRepository.findById((long) 1).get();

        boardRepository.delete(board);

    }

}
