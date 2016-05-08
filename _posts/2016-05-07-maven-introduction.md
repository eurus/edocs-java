---
layout: page
title:  "Maven 简介"
date:  2016-05-07 10:54:01
categories: maven
author: simon
---

## 简介

Maven这个单词来自于意第绪语，意为知识的积累。Maven通过pom.xml来管理项目的**构建、测试和报告**。

Maven工程中会有一个pom.xml用来记录所有与项目相关的配置信息。
**Maven也会严格要求文件、目录的摆放位置，如果摆放的位置不正确，Maven将无法正确构建项目**

Maven也有足够多的插件，来保证项目的个性化需求，比如自定义模板工程、内部JAR包发布共享机制（Nexus仓库）以及自动化测试覆盖报告等。

# 生命周期

Maven有明确的生命周期概念，而且都提供与之对应的命令，使得项目构建更加清晰明了。主要的生命周期阶段：

* validate，验证工程是否正确，所有需要的资源是否可用。
* clean 清理编译目录
* compile，编译项目的源代码。
* test，使用已编译的测试代码，测试已编译的源代码。
* package，已发布的格式，如jar，将已编译的源代码打包。
* verify，运行任何检查，验证包是否有效且达到质量标准。
* install，把包安装在本地的repository中，可以被其他工程作为依赖来使用
* deploy，在整合或者发布环境下执行，将最终版本的包拷贝到远程的repository，使得其他的开发者或者工程可以共享。

如果要执行项目编译，那么直接输入：`mvn compile`即可，对于其他的阶段可以类推。阶段之间是存在依赖关系的，如compile依赖clean，在执行`mvn test`时，相当于运行`mvn clean compile`。

除了生命周期外，maven也可以执行插件中的Goal来执行动作，常见的有:

```bash
mvn spring-boot:run # spring boot 启动服务
mvn flyway:migrate # flyway 数据库迁移
```

## 安装

Maven 是一套命令行工具，安装方式为在安装好jdk后，下载[Maven 3.1.1](http://maven.apache.org/download.cgi)。解压后，将bin路径添加到环境变量PATH中即可在命令行下使用（请提前设置JAVA_HOME）。

使用eclipse的小伙伴，直接下载最新版即可（已内含Maven支持）

# 配置

## settings.xml

[官方文档](https://maven.apache.org/settings.html)

settings.xml是maven的全局配置文件，放置在`~/.m2/`目录中。

一个典型的settings.xml大致为：

{% highlight xml %}
<?xml version="1.0" encoding="UTF-8"?>
<settings xmlns="http://maven.apache.org/SETTINGS/1.0.0"
  xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
  xsi:schemaLocation="http://maven.apache.org/SETTINGS/1.0.0 http://maven.apache.org/xsd/settings-1.0.0.xsd">

  <servers>
    <server>
      <id>eurus</id>
      <username>eurus</username>
      <password>eurusnet</password>
    </server>
  </servers>

  <mirrors>
    <mirror>
      <id>nexus</id>
      <mirrorOf>*</mirrorOf>
      <name>Nexus Mirror Repository</name>
      <url>http://eurus.cn:8081/nexus/content/groups/public</url>
    </mirror>
  </mirrors>
</settings>
{% endhighlight %}

这其中主要配置了两个内容：

1. `server`段，分享Jar包时，写入服务器的用户名和密码
2. `mirrors`段，下载Jar包时，使用风豪私有的镜像服务器

## pom.xml

[官方文档](https://maven.apache.org/pom.html)

pom.xml是maven工程配置文件。其中的重要配置参数为：

* artifactId 产品
* groupId 开发组织（一般为com.eurus）
* version 版本（分为release和snapshot两种，对应不同的仓库）
* packaging 打包方式（可选为jar/war/pom等）
* dependencies 依赖的所有JAR包
* build build时所需的插件配置
* reporting 生成报告时的插件配置

dependencies中，需要分别定义依赖jar包的信息，一个示例的定义段为：

{% highlight xml %}
<dependency>
  <groupId>commons-logging</groupId>
  <artifactId>commons-logging</artifactId>
  <version>1.1.1</version>
</dependency>
{% endhighlight %}

申明后保存，maven会自动下载JAR包并配置eclipse项目依赖。第一次下载时间较长。

# 目录结构

|目录|存放内容|
|---|---|
| lib | 无法在maven主站下载到的Jar包临时去处 |
| src/main/java | Java代码 |
| src/main/resources | 资源文件 |
| src/main/webapp | web app的根目录，相当于Web Root |
| src/test/java | Java测试代码 sources |
| src/test/resources | 测试所需资源文件 |
| target/classes | 编译生成的class文件所在 |
| target/site | 生成的网站 |
| LICENSE.txt | 项目许可证 |
| README.txt | 项目说明 |

## 应用场景

### 发布产品

右键点击工程 -> Run as -> Maven install

最后的成品可以在target目录中找到。

### 查找所需依赖

如果你需要查找一个类是在哪一个jar包中，请直接google这几个关键字：maven jar 类名

如果你需要查找一个jar包是如何书写dependency，你可以搜索[这里](http://www.mvnrepository.com/)

## 参考资料

* [Maven 生命周期](http://www.cnblogs.com/haippy/archive/2012/07/04/2576453.html)

