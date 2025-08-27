(setq inhibit-splash-screen t)
(setq use-file-dialog nil)

(set-face-attribute 'default nil
    :font "JetBrainsMono NFM"
    :height 140)

(load-theme 'modus-operandi t)

(global-display-line-numbers-mode)

(use-package svelte-mode
  :mode "\\.svelte\\'")

(use-package treesit-auto
  :config
  (treesit-auto-add-to-auto-mode-alist 'all)
  (global-treesit-auto-mode 1))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.3))
