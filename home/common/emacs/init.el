;; -- OPTIONS --
(setq inhibit-splash-screen t)
(setq use-file-dialog nil)

(set-face-attribute 'default nil
    :font "JetBrainsMono NFM"
    :height 140)

(fido-mode 1)
(fido-vertical-mode 1)
(setq completion-auto-select t
      fido-auto-prefix nil)

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
  (add-hook 'completion-at-point-functions #'yasnippet-capf))

(use-package corfu
  :custom
  (corfu-auto t)
  (corfu-preselect 'directory)
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
         (org-mode  . flyspell-mode)
         (prog-mode . flyspell-prog-mode)))

(use-package git-auto-commit-mode
  :custom
  (gac-automatically-push-p t)
  (gac-automatically-add-new-files-p t)
  (gac-silent-message-p t))

(use-package multiple-cursors
  :bind
  ("C-S-c C-S-c" .  mc/edit-lines)
  ("C->" .  mc/mark-next-like-this)
  ("C-<" .  mc/mark-previous-like-this)
  ("C-c C-<" .  mc/mark-all-like-this))

(use-package orderless
  :custom
  (completion-styles '(orderless basic))
  (completion-category-overrides '((file (styles partial-completion)))))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))

(use-package yasnippet
  :init
  (yas-global-mode 1))

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
