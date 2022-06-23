package com.shopping.dto;

import com.shopping.domain.User;
import com.shopping.security.Role;
import lombok.AllArgsConstructor;
import lombok.Builder;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.time.LocalDateTime;

@Data
@AllArgsConstructor
@NoArgsConstructor
@Builder
public class UserDto {

    private String userid; // 아이디

    private String password; // 비밀번호

    private String username; // 사용자 이름

    private String email; // 이메일

    private Role role; // 계정권한

    public User toEntity() {
        User user = User.builder()
                .userid(userid)
                .password(password)
                .username(username)
                .email(email)
                .role(role.USER)
                .createdDate(LocalDateTime.now())
                .build();
        return user;
    }

}
