
package com.example.sevlet;


import java.io.IOException;
import java.sql.Date;
import java.util.List;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.example.domain.User;
import com.example.repository.UserRepository;
import com.example.service.CrawlingDataService;
import com.example.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import com.example.domain.CrawlingData;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;


@ComponentScan
@WebServlet(name = "UserLogin", value = "/user/login")
public class UserServlet extends HttpServlet {

    @Autowired
    UserService userService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        Gson gson = new GsonBuilder().setPrettyPrinting().create();

        //1. request 로 온 것중 email, nickname 확인
        String email = request.getParameter("email");
        String nickname = request.getParameter("nickname");
        User user = new User("email","nickname");
        //2. User 테이블에서 where email=email, nickname = nickname 인 것 있으면 login
        //3. 없어도 해당 email, nickname으로 회원가입 후 login
        Long userid = userService.join(user);

        user = userService.findUserById(userid);
        user.setAge(0);
        user.setBirthday(java.sql.Date.);
        user.setCity("");
        user.setGender("");
        user.setProvince("");


        String json = gson.toJson(user);
        response.setContentType("application/json");
        response.getWriter().write(json);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {

    }
}



