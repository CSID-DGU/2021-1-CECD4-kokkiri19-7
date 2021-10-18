
package com.example.sevlet;


import java.io.IOException;
import java.util.*;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import lombok.AllArgsConstructor;
import lombok.Data;
import org.jetbrains.annotations.NotNull;
import org.springframework.boot.Banner;
import org.springframework.context.annotation.ComponentScan;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;

@ComponentScan
@WebServlet(name = "Banner", value = "/banner")
public class BannerServlet extends HttpServlet {

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Gson gson = new GsonBuilder().setPrettyPrinting().create();

        //request :

        // for local test
        ArrayList<String> images = new ArrayList<>();
        ArrayList<String> urls = new ArrayList<>();

        images.add("http://www.junggu.seoul.kr/main/14236_image_1.jpg");
        images.add("http://www.junggu.seoul.kr/main/14236_image_2.jpg");

        urls.add("http://www.junggu.seoul.kr/content.do?cmsid=14603&mode=view&cid=1057965478");
        urls.add("https://blog.naver.com/junggu4u/222531074782");

        BannerDto bannerDto = new BannerDto(images,urls);

        String json = gson.toJson(bannerDto);

        response.setContentType("application/json");
        response.getWriter().write(json);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/plain");
        response.getWriter().println(
                "test");
    }

    @Data
    static class BannerDto{
        private ArrayList<String> images;
        private ArrayList<String> urls;

        public BannerDto() {
        }
        public BannerDto(ArrayList<String> images, ArrayList<String> urls) {
            this.images= images;
            this.urls=urls;
        }
    }
}

