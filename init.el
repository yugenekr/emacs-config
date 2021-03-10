;;; init.el --- Main configuration file   -*- lexical-binding: t -*-

;; Make more executables available to Emacs.
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize))

(defconst *is-a-mac* (eq system-type 'darwin))

;; Load private settings.
(let ((private-init (expand-file-name "private-init.el" user-emacs-directory)))
  (when (file-exists-p private-init)
    (load private-init)))

;; Load additional configuration files matching the name pattern.
;; If needed, rename a file to disable (enable) its load on Emacs startup.
(mapc 'load (file-expand-wildcards (concat user-emacs-directory "configs/init-*.el")))

;;; Load configuration file handled by Emacs Customization.
(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

