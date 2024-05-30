import shutil
import os
import os.path as osp
import argparse
from glob import glob

HOME = osp.expanduser("~")
ROOT = osp.split(osp.split(osp.abspath(__file__))[0])[0]

def process_git(my_email, my_name):
    git_config_file = osp.join(ROOT, "git", ".gitconfig")
    git_ignore_global_file = osp.join(ROOT, "git", ".gitignore_global")

    entry_config_file = osp.join(HOME, ".gitconfig")
    if osp.exists(entry_config_file):
        os.rename(entry_config_file, osp.join(HOME, ".gitconfig.bak"))
        print("We backup ~/.gitconfig to ~/.gitconfig.bak!")
    with open(entry_config_file, "w") as f:
        user_str = "[user]\n    "
        user_str += "email = %s\n    " % my_email
        user_str += "name = %s\n" % my_name
        user_str += "\n"
        f.write(user_str)

        include_str = "[include]\n    "
        include_str += "path = %s\n" % git_config_file
        include_str += "\n"
        f.write(include_str)

        core_str = "[core]\n    "
        core_str += "excludesFile = %s\n" % git_ignore_global_file
        core_str += "\n"
        f.write(core_str)

        credential_str = "[credential]\n    "
        credential_str += "helper = store"
        credential_str += "\n"
        f.write(credential_str)

        f.close()

    print("Finish writing config info to ~/.gitconfig!\n")


def process_tmux():
    tmux_config_file = osp.join(ROOT, "tmux", ".tmux.conf")
    entry_tmux_config_file = osp.join(HOME, ".tmux.conf")

    if osp.exists(entry_tmux_config_file):
        os.rename(entry_tmux_config_file, osp.join(HOME, ".tmux.conf.bak"))
        print("We backup ~/.tmux.conf to ~/.tmux.conf.bak!")
    with open(entry_tmux_config_file, "w") as f:
        write_str = "source-file %s" % tmux_config_file
        write_str += "\n"
        f.write(write_str)
        f.close()

    print("Finish writing config info to ~/.tmux.conf!\n")


def process_vim(python_interp, python_lib):
    vim_rc_file = osp.join(ROOT, "vim", ".vimrc")
    ycm_global_ycm_extra_conf_file = osp.join(ROOT, "vim", ".ycm_global_ycm_extra_conf.py")
    entry_vim_rc_file = osp.join(HOME, ".vimrc")

    if osp.exists(entry_vim_rc_file):
        os.rename(entry_vim_rc_file, osp.join(HOME, ".vimrc.bak"))
        print("We backup ~/.vimrc to ~/vimrc.bak!")
    with open(entry_vim_rc_file, "w") as f:
        source_str = "\" source default .vimrc\n"
        source_str += "let $default_vimrc = \"%s\"\n" % vim_rc_file
        source_str += "source $default_vimrc\n"
        source_str += "\n"
        f.write(source_str)

        ycm_str = "\" ycm path config\n"
        ycm_str += "let g:ycm_python_interpreter_path = \"%s\"\n" % python_interp
        ycm_str += "let g:ycm_python_sys_path = [%s]\n" % ("\"" + python_lib + "\"")
        ycm_str += "let g:ycm_global_ycm_extra_conf = \"%s\"\n" %  ycm_global_ycm_extra_conf_file
        ycm_str += "\n"
        f.write(ycm_str)

        f.close()

    print("Finish writing config info to ~/.vimrc!\n")


def process_zsh():
    zsh_rc_file = osp.join(ROOT, "zsh", ".zshrc")
    entry_zsh_rc_file = osp.join(HOME, ".zshrc")

    if osp.exists(entry_zsh_rc_file):
        shutil.copyfile(entry_zsh_rc_file, osp.join(HOME, ".zshrc.bak"))
        print("We backup ~/.zshrc to ~/.zshrc.bak!")
    with open(entry_zsh_rc_file, "r+") as f:
        old = f.read()
        f.seek(0)

        source_str = "# source default .zshrc\n"
        source_str += "export default_zshrc=\"%s\"\n" % zsh_rc_file
        source_str += r"[ -f $default_zshrc ] && source $default_zshrc"
        source_str += "\n\n"
        f.write(source_str)

        oh_my_zsh_str = "# source oh-my-zsh\n"
        oh_my_zsh_str += r"[ -f $ZSH/oh-my-zsh.sh ] && source $ZSH/oh-my-zsh.sh"
        oh_my_zsh_str += "\n\n"
        f.write(oh_my_zsh_str)

        fzf_str = "# source fzf\n"
        fzf_str += r"[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh"
        fzf_str += "\n\n"
        f.write(fzf_str)

        auto_jump_str = "# source autojump\n"
        auto_jump_str += r"[ -f /usr/share/autojump/autojump.sh ] && . /usr/share/autojump/autojump.sh"
        auto_jump_str += "\n\n"
        f.write(auto_jump_str)

        f.write(old)
        f.close()

    print("Finish writing config into to ~/.zshrc!\n")
    print("There may be some repeated codes in ~/.zshrc, " + \
            "since we keep the orignal content.")
    print("Basically, this will not affect usage effect. " + \
            "But, anyway, you can check ~/.zshrc, " + \
            "and remove the repeated codes.")


if __name__ == "__main__":
    parser = argparse.ArgumentParser(description='config for linux softwares')
    parser.add_argument('--python_interp', type=str,
            default=osp.join(HOME, "anaconda3/bin/python"))
    parser.add_argument('--python_lib', type=str,
            default=osp.join(HOME, "anaconda3/lib/python*/site-packages"))
    parser.add_argument('--my_email', type=str,
            default="jinxin.ashin@outlook.com")
    parser.add_argument('--my_name', type=str, default="jinxin")
    args = parser.parse_args()

    python_interp = args.python_interp
    python_lib = args.python_lib
    my_email = args.my_email
    my_name = args.my_name
    process_git(my_email, my_name)
    process_tmux()
    process_vim(python_interp, python_lib)
    process_zsh()
