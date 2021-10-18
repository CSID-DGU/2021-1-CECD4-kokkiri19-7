/*
 * Copyright 2018 Google LLC
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     https://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */

package com.example;

import com.example.domain.CrawlingData;
import com.example.service.CrawlingDataService;
import com.google.actions.api.ActionRequest;
import com.google.actions.api.ActionResponse;
import com.google.actions.api.DialogflowApp;
import com.google.actions.api.ForIntent;
import com.google.actions.api.response.ResponseBuilder;
import com.google.api.services.actions_fulfillment.v2.model.*;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.ResourceBundle;

import lombok.RequiredArgsConstructor;
import lombok.extern.apachecommons.CommonsLog;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Component;
import org.springframework.stereotype.Controller;


@Component
public class MyActionsApp extends DialogflowApp {

    private CrawlingDataService crawlingDataService;

    @ForIntent("welfare")
    public ActionResponse welfareAsk(ActionRequest request) {
        ResponseBuilder responseBuilder = getResponseBuilder(request);
        //List<CrawlingData> crawlingDataList = crawlingDataService.findCrawlingClassificationData();
        CrawlingData crawlingData = new CrawlingData();
        crawlingData.setId(1);
        crawlingData.setUrl("http://www.junggu.seoul.kr/content.do?cmsid=14386&sf_text4=F");
        crawlingData.setTitle("국민연금 실업크레딧");
        crawlingData.setContent("지원내용\n" +
                "실업급여를 받는 실업자에게 국민연금보험료를 지원해 주는 사회적제도로 실업기간에도 보험료를 납입함으로써 노후대비를 할 수 있도록 도움을 주는 제도\n" +
                "- 지원기간 : 구직급여를 받는 기간 중 지원 (최대 1년)\n" +
                "- 지원방법 : 본인부담분 25%를 납부하면 국민연금 보험료의 75%지원 ");
        crawlingData.setClassification("복지");
        String title = crawlingData.getTitle();
        String content = crawlingData.getContent();
        String url = crawlingData.getUrl();
        String classification = crawlingData.getClassification();
        responseBuilder
                .add("basic card")
                .add(
                        new BasicCard()
                                .setTitle(title)
                                .setSubtitle(classification)
                                .setFormattedText(content)
                                .setImage(
                                        new Image()
                                                .setUrl(url)
                                                .setAccessibilityText("Image alternate text"))
                                .setImageDisplayOptions("CROPPED")
                                .setButtons(
                                        new ArrayList<Button>(
                                                Arrays.asList(
                                                        new Button()
                                                                .setTitle("This is a Button")
                                                                .setOpenUrlAction(
                                                                        new OpenUrlAction().setUrl(url))))))
                .add("Which response would you like to see next?");
        return responseBuilder.build();
    }

    @ForIntent("Problem")
    public ActionResponse problem(ActionRequest request) {
        ResponseBuilder responseBuilder = getResponseBuilder(request);
        String text =
                "This is a basic card.  Text in a basic card can include \"quotes\" and\n"; // Note the two spaces before '\n' required for
        responseBuilder
                .add("Here's an example of a basic card.")
                .add(
                        new BasicCard()
                                .setTitle("Title: this is a title")
                                .setSubtitle("This is a subtitle")
                                .setFormattedText(text)
                                .setImage(
                                        new Image()
                                                .setUrl(
                                                        "https://storage.googleapis.com/actionsresources/logo_assistant_2x_64dp.png")
                                                .setAccessibilityText("Image alternate text"))
                                .setImageDisplayOptions("CROPPED")
                                .setButtons(
                                        new ArrayList<Button>(
                                                Arrays.asList(
                                                        new Button()
                                                                .setTitle("This is a Button")
                                                                .setOpenUrlAction(
                                                                        new OpenUrlAction().setUrl("https://assistant.google.com"))))))
                .add("Which response would you like to see next?");

        return responseBuilder.build();
    }
}
