;; Appearance
(setq inhibit-splash-screen t)
(menu-bar-mode -1) 
(toggle-scroll-bar -1) 
(tool-bar-mode -1) 
(transient-mark-mode 1)
(global-visual-line-mode 1)

(setq display-line-numbers-type 'relative)
(global-display-line-numbers-mode)

(if (string= system-name "aiko")
    (set-frame-font "Hack Nerd Font Mono 12" nil t)   
  (set-frame-font "Hack Nerd Font Mono 10" nil t))

;; Behaviours
(setq auto-save-file-name-transforms '((".*" "~/.emacs-saves/" t)))

;; Built-ins
(require 'which-key)
(which-key-mode)

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

(defun open-file-from-org-dir ()
  (interactive)
  (find-file org-directory))
(global-set-key (kbd "C-c o") 'open-file-from-org-dir)

;; Plugins
(use-package cape
  :bind ("C-c p" . cape-prefix-map) ;; Alternative key: M-<tab>, M-p, M-+
  :init
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'cape-elisp-block)
)

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

(use-package corfu
  ;; Optional customizations
  :custom
  (corfu-cycle t)                ;; Enable cycling for `corfu-next/previous'
  :init
  (global-corfu-mode)
  ;; Enable optional extension modes:
  ;; (corfu-history-mode)
  ;; (corfu-popupinfo-mode)
  )

(use-package emacs
  :custom
  (tab-always-indent 'complete)
  ;; Emacs 30 and newer: Disable Ispell completion function.
  ;; Try `cape-dict' as an alternative.
  (text-mode-ispell-word-completion nil)

  ;; Hide commands in M-x which do not apply to the current mode.  Corfu
  ;; commands are hidden, since they are not used via M-x. This setting is
  ;; useful beyond Corfu.
  (read-extended-command-predicate #'command-completion-default-include-p))

(use-package envrc
  :hook (after-init . envrc-global-mode))

(use-package evil
  :init
  (setq evil-want-integration t) ;; This is optional since it's already set to t by default.
  (setq evil-want-keybinding nil)
  :config
  (evil-mode 1)
)

(use-package evil-collection
  :after evil
  :config
  (evil-collection-init)
)

(use-package flycheck
  :init (global-flycheck-mode))

(use-package lsp-mode
  :custom
  (lsp-completion-provider :none) ;; we use Corfu!
  :init
  (defun my/lsp-mode-setup-completion ()
  (setf (alist-get 'styles (alist-get 'lsp-capf completion-category-defaults))
        '(orderless))) ;; Configure orderless
  :hook (
         (lsp-completion-mode . my/lsp-mode-setup-completion)
	 ((c++-ts-mode python-ts-mode java-ts-mode js-ts-mode) . lsp-deferred)
  )
  :commands lsp)

(use-package lsp-java :config (add-hook 'java-mode-hook 'lsp))

(use-package lsp-ui
  :commands lsp-ui-mode)

(use-package marginalia
  :after vertico
  :init
  (marginalia-mode))

(use-package orderless
  :custom
  (completion-styles '(orderless partial-completion basic))
  (completion-category-defaults nil)
  (completion-category-overrides nil))

(use-package org-bullets
  :after org
  :hook (org-mode . org-bullets-mode))

(use-package pdf-tools
  :init
  (pdf-tools-install)
  :hook
  (pdf-view-mode . (lambda () (display-line-numbers-mode -1)))
  :config 
  (use-package org-pdftools
    :hook (org-mode . org-pdftools-setup-link))
)

(use-package pdf-view-restore
  :after pdf-tools
  :config
  (add-hook 'pdf-view-mode-hook 'pdf-view-restore-mode))

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
  :custom
  (vertico-cycle t)
  :init
  (vertico-mode))

(use-package vterm
  :bind (("M-RET" . vterm))
)
