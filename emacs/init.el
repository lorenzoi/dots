;;; Basic Initialization

(require 'package)
(setq package-enable-at-startup nil)
;; Setup Plugin Repos
(setq package-archives '(("gnu" . "https://elpa.gnu.org/packages/")
			 ("melpa" . "https://melpa.org/packages/")))
(package-initialize)

;; Install use-package (will be used later)

(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package auto-package-update
  :ensure t
  :config
  (setq auto-package-update-delete-old-versions t)
  (setq auto-package-update-hide-results t)
  (auto-package-update-maybe))

;; Things I want to disable.
(scroll-bar-mode -1)
(tool-bar-mode -1)
(menu-bar-mode -1)
(tooltip-mode -1)
(mouse-wheel-mode -1)

(setq use-file-dialog nil)
(setq use-dialog-box nil)
(setq frame-resize-pixelwise t)
(setq inhibit-startup-message t)

;; Disable Lock and Backup files
(setq create-lockfiles nil)
(setq make-backup-files nil)

;; Change font to a DOS Font clone because I like the DOS Font
(set-frame-font "More Perfect DOS VGA 12" nil t)

;; Tab Config, just because it can get annoying
(setq-default tab-width 8)
(setq-default tab-always-indent t)
(setq indent-tabs-mode -1)

(defun tab-as-tab ()
  "Insert a tab character."
  (interactive)
  (insert "\t"))

;(global-set-key (kbd "TAB") 'tab-as-tab)
(global-set-key (kbd "C-x <C-tab>") 'whitespace-mode)

(defun my-c++-mode-hook ()
  "Setup Tab offset for C and other related languages."
  (setq c-basic-offset 8)
  (setq c-default-style "linux")
  (c-set-offset 'substatement-open 0))
(add-hook 'prog-mode-hook 'my-c++-mode-hook)

;; Custom File Variables
(setq org-init-file "oinit.org")
(setq custom-file "custom.el")

; Set those up

(if (file-exists-p custom-file)
	(load (expand-file-name custom-file user-emacs-directory)))

(org-babel-load-file
 (expand-file-name org-init-file user-emacs-directory))

;; Enable Dired DWIM
(setq dired-dwim-target t)

;; Whitespace stuff
 (require 'whitespace)
 (setq whitespace-style '(face empty lines-tail trailing))
 (global-whitespace-mode t)
 (setq whitespace-display-mappings
       '((space-mark   ?\    [?\xB7]     [?.])
         (space-mark   ?\xA0 [?\xA4]     [?_])
         (newline-mark ?\n   [?\xB6 ?\n] [?$ ?\n])))
;; Enable Q-Sharp Mode
;; Yes Q# Like Microsoft's Quantum computing language Q#
(add-to-list 'load-path "~/.emacs.d/qsharp-mode/")
(autoload 'qsharp-mode "qsharp-mode" "Major mode for editing Q# code." t)
(add-to-list 'auto-mode-alist '("\\.qs$" . qsharp-mode))

;;(provide 'init)
;;; init.el ends here
