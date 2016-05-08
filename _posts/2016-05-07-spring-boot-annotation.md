---
layout: page
title:  "Spring Boot 注解"
date:  2016-05-07 10:55:05
categories: boot
author: simon
---

既然是基于注解的简化，当然要好好讲一下Spring Boot常见的注解。

## @EnableAutoConfiguration

一般来说，会把Application类放在根包下，并在其中放置`@EnableAutoConfiguration`。这个注解会“猜”你想让Spring Boot如何工作，比如在classpath中出现JPA相关的Jar包，Spring Boot会自动搜索`@Entity`注解。

@EnableAutoConfiguration也会自动启动`@ComponentScan`：即所有子包内的注解了`@Controller`，`@Service`, `@Component`的类会自动被扫描到。

一个典型的工程目录结构为：

    com
     +- example
         +- myproject
             +- Application.java
             |
             +- domain
             |   +- Customer.java
             |   +- CustomerRepository.java
             |
             +- service
             |   +- CustomerService.java
             |
             +- web
                 +- CustomerController.java


## @Configuration

Spring Boot favors Java-based configuration. Although it is possible to call SpringApplication.run() with an XML source, we generally recommend that your primary source is a @Configuration class. Usually the class that defines the main method is also a good candidate as the primary @Configuration.

Spring Boot 将原有Spring基于XML的配置简化为注解配置，而`@Configuration`即为配置类。这个类可以和`@EnableAutoConfiguration`重合。

## @SpringBootApplication

相当于`@Configuration`, `@EnableAutoConfiguration`和`@ComponentScan`的组合

## 依赖注入相关

应用程序组件包括四类：`@Component`, `@Service`, `@Repository`, `@Controller`。

只有在拥有这些注解的类当中，才能使用`@Autowired`和`@Bean`。

其中，`@Bean`负责定义一个Bean的初始化过程，例如：

```java
@SpringBootApplication
public class WebApplication extends WebMvcConfigurerAdapter {

  @Bean
  public WxMpConfigStorage getWxMpConfigStorage() {
    WxMpInMemoryConfigStorage config = new WxMpInMemoryConfigStorage();
    config.setAppId(wechatAppId); // 设置微信公众号的appid
    config.setSecret(wechatAppSecret); // 设置微信公众号的appSecret
    config.setToken(wechatToken); // 设置微信公众号的token
    config.setAesKey(wechatAESKey); // 设置微信公众号的EncodingAESKey
    return config;
  }

  @Bean
  public WxMpService getWxMpService(WxMpConfigStorage config) {
    WxMpService wxService = new WxMpServiceImpl();
    wxService.setWxMpConfigStorage(config);
    return wxService;
  }
}

```

然后在需要的地方，即可以使用

```java
  @Autowired
  WxMpService wxMpService;
```

来使用定义好的Bean，利用依赖注入（Dependency Injection）彻底减少了耦合。

### @Autowired

`@Autowired`负责定义使用一个Bean的位置，可以出现在3处：

1. setter方法
2. 构造函数
3. 类成员

```java
// 1. @Autowired setter method
public class Customer {
  private Person person;
  private int type;

  @Autowired
  public void setPerson(Person person) {
    this.person = person;
  }
}
```

```java
// 2. @Autowired construtor
public class Customer {
  private Person person;
  private int type;

  @Autowired
  public Customer(Person person) {
    this.person = person;
  }
}
```

```java
// 3. @Autowired field
public class Customer {
  @Autowired
  private Person person;
  private int type;
}
```
