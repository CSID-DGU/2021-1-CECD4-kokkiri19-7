package com.example.repository;

import com.example.domain.CrawlingData;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import java.util.List;

@Repository
@RequiredArgsConstructor
public class CrawlingDataRepository {

    private final EntityManager em;

    public CrawlingData findOne(Long id) {
        return em.find(CrawlingData.class, id);
    }

    public List<CrawlingData> findAll() {
        return em.createQuery("select m from CrawlingData m", CrawlingData.class)
                .getResultList();
    }

    public List<CrawlingData> findByClassification(String classification) {
        return em.createQuery("select m from CrawlingData m where m.classification = :classification", CrawlingData.class)
                .setParameter("classification", classification)
                .getResultList();
    }

}
