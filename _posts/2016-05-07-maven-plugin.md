---
layout: page
title:  "进阶：插件的使用"
date:  2016-05-07 10:54:29
categories: maven
author: simon
---

相信经过之前的介绍，Maven世界的大门已经向你打开，现在我们再来看一下如何使用插件将maven进行扩展

我们以Flyway这个用来做数据库迁移的工具作为例子：

## 配置

找到pom.xml中的`<build>`元素，如果没有的话，创建一个，并将内容设置为以下：

```xml
<build>
  <plugins>
    <!-- Flyway -->
    <plugin>
      <groupId>org.flywaydb</groupId>
      <artifactId>flyway-maven-plugin</artifactId>
      <version>3.2.1</version>
      <configuration>
        <locations>
          <location>
            classpath:db/migration
          </location>
        </locations>
        <user>your-username</user>
        <password>your-password</password>
        <url>jdbc:mysql://your-server:3306/your-db</url>
      </configuration>
    </plugin>
  </plugins>
</build>
```

然后在`src/main/resources/db/migration`加入`V1_init.sql`，再执行`mvn compile flyway:migrate`即可将sql在指定数据库上执行。

如果你需要配置更多的插件，只需要以`<plugin>`的形式继续插入`<plugins>`即可，是不是很简单？

## 锁定Java版本

有时候有好几个小伙伴一起开发一个项目，虽然IDE可以使用不同的JDK版本，但最后编译打包必须以一个版本为主，怎么做到呢？

只需要一行，在`<project>`下的`<properties>`中（如无，则创建一个），添加：

```xml
<java.version>1.8</java.version>
```

## 遇到镜像中找不到Jar包的情况处理

有些Jar包，不在中央库中，比如：Ping++或阿里大鱼

对于这些Jar包，有两种解决办法

### 上传至镜像服务器

通知管理员将相应的Jar包上传至镜像服务器

### 本地安装

1. 将Jar包放在工程的`lib`目录下
2. 配置插件，详见下
3. 将其中的id和configuration中的内容修改为真实情况
4. 使用`mvn clean`触发，这条命令的实际作用相当于执行`mvn install:install -Dfile=lib/xxx.jar -DgroupId=some-groupid -DartifactId=some-artifact -Dversion=some-version -Dpackaing=jar`

```xml
<plugin>
  <groupId>org.apache.maven.plugins</groupId>
  <artifactId>maven-install-plugin</artifactId>
  <executions>
    <execution>
      <id>some-id</id>
      <phase>clean</phase>
      <configuration>
        <file>${project.basedir}/lib/xxx.jar</file>
        <groupId>some-groupid</groupId>
        <artifactId>some-artifact</artifactId>
        <version>some-version</version>
        <packaging>jar</packaging>
      </configuration>
      <goals>
        <goal>install-file</goal>
      </goals>
    </execution>
  </executions>
</plugin>
```

如果有多个jar包需要安装，则使用多个`<execution>`标签即可。
