(tool-bar-mode -1) ;; remove toolbar
;;(toggle-scroll-bar -1) ;; remove scrollbar
;;(setq inhibit-startup-screen t) ;; no startup screen
(setq mouse-wheel-scroll-amount '(1 ((shift) . 1))) ;; mouse scroll one line at a time
(setq mouse-wheel-progressive-speed nil) ;; don't accelerate mouse scrolling
(setq
   backup-by-copying t
   backup-directory-alist
    '(("." . "~/.emacs.d/backups/"))
   delete-old-versions t
   kept-new-versions 6
   kept-old-versions 2
   version-control t)
(add-hook 'prog-mode-hook 'linum-mode) ;; Line numbers
(setq-default indent-tabs-mode nil) ;; No tabs
(add-to-list 'default-frame-alist '(fullscreen . maximized)) ;; start every frame maximized
(setq column-number-mode t) ;; Display column numbers

;; Other packages from packages folder
(add-to-list 'load-path "~/.emacs.d/packages")
(load "hide-comnt.el")
(require 'hide-comnt)

(require 'package) ;; Emacs builtin

;; set package.el repositories
(setq package-archives
'(
   ("org" . "https://orgmode.org/elpa/")
   ("gnu" . "https://elpa.gnu.org/packages/")
   ("melpa" . "https://melpa.org/packages/")
))

;; initialize built-in package management
(package-initialize)

;; update packages list if we are on a new install
(unless package-archive-contents
  (package-refresh-contents))

;; a list of pkgs to programmatically install
;; ensure installed via package.el
(setq my-package-list '(use-package))

;; programmatically install/ensure installed
;; pkgs in your personal list
(dolist (package my-package-list)
  (unless (package-installed-p package)
    (package-install package)))

;; Haskell Mode

(use-package haskell-mode
  :ensure t)

;; OCaml Mode

(use-package tuareg
  :ensure t
  :config
  (add-hook 'tuareg-mode-hook 'tuareg-imenu-set-imenu))

(use-package merlin
  :ensure t
  :after tuareg
  :config
  (add-hook 'tuareg-mode-hook 'merlin-mode))

;; Rust Mode

(use-package rust-mode
  :ensure t)

;; Ivy and Counsel (better completion)

(use-package ivy
  :ensure t
  :config (ivy-mode))

(use-package counsel
  :ensure t
  :after ivy
  :config (counsel-mode))

;; Generally useful stuff for working on projects

;(load "/usr/share/emacs/site-lisp/clang-format/clang-format.el")
;(global-set-key (kbd "C-M-i") 'clang-format-buffer)

(use-package magit
  :ensure t)

(use-package company
  :ensure t
  :init
  (setq company-idle-delay 0)
  :config
  (define-key company-active-map (kbd "C-n") #'company-select-next)
  (define-key company-active-map (kbd "C-p") #'company-select-previous)
  (global-company-mode))

(add-hook ;; Disable company mode in ssh to avoid latency
 'prog-mode-hook
 (lambda () (when (file-remote-p default-directory) (company-mode -1))))

(use-package projectile
  :ensure t
  :after ivy
  :config
  (projectile-mode 1)
  (define-key projectile-mode-map (kbd "C-c p") 'projectile-command-map)
  (use-package counsel-projectile
    :after projectile
    :ensure t
    :config (counsel-projectile-mode)))

;; Customize variables (generated)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages '(use-package)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
