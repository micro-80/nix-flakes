;; Appearance
(setq inhibit-splash-screen t)
(menu-bar-mode -1) 
(toggle-scroll-bar -1) 
(tool-bar-mode -1) 
(transient-mark-mode 1)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)
(set-frame-font "Hack Nerd Font Mono 10" nil t)

;; Built-ins
(require 'which-key)
(which-key-mode)

(setq evil-want-C-i-jump nil)
(require 'org)
(setq org-indent-mode t)
(setq org-agenda-files '("~/Documents/Org/daily.org"))
(setq org-directory "~/Documents/Org")
(setq org-capture-templates
      '(
	("b" "Branch" entry (file+datetree "~/Documents/Org/daily.org") "* Branch %?\n** %^{Topic} - %^{Comrade} :leadoff:\n** Minutes\n  %i\n  %a")
	("d" "Daily" entry (file+datetree "~/Documents/Org/daily.org") "* %?\n  %i\n  %a")
	("l" "Leadoff" entry (file+datetree "~/Documents/Org/daily.org") "* %^{Topic} - %^{Comrade} :leadoff: \n%?  %i\n  %a")
	("t" "TODO" entry (file+datetree "~/Documents/Org/daily.org") "* TODO %?\n \nSCHEDULED: %^t\nDEADLINE: %^t  %i\n  %a")
       ))
(setq org-todo-keywords
  '((sequence
     "TODO"
     "IN PROGRESS"
     "DONE"
     )))

;; Plugins

(use-package catppuccin-theme
    :config
    (setq catppuccin-flavor 'macchiato)
    (load-theme 'catppuccin :no-confirm))

;; Example configuration for Consult
(use-package consult
  ;; Replace bindings. Lazily loaded by `use-package'.
  :bind (;; C-c bindings in `mode-specific-map'
         ("C-c M-x" . consult-mode-command)
         ("C-c h" . consult-history)
         ("C-c k" . consult-kmacro)
         ("C-c m" . consult-man)
         ("C-c i" . consult-info)
         ([remap Info-search] . consult-info)
         ;; C-x bindings in `ctl-x-map'
         ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ("C-x t b" . consult-buffer-other-tab)    ;; orig. switch-to-buffer-other-tab
         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ;; M-g bindings in `goto-map'
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
         ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ;; M-s bindings in `search-map'
         ("M-s d" . consult-find)                  ;; Alternative: consult-fd
         ("M-s c" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)                 ;; orig. next-matching-history-element
         ("M-r" . consult-history))                ;; orig. previous-matching-history-element

  :hook (completion-list-mode . consult-preview-at-point-mode)
  :init
  (advice-add #'register-preview :override #'consult-register-window)
  (setq register-preview-delay 0.5)
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)
  :config

  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep consult-man
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   :preview-key '(:debounce 0.4 any))

  (setq consult-narrow-key "<") ;; "C-+"
)

(use-package evil
    :config 
    (evil-mode 1)
    (evil-set-leader 'normal (kbd "SPC")))

(use-package evil-org
  :after org
  :hook (org-mode . evil-org-mode)
  :config
  (require 'evil-org-agenda)
  (evil-org-agenda-set-keys))

(use-package orderless
  :ensure t
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode))

(use-package marginalia
  :after vertico
  :init
  (marginalia-mode))

(use-package savehist
  :init
  (savehist-mode))

(use-package treesit-auto
  :custom
  (treesit-auto-install 'prompt)
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode))

(use-package vertico
  :bind (:map vertico-map
	  ("C-j" . vertico-next)
	  ("C-k" . vertico-previous)
	  ("C-x" . vertico-exit))
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode))

(use-package vterm
  :ensure t
  :bind (("M-RET" . vterm))
)
