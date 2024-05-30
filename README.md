# My Software Configs for Ubuntu

This repo maintains my config files for vim, zsh, git, and tmux. It will help to
set up a deeply personal Linux environment, which is convenient and fast for
text editing, code development, and multi-task management.

## Usage

We provide a script to automatically setup config files simultaneously for vim,
zsh, git, and tmux.  Specifically, you only need to run:

```python
python -m tools.setup
```
under the root dir of this repo.

However, to make the setup process go smoothly and compatible to existing Linux
environment, we suggest to finish the following preparatory work step-by-step
before you running above code.

## Step-by-step preparatory work

### git

Git is not only a powerful version control tool, but also is the default way for
installing many softwares. Therefore, we suggest to install Git first by
`apt-get install git`, when entering a newly installed Linux system.

### zsh and oh-my-zsh

We suggest to use `zsh` rather than the native bash shell in Linux. We also
suggest to use the `oh-my-zsh` framework to manage the `zsh` configuration.

`zsh` can be directly installed by `apt-get install zsh`, and the installation
of `oh-my-zsh` can refer to <https://zhuanlan.zhihu.com/p/58073103>. The reason
-- why `zsh` is a perfect shell -- can be found here
<https://www.zhihu.com/question/21418449/answer/300879747>.

### anaconda

Anaconda provides an extremely convenient way to set up customized scientific
computing environment (not just for python).  We suggest to use Anaconda to set
up a default environment for our daily use, including Python, gcc, and even some
practical tools like `glances` (installed by pip).

We suggest to install commonly used packages (e.g., PyTorch for a deep learning
practitioner) within the default conda env which is typically named as `base`.
This will greatly reduce our cost in switching conda env.

### vim

We suggest to compile Vim from source code to support a wider range of new
features. Actually, it is not that difficult, and you can just follow the steps
described by
<https://github.com/ycm-core/YouCompleteMe/wiki/Building-Vim-from-source>. When
compiling Vim, you can use the config file for Python within the default conda
env.

### tmux

Tmux is a powerful tool for window splitting and multi-task management. Tmux can
be conveniently installed by `apt-get install tmux`.

### setup.py

Before running `python -m tools.setup`, you need to check the path setting in
"/tools/setup.py". If the default setting does not match with your linux
environment, you need to modify it.
