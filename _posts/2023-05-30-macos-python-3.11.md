---
date: 2023-05-30 12:24
layout: post
title: Set up Python 3.11 as default on MacOS
subtitle: How-to
description: Step by step instructions to set up Python 3.11 as the default on MacOS.
image: https://bgx4k3p.github.io/blog/assets/img/bash.jpg
category: macos
tags: macos python
author: bgx4k3p
paginate: true
---

## 1. Prerequisites

- Installed Homebrew: <https://brew.sh/>

## 2. Install Python 3.11

Run this command in Terminal to install Python 3.11 from Homebrew.

```bash
# Brew
bgx4k3p@MacBook:~$ brew install python@3.11
```

## 3. Add to BASH or ZSH profile

Run this command only once to append. If using Bash, replace the output file to **~/.bashrc**

```bash
# Append to shell profile
echo '
# Python 3.11
export PATH="$(brew --prefix)/opt/python@3.11/libexec/bin:$PATH"' | tee -a ~/.zshrc
```

## 4. Load Config

```bash
# Load shell profile
➜  ~ source ~/.zshrc

# Test
➜  ~ python
Python 3.11.3 (main, Apr  7 2023, 19:25:52) [Clang 14.0.0 (clang-1400.0.29.202)] on darwin
Type "help", "copyright", "credits" or "license" for more information.
>>> exit()
```
