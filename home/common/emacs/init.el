;; -- OPTIONS --
;; This section is a fucking mess - I will clean it once I am happy with it!
(setq inhibit-splash-screen t)
(setq use-file-dialog nil)

(load-theme 'modus-vivendi-tinted t)

(set-face-attribute 'default nil
		    :font "JetBrainsMono NFM"
		    :height 140)

(global-display-line-numbers-mode)
(global-hl-line-mode)
(savehist-mode)

(setq mac-option-modifier 'meta)
(setq mac-right-option-modifier 'none)

(dolist (dir '("~/.emacs.d/backups" "~/.emacs.d/auto-saves"))
  (unless (file-directory-p dir)
    (make-directory dir t)))

(setq backup-directory-alist `(("." . "~/.emacs.d/backups"))
      auto-save-file-name-transforms `((".*" "~/.emacs.d/auto-saves/" t)))

(add-to-list 'safe-local-variable-values
             '(magit-pull . nil))

(setq ediff-window-setup-function 'ediff-setup-windows-plain
      ediff-split-window-function 'split-window-horizontally)

(setq browse-url-browser-function 'eww-browse-url)
(setq browse-url-firefox-program "/usr/bin/open")
(setq browse-url-firefox-arguments '("-a" "Firefox"))

(setq org-adapt-indentation t
      org-checkbox-hierarchical-statistics t
      org-enforce-todo-dependencies t)

(defun my/compile-with-local-env (command)
  "Run `compile` using the buffer-local environment (from envrc) and /bin/sh."
  (interactive
   (list (compilation-read-command compile-command)))
  (let ((process-environment process-environment)
        (shell-file-name "/bin/sh")
        (explicit-shell-file-name "/bin/sh")
        (compilation-environment process-environment))
    (compile command)))

(defun my/recompile-with-local-env (command)
  "Run `recompile` using the buffer-local environment (from envrc) and /bin/sh."
  (interactive
   (list (compilation-read-command compile-command)))
  (let ((process-environment process-environment)
        (shell-file-name "/bin/sh")
        (explicit-shell-file-name "/bin/sh")
        (compilation-environment process-environment))
    (recompile command)))

(defvar-local my/notes-folder "~/Notes")
(defvar-local my/journal-folder "~/Notes/Journal/")
(defun my/open-current-week-journal ()
  "Open this week's journal file."
  (interactive)
  (find-file (expand-file-name (format-time-string "%G-W%V.org") my/journal-folder)))
(defun my/search-notes ()
  "Search notes with ripgrep."
  (interactive)
  (consult-ripgrep my/notes-folder))

(define-prefix-command 'notes-prefix)
(keymap-global-set "C-c n" 'notes-prefix)
(define-key notes-prefix (kbd "j") #'my/open-current-week-journal)
(define-key notes-prefix (kbd "s") #'my/search-notes)

(defun my/open-link-in-firefox ()
  "Open link below cursor in Firefox."
  (interactive)
  (let ((url (or (thing-at-point 'url t)
                 (read-string "URL: "))))
    (browse-url-firefox url)))

(define-prefix-command 'magit-prefix)
(keymap-global-set "C-x m" 'magit-prefix)
(define-key magit-prefix (kbd "m") #'magit)
(define-key magit-prefix (kbd "p") #'magit-pull)

;; -- PLUGINS --

(use-package cape
  :bind ("C-c p" . cape-prefix-map)
  :init
  (add-hook 'completion-at-point-functions #'cape-dabbrev)
  (add-hook 'completion-at-point-functions #'cape-file)
  (add-hook 'completion-at-point-functions #'yasnippet-capf))

(use-package corfu
  :custom
  (corfu-auto t)
  (corfu-preselect 'directory)
  (corfu-popupinfo-mode)
  :init
  (global-corfu-mode)
  :config
  (keymap-unset corfu-map "RET"))

(use-package consult
  :bind
  (
   ("C-c f d" . consult-flymake)
   ))

(use-package envrc
  :hook (after-init . envrc-global-mode))

(use-package exec-path-from-shell
  :config
  (exec-path-from-shell-initialize))

(use-package flymake
  :hook ((prog-mode) . flymake-mode)
  :bind (:map flymake-mode-map
              ("M-n" . flymake-goto-next-error)
              ("M-p" . flymake-goto-prev-error)))

(use-package flyspell
  :init
  (setq ispell-dictionary "en_GB")
  (setq ispell-program-name "hunspell")
  (setq ispell-silently-savep t)
  :hook ((text-mode . flyspell-mode)
         (org-mode  . flyspell-mode)))

(use-package git-auto-commit-mode
  :custom
  (gac-automatically-push-p t)
  (gac-automatically-add-new-files-p t)
  (gac-silent-message-p t))

(use-package marginalia
  :init
  (marginalia-mode))

(use-package multiple-cursors
  :bind
  ("C-S-c C-S-c" .  mc/edit-lines)
  ("C->" .  mc/mark-next-like-this)
  ("C-<" .  mc/mark-previous-like-this)
  ("C-c C-<" .  mc/mark-all-like-this))

(use-package nov
  :init
  (add-to-list 'auto-mode-alist '("\\.epub\\'" . nov-mode)))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion)))))

(use-package pdf-tools
  :config
  (pdf-tools-install)
  (add-hook 'pdf-view-mode-hook (lambda () (display-line-numbers-mode -1)))
  (setq pdf-view-display-size 'fit-page
	pdf-view-resize-factor 1.1
	pdf-annot-activate-created-annotations t))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

(use-package yasnippet
  :init
  (yas-global-mode 1))

(use-package verb
  :after org
  :config
  (define-key org-mode-map (kbd "C-c C-v") verb-command-map))

(use-package vertico
  :custom
  ;; (vertico-scroll-margin 0) ;; Different scroll margin
  ;; (vertico-count 20) ;; Show more candidates
  ;; (vertico-resize t) ;; Grow and shrink the Vertico minibuffer
  (vertico-cycle t) ;; Enable cycling for `vertico-next/previous'
  :init
  (setq context-menu-mode t
	enable-recursive-minibuffers t
	read-extended-command-predicate #'command-completion-default-include-p
	minibuffer-prompt-properties
	'(read-only t cursor-intangible t face minibuffer-prompt))
  (vertico-mode))

;; lsp + treesit + modes
(use-package eglot
  :custom
  (eglot-autoshutdown t)
  (eglot-code-action-indicator "!")
  :hook (prog-mode . eglot-ensure))

(use-package svelte-mode
  :mode "\\.svelte\\'")

(setq major-mode-remap-alist
      '((python-mode . python-ts-mode)
        (c-mode      . c-ts-mode)
        (c++-mode    . c++-ts-mode)
        (js-mode     . js-ts-mode)
        (typescript-mode . typescript-ts-mode)
        ))

;; (use-package treesit-auto
;;   :config
;;   (setq treesit-auto-install 'prompt)
;;   (treesit-auto-add-to-auto-mode-alist 'all)
;;   (global-treesit-auto-mode 1))
