package com.example.domain;


import lombok.AllArgsConstructor;
import lombok.Getter;
import lombok.NoArgsConstructor;
import lombok.Setter;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.validation.constraints.NotNull;
import java.sql.Date;

@Entity
@NoArgsConstructor
@Getter @Setter
public class User {


    @Id @GeneratedValue
    private Long id;

    @NotNull
    private String nickname;

    @NotNull
    private String email;

    @Column(nullable = true)
    private String gender;
    @Column(nullable = true)
    private int age;
    @Column(nullable = true)
    private Date birthday;
    @Column(nullable = true)
    private String city;
    @Column(nullable = true)
    private String province;

    public User(String email, String nickname) {
        this.email=email;
        this.nickname=nickname;
    }

    public void setAge(Integer integer) {
        age=integer;
    }
}
