;; -- OPTIONS --
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

(setq browse-url-browser-function 'eww-browse-url)
(setq browse-url-firefox-program "/usr/bin/open")
(setq browse-url-firefox-arguments '("-a" "Firefox"))

(setq org-adapt-indentation t
      org-checkbox-hierarchical-statistics t
      org-enforce-todo-dependencies t)

(defun open-current-week-journal ()
  "Open this week's journal file in ~/Notes/Journal."
  (interactive)
  (find-file (expand-file-name (format-time-string "%G-W%V.org")
                               "~/Notes/Journal/")))
(define-prefix-command 'org-journal-prefix)
(keymap-global-set "C-c j" 'org-journal-prefix)
(define-key org-journal-prefix (kbd "j") #'open-current-week-journal)

(defun open-link-in-firefox ()
  "Open link below cursor in Firefox."
  (interactive)
  (let ((url (or (thing-at-point 'url t)
                 (read-string "URL: "))))
    (browse-url-firefox url)))

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

(use-package treesit-auto
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode 1))
