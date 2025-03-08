{ pkgs, global_utils, ... }:
{
  home.packages = with pkgs; [
    libtool
  ];

  home.file.".emacs.d/language-servers/ts".source = pkgs.typescript;
  services.emacs.enable = true;
  programs.emacs = {
    enable = true;
    package = pkgs.emacs-pgtk;
    # extraPackages = epkgs: with global_utils.pkgs-unstable.emacsPackages; [
    #   lsp-bridge
    #   # markdown-mode
    #   # yasnippet
    # ];
    extraPackages = epkgs: with epkgs; [
      lsp-bridge
      markdown-mode
      yasnippet
    ];
    extraConfig = ''
    (use-package yasnippet
    :ensure nil
    :config
    (yas-global-mode 1))

    (require 'lsp-bridge)

    (use-package lsp-bridge
    :ensure nil
    :init
    (global-lsp-bridge-mode)
    :general
    (general-define-key
    :keymaps 'acm-mode-map
    :states '(insert normal emacs)
    "C-j" 'acm-select-next
    "C-k" 'acm-select-prev)

    (general-define-key
    :keymaps 'lsp-bridge-mode-map
    :prefix ","
    :states '(normal motion)
    "g"  '(:ignore t :which-key "jump")
    "gg" '(lsp-bridge-find-def :which-key "find-def")
    "gG" '(lsp-bridge-find-def-other-window :which-key "find-def-other-window")
    "gb" '(lsp-bridge-find-def-return :which-key "find-def-return")
    "gt" '(lsp-bridge-find-type-def :which-key "find-type")
    "gT" '(lsp-bridge-find-type-def-other-window :which-key "find-type-other-window")
    "gi" '(lsp-bridge-find-impl :which-key "find-implementation")
    "gI" '(lsp-bridge-find-impl-other-window :which-key "find-impl-other-window")
    "gr" '(lsp-bridge-find-references :which-key "find-ref")

    "d"  '(:ignore t :which-key "doc")
    "dd" '(lsp-bridge-popup-documentation :which-key "pop-doc")
    "db" '(lsp-bridge-show-documentation :which-key "show-doc-buf")

    "r"  '(:ignore t :which-key "refactor")
    "rr" '(lsp-bridge-rename :which-key "rename")
    "ra" '(lsp-bridge-code-action :which-key "action")

    "b"  '(:ignore t :which-key "bugs")
    "bb" '(lsp-bridge-diagnostic-list :which-key "list-bugs")
    "bj" '(lsp-bridge-diagnostic-jump-next :which-key "next-bugs")
    "bk" '(lsp-bridge-diagnostic-jump-prev :which-key "prev-bugs")
    "by" '(lsp-bridge-diagnostic-copy :which-key "copy-bugs")

    "s"  '(:ignore t :which-key "symbols")
    "ss" '(lsp-bridge-workspace-list-symbol-at-point :which-key "list-symbol-at-point")
    "sa" '(lsp-bridge-workspace-list-symbols :which-key "list-all-symbols")
    )

    :custom
    (lsp-bridge-c-lsp-server 'clangd)
    (lsp-bridge-python-lsp-server 'pyright)
    (lsp-bridge-python-multi-lsp-server 'basedpyright_ruff)
    (lsp-bridge-nix-lsp-server 'nixd)
    (lsp-bridge-tex-lsp-server 'digestif)
    )

    (use-package vue-mode
    :hook
    (vue-mode . lsp-bridge-mode))


    (provide 'init-lspbridge)
    ;;; init-lspbridge.el ends here



    ;; make font work right
    (set-face-attribute 'default nil :font "Fira Code" :height efs/default-font-size)
    
    ;; Set the fixed pitch face
    (set-face-attribute 'fixed-pitch nil :font "Fira Code" :height efs/default-font-size)
    ;; Set the variable pitch face
    (set-face-attribute 'variable-pitch nil :font "LXGW WenKai" :height efs/default-variable-font-size :weight 'regular)
    (setq all-the-icons-dired-monochrome nil)  ;; 关闭单色图标模式,在文件系统中看起来更好
    '';

  };
}
