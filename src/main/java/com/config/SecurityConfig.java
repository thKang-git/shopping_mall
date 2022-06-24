package com.config;

import com.security.CustomAccessDeniedHandler;
import com.security.CustomUserDetailsService;
import lombok.RequiredArgsConstructor;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.security.config.annotation.authentication.builders.AuthenticationManagerBuilder;
import org.springframework.security.config.annotation.method.configuration.EnableGlobalMethodSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.builders.WebSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.configuration.WebSecurityConfigurerAdapter;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.web.access.AccessDeniedHandler;

@RequiredArgsConstructor
@Configuration
@EnableWebSecurity
@EnableGlobalMethodSecurity(prePostEnabled = true)
public class SecurityConfig extends WebSecurityConfigurerAdapter {

    private final CustomUserDetailsService customUserDetailsService;

    /**
     * 비밀번호 암호화
     */
    @Bean
    public BCryptPasswordEncoder encoder() {
        return new BCryptPasswordEncoder();
    }

    /**
     * 로그인 인증 처리
     */
    @Override
    protected void configure(AuthenticationManagerBuilder auth) throws Exception {
        auth.userDetailsService(customUserDetailsService).passwordEncoder(encoder());
    }

    /**
     * 인증 무시 (현재는 css, js, scripts, assets 접근 무시 설정)
     */
    @Override
    public void configure(WebSecurity web) throws Exception {
        web.ignoring().antMatchers( "/css/**", "/js/**", "/scripts/**", "/assets/**");
    }

    /**
     * 접근 제한 설정
     */
    @Override
    protected void configure(HttpSecurity http) throws Exception {
//        http
//                .csrf().disable()
//                .authorizeRequests()
//                .antMatchers("/", "/auth/login")
//                .permitAll()
//                .antMatchers("/shopping/list.do", "/shopping/view/**")
//                .hasAnyRole("USER", "ADMIN")
//                .antMatchers("/shopping/**")
//                .hasAnyRole("ADMIN")
//                .anyRequest()
//                .authenticated()
//                .and()
//                .formLogin()
//                .loginPage("/auth/login")
//                .loginProcessingUrl("/loginProc")
//                .defaultSuccessUrl("/shopping/list.do", true)
//                .and()
//                .logout()
//                .logoutSuccessUrl("/auth/login")
//                .invalidateHttpSession(true);
//
//        // 인증 거부 관련 처리
//        http.exceptionHandling().accessDeniedHandler(accessDeniedHandler());
        http
                .csrf().disable()
                .headers().frameOptions().disable();
    }

    private AccessDeniedHandler accessDeniedHandler() {
        CustomAccessDeniedHandler accessDeniedHandler = new CustomAccessDeniedHandler();
        accessDeniedHandler.setErrorPage("/auth/denied");
        return accessDeniedHandler;
    }
}
