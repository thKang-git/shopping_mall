package com.shopping.security;

import org.springframework.security.access.AccessDeniedException;
import org.springframework.security.web.access.AccessDeniedHandler;

import javax.servlet.ServletException;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.IOException;

/**
 * 권한 없는 페이지 이동시 에러페이지 이동
 */
public class CustomAccessDeniedHandler implements AccessDeniedHandler {

    private String errorPage;

    @Override
    public void handle(HttpServletRequest httpServletRequest,
                       HttpServletResponse httpServletResponse,
                       AccessDeniedException e) throws IOException, ServletException {

        String deniedUrl = errorPage + "?exception=" + e.getMessage();
        httpServletResponse.sendRedirect(deniedUrl);
    }

    public void setErrorPage(String errorPage){
        this.errorPage = errorPage;
    }
}

