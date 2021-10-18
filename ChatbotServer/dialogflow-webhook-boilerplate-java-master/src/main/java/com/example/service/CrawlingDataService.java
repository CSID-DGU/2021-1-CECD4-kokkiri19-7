package com.example.service;

import com.example.domain.CrawlingData;
import com.example.repository.CrawlingDataRepository;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CrawlingDataService {

    private final CrawlingDataRepository crawlingDataRepository;

    public List<CrawlingData> findCrawlingData(){
        return crawlingDataRepository.findAll();
    }

    public List<CrawlingData> findCrawlingClassificationData(String classification){
        return crawlingDataRepository.findByClassification(classification);
    }

    public CrawlingData findCrawlingOneData(Long id){
        return crawlingDataRepository.findOne(id);
    }
}
