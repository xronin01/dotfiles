;; Set Custom-file
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))

(menu-bar-mode 0)
(tool-bar-mode 0)
(scroll-bar-mode 0)

;; Android
;; (when (eq system-type 'android)
;;   (unless (string-prefix-p "/data/data/com.termux" (expand-file-name "~"))
;;     (setq touch-screen-preview-select t
;; 	  touch-screen-display-keyboard t
;; 	  overriding-text-conversion-style nil)
;;     (setopt tool-bar-position 'bottom)
;;     (tool-bar-mode 1)
;;     (modifier-bar-mode 1)))

;; Font
(add-to-list 'default-frame-alist '(font . "Maple Mono NF"))

(global-hl-line-mode 1)
(column-number-mode 1)
(which-key-mode 1)
(electric-pair-mode 1)

(setq make-backup-files nil
      create-lockfiles nil
      auto-save-default nil)

(fset 'yes-or-no-p 'y-or-n-p)

;; Line-numbers
(dolist (hook '(prog-mode-hook conf-mode-hook text-mode-hook))
  (add-hook hook #'display-line-numbers-mode 1))
(setq display-line-numbers-type 'relative)

;; Dired
(setq dired-listing-switches "-al --group-directories-first"
      dired-mouse-drag-files t
      mouse-drag-and-drop-region-cross-program t)

;; Lsp
(setq eglot-server-programs
      '(((c-mode c-ts-mode c++-mode c++-ts-mode) . ("clangd"))
	((rust-mode rust-ts-mode) . ("rust-analyzer"))
	((kotlin-mode kotlin-ts-mode) . ("kotlin-lsp" "--stdio"))
	((elixir-mode elixir-ts-mode heex-ts-mode) . ("expert" "--stdio"))
	((lua-mode lua-ts-mode) . ("lua-language-server"))
	((conf-toml-mode toml-ts-mode) . ("taplo" "lsp" "stdio"))
	))
(dolist (entry eglot-server-programs)
  (dolist (mode (car entry))
    (add-hook (intern (concat (symbol-name mode) "-hook"))
	      #'eglot-ensure)))

;; Add Melpa to the package repos
(require 'package)
(add-to-list 'package-archives' ("melpa" . "https://melpa.org/packages/") t)

;; Packages
(use-package catppuccin-theme
  :ensure t
  :config
  (load-theme 'catppuccin t))

(use-package nerd-icons
  :ensure t)

(use-package evil
  :ensure t
  :init
  (setq evil-want-keybinding nil
	evil-undo-system 'undo-redo)
  :config
  (setq evil-vsplit-window-right t
	evil-split-window-below t
	evil-normal-state-tag "NORMAL"
	evil-insert-state-tag "INSERT"
	evil-visual-char-tag "VISUAL"
	evil-visual-line-tag "V-LINE"
	evil-visual-block-tag "V-BLOCK"
	evil-replace-state-tag "REPLACE"
	evil-operator-state-tag "O-PENDING"
	evil-motion-state-tag "MOTION"
	evil-emacs-state-tag "EMACS") 
  (evil-mode 1))

(use-package evil-collection
  :ensure t
  :after evil
  :init
  (setq evil-collection-setup-minibuffer t)
  :config
  (evil-collection-init))

(use-package evil-cleverparens
  :ensure t
  :after evil
  :hook
  (emacs-lisp-mode . evil-cleverparens-mode))

(use-package evil-surround
  :ensure t
  :after evil
  :config
  (global-evil-surround-mode 1))

(use-package evil-commentary
  :ensure t
  :after evil
  :config
  (evil-commentary-mode 1))

(use-package evil-terminal-cursor-changer
  :ensure t
  :after evil
  :hook
  (tty-setup . evil-terminal-cursor-changer-activate))

(use-package treesit-auto
  :ensure t
  :config
  ;; (setq treesit-auto-install 'prompt
  ;; 	treesit-auto-langs '(c
  ;; 			     cpp
  ;; 			     rust
  ;; 			     kotlin
  ;; 			     elixir
  ;; 			     heex
  ;; 			     lua
  ;; 			     javascript
  ;; 			     bash
  ;; 			     html
  ;; 			     css
  ;; 			     markdown
  ;; 			     org
  ;; 			     ;; latex
  ;; 			     typst))
  ;; (treesit-auto-install-all)
  (treesit-auto-add-to-auto-mode-alist)
  (global-treesit-auto-mode 1))

(use-package treesit-langs
  :vc (:url "https://github.com/emacs-tree-sitter/treesit-langs"
       :branch "main"
       :rev :newest))

(use-package treesit-fold
  :ensure t)

(use-package mason
  :ensure t
  :config
  (mason-ensure))

(use-package dape
  :ensure t)

(use-package agent-shell
  :ensure t)

(use-package eldoc-mouse
  :ensure t
  :hook
  (emacs-lisp-mode eglot-managed-mode))

(use-package corfu
  :ensure t
  :demand t
  :config
  (setq corfu-auto t
        corfu-cycle t)
  (global-corfu-mode 1)
  (corfu-popupinfo-mode 1)
  :bind
  (:map corfu-map
        ("TAB" . corfu-next)
        ([tab] . corfu-next)
        ("S-TAB" . corfu-previous)
        ([backtab] . corfu-previous)))

(use-package nerd-icons-corfu
  :ensure t
  :after corfu
  :config
  (add-to-list 'corfu-margin-formatters #'nerd-icons-corfu-formatter))

;; Remove this in emacs 31
(use-package corfu-terminal
  :ensure t
  :after corfu
  :hook
  (tty-setup . corfu-terminal-mode))

(use-package cape
  :ensure t
  :hook
  (completion-at-point-functions . cape-file)
  (completion-at-point-functions . cape-dabbrev)
  (completion-at-point-functions . cape-keyword))

(use-package vertico
  :ensure t
  :config
  (setq vertico-cycle t)
  (vertico-mode 1)
  (vertico-mouse-mode 1))

(use-package marginalia
  :ensure t
  :config
  (marginalia-mode 1))

(use-package nerd-icons-completion
  :ensure t
  :after marginalia
  :config
  (nerd-icons-completion-mode 1)
  (add-hook 'marginalia-mode-hook #'nerd-icons-completion-marginalia-setup))

(use-package orderless
  :ensure t
  :config
  (setq completion-styles '(orderless basic)
	completion-category-overrides '((file (styles partial-completion)))))

(use-package doom-modeline
  :ensure t
  :config
  (setq doom-modeline-modal-icon nil)
  (doom-modeline-mode 1)
  (doom-modeline-def-modeline 'my-modeline
    '(bar modals vcs buffer-info)
    '(debug check lsp major-mode buffer-encoding buffer-position)
    )
  (doom-modeline-set-modeline 'my-modeline 'default))

(use-package centaur-tabs
  :ensure t
  :config
  (setq centaur-tabs-set-icons t
	centaur-tabs-icon-type 'nerd-icons
	centaur-tabs-set-bar 'left
	centaur-tabs-height 32)
  (centaur-tabs-mode 1))

;; (use-package indent-bars
;;   :config
;;   (setq indent-bars-treesit-support t
;; 	indent-bars-prefer-character t)
;;   :hook (prog-mode . indent-bars-mode))

(use-package colorful-mode
  :ensure t
  :config
  (global-colorful-mode 1)
  (add-to-list 'global-colorful-modes 'conf-toml-mode))

(use-package diff-hl
  :ensure t
  :config
  (global-diff-hl-mode 1)
  (add-hook 'dired-mode-hook
	    (lambda ()
	      (diff-hl-dired-mode 1)
	      (diff-hl-margin-mode 1))))

(use-package dirvish
  :ensure t
  :demand t
  :config
  (setq dirvish-attributes '(subtree-state))
  (when (featurep 'nerd-icons)
    (push 'nerd-icons dirvish-attributes))
  (when (featurep 'diff-hl)
    (push 'vc-state dirvish-attributes))
  (when (featurep 'evil)
    (evil-make-overriding-map dirvish-mode-map 'normal)) 
  (dirvish-override-dired-mode 1)
  :bind
  (:map dirvish-mode-map
	("TAB" . dirvish-subtree-toggle)))

(use-package filechooser
  :ensure t)

(use-package ement
  :ensure t)

(use-package vterm
  :ensure t
  :config
  (when (featurep 'evil)
    (when (derived-mode-p 'vterm-mode)
      ;; (setq-local evil-insert-state-tag "TERMINAL" )
      (add-hook 'evil-insert-state-entry-hook
		(lambda ()
		  (setq-local global-hl-line-mode nil)))
      (add-hook 'evil-insert-state-exit-hook
		(lambda ()
		  (kill-local-variable 'global-hl-line-mode))))))

(use-package xclip
  :ensure t
  :hook
  (tty-setup . xclip-mode))

;; (use-package exwm
;;   :ensure t
;;   :config
;;   (exwm-wm-mode 1))

;; (use-package xdg-launcher
;;   :vc (:url "https://github.com/emacs-exwm/xdg-launcher"
;; 	      :branch "main"
;; 	      :rev :newest))

;; Load Custom-file
(when (file-exists-p custom-file)
  (load custom-file))
