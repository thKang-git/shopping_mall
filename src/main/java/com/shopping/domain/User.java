package com.shopping.domain;

import com.security.Role;
import lombok.*;

import javax.persistence.*;
import java.time.LocalDateTime;

@AllArgsConstructor
@NoArgsConstructor(access = AccessLevel.PROTECTED)
@Builder
@Getter
@Entity
@Table(name = "user")
public class User {

    @Id
    @GeneratedValue(strategy = GenerationType.IDENTITY)
    private Long id;

    private String userid;

    private String username;

    private String password;

    private String email;

    private String phone_no;

    @Enumerated(EnumType.STRING)
    private Role role;

    private LocalDateTime createdDate = LocalDateTime.now(); // 생성일
}
