---
title: Travian analyser (php & MySQL)
image: assets/code.png
---

Find inactive players so that you can safely farm them. Made my own since commonly used one didn't include my server from the beginning, and time is of the essence here :wink:
 
Daily database dumps were loaded into local MySQL with cronjob, then this php used local DB to analyse whatever I wanted to see.

Many years later I've realised that this was basically my first ETL, data warehouse, and data analysis project. Solving real world problems, no :wink:

Main php file: [travian-analyser](https://github.com/inesucrvenom/inesucrvenom.github.io/tree/master/projects/php/travian-analyser/).
