;;; emacs/term/autoload.el -*- lexical-binding: t; -*-

;;;###autoload
(defun +term/open (&optional project-root)
  "Open a terminal buffer in the current window. If PROJECT-ROOT (C-u) is
non-nil, cd into the current project's root."
  (interactive "P")
  (let ((default-directory (if project-root (doom-project-root 'nocache) default-directory)))
    (call-interactively #'multi-term)))

;;;###autoload
(defun +term/open-popup (arg)
  "Open a terminal popup window. If ARG (universal argument) is
non-nil, cd into the current project's root."
  (interactive "P")
  (require 'multi-term)
  (let ((default-directory (if arg (doom-project-root 'nocache) default-directory))
        (buffer (multi-term-get-buffer current-prefix-arg)))
    (pop-to-buffer buffer)
    (setq multi-term-buffer-list (nconc multi-term-buffer-list (list buffer)))
    (multi-term-internal)))

;;;###autoload
(defun +term/open-popup-in-project (arg)
  "Open a terminal popup window in the root of the current project.

If ARG (universal argument) is non-nil, open it in `default-directory' instead."
  (interactive "P")
  (+term/open-popup (not arg)))
