;;; install-packages.el --- Install configured packages   -*- lexical-binding: t -*-

;; Run once after cloning the repo into ~/.emacs.d:
;;   - Open this file ~/.emacs.d/install-packages.el in Emacs.
;;   - Run command M-x eval-buffer.
;;   - Confirm to install the listed packages.
;;   - Wait untill the load and installation are finished.

;; Fill variable package-selected-packages.
(load-file "custom.el")

;; Use configured package archives.
(load-file "configs/init-package.el")

;; Refresh descriptions of the packages. 
(package-refresh-contents)

;; Install packages listed in the variable package-selected-packages.
(package-install-selected-packages)
