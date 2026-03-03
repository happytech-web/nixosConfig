from typing import Dict
import os
import shlex


config.load_autoconfig(False)

c.url.default_page = "about:blank"

c.window.hide_decoration = True
# 隐藏底部状态栏 (平时隐藏，输入命令或报错时自动浮现)
c.colors.webpage.darkmode.enabled = True
c.colors.webpage.preferred_color_scheme = "dark"
c.colors.webpage.darkmode.policy.images = "never"

c.fileselect.handler = "external"
c.fileselect.single_file.command = [
    "kitty",
    "--title",
    "float-term",
    "yazi",
    "--chooser-file",
    "{}",
]
c.fileselect.multiple_files.command = [
    "kitty",
    "--title",
    "float-term",
    "yazi",
    "--chooser-file",
    "{}",
]

# Edit Text
my_terminal_editor = ["kitty", "--title", "float-term", "nvim"]
# 在 Insert 模式下按 Ctrl+space 呼出编辑器输入，默认使用markdown类型
c.editor.command = my_terminal_editor + [
    "-c",
    "if &ft == '' | set ft=markdown | endif",
    "{file}",
]
config.bind("<Ctrl-space>", "edit-text", mode="insert")

bookmark_file = os.path.expanduser("~/.config/qutebrowser/bookmarks/urls")
cmd_edit_bookmark = shlex.join(my_terminal_editor + [bookmark_file])


def bind_keys(bindings: Dict[str, str]):
    for k, v in bindings.items():
        config.bind(k, v)


bindings = {
    # reload
    "r": 'config-source ;; reload ;; message-info "config reload"',
    # sessions
    " ss": "session-save",
    " sl": "session-load default",
    " sL": "set-cmd-text -s :session-load ",
    # tabs
    " tt": "config-cycle tabs.show always never",
    " ti": "cmd-set-text -s :open -t",
    " th": "tab-prev",
    " tl": "tab-next",
    "<Ctrl-Alt-h>": "tab-prev",
    "<Ctrl-Alt-l>": "tab-next",
    "<Ctrl-Alt-H>": "tab-move -",
    "<Ctrl-Alt-L>": "tab-move +",
    " td": "tab-close",
    " ts": "cmd-set-text -s :tab-select",
    # bookmark
    " mi": "bookmark-add",
    " md": "bookmark-del",
    " ms": "cmd-set-text -s :bookmark-load -t",
    " me": f"spawn --detach {cmd_edit_bookmark}",
}

bind_keys(bindings)

enabled_scripts = [
    # CSDN 去广告
    "https://greasyfork.org/zh-CN/scripts/420352-csdn-focus",
    # 知乎免登录
    "https://greasyfork.org/zh-CN/scripts/396171-%E7%9F%A5%E4%B9%8E%E5%85%8D%E7%99%BB%E5%BD%95",
]


config.bind("<Ctrl-j>", "completion-item-focus next", mode="command")
config.bind("<Ctrl-k>", "completion-item-focus prev", mode="command")


# Emacs 风格：C-g 作为通用取消键

# command 模式（: / o / set-cmd-text 等）
config.bind("<Ctrl-g>", "mode-leave", mode="command")

# insert 模式（网页输入框）
config.bind("<Ctrl-g>", "mode-leave", mode="insert")

# prompt 模式（确认框 / 选择框）
config.bind("<Ctrl-g>", "mode-leave", mode="prompt")

# hint 模式（f / F 之后的链接选择）
config.bind("<Ctrl-g>", "mode-leave", mode="hint")

# passthrough（网页自己接管键盘时）
config.bind("<Ctrl-g>", "mode-leave", mode="passthrough")
