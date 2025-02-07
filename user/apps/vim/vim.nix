{ pkgs, ... }: {
  programs.vim = {
    enable = true;
    settings = {
      background = "dark";
      mousefocus = true;
      number = true;
      ignorecase = true;
      smartcase = true;
    };
     extraConfig = ''
      " 插入模式用 jk 退出到 Normal 模式
      inoremap jk <Esc>
      
      " 更快的 Esc 响应（单位：毫秒）
      set timeoutlen=1000
      set ttimeoutlen=0
      
      " 语法高亮
      syntax enable

      " 启用剪贴板支持
      if has('clipboard')
        set clipboard=unnamedplus
      endif
      
      " 自动重新加载外部修改的文件
      set autoread

      " 缩进相关
      set autoindent
      set smarttab
    '';
  };
}
