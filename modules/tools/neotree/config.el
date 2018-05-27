;;; tools/neotree/config.el -*- lexical-binding: t; -*-

(def-package! neotree
  :commands (neotree-show
             neotree-hide
             neotree-toggle
             neotree-dir
             neotree-find
             neo-global--with-buffer
             neo-global--window-exists-p)
  :config
  (setq neo-create-file-auto-open nil
        neo-auto-indent-point nil
        neo-autorefresh nil
        neo-mode-line-type 'none
        neo-window-width 25
        neo-show-updir-line nil
        neo-theme 'nerd ; fallback
        neo-banner-message nil
        neo-confirm-create-file #'off-p
        neo-confirm-create-directory #'off-p
        neo-show-hidden-files nil
        neo-keymap-style 'concise
        neo-hidden-regexp-list
        '(;; vcs folders
          "^\\.\\(git\\|hg\\|svn\\)$"
          ;; compiled files
          "\\.\\(pyc\\|o\\|elc\\|lock\\|css.map\\)$"
          ;; generated files, caches or local pkgs
          "^\\(node_modules\\|vendor\\|.\\(project\\|cask\\|yardoc\\|sass-cache\\)\\)$"
          ;; org-mode folders
          "^\\.\\(sync\\|export\\|attach\\)$"
          "~$"
          "^#.*#$"))

  (when (bound-and-true-p winner-mode)
    (push neo-buffer-name winner-boring-buffers)))

   ;; Set the neo-window-width to the current width of the
   ;; neotree window, to trick neotree into resetting the
   ;; width back to the actual window width.
   ;; Fixes: https://github.com/jaypei/emacs-neotree/issues/262
   (eval-after-load "neotree"
       '(add-to-list 'window-size-change-functions
                     (lambda (frame)
                       (let ((neo-window (neo-global--get-window)))
                         (unless (null neo-window)
                           (setq neo-window-width (window-width neo-window)))))))