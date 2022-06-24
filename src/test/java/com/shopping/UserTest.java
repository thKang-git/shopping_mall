package com.shopping;

import com.shopping.domain.User;
import com.shopping.domain.UserRepository;
import com.security.Role;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;

import java.time.LocalDateTime;

import static org.assertj.core.api.Assertions.assertThat;

@SpringBootTest
public class UserTest {

    @Autowired
    UserRepository userRepository;

    @Test
    void save() {

        User parms = User.builder()
                .userid("netuad4")
                .password("Ksh0406")
                .username("테스트")
                .email("netk@naver.com")
                .role(Role.USER)
                .createdDate(LocalDateTime.now())
                .build();

        userRepository.save(parms);

    }

}