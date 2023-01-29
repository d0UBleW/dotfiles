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

(load "~/.emacs.d/emacs.rc/rc.el")
(load "~/.emacs.d/emacs.rc/org-mode-rc.el")
(load "~/.emacs.d/emacs.rc/clipboard-rc.el")

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
      compilation-scroll-output t)

(setq-default tab-width 4
			  indent-tabs-mode nil)			  

(setq confirm-kill-emacs 'y-or-n-p)

(use-package evil
  :ensure t
  :init
  (setq evil-want-integration t)
  (setq evil-want-keybinding nil)
  (setq evil-want-C-u-scroll t)
  (setq evil-want-C-i-jump nil)
  (setq evil-disable-insert-state-bindings t)
  (setq evil-default-state 'emacs)
  (setq evil-buffer-regexps '((".*" . emacs)))
  :config
  (evil-mode 1)
  (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
  (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)
  ;; (define-key evil-insert-state-map (kbd "C-a") 'nil)
  ;; (define-key evil-insert-state-map (kbd "C-e") 'nil)
  (define-key evil-normal-state-map (kbd "C-a") 'nil)
  (define-key evil-motion-state-map (kbd "C-e") 'nil)
  (define-key evil-motion-state-map (kbd "C-y") 'nil)
  (define-key evil-normal-state-map (kbd "C-n") 'nil)
  (define-key evil-normal-state-map (kbd "C-p") 'nil)
  (define-key evil-motion-state-map (kbd "C-f") 'nil)
  (define-key evil-motion-state-map (kbd "C-b") 'nil)

  ;; Use visual line motions even outside of visual-line-mode buffers
  (evil-global-set-key 'motion "j" 'evil-next-visual-line)
  (evil-global-set-key 'motion "k" 'evil-previous-visual-line))

(use-package evil-collection
  :ensure t
  :after evil
  :config
  (evil-collection-init))

(use-package general
  :after evil
  :config
  (general-create-definer efs/leader-keys
    :keymaps '(normal insert visual emacs)
    :prefix "SPC"
    :global-prefix "C-SPC")

  (efs/leader-keys
    "t"  '(:ignore t :which-key "toggles")
    "tt" '(counsel-load-theme :which-key "choose theme")
    "fde" '(lambda () (interactive) (find-file (expand-file-name "~/.emacs.d/Emacs.org")))))


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

(setq gc-cons-threshold (* 100 1024 1024))
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

(use-package saveplace
  :ensure t
  :config
  (setq-default save-place t)
  (setq save-place-file (expand-file-name ".places" user-emacs-directory)))

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


(use-package all-the-icons
  :ensure t
  :if (display-graphic-p))

(use-package helpful
  :commands (helpful-callable helpful-variable helpful-command helpful-key)
  :custom
  (counsel-describe-function-function #'helpful-callable)
  (counsel-describe-variable-function #'helpful-variable)
  :bind
  ([remap describe-function] . counsel-describe-function)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . counsel-describe-variable)
  ([remap describe-key] . helpful-key))

(use-package ido-completing-read+
  :ensure t)

(use-package helm
  :ensure t
  :custom
  (helm-split-window-inside-p t)
  :bind
  ("C-c h t" . helm-cmd-t)
  ("C-c h g g" . helm-git-grep)
  ("C-c h g l" . helm-ls-git)
  ("C-c h F" . helm-find)
  ("C-c h f" . helm-find-files)
  ("C-c h a" . helm-org-agenda-files-headings)
  ("C-c h r" . helm-recentf)
  ("C-c h x" . helm-M-x))

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package ivy-rich
  :after ivy
  :init
  (ivy-rich-mode 1))

(use-package counsel
  :bind (("C-M-j" . 'counsel-switch-buffer)
         :map minibuffer-local-map
         ("C-r" . 'counsel-minibuffer-history))
  :custom
  (counsel-linux-app-format-function #'counsel-linux-app-format-function-name-only)
  :config
  (counsel-mode 1))

(use-package ivy-prescient
  :after counsel
  :custom
  (ivy-prescient-enable-filtering nil)
  :config
  ;; Uncomment the following line to have sorting remembered across sessions!
  ;(prescient-persist-mode 1)
  (ivy-prescient-mode 1))

(use-package ace-window
  :ensure t
  :bind
  (("M-o" . ace-window)))

(use-package ido
  :ensure t
  :config
  (setq ido-everywhere 1)
  (setq ido-enable-flex-matching 1)
  (setq ido-use-faces nil)
  (ido-mode 1)
  (ido-everywhere 1)
  (ido-ubiquitous-mode 1))

(use-package flx-ido
  :ensure t
  :config
  (flx-ido-mode 1))

(use-package smex
  :ensure t)

(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

;; (use-package projectile
;;   :ensure t
;;   :config
;;   (projectile-mode 1)
;;   :custom
;;   (projectile-completion-system 'helm)
;;   :bind-keymap
;;   ("C-x p" . projectile-command-map)
;;   :init
;;   (when (file-directory-p "~/projects")
;;     (setq projectile-project-search-path '(("~/projects/" . 2))))
;;   (setq projectile-switch-project-action #'projectile-dired))

;; (use-package counsel-projectile
;;   :after projectile
;;   :config (counsel-projectile-mode))

(use-package project
  :ensure t)

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
  (doom-modeline-indent-info t)
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

(define-key yas-minor-mode-map (kbd "C-c y") #'yas-expand)

(use-package move-text
  :ensure t
  :bind
  (("M-P" . move-text-up)
   ("M-N" . move-text-down)))

(use-package multiple-cursors
  :ensure t
  :bind
  (("C-S-c C-S-c" . mc/edit-lines)
   ("C->" . mc/mark-next-like-this)
   ("C-<" . mc/mark-previous-like-this)
   ("C-M->" . mc/unmark-next-like-this)
   ("C-M-<" . mc/unmark-previous-like-this)
   ("C-c m a" . mc/mark-all-like-this)
   ("C-\"" . mc/skip-to-next-like-this)
   ("C-;" . mc/skip-to-previous-like-this)))

(require 'dired-x)
;; (setq dired-omit-files
;;       (concat dired-omit-files "\\|^\\..+$"))
(defun rc/dired-key()
  (local-set-key (kbd "M-<return>") 'dired-up-directory))
;; (add-hook 'dired-mode-hook 'dired-key)

(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump))
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

(use-package evil-nerd-commenter
  :bind
  ("C-M-;" . evilnc-comment-or-uncomment-lines))

;; (use-package json-mode
;;   :ensure t)

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


(use-package company
  :hook (prog-mode . company-mode)
  :bind
  (:map company-active-map ("<tab>" . company-complete-selection))
  :custom
  (company-minimum-prefix-length 1)
  (company-idle-delay 0.0))

(use-package company-box
  :hook (company-mode . company-box-mode))

(defun rc/lsp-mode-setup ()
  (setq lsp-headerline-breadcrumb-segments '(path-up-to-project file symbols))
  (lsp-headerline-breadcrumb-mode))

(use-package lsp-mode
  :commands (lsp lsp-deferred)
  :hook
  ((lsp-mode . rc/lsp-mode-setup)
   (web-mode . lsp-deferred))
  :bind
  (:map lsp-mode-map ("<tab>" . company-indent-or-complete-common))
  :init
  (setq lsp-keymap-prefix "C-l")
  :custom
  (lsp-enable-symbol-highlighting t)
  (lsp-signature-auto-activate nil)
  :config
  (lsp-enable-which-key-integration t)
  (setq lsp-log-io nil))

(use-package lsp-ui
  :hook (lsp-mode . lsp-ui-mode)
  :custom
  (lsp-ui-doc-position 'bottom)
  :commands lsp-ui-mode)

(use-package lsp-treemacs
  :after lsp)

;; (use-package helm-lsp
;;   :after lsp)

(use-package lsp-ivy
  :after lsp)

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

(use-package dap-mode)

(use-package typescript-mode
  :mode "\\.tsx?\\'"
  :hook (typescript-mode . lsp-deferred)
  :config
  (setq typescript-indent-level 2))


(use-package python-mode
  :ensure t
  :hook
  (python-mode . lsp-deferred)
  :config
  (setq python-indent-offset 4)
  :custom
  (python-shell-interpreter "python3"))

(use-package pyvenv
  :ensure t
  :init
  (setenv "WORKON_HOME" "~/.pyenv/versions/"))


(use-package term
  :commands term
  :config
  (setq explicit-shell-file-name "bash")
  ;;(setq explicit-zsh-args '())         ;; Use 'explicit-<shell>-args for shell-specific args

  ;; Match the default Bash shell prompt.  Update this if you have a custom prompt
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *"))

(use-package eterm-256color
  :hook (term-mode . eterm-256color-mode))

(use-package vterm
  :ensure t
  :commands vterm
  :config
  (setq term-prompt-regexp "^[^#$%>\n]*[#$%>] *")  ;; Set this to match your custom shell prompt
  (setq vterm-shell "bash")                       ;; Set this to customize the shell to launch
  (setq vterm-max-scrollback 10000))

(defun rc/configure-eshell ()
  ;; Save command history when commands are entered
  (add-hook 'eshell-pre-command-hook 'eshell-save-some-history)

  ;; Truncate buffer for performance
  (add-to-list 'eshell-output-filter-functions 'eshell-truncate-buffer)

  (setq eshell-history-size         10000
        eshell-buffer-maximum-lines 10000
        eshell-hist-ignoredups t
        eshell-scroll-to-bottom-on-input t))

(use-package eshell-git-prompt
  :after eshell)

(use-package eshell
  :hook (eshell-first-time-mode . rc/configure-eshell)
  :config

  (with-eval-after-load 'esh-opt
    (setq eshell-destroy-buffer-when-process-dies t)
    (setq eshell-visual-commands '("htop" "bash" "vim" "npx")))

  (eshell-git-prompt-use-theme 'robbyrussell))

(use-package popper
  :ensure t ; or :straight t
  :bind (("C-`"   . popper-toggle-latest)
         ("M-`"   . popper-cycle)
         ("C-M-`" . popper-toggle-type))
  :init
  (setq popper-reference-buffers
        '("\\*Messages\\*"
          "Output\\*$"
          "\\*Async Shell Command\\*"
          help-mode
          compilation-mode
          "^\\*Python\\*$"
          "^\\*ielm\\*$"
          "^\\*helpful.*\\*$" helpful-mode
          "^\\*eshell.*\\*$" eshell-mode
          "^\\*shell.*\\*$" shell-mode
          "^\\*term.*\\*$" term-mode
          "^\\*vterm.*\\*$" vterm-mode))
  (popper-mode +1)
  (popper-echo-mode +1))                ; For echo area hints


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("bddf21b7face8adffc42c32a8223c3cc83b5c1bbd4ce49a5743ce528ca4da2b6" default))
 '(display-line-numbers-type 'relative)
 '(helm-minibuffer-history-key "M-p")
 '(package-selected-packages
   '(popper evil pyenv-mode lsp-ivy pyenv ivy-prescient ivy-rich yaml-mode which-key web-mode vterm visual-fill-column use-package tuareg toml-mode tide sml-mode smex scala-mode rust-mode rfc-mode rainbow-delimiters racket-mode qml-mode python-mode purescript-mode proof-general prettier-js powershell php-mode paredit org-cliplink org-bullets no-littering nix-mode nim-mode nginx-mode nasm-mode multiple-cursors move-text magit lua-mode lsp-ui lsp-pyright kotlin-mode json-mode jinja2-mode ido-completing-read+ htmlize hindent helpful helm-swoop helm-lsp helm-ls-git helm-git-grep helm-cmd-t haskell-mode gruber-darker-theme graphviz-dot-mode go-mode glsl-mode flx-ido expand-region exec-path-from-shell evil-nerd-commenter eterm-256color eshell-git-prompt elpy edit-indirect doom-modeline dockerfile-mode dired-single dired-open dash-functional dap-mode d-mode csharp-mode counsel-projectile company-box cmake-mode clojure-mode auto-package-update ansible all-the-icons-dired ag))
 '(whitespace-style
   '(face tabs spaces trailing space-before-tab newline indentation empty space-after-tab space-mark tab-mark)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
