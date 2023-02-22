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
              c-basic-offset 4
			  indent-tabs-mode nil)			  

(setq confirm-kill-emacs 'y-or-n-p)

;; (use-package so-long
;;   :ensure t
;;   :config
;;   (global-so-long-mode 1))

;; (use-package evil
;;   :ensure t
;;   :init
;;   (setq evil-want-integration t)
;;   (setq evil-want-keybinding nil)
;;   (setq evil-want-C-u-scroll t)
;;   (setq evil-want-C-i-jump nil)
;;   (setq evil-disable-insert-state-bindings t)
;;   (setq evil-default-state 'emacs)
;;   (setq evil-buffer-regexps '((".*" . emacs)))
;;   :config
;;   (define-key evil-insert-state-map (kbd "C-g") 'evil-normal-state)
;;   (define-key evil-insert-state-map (kbd "C-h") 'evil-delete-backward-char-and-join)
;;   ;; (define-key evil-insert-state-map (kbd "C-a") 'nil)
;;   ;; (define-key evil-insert-state-map (kbd "C-e") 'nil)
;;   (define-key evil-normal-state-map (kbd "C-a") 'nil)
;;   (define-key evil-motion-state-map (kbd "C-e") 'nil)
;;   (define-key evil-motion-state-map (kbd "C-y") 'nil)
;;   (define-key evil-normal-state-map (kbd "C-n") 'nil)
;;   (define-key evil-normal-state-map (kbd "C-p") 'nil)
;;   (define-key evil-motion-state-map (kbd "C-f") 'nil)
;;   (define-key evil-motion-state-map (kbd "C-b") 'nil)

;;   ;; Use visual line motions even outside of visual-line-mode buffers
;;   (evil-global-set-key 'motion "j" 'evil-next-visual-line)
;;   (evil-global-set-key 'motion "k" 'evil-previous-visual-line))

;; (use-package evil-collection
;;   :ensure t
;;   :after evil
;;   :config
;;   (evil-collection-init))

;; (use-package general
;;   :after evil
;;   :config
;;   (general-create-definer efs/leader-keys
;;     :keymaps '(normal insert visual emacs)
;;     :prefix "SPC"
;;     :global-prefix "C-SPC")

;;   (efs/leader-keys
;;     "t"  '(:ignore t :which-key "toggles")
;;     ;; "tt" '(counsel-load-theme :which-key "choose theme")
;;     "fde" '(lambda () (interactive) (find-file (expand-file-name "~/.emacs.d/Emacs.org")))))


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

(use-package recentf
  :ensure nil
  :config
  (recentf-mode 1))

;; (defun rc/turn-on-paredit()
;;   (interactive)
;;   (paredit-mode 1))

;; (use-package paredit
;;   :ensure t
;;   :hook
;;   (emacs-lisp-mode . rc/turn-on-paredit)
;;   (clojure-mode . rc/turn-on-paredit)
;;   (lisp-mode . rc/turn-on-paredit)
;;   (common-lisp-mode . rc/turn-on-paredit)
;;   (scheme-mode . rc/turn-on-paredit))

(use-package smartparens
  :ensure t
  :hook
  ;; (emacs-lisp-mode . smartparens-mode)
  ;; (common-lisp-mode . smartparens-mode)
  ;; (lisp-mode . smartparens-mode)
  ;; (clojure-mode . smartparens-mode)
  ;; (scheme-mode . smartparens-mode)
  ;; (js-mode . smartparens-mode)
  (prog-mode . smartparens-mode)
  :config
  (require 'smartparens-config)
  (sp-use-smartparens-bindings)
  (define-key smartparens-mode-map (kbd "C-M-]") 'sp-select-previous-thing-exchange))

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
  :bind
  ([remap describe-function] . helpful-callable)
  ([remap describe-command] . helpful-command)
  ([remap describe-variable] . helpful-variable)
  ([remap describe-key] . helpful-key))

;; (use-package ido-completing-read+
;;   :ensure t)

(use-package helm
  :ensure t
  :custom
  (helm-split-window-inside-p t))


(use-package orderless
  :ensure t
  :custom
  (orderless-component-separator "[ &]")
  (completion-styles '(substring orderless basic flex partial-completion))
  (completion-category-overrides '((file (styles basic partial-completion)))))

;; Enable vertico
(use-package vertico
  :init
  (vertico-mode)

  ;; Different scroll margin
  ;; (setq vertico-scroll-margin 0)

  ;; Show more candidates
  ;; (setq vertico-count 20)

  ;; Grow and shrink the Vertico minibuffer
  ;; (setq vertico-resize t)

  ;; Optionally enable cycling for `vertico-next' and `vertico-previous'.
  (setq vertico-cycle t)
  )

;; Persist history over Emacs restarts. Vertico sorts by history position.
(use-package savehist
  :init
  (savehist-mode))

;; A few more useful configurations...
(use-package emacs
  :init
  ;; Add prompt indicator to `completing-read-multiple'.
  ;; We display [CRM<separator>], e.g., [CRM,] if the separator is a comma.
  (defun crm-indicator (args)
    (cons (format "[CRM%s] %s"
                  (replace-regexp-in-string
                   "\\`\\[.*?]\\*\\|\\[.*?]\\*\\'" ""
                   crm-separator)
                  (car args))
          (cdr args)))
  (advice-add #'completing-read-multiple :filter-args #'crm-indicator)



  ;; Do not allow the cursor in the minibuffer prompt
  (setq minibuffer-prompt-properties
        '(read-only t cursor-intangible t face minibuffer-prompt))
  (add-hook 'minibuffer-setup-hook #'cursor-intangible-mode)

  ;; Emacs 28: Hide commands in M-x which do not work in the current mode.
  ;; Vertico commands are hidden in normal buffers.
  ;; (setq read-extended-command-predicate
  ;;       #'command-completion-default-include-p)

  ;; Enable recursive minibuffers
  (setq enable-recursive-minibuffers t))

;; Example configuration for Consult
(use-package consult
  ;; Replace bindings. Lazily loaded due by `use-package'.
  :bind (;; C-c bindings (mode-specific-map)
         ("C-c M-x" . consult-mode-command)
         ("C-c h" . consult-history)
         ("C-c k" . consult-kmacro)
         ("C-c M-m" . consult-man)
         ("C-c i" . consult-info)
         ([remap Info-search] . consult-info)
         ;; C-x bindings (ctl-x-map)
         ("C-x M-:" . consult-complex-command)     ;; orig. repeat-complex-command
         ("C-x b" . consult-buffer)                ;; orig. switch-to-buffer
         ("C-x 4 b" . consult-buffer-other-window) ;; orig. switch-to-buffer-other-window
         ("C-x 5 b" . consult-buffer-other-frame)  ;; orig. switch-to-buffer-other-frame
         ("C-x r b" . consult-bookmark)            ;; orig. bookmark-jump
         ("C-x p b" . consult-project-buffer)      ;; orig. project-switch-to-buffer
         ;; Custom M-# bindings for fast register access
         ("M-#" . consult-register-load)
         ("M-'" . consult-register-store)          ;; orig. abbrev-prefix-mark (unrelated)
         ("C-M-#" . consult-register)
         ;; Other custom bindings
         ("M-y" . consult-yank-pop)                ;; orig. yank-pop
         ;; M-g bindings (goto-map)
         ("M-g e" . consult-compile-error)
         ("M-g f" . consult-flymake)               ;; Alternative: consult-flycheck
         ;; ("M-g g" . consult-goto-line)             ;; orig. goto-line
         ;; ("M-g M-g" . consult-goto-line)           ;; orig. goto-line
         ("M-g o" . consult-outline)               ;; Alternative: consult-org-heading
         ("M-g m" . consult-mark)
         ("M-g k" . consult-global-mark)
         ("M-g i" . consult-imenu)
         ("M-g I" . consult-imenu-multi)
         ;; M-s bindings (search-map)
         ("M-s d" . consult-find)
         ("M-s D" . consult-locate)
         ("M-s g" . consult-grep)
         ("M-s G" . consult-git-grep)
         ("M-s r" . consult-ripgrep)
         ("M-s l" . consult-line)
         ("M-s L" . consult-line-multi)
         ("M-s k" . consult-keep-lines)
         ("M-s u" . consult-focus-lines)
         ;; Isearch integration
         ("M-s e" . consult-isearch-history)
         :map isearch-mode-map
         ("M-e" . consult-isearch-history)         ;; orig. isearch-edit-string
         ("M-s e" . consult-isearch-history)       ;; orig. isearch-edit-string
         ("M-s l" . consult-line)                  ;; needed by consult-line to detect isearch
         ("M-s L" . consult-line-multi)            ;; needed by consult-line to detect isearch
         ;; Minibuffer history
         :map minibuffer-local-map
         ("M-s" . consult-history)                 ;; orig. next-matching-history-element
         ("M-r" . consult-history))                ;; orig. previous-matching-history-element

  ;; Enable automatic preview at point in the *Completions* buffer. This is
  ;; relevant when you use the default completion UI.
  :hook (completion-list-mode . consult-preview-at-point-mode)

  ;; The :init configuration is always executed (Not lazy)
  :init

  ;; Optionally configure the register formatting. This improves the register
  ;; preview for `consult-register', `consult-register-load',
  ;; `consult-register-store' and the Emacs built-ins.
  (setq register-preview-delay 0.5
        register-preview-function #'consult-register-format)

  ;; Optionally tweak the register preview window.
  ;; This adds thin lines, sorting and hides the mode line of the window.
  (advice-add #'register-preview :override #'consult-register-window)

  ;; Use Consult to select xref locations with preview
  (setq xref-show-xrefs-function #'consult-xref
        xref-show-definitions-function #'consult-xref)

  ;; Configure other variables and modes in the :config section,
  ;; after lazily loading the package.
  :config

  ;; Optionally configure preview. The default value
  ;; is 'any, such that any key triggers the preview.
  ;; (setq consult-preview-key 'any)
  ;; (setq consult-preview-key (kbd "M-."))
  ;; (setq consult-preview-key (list (kbd "<S-down>") (kbd "<S-up>")))
  ;; For some commands and buffer sources it is useful to configure the
  ;; :preview-key on a per-command basis using the `consult-customize' macro.
  (consult-customize
   consult-theme :preview-key '(:debounce 0.2 any)
   consult-ripgrep consult-git-grep consult-grep
   consult-bookmark consult-recent-file consult-xref
   consult--source-bookmark consult--source-file-register
   consult--source-recent-file consult--source-project-recent-file
   ;; :preview-key (kbd "M-.")
   :preview-key '(:debounce 0.4 any))

  ;; Optionally configure the narrowing key.
  ;; Both < and C-+ work reasonably well.
  (setq consult-narrow-key "<") ;; (kbd "C-+")

  ;; Optionally make narrowing help available in the minibuffer.
  ;; You may want to use `embark-prefix-help-command' or which-key instead.
  ;; (define-key consult-narrow-map (vconcat consult-narrow-key "?") #'consult-narrow-help)

  ;; By default `consult-project-function' uses `project-root' from project.el.
  ;; Optionally configure a different project root function.
  ;; There are multiple reasonable alternatives to chose from.
  ;;;; 1. project.el (the default)
  ;; (setq consult-project-function #'consult--default-project--function)
  ;;;; 2. projectile.el (projectile-project-root)
  ;; (autoload 'projectile-project-root "projectile")
  ;; (setq consult-project-function (lambda (_) (projectile-project-root)))
  ;;;; 3. vc.el (vc-root-dir)
  ;; (setq consult-project-function (lambda (_) (vc-root-dir)))
  ;;;; 4. locate-dominating-file
  ;; (setq consult-project-function (lambda (_) (locate-dominating-file "." ".git")))
)

(use-package ace-window
  :ensure t
  :bind
  (("M-o" . ace-window)))

;; (use-package ido
;;   :ensure t
;;   :config
;;   (setq ido-everywhere 1)
;;   (setq ido-enable-flex-matching 1)
;;   (setq ido-use-faces nil)
;;   (ido-mode 1)
;;   (ido-everywhere 1)
;;   (ido-ubiquitous-mode 1))

;; (use-package flx-ido
;;   :ensure t
;;   :config
;;   (flx-ido-mode 1))

;; (use-package smex
;;   :ensure t)

;; (global-set-key (kbd "M-x") 'smex)
;; (global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)

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

(defun rc/org-mode-visual-fill ()
  (setq visual-fill-column-width 100
        visual-fill-column-center-text t)
  (visual-fill-column-mode 1))

(use-package visual-fill-column
  :hook (org-mode . rc/org-mode-visual-fill))

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
  (local-set-key (kbd "M-p") 'dired-single-up-directory)
  (local-set-key (kbd "M-n") 'dired-single-buffer))

;; (add-hook 'dired-mode-hook 'dired-key)

(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :bind (("C-x C-j" . dired-jump))
  :hook (dired-mode . rc/dired-key)
  :custom ((dired-listing-switches "-alh --group-directories-first")))


(use-package dired-single
  :commands (dired dired-jump))

(setq dired-dwim-target t)

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
  (company-minimum-prefix-length 2)
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

(use-package helm-lsp
  :after lsp)

(use-package consult-lsp
  :ensure t)

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
  (setq-default python-indent-offset 4)
  :custom
  (python-shell-interpreter "python3")
  (lsp-pylsp-plugins-pycodestyle-enabled t)
  (lsp-pylsp-plugins-pycodestyle-max-line-length 79)
  (lsp-pylsp-plugins-autopep8-enabled t)
  (lsp-pylsp-plugins-pydocstyle-ignore ["D100" "D101" "D102" "D103" "D107"]))

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

(use-package multi-vterm
  :ensure t)

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

(use-package marginalia
  ;; Either bind `marginalia-cycle' globally or only in the minibuffer
  :bind (("M-A" . marginalia-cycle)
         :map minibuffer-local-map
         ("M-A" . marginalia-cycle))

  ;; The :init configuration is always executed (Not lazy!)
  :init

  ;; Must be in the :init section of use-package such that the mode gets
  ;; enabled right away. Note that this forces loading the package.
  (marginalia-mode))

(use-package embark
  :ensure t

  :bind
  (("C-." . embark-act)         ;; pick some comfortable binding
   ("C-;" . embark-dwim)        ;; good alternative: M-.
   ("C-h B" . embark-bindings)) ;; alternative for `describe-bindings'

  :init

  ;; Optionally replace the key help with a completing-read interface
  (setq prefix-help-command #'embark-prefix-help-command)

  :config

  ;; Hide the mode line of the Embark live/completions buffers
  (add-to-list 'display-buffer-alist
               '("\\`\\*Embark Collect \\(Live\\|Completions\\)\\*"
                 nil
                 (window-parameters (mode-line-format . none)))))

;; Consult users will also want the embark-consult package.
(use-package embark-consult
  :ensure t ; only need to install it, embark loads it after consult if found
  :hook
  (embark-collect-mode . consult-preview-at-point-mode))

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
   '(smartparens smartparens-config multi-vterm consult-lsp consult orderless popper evil pyenv-mode lsp-ivy pyenv yaml-mode which-key web-mode vterm visual-fill-column use-package tuareg toml-mode tide sml-mode smex scala-mode rust-mode rfc-mode rainbow-delimiters qml-mode python-mode purescript-mode proof-general prettier-js powershell php-mode paredit org-cliplink org-bullets no-littering nix-mode nim-mode nginx-mode nasm-mode multiple-cursors move-text magit lua-mode lsp-ui lsp-pyright kotlin-mode json-mode jinja2-mode ido-completing-read+ htmlize hindent helpful helm-lsp helm-ls-git helm-git-grep haskell-mode gruber-darker-theme graphviz-dot-mode go-mode glsl-mode flx-ido expand-region exec-path-from-shell evil-nerd-commenter eterm-256color eshell-git-prompt elpy edit-indirect doom-modeline dockerfile-mode dired-single dired-open dash-functional dap-mode d-mode csharp-mode company-box cmake-mode clojure-mode auto-package-update ansible all-the-icons-dired ag))
 '(whitespace-style
   '(face tabs spaces trailing space-before-tab newline indentation empty space-after-tab space-mark tab-mark)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
