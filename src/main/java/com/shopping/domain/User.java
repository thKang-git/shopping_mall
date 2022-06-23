package com.shopping.domain;

import com.shopping.security.Role;
import lombok.*;
import org.springframework.data.annotation.CreatedDate;

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

    @Enumerated(EnumType.STRING)
    private Role role;

    private LocalDateTime createdDate = LocalDateTime.now(); // 생성일
}
