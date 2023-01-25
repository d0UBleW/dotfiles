(defun rc/display-startup-time ()
  (message "Emacs loaded in %s with %d garbage collections."
           (format "%.2f seconds"
                   (float-time
                    (time-subtract after-init-time before-init-time)))
           gcs-done))

(add-hook 'emacs-startup-hook #'rc/display-startup-time)

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")))

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))


(unless (package-installed-p 'use-package)
  (package-install 'use-package))


(require 'use-package)
(setq use-package-always-ensure t)

(use-package auto-package-update
  :custom
  (auto-package-update-interval 7)
  (auto-package-update-prompt-before-update t)
  (auto-package-update-hide-results t)
  :config
  (auto-package-update-maybe)
  (auto-package-update-at-time "09:00"))


(use-package no-littering)

(setq auto-save-file-name-transforms
      `((".*", (no-littering-expand-var-file-name "auto-save/") t)))

(setq backup-directory-alist '(("." . "~/.saves")))

(setq inhibit-splash-screen t
      tab-width 4
      indent-tabs-mode nil
      compilation-scroll-output t)

(setq confirm-kill-emacs 'y-or-n-p)

(defun rc/duplicate-line ()
  "Duplicate current line"
  (interactive)
  (let ((column (- (point) (point-at-bol)))
        (line (let ((s (thing-at-point 'line t)))
                (if s (string-remove-suffix "\n" s) ""))))
    (move-end-of-line 1)
    (newline)
    (insert line)
    (move-beginning-of-line 1)
    (forward-char column)))

(global-set-key (kbd "C-,") 'rc/duplicate-line)

(scroll-bar-mode 0)
(tool-bar-mode 0)
(tooltip-mode 0)
(set-fringe-mode 10)

(menu-bar-mode 0)
(global-hl-line-mode 1)
(delete-selection-mode 1)
(column-number-mode 1)
(add-hook 'prog-mode-hook 'display-line-numbers-mode)
(show-paren-mode 1)
(display-battery-mode 1)
(display-time-mode 1)

(save-place-mode 1)

(setq global-auto-revert-non-file-buffers t)

(setq gc-cons-threshold 100000000)
(setq read-process-output-max (* 1024 1024))
(setq auto-save-default nil)
(setq make-backup-files nil)
(setq create-lockfiles nil)

(setq ring-bell-function 'ignore)

(defun rc/get-default-font ()
  (cond
   ((eq system-type 'windows-nt) "Consolas-13")
   ((eq system-type 'gnu/linux) "Iosevka Term-14")))

(add-to-list 'default-frame-alist `(font . ,(rc/get-default-font)))

(defun rc/turn-on-paredit()
  (interactive)
  (paredit-mode 1))

(use-package paredit
  :ensure t
  :hook
  (emacs-lisp-mode . rc/turn-on-paredit)
  (clojure-mode . rc/turn-on-paredit)
  (lisp-mode . rc/turn-on-paredit)
  (common-lisp-mode . rc/turn-on-paredit)
  (scheme-mode . rc/turn-on-paredit)
  (racket-mode . rc/turn-on-paredit))

;;; Whitespace mode
(defun rc/set-up-whitespace-handling ()
  (interactive)
  (whitespace-mode 1)
  (add-to-list 'write-file-functions 'delete-trailing-whitespace))

(add-hook 'tuareg-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'c++-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'c-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'simpc-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'emacs-lisp-mode 'rc/set-up-whitespace-handling)
(add-hook 'java-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'lua-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'rust-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'scala-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'markdown-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'haskell-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'python-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'erlang-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'asm-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'nasm-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'go-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'nim-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'yaml-mode-hook 'rc/set-up-whitespace-handling)
(add-hook 'porth-mode-hook 'rc/set-up-whitespace-handling)

(use-package exec-path-from-shell
  :ensure t
  :config
  (setq exec-path-from-shell-arguments nil)
  (exec-path-from-shell-initialize))

(use-package gruber-darker-theme
  :ensure t
  :config
  (load-theme 'gruber-darker t))

(use-package ido-completing-read+
  :ensure t)

(use-package ido
  :ensure t
  :config
  (setq ido-everywhere 1)
  (setq ido-enable-flex-matching 1)
  (ido-mode 1)
  (ido-everywhere 1)
  (ido-ubiquitous-mode 1))

(use-package smex
  :ensure t)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))

(use-package projectile
  :ensure t
  :config
  (projectile-mode 1)
  :bind-keymap
  ("C-x p" . projectile-command-map)
  :init
  (when (file-directory-p "~/projects")
    (setq projectile-project-search-path '(("~/projects/" . 2))))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package cl-lib
  :ensure t)

(use-package magit
  :ensure t
  :pin melpa
  :after cl-lib
  :custom
  (magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
  :config
  (setq magit-auto-revert-mode nil)
  :bind
  (("C-c m s" . magit-status)
   ("C-c m l" . magit-log)))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package doom-modeline
  :ensure t
  :init
  (doom-modeline-mode 1)
  :custom
  (doom-modeline-height 35)
  (doom-modeline-icon t)
  (doom-modeline-battery t)
  (doom-modeline-time t))


(use-package org-bullets
  :hook (org-mode . org-bullets-mode)
  :custom
  (org-bullets-bullet-list '("◉" "○" "●" "○" "●" "○" "●")))

(use-package which-key
  :defer 0
  :diminish which-key-mode
  :config
  (which-key-mode)
  (setq which-key-idle-delay 1.5))



(use-package expand-region
  :ensure t
  :bind
  (("C-=" . er/expand-region)
   ("C--" . er/contract-region)))

(use-package yasnippet
  :ensure t
  :config
  (setq yas/triggers-in-field nil)
  (setq yas-snippet-dirs '("~/.emacs.d/emacs.snippets/"))
  (yas-global-mode 1))

(use-package move-text
  :ensure t
  :bind
  (("M-p" . move-text-up)
   ("M-n" . move-text-down)))

(use-package multiple-cursors
  :ensure t
  :bind
  (("C-S-c C-S-c" . mc/edit-lines)
   ("C->" . mc/mark-next-like-this)
   ("C-<" . mc/mark-previous-like-this)
   ("C-M->" . mc/unmark-next-like-this)
   ("C-M-<" . mc/unmark-previous-like-this)
   ("C-c C-<" . mark/mark-all-like-this)
   ("C-\"" . mc/skip-to-next-like-this)
   ("C-;" . mc/skip-to-previous-like-this)))

(require 'dired-x)
(setq dired-omit-files
      (concat dired-omit-files "\\|^\\..+$"))
(defun rc/dired-key()
  (local-set-key (kbd "M-<return>") 'dired-up-directory))
;; (add-hook 'dired-mode-hook 'dired-key)

(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :bind (("C-c C--" . dired-jump))
  :hook (dired-mode . rc/dired-key)
  :custom ((dired-listing-switches "-alh --group-directories-first")))


(use-package dired-single
  :commands (dired dired-jump))

(use-package all-the-icons-dired
  :hook (dired-mode . all-the-icons-dired-mode))

(use-package dired-open
  :commands (dired dired-jump)
  :config
  ;; Doesn't work as expected!
  ;;(add-to-list 'dired-open-functions #'dired-open-xdg t)
  (setq dired-open-extensions '(("png" . "feh")
                                ("mkv" . "mpv"))))

(global-set-key (kbd "C-c p") 'find-file-at-point)

(use-package json-mode
  :ensure t)

(defun rc/webmode-hook ()
  (setq web-mode-enable-comment-annotation t
	web-mode-markup-indent-offset 2
	web-mode-code-indent-offset 2
	web-mode-css-indent-offset 2
	web-mode-attr-indent-offset 0
	web-mode-enable-auto-identation t
	web-mode-enable-auto-closing t
	web-mode-enable-auto-pairing t
	web-mode-enable-css-colorization t))

(use-package web-mode
  :ensure t
  :mode
  (("\\.jsx?\\'" . web-mode)
   ("\\.tsx?\\'". web-mode)
   ("\\.html\\'". web-mode))
  :commands web-mode
  :hook (web-mode . rc/webmode-hook))

(defun rc/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook ((lsp-mode . rc/lsp-mode-setup)
	 (web-mode . lsp-deferred))
  :init
  (setq lsp-keymap-prefix "C-l")
  :config
  (lsp-enable-which-key-integration t)
  (setq lsp-log-io nil))

(use-package typescript-mode
  :mode "\\.tsx?\\'"
  :hook (typescript-mode . lsp-deferred)
  :config
  (setq typescript-indent-level 2))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom)
  :commands lsp-ui-mode)

(use-package company
  :after lsp-mode
  :hook (lsp-mode . company-mode)
  :bind (:map company-active-map
         ("<tab>" . company-complete-selection))
        (:map lsp-mode-map
         ("<tab>" . company-indent-or-complete-common))
  :config
  (global-company-mode t)
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :hook (company-mode . company-box-mode))


(defun enable-minor-mode (my-pair)
  (if (buffer-file-name)
      (if (string-match (car my-pair) buffer-file-name)
	  (funcall (cdr my-pair)))))

(use-package prettier-js
  :ensure t)

(add-hook 'web-mode-hook #'(lambda ()
			     (enable-minor-mode
			      '("\\.jsx?\\'" . prettier-js-mode))
			     (enable-minor-mode
			      '("\\.tsx?\\'" . prettier-js-mode))))



(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(display-line-numbers-type 'relative)
 '(custom-safe-themes
   '("bddf21b7face8adffc42c32a8223c3cc83b5c1bbd4ce49a5743ce528ca4da2b6" default))
 '(package-selected-packages
   '(dired-open all-the-icons-dired dired-single prettier-js dired-x web-mode json-mode exec-path-from-shell expand-region company-box which-key lsp-treemacs lsp-ui lsp-mode org-bullets doom-modeline rainbow-delimiters projecilte gruber-darker yaml-mode use-package tuareg toml-mode tide sml-mode smex scala-mode rust-mode rfc-mode racket-mode qml-mode purescript-mode proof-general projectile powershell php-mode paredit org-cliplink no-littering nix-mode nim-mode nginx-mode nasm-mode multiple-cursors move-text markdown-mode magit lua-mode kotlin-mode jinja2-mode ido-completing-read+ htmlize hindent helm-ls-git helm-git-grep helm-cmd-t haskell-mode gruber-darker-theme graphviz-dot-mode go-mode glsl-mode elpy dockerfile-mode dash-functional d-mode csharp-mode cmake-mode clojure-mode auto-package-update ansible ag))
 '(whitespace-style
   '(face tabs spaces trailing space-before-tab newline indentation empty space-after-tab space-mark tab-mark)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
