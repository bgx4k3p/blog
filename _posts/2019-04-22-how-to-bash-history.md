---
date: 2019-04-22 12:26
layout: post
title: Dedup BASH History
subtitle: Quick notes
description: One-liner to dedup Bash History.
image: /assets/img/bash.jpg
category: Linux
tags: [Linux, Shell]
paginate: true
---


```bash
# Remove duplicates
nl ~/.bash_history | sort -k 2  -k 1,1nr| uniq -f 1 | sort -n | cut -f 2 > unduped_history

# Replace history file
cp unduped_history ~/.bash_history
rm -f unduped_history
```
