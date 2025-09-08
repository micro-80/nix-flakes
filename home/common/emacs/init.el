;; -- OPTIONS --
(setq inhibit-splash-screen t)
(setq use-file-dialog nil)

(set-face-attribute 'default nil
    :font "JetBrainsMono NFM"
    :height 140)

(global-display-line-numbers-mode)
(global-hl-line-mode)

(setq mac-option-modifier 'meta)
(setq mac-right-option-modifier 'none)

(dolist (dir '("~/.emacs.d/backups" "~/.emacs.d/auto-saves"))
  (unless (file-directory-p dir)
    (make-directory dir t)))

(setq backup-directory-alist `(("." . "~/.emacs.d/backups"))
      auto-save-file-name-transforms `((".*" "~/.emacs.d/auto-saves/" t)))

(setq browse-url-browser-function 'eww-browse-url)
(setq browse-url-firefox-program "/usr/bin/open")
(setq browse-url-firefox-arguments '("-a" "Firefox"))

(setq org-adapt-indentation t
      org-checkbox-hierarchical-statistics t
      org-enforce-todo-dependencies t)

(defun open-latest-journal-file ()
  "Open the most recently modified journal file in `org-journal-dir`."
  (interactive)
  (let* ((files (directory-files org-journal-dir t "\\.org$"))
         (latest (car (sort files
                             (lambda (a b)
                               (time-less-p (nth 5 (file-attributes b))
                                            (nth 5 (file-attributes a))))))))
    (if latest
        (find-file latest)
      (message "No journal files found."))))

(defun open-link-in-firefox ()
  "Open link below cursor in Firefox."
  (interactive)
  (let ((url (or (thing-at-point 'url t)
                 (read-string "URL: "))))
    (browse-url-firefox url)))

;; -- PLUGINS --

;; appearance
(use-package doom-themes
  :custom
  (doom-themes-enable-bold t)
  (doom-themes-enable-italic t)
  :config
  (load-theme 'doom-monokai-pro t)
  (doom-themes-visual-bell-config)
  (doom-themes-org-config))

;; functional
(use-package cape
  :bind ("C-c p" . cape-prefix-map)
  :init
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'yasnippet-capf)
  )

(use-package consult
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
  :custom
  (corfu-auto t)
  (corfu-preselect 'directory)
  :init
  (global-corfu-mode)
  :config
  (keymap-unset corfu-map "RET"))

(use-package eglot
  :custom
  (eglot-autoshutdown t)
  (eglot-code-action-indicator "!")
  :hook (prog-mode . eglot-ensure))

(use-package envrc
  :hook (after-init . envrc-global-mode))

(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))

(use-package flymake
  :hook ((prog-mode) . flymake-mode)
  :bind (:map flymake-mode-map
              ("M-n" . flymake-goto-next-error)
              ("M-p" . flymake-goto-prev-error)
              ("C-c ! l" . flymake-show-buffer-diagnostics)))

(use-package flyspell
  :init
  (setq ispell-dictionary "en_GB")
  (setq ispell-program-name "hunspell")
  (setq ispell-silently-savep t)
  :hook ((text-mode . flyspell-mode)
         (org-mode  . flyspell-mode)
         (prog-mode . flyspell-prog-mode)))

(use-package git-auto-commit-mode
  :custom
  (gac-automatically-push-p t)
  (gac-automatically-add-new-files-p t)
  (gac-silent-message-p t))

(use-package marginalia
  :bind (:map minibuffer-local-map
         ("M-A" . marginalia-cycle))
  :init
  (marginalia-mode))

(use-package multiple-cursors
  :bind
  ("C-S-c C-S-c" .  mc/edit-lines)
  ("C->" .  mc/mark-next-like-this)
  ("C-<" .  mc/mark-previous-like-this)
  ("C-c C-<" .  mc/mark-all-like-this))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles basic partial-completion)))))

(use-package org-journal
  :config
  (setq org-journal-dir "~/Notes/Journal/"
	org-journal-file-format "%Y-%m-%d.org"
        org-journal-file-type 'weekly)
  (setq org-journal-file-header
      (lambda ()
        (let ((today (format-time-string "%Y-%m-%d")))
          (concat "#+TITLE: Weekly Journal (" today ")\n"
		  "#+STARTUP: overview\n"
                  "* TODO Weekly [0/0]\n\n"))))
  (define-prefix-command 'my/org-journal-prefix)
  (global-set-key (kbd "C-c j") 'my/org-journal-prefix)
  (define-key my/org-journal-prefix (kbd "j") #'open-latest-journal-file)
  (define-key my/org-journal-prefix (kbd "d") #'org-journal-new-entry)
  (define-key my/org-journal-prefix (kbd "s") #'org-journal-search-forever)
  (with-eval-after-load 'which-key
    (which-key-add-key-based-replacements
      "C-c j"   "Org Journal"
      "C-c j d" "New Daily Entry"
      "C-c j j" "Go To Latest Journal Entry"
      "C-c j s" "Search Journal")))

(use-package savehist
  :init
  (savehist-mode))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

(use-package vertico
  :custom
  (vertico-cycle t)
  :init
  (context-menu-mode t)
  (setq enable-recursive-minibuffers t)
  (setq read-extended-command-predicate #'command-completion-default-include-p)
  (setq minibuffer-prompt-properties
   '(read-only t cursor-intangible t face minibuffer-prompt))
  (vertico-mode))

(use-package yasnippet
  :init
  (yas-global-mode 1))

;; lsp + treesit
(use-package svelte-mode
  :mode "\\.svelte\\'")

(use-package treesit-auto
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode 1))
