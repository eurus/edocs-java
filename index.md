---
layout: default
title: "风豪科技 文档模板"
---

## 公司

风豪科技，是一个梦开始的地方，我们践行着```We do IT Better```的信念，竭尽全力提供清新易用的IT解决方案。你可以在[Github](https://github.com/eurus) 上找到我们:)

## 使用方式

你可以使用以下方式创建一个文档页面:

```bash
npm install -g edocs-utils
new-edoc some-file-name -a simon -c intro
# -a 表示作者
# -c 表示category类别，默认配置请参见_config.xml
# -o 表示输出路径，默认在执行路径的_posts目录下
```

### 配置

- 修改`config.yml`中sections，并在调用`new-edoc`时使用正确的category
- 修改```index.md```中的描述文字及```title```
- 修改`config.yml`中的`title`和`subtitle`字段
- 修改`config.yml`中的git仓库地址

### 启动

**Mac OS**

```bash
gem install jekyll
jekyll s -w
```

**Windows**

```bash
npm install -g darko
darko serve --watch
```
