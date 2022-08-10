package com.shopping.dto;

import com.shopping.domain.User;
import com.security.Role;
import lombok.Getter;

import java.io.Serializable;
import java.time.LocalDateTime;

@Getter
public class UserSessionDto implements Serializable {
    private Long id;
    private String userid;
    private String password;
    private String username;
    private String email;
    private Role role;
    private LocalDateTime createdDate; // 생성일

    /* Entity -> Dto */
    public UserSessionDto(User user) {
        this.id = user.getId();
        this.userid = user.getUserid();
        this.password = user.getPassword();
        this.username = user.getUsername();
        this.email = user.getEmail();
        this.role = user.getRole();
        this.createdDate = user.getCreatedDate();
    }
}
