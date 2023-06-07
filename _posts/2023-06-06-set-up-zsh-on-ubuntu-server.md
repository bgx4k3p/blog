---
date: 2023-06-06 01:44
layout: post
title: Customize ZSH on Ubuntu Server
subtitle: How-to
description: Step by step instructions to set up ZSH on Ubuntu and other Debian OS
image: https://bgx4k3p.github.io/blog/assets/img/bash.jpg
category: linux
tags: ubuntu linux zsh
author: bgx4k3p
paginate: true
---


## 1. Prerequisites

- Ubuntu Server

## 2. Install ZSH

Run this command in Terminal

```bash
apt-get update && apt-get install zsh -y
zsh --version
```

## 3. Set ZSH as default shell

Run this command in Terminal

```bash
chsh -s $(which zsh)
```

## 4. Install Oh-My-Zsh

Run this command in Terminal

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

## 5. Customize Oh-My-Zsh

Multiple themes are installed by default here:

```bash
ls ~/.oh-my-zsh/themes/
```

Run this command in Terminal to add fonts

```bash
apt-get install fonts-powerline -y
```

Customize the prompt by adding this code to ~/.zshrc

```bash
PROMPT='%{$fg_bold[blue]%}%m%{$fg_bold[red]%}|%{$fg_bold[cyan]%}%1~%{$reset_color%}%{$fg_bold[red]%}|%{$reset_color%}$(git_prompt_info)%{$fg_bold[cyan]%}⇒%{$reset_color%} '
```

For more info: <https://github.com/ohmyzsh/ohmyzsh/wiki/Themes>
