;; 1. Options
(setq inhibit-startup-message t
  visible-bell t)

(load-theme 'gruvbox-dark-soft t)
(custom-theme-set-faces
  'user
  '(default ((t (:family "Inconsolata" :height 160))))
  '(variable-pitch ((t (:family "Helvetica Neue" :height 160 :weight regular))))
  '(fixed-pitch ((t ( :family "Inconsolata" :height 160)))))

;; TODO: order in some way
(setq make-backup-files nil)
(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode -1)
(global-auto-revert-mode 1)
(setq global-auto-revert-non-file-buffers t)
(global-display-line-numbers-mode 1)
(save-place-mode 1)
(setq history-length 25)
(savehist-mode 1)
(visual-line-mode 1)

(add-hook 'emacs-startup-hook 'toggle-frame-maximized)

;; 2. Various Plugins
(use-package consult
  :ensure t
  :bind
  (("C-x b" . consult-buffer)         ;; Switch buffers
   ("C-x C-r" . consult-recent-file)  ;; Recently opened files
   ("C-s" . consult-line)             ;; Search within buffer
   ("M-g g" . consult-goto-line)      ;; Go to line
   ("C-c p b" . consult-project-buffer))) ;; Buffers in current project

(use-package corfu
  :hook ((prog-mode . corfu-mode)))

(use-package envrc
  :hook (after-init . envrc-global-mode))

(use-package evil
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  :config
  (evil-mode 1)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line)

  (evil-set-initial-state 'messages-buffer-mode 'normal)
  (evil-set-initial-state 'dashboard-mode 'normal))

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init))

(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))

(use-package flymake
  :bind (:map prog-mode-map
              ("M-n" . flymake-goto-next-error)
              ("M-p" . flymake-goto-prev-error)))

(use-package marginalia
  :ensure t
  :init
  (marginalia-mode))

(use-package org
  :custom
  (org-hide-emphasis-markers t)
  :config
  (let* ((variable-tuple
          (cond ((x-list-fonts "Helvetica Neue")  '(:font "Helvetica Neue"))
                ((x-list-fonts "Verdana")         '(:font "Verdana"))
                ((x-family-fonts "Sans Serif")    '(:family "Sans Serif"))
                (nil (warn "Cannot find a suitable font"))))
         ;; (base-font-color (face-foreground 'default nil 'default))
         (headline `(:inherit default :weight bold)))

    (custom-theme-set-faces
     'user
     `(org-level-8 ((t (,@headline ,@variable-tuple))))
     `(org-level-7 ((t (,@headline ,@variable-tuple))))
     `(org-level-6 ((t (,@headline ,@variable-tuple))))
     `(org-level-5 ((t (,@headline ,@variable-tuple))))
     `(org-level-4 ((t (,@headline ,@variable-tuple :height 1.1))))
     `(org-level-3 ((t (,@headline ,@variable-tuple :height 1.25))))
     `(org-level-2 ((t (,@headline ,@variable-tuple :height 1.5))))
     `(org-level-1 ((t (,@headline ,@variable-tuple :height 1.75))))
     `(org-document-title ((t (,@headline ,@variable-tuple :height 2.0 :underline nil))))))

  :hook
  ((org-mode . (lambda () (display-line-numbers-mode 0)))
         (org-mode . variable-pitch-mode)))

(use-package pdf-tools
  :config
  (pdf-tools-install)
  :custom
  (pdf-view-display-size 'fit-page)
  :hook
  (pdf-view-mode . (lambda () (display-line-numbers-mode -1))))

(use-package olivetti
  :custom
  (olivetti-style 'fancy)
  (olivetti-body-width 100)
  :hook
  (olivetti-mode . (lambda ()
    (when (eq olivetti-style 'fancy)
      (set-face-background 'olivetti-fringe "#665c54"))))
  (org-mode . olivetti-mode))

(use-package orderless
  :custom
  ;; Configure a custom style dispatcher (see the Consult wiki)
  ;; (orderless-style-dispatchers '(+orderless-consult-dispatch orderless-affix-dispatch))
  ;; (orderless-component-separator #'orderless-escapable-split-on-space)
  (completion-styles '(orderless basic))
  (completion-category-defaults nil)
  (completion-category-overrides '((file (styles partial-completion)))))

(use-package treesit-auto
  :ensure t
  :custom
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(use-package vertico
  :custom
  (context-menu-mode t)
  (enable-recursive-minibuffers t)
  (read-extended-command-predicate #'command-completion-default-include-p) ;; hide M-x commands which do not work in current mode
  (minibuffer-prompt-properties
   '(read-only t cursor-intangible t face minibuffer-prompt))
  ;; (vertico-count 20) ;; Show more candidates
  ;; (vertico-resize t) ;; Grow and shrink the Vertico minibuffer
  ;; (vertico-cycle t) ;; Enable cycling for `vertico-next/previous'
  :init
  (vertico-mode)
  :bind
    (:map vertico-map
        ("C-j" . vertico-next)
        ("C-k" . vertico-previous)
        ("<escape>" . keyboard-escape-quit)
        ("C-c" . keyboard-escape-quit)))

(use-package vterm
  :ensure t
  :custom
  (vterm-shell "fish")
  :bind (("M-t" . vterm)))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

;; 3. LSP + major modes
(use-package eglot
  :hook ((python-mode . eglot-ensure)))

(use-package go-mode
  :ensure t
  :hook (go-mode . eglot-ensure))
