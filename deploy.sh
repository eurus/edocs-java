#!/bin/bash
jekyll build
rsync -vzr --delete --exclude=node_modules _site/* deploy@eurus.cn:/var/www/edocs-java
