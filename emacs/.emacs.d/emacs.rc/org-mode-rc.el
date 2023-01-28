(global-set-key (kbd "C-x a") 'org-agenda)
(global-set-key (kbd "C-c C-x j") #'org-clock-jump-to-current-clock)

(require 'ox-latex)
(require 'ox-md)
(require 'ox-html)

(setq org-src-fontify-natively t)

(setq org-export-backends '(md))

(defun rc/org-increment-move-counter ()
  (interactive)

  (defun default (x d)
    (if x x d))

  (let* ((point (point))
         (move-counter-name "MOVE_COUNTER")
         (move-counter-value (-> (org-entry-get point move-counter-name)
                                 (default "0")
                                 (string-to-number)
                                 (1+))))
    (org-entry-put point move-counter-name
                   (number-to-string move-counter-value)))
  nil)

(defun rc/org-get-heading-name ()
  (nth 4 (org-heading-components)))

(defun rc/org-kill-heading-name-save ()
  (interactive)
  (let ((heading-name (rc/org-get-heading-name)))
    (kill-new heading-name)
    (message "Kill \"%s\"" heading-name)))

(global-set-key (kbd "C-x p w") 'rc/org-kill-heading-name-save)

(with-eval-after-load 'ox-latex
  (add-to-list 'org-latex-classes
               '("org-plain-latex"
                 "\\documentclass{article}
                  [NO-DEFAULT-PACKAGES]
                  [PACKAGES]
                  [EXTRA]"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))


(with-eval-after-load 'ox-latex
  (add-to-list 'org-latex-classes
               '("org-apu-latex"
                 "\\documentclass{article}
                  [NO-DEFAULT-PACKAGES]
                  [PACKAGES]
                  [EXTRA]"
                 ("\\section{%s}" . "\\section*{%s}")
                 ("\\subsection{%s}" . "\\subsection*{%s}")
                 ("\\subsubsection{%s}" . "\\subsubsection*{%s}")
                 ("\\paragraph{%s}" . "\\paragraph*{%s}")
                 ("\\subparagraph{%s}" . "\\subparagraph*{%s}"))))

(setq org-latex-listings 't)

(setq org-todo-keywords
      '((sequence "TODO(t)" "STARTED(s)" "|" "DONE(d!)")))

;;; org-agenda

(setq org-agenda-files (list "~/Documents/Agenda/"))

(setq org-agenda-custom-commands
      '(("u" "Unscheduled" tags "+personal-SCHEDULED={.+}-DEADLINE={.+}/!+TODO"
         ((org-agenda-sorting-strategy '(priority-down))))
        ("A" "APU"
         ((agenda "")
          (tags-todo "+apu+CATEGORY=\"assignment\""
                     ((org-agenda-overriding-header "Assignment")
                      (org-agenda-entry-types '(:deadline))
                      (org-agenda-ndays 7)
                      (org-agenda-time-grid nil)))
          (tags-todo "+apu+CATEGORY=\"fsec\""
                     ((org-agenda-overriding-header "FSec"))))
         ((org-agenda-sorting-strategy '(priority-down))
          (org-agenda-ndays 1)
          (org-deadline-warning-days 60)
          ))
        ("p" "Personal" ((agenda "" ((org-agenda-tag-filter-preset (list "+personal"))))))
        ("w" "Work" ((agenda "" ((org-agenda-tag-filter-preset (list "+work"))))))
        ("d" "Deadlines" agenda ""
         ((org-agenda-entry-types '(:deadline))
          (org-agenda-ndays 1)
          (org-deadline-warning-days 60)
          (org-agenda-time-grid nil)))
        ("c" "Calendar" agenda ""
         ((org-agenda-ndays 7)
          (org-agenda-start-on-weekday 0)
          (org-agenda-time-grid nil)                    
          (org-agenda-repeating-timestamp-show-all t)
          (org-agenda-entry-types '(:timestamp :sexp))))
        ))


(setq org-agenda-start-with-log-mode t)
(setq org-log-done 'time)
(setq org-log-into-drawer t)
(setq org-refile-targets
      '(("Archive.org" :maxlevel . 1)
        ("Tasks.org" :maxlevel . 1)))

(advice-add 'org-refile :after 'org-save-all-org-buffers)


;;; org-cliplink

(rc/require 'org-cliplink)

(global-set-key (kbd "C-x y i") 'org-cliplink)

(defun rc/cliplink-task ()
  (interactive)
  (org-cliplink-retrieve-title
   (substring-no-properties (current-kill 0))
   '(lambda (url title)
      (insert (if title
                  (concat "* TODO " title
                          "\n  [[" url "][" title "]]")
                (concat "* TODO " url
                        "\n  [[" url "]]"))))))
(global-set-key (kbd "C-x y t") 'rc/cliplink-task)

;;; org-capture

(setq org-capture-templates
      '(("p" "Capture task" entry (file "~/Documents/Agenda/Tasks.org")
         "* TODO %?\n  SCHEDULED: %t\n")
        ("K" "Cliplink capture task" entry (file "~/Documents/Agenda/Tasks.org")
         "* TODO %(org-cliplink-capture) \n  SCHEDULED: %t\n" :empty-lines 1)
        ("A" "APU")
        ("Aa" "Assignment" entry (file "~/Documents/Agenda/APU.org")
         "* TODO %? %^G\n  %^{prompt|DEADLINE|SCHEDULED}: %^{Due date}t\n  :PROPERTIES:\n  :CATEGORY: assignment\n  :END:" :empty-lines 1 :kill-buffer t)
        ("Af" "FSec" entry (file "~/Documents/Agenda/APU.org")
         "* TODO %? %^G\n \n  %^{prompt|DEADLINE|SCHEDULED}: %^{Due date}t\n  :PROPERTIES:\n  :CATEGORY: fsec\n  :END:" :empty-lines 1 :kill-buffer t)
        ))
(define-key global-map "\C-cc" 'org-capture)

