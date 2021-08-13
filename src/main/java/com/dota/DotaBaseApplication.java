package com.dota;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.cache.annotation.EnableCaching;

@SpringBootApplication
@EnableCaching
@MapperScan("com.dota.admin.mapper")
public class DotaBaseApplication {

  public static void main(String[] args) {
    SpringApplication.run(DotaBaseApplication.class, args);
  }
}
