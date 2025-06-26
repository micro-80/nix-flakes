;; 1. macOS path config
(when (and (eq system-type 'darwin)
           (not (getenv "IN_NIX_SHELL")))

  ;; a. add Nix-installed Emacs packages to load-path
  (let* ((default-directory "/nix/store/")
         (nix-elisp-paths
          (directory-files default-directory t ".*emacs.*share/emacs/site-lisp$")))
    (dolist (path nix-elisp-paths)
      (add-to-list 'load-path path)))

  ;; b. add ~/.nix-profile/bin to exec-path and PATH
  (let ((nix-profile-bin (expand-file-name "~/.nix-profile/bin")))
    (when (file-directory-p nix-profile-bin)
      (setenv "PATH" (concat nix-profile-bin ":" (getenv "PATH")))
      (add-to-list 'exec-path nix-profile-bin))))

;; 2. options
(menu-bar-mode -1)
(scroll-bar-mode -1)
(set-face-attribute 'default nil :height 140)
(tool-bar-mode -1)
(setq inhibit-startup-screen t)
(setq initial-scratch-message nil)
(setq ring-bell-function 'ignore)

;; 3. plugins
(require 'use-package)

;; Add extra completion backends (cape = Completion At Point Extensions)
(use-package cape
  :init
  ;; Add various capes to completion-at-point-functions
  (add-to-list 'completion-at-point-functions #'cape-file)    ;; file paths
  (add-to-list 'completion-at-point-functions #'cape-dabbrev) ;; words in buffer
  ;; You can add more: cape-keyword, cape-symbol, cape-history, etc.
)

(use-package catppuccin-theme
  :config
  (load-theme 'catppuccin :no-confirm)
  (setq catppuccin-flavor 'macchiato)
  (catppuccin-reload)
)

(use-package consult)

(use-package corfu
  :init
  (global-corfu-mode)
  :custom
  (corfu-auto t)                 ;; Enable auto popup
  (corfu-cycle t)                ;; Allows cycling through candidates
  (corfu-quit-no-match 'separator) ;; Don't quit immediately
  (corfu-preselect 'prompt))     ;; Show prompt at top

(use-package evil
  :init
  (setq evil-want-integration t)      ;; required by evil-collection
  (setq evil-want-keybinding nil)     ;; defer to evil-collection
  (setq evil-want-C-u-scroll t)       ;; emulate Vim C-u scrolling
  (setq evil-want-C-i-jump t)         ;; tab jump behavior
  :config
  (evil-mode 1))

(use-package evil-collection
  :after (evil consult)
  :config
  (setq evil-collection-setup-minibuffer t)
  (evil-collection-init)
)

(use-package evil-surround
  :after evil
  :config
  (global-evil-surround-mode 1))

(use-package evil-commentary
  :after evil
  :config
  (evil-commentary-mode))

(use-package git-auto-commit-mode
  :custom
  (gac-automatically-add-new-files-p t)
  (gac-automatically-push-p t)
)

(use-package flycheck
  :hook (after-init . global-flycheck-mode))

(use-package lsp-mode
  :init
  :after flycheck
  (setq lsp-diagnostics-provider :flycheck))

(use-package magit)

(use-package marginalia
  :init
  (marginalia-mode))

(use-package orderless
  :init
  (setq completion-styles '(orderless)
        completion-category-defaults nil
        completion-category-overrides '((file (styles . (partial-completion))))))

(use-package org
  :config
  (add-to-list 'org-modules 'org-tempo))

(use-package treesit-auto
  :config
  (global-treesit-auto-mode))

(use-package which-key
  :config
  (which-key-mode))

(use-package vertico
  :init
  (vertico-mode)
  :bind
  (:map vertico-map
        ("C-j" . vertico-next)
        ("C-k" . vertico-previous))
)

(use-package vterm
  :bind
  ("M-<return>" . vterm))
