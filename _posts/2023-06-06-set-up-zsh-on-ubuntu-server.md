---
date: 2023-06-06 01:44
layout: post
title: Customize ZSH on Ubuntu Server
subtitle: How-to
description: Step by step instructions to set up ZSH on Ubuntu and other Debian OS
image: /assets/img/bash.jpg
category: Linux
tags: [Linux, Shell]
paginate: true
---

# Install and Customize ZSH on Ubuntu Server

As someone who likes simple copy/paste commands to save time rather than Googling every step, this tutorial is designed with that in mind. ZSH is known for its robust feature set, including auto-completion, spelling correction, and more. These are the steps to get it up and running on your system using straightforward, easy-to-follow commands.

## Prerequisites

Before getting started, ensure you have an Ubuntu server or another Debian-based Linux distribution installed and ready to go. These commands should work with most current distributions.

## Step 1: Install ZSH

Open a terminal window and run the following commands:

```bash
sudo apt-get update && sudo apt-get install zsh -y
zsh --version
```

#### What These Commands Do

- `apt-get update`: Updates the package list to ensure you have access to the latest software versions.
- `apt-get install zsh -y`: Installs ZSH and automatically confirms the installation (`-y` flag).
- `zsh --version`: Verifies that ZSH has been installed correctly by displaying its version.

## Step 2: Set ZSH as Default Shell

In your terminal, run:

```bash
chsh -s $(which zsh)
```

#### What These Commands Do

- `chsh`: Changes your current login shell.
- `-s $(which zsh)`: Specifies ZSH as the new default shell by providing its path (`$(which zsh)`).

## Step 3: Install Oh-My-Zsh

Open your terminal and run:

```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
```

#### What These Commands Do

- `curl`: Downloads the installation script from the Oh-My-Zsh repository.
- `sh -c ...`: Executes the downloaded script, which installs Oh-My-Zsh and sets up your environment.

## Step 4: Customize Oh-My-Zsh

#### Explore Themes

Oh-My-Zsh comes with a wide selection of themes to choose from. To see what's available, run:

```bash
ls ~/.oh-my-zsh/themes/
```

You can change the theme by modifying the `ZSH_THEME` variable in your `.zshrc` file.

#### Example: Change Theme to "agnoster"

Open your `.zshrc` file with a text editor like nano or vim and add:

```bash
export ZSH_THEME="agnoster"
```

#### Install Powerline Fonts

To enable special characters (like Unicode glyphs) in your prompt, install the Powerline fonts.

Run this command to install Powerline fonts:

```bash
sudo apt-get install fonts-powerline -y
```

## Step 5: Customize Prompt

A well-crafted prompt can provide valuable information at a glance, such as your current directory or git branch. Here's an example of how to customize your prompt using colors and Git integration.

#### Example Customization
Open your `.zshrc` file and add the following line:

```bash
PROMPT='%{$fg_bold[blue]%}%m%{$fg_bold[red]%}|%{$fg_bold[cyan]%}%1~%{$reset_color%}%{$fg_bold[red]%}|%{$reset_color%}$(git_prompt_info)%{$fg_bold[cyan]%}⇒%{$reset_color%} '
```

#### Explanation

- `%m`: Displays the hostname.
- `%1~`: Shows the current directory (up to 1 level).
- `git_prompt_info`: Displays Git information if you are in a git repository.

## Conclusion

Congratulations! You've successfully set up and customized ZSH on your Ubuntu or Debian server. This should provide a more efficient and enjoyable shell experience for managing your system.

Feel free to explore Oh-My-Zsh further by checking out its [official documentation](https://github.com/ohmyzsh/ohmyzsh/wiki)!

---

By following this guide, you can make the most of ZSH's capabilities on your Linux server. Happy coding!
