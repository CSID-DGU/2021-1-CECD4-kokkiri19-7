package com.example.repository;

import com.example.domain.User;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Repository;

import javax.persistence.EntityManager;
import java.util.List;

@Repository
@RequiredArgsConstructor
public class UserRepository {

    private final EntityManager em;

    public void save(User user)
    {
        em.persist(user);
    }

    public User findOne(Long id){
        return em.find(User.class, id);
    }

    public List<User> findAll(){
        return em.createQuery("select m from User m", User.class)
                .getResultList();
    }

    public List<User> findByNickname(String nickname){
        return em.createQuery("select m from User m where m.nickname = :nickname", User.class)
                .setParameter("nickname", nickname)
                .getResultList();
    }
}
