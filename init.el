;;; init.el --- Main configuration file   -*- lexical-binding: t -*-

;; ===================================
;; Installed Mac OS packages
;; ===================================
;;
;; Pre-installed `$ brew install jansson` for better performance
;; `$ brew install pandoc` for markdown-mode
;; `$ brew install aspell` for ispell and flyspell
;; `$ brew install trash` for osx-trash
;; `$ brew install mit-scheme` for MIT/GNU Scheme REPL by geiser

;; ===================================
;; Backward Compatibility
;; ===================================

(when (< emacs-major-version 27)
  (package-initialize))


;; ===================================
;; Basics
;; ===================================

;; Make more executables available to Emacs.
(add-to-list 'exec-path "/usr/local/bin")

;; Load private settings.
(let ((private-init (expand-file-name "private-init.el" user-emacs-directory)))
  (when (file-exists-p private-init)
    (load private-init)))

;; Load additional configuration files matching the name pattern.
;; If needed, rename a file to disable (enable) its load on Emacs startup.
(mapc 'load (file-expand-wildcards (concat user-emacs-directory "configs/init-*.el")))

;;; Modes
(setq auto-save-visited-mode t) ; save file-visiting buffers in 5 seconds

;;; Session
(setq-default history-length 1000) ; size of command history
(savehist-mode t) ; save command history between sessions
(setq-default default-directory "~/")
(desktop-save-mode 1) ; save session automatically
(setq desktop-save t) ; do not ask, always save

;;; Version Control
(setq
 vc-handled-backends '(Git) ; disables other VC systems to improve performance
 vc-make-backup-files 1 ; backup files under VC system
 vc-command-messages 1) ; output shell commands vc executes

;;; Backups and Auto-saving
(setq
 backup-directory-alist `(("." . ,(concat user-emacs-directory ".backups")))
 backup-by-copying t ; don't clobber symlinks
 version-control t ; save numbered files
 delete-old-versions t ; delete files silently
 kept-new-versions 10
 kept-old-versions 4)
(setq
 auto-save-file-name-transforms `((".*" ,temporary-file-directory t))
 auto-save-default t
 auto-save-interval 200 ; characters between auto-saves
 auto-save-timeout 600 ; save after N seconds of idleness
 delete-auto-save-files nil) ; do not delete on buffer saving
;; Backup on each save
;; https://www.emacswiki.org/emacs/ForceBackups
(defun force-buffer-backup ()
  (let ((buffer-backed-up nil))
    (backup-buffer)))
(add-hook 'after-save-hook 'force-buffer-backup)
(add-hook 'auto-save-hook 'force-buffer-backup)

;;; Mark region
(setq highlight-nonselected-windows t)
(setq mark-even-if-inactive nil) ; inactive region accepts commands
(delete-selection-mode 1) ; active region removed on typing
(put 'downcase-region 'disabled nil)
(put 'upcase-region 'disabled nil)

;;; Edit
(setq kill-whole-line t) ; C-k kills newline character too
(setq
 undo-limit 8000000 ; 8 MB
 undo-strong-limit 12000000 ; 12 MB
 undo-outer-limit 20000000) ; 20 MB

;;; Files
(setq delete-by-moving-to-trash t)

;;; Dired
(setq dired-auto-revert-buffer t) ; keep the buffer up-to-date
(add-hook 'dired-mode-hook 'auto-revert-mode) ; auto refresh dired when file changes

;;; Spell Checking
(setq ispell-program-name "aspell")


;; ===================================
;; Packages
;; ===================================

(require 'smex)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command) ; fallback to M-x

(require 'ido)
(ido-mode t)

(require 'osx-trash)
(when (eq system-type 'darwin)
  (osx-trash-setup))

(require 'geiser)
(setq geiser-active-implementations '(mit))
(setq geiser-repl-query-on-kill-p nil)

;; Org Mode
(setq
 org-startup-truncated nil
 org-startup-folded nil ; open org file with the items expanded
 org-support-shift-select 'always) ; force enable shift-selection


;; ===================================
;; Custom
;; ===================================

(setq custom-file (expand-file-name "custom.el" user-emacs-directory))
(when (file-exists-p custom-file)
  (load custom-file))

