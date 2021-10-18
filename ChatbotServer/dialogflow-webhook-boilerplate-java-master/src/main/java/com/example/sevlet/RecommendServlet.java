
package com.example.sevlet;


import java.io.IOException;
import java.util.List;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import com.example.service.CrawlingDataService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.annotation.ComponentScan;
import com.example.domain.CrawlingData;
import com.google.gson.Gson;
import com.google.gson.GsonBuilder;


@ComponentScan
@WebServlet(name = "recommend", value = "/recommend")
public class RecommendServlet extends HttpServlet {

    @Autowired //의존성 주입
    CrawlingDataService crawlingDataService;

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) throws IOException {
        String classification = "복지";
        Gson gson = new GsonBuilder().setPrettyPrinting().create();
        List<CrawlingData> crawlingDataList = crawlingDataService.findCrawlingClassificationData(classification);
        String jsonArray = gson.toJson(crawlingDataList);
        /* for local test
        CrawlingData crawlingData = new CrawlingData();
        crawlingData.setId(1);
        crawlingData.setUrl("test");
        crawlingData.setTitle("test");
        crawlingData.setContent("test");
        crawlingData.setClassification("복지");
        String json = gson.toJson(crawlingData);
        response.setContentType("application/json");
        response.getWriter().write(json);
        */
        response.setContentType("application/json");
        response.getWriter().write(jsonArray);

    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) throws IOException {
        response.setContentType("text/plain");
        response.getWriter().println("test");
    }
}

