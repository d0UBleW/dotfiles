(defun wsl-copy (start end)
  "Copy currently selected text to the Windows clipboard"
  (interactive "r")
  (let ((default-directory "/mnt/c/"))
    (shell-command-on-region start end "clip.exe")))

(defun wsl-paste ()
  "Paste contents of Windows clipboard to buffer"
  (interactive)
  (let ((coding-system-for-read 'dos)
	    (default-directory "/mnt/c/"))
    (insert (shell-command-to-string
	     "powershell.exe -command 'Get-Clipboard'"))))
