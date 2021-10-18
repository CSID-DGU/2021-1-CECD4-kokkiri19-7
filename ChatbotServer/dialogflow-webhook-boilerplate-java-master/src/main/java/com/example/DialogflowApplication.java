package com.example;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.ServletComponentScan;


@ServletComponentScan //서블릿컴포넌트 스캔 및 등록, local 사용시에만 동작
@SpringBootApplication
public class DialogflowApplication {
    public static void main(String[] args) {
        SpringApplication.run(DialogflowApplication.class, args);
    }
}
