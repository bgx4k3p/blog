---
date: 2019-04-22 12:20
layout: post
title: Uninstall Old Kernels on Ubuntu
subtitle: Quick notes
description: How to clean up old kernels on Ubuntu linux.
image: /assets/img/bash.jpg
category: Linux
tags: [Linux, Shell]
paginate: true
---


### One liner

```bash
echo $(dpkg --list | grep linux-image | awk '{ print $2 }' | sort -V | sed -n '/'`uname -r`'/q;p') $(dpkg --list | grep linux-headers | awk '{ print $2 }' | sort -V | sed -n '/'"$(uname -r | sed "s/\([0-9.-]*\)-\([^0-9]\+\)/\1/")"'/q;p') | xargs sudo apt-get -y purge
```
