---
layout: page
title:  "Spring Boot 简介"
date:  2016-05-07 10:54:43
categories: boot
author: simon
---

## 简介

Spring Boot是在Spring Framework基础上的一次简化，据我所知主要体现在这几个方面：

1. 以注解的形式简化Spring的配置
2. 引入starter的概念，简化工程依赖配置
3. `@EnableAutoConfiguration`进行全局自动配置

## Hello World

Spring Boot 可以采用Maven或Gradle作为项目工具，这里我们给出一个典型的`pom.xml`

```xml
<?xml version="1.0" encoding="UTF-8"?>
<project xmlns="http://maven.apache.org/POM/4.0.0" xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
    xsi:schemaLocation="http://maven.apache.org/POM/4.0.0 http://maven.apache.org/xsd/maven-4.0.0.xsd">
    <modelVersion>4.0.0</modelVersion>

    <groupId>com.eurus</groupId>
    <artifactId>myproject</artifactId>
    <version>0.0.1</version>
    <packaging>jar</packaging>

    <!-- Inherit defaults from Spring Boot -->
    <parent>
        <groupId>org.springframework.boot</groupId>
        <artifactId>spring-boot-starter-parent</artifactId>
        <version>1.3.3.RELEASE</version>
    </parent>

    <!-- Add typical dependencies for a web application -->
    <dependencies>
        <dependency>
            <groupId>org.springframework.boot</groupId>
            <artifactId>spring-boot-starter-web</artifactId>
        </dependency>
    </dependencies>

    <!-- Package as an executable jar -->
    <build>
        <plugins>
            <plugin>
                <groupId>org.springframework.boot</groupId>
                <artifactId>spring-boot-maven-plugin</artifactId>
            </plugin>
        </plugins>
    </build>
</project>
```

Spring Boot 提供了很多 "Starter POMs" 让添加依赖变得更加简单便捷。
其中我们可以看到`spring-boot-starter-parent`，这是一个特殊的starter，用来提供一些默认值，比如starter的集体版本。

其他的 "Starter POMs"提供了你开发某一类应用是必须要用到的依赖列表。例如，开发一个web应用，你就必须添上`spring-boot-starter-web`。

你可以在[这里](http://docs.spring.io/spring-boot/docs/current/reference/htmlsingle/#using-boot-starter-poms)找到完整的starter清单。

然后是Java文件：

```java
// src/main/java/com/eurus/WebApplication.java

import org.springframework.boot.*;
import org.springframework.boot.autoconfigure.*;
import org.springframework.stereotype.*;
import org.springframework.web.bind.annotation.*;

@RestController
@EnableAutoConfiguration
public class WebApplication {

    @RequestMapping("/")
    String home() {
        return "Hello World!";
    }

    public static void main(String[] args) throws Exception {
        SpringApplication.run(Example.class, args);
    }

}
```

然后就可以启动了，命令行执行`mvn spring-boot:run`或使用STS 右键`Run as > Spring Boot`

这个时候访问http://localhost:8080，就可以看到

    Hello World!

整个过程是不是异常简单

## 生成可执行的Jar包

```bash
mvn package
# 然后在target目录中，会生成myproject-0.0.1.jar
# 就可以运行了
java -jar myproject-0.0.1.jar
```

## 热插拔 Hot Swapping


在web应用开发中，热插拔（hot swapping）意味着你可以改动源码然后立即查看结果，只要刷新页面，而不需要重新编译整个工程并重启服务器。

下载[springloaded-1.2.6.RELEASE.jar](https://repo1.maven.org/maven2/org/springframework/springloaded/1.2.6.RELEASE/)然后放在一个目录中，记住路径，例如：`/<path-to>/springloaded-1.2.6.RELEASE.jar`


### Spring Tool Suite 配置

右键点击工程名 > Run As > Spring Boot (至少以Spring Boot的方式启动一次).

然后，再次右键点击工程名 > Run As > Run Configurations… > Spring Boot App > <project_name> > Arguments

在**VM Arguments**中贴入一段：

```bash
 -javaagent:/<path-to>/springloaded-1.2.6.RELEASE.jar -noverify
```

### Maven 配置

在`~/.bashrc`文件中，添加以下一行:

```bash
export MAVEN_OPTS="-javaagent:/<path-to>/springloaded-1.2.6.RELEASE.jar -noverify"
```

## 参考

* [HOT SWAPPING IN SPRING BOOT WITH ECLIPSE STS](http://blog.netgloo.com/2014/05/21/hot-swapping-in-spring-boot-with-eclipse-sts/)
