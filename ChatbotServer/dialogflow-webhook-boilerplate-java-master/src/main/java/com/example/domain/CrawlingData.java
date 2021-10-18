package com.example.domain;

import lombok.Getter;
import lombok.Setter;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;

@Entity
@Getter @Setter
public class CrawlingData {

    @Id @GeneratedValue
    private long id;

    private String title;
    private String classification;
    private String content;
    private String url;
}

