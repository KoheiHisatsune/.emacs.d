(load-theme 'zenburn t)

(global-linum-mode t)
(line-number-mode t)
(column-number-mode t)
(display-time)
(setq frame-title-format "%f")

(setq backup-inhibited t)

(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook 'rainbow-delimiters-mode)

(require 'cl-lib)
(require 'color)
(defun rainbow-delimiters-using-stronger-colors ()
  (interactive)
  (cl-loop
   for index from 1 to rainbow-delimiters-max-face-count
   do
   (let ((face (intern (format "rainbow-delimiters-depth-%d-face" index ))))
     (cl-callf color-saturate-name (face-foreground face) 30 ))))
(add-hook 'emacs-startup-hook 'rainbow-delimiters-using-stronger-colors)

;;Indent HDL Mode
(add-hook 'verilog-mode-hook
	  (lambda ()
	    (setq indent-tabs-mode nil)))
(add-hook 'verilog-mode-hook
	  (lambda ()
	    (setq tab-width 2)))
(add-hook 'vhdl-mode-hook
	  (lambda ()
	    (setq indent-tabs-mode nil)))
(add-hook 'vhdl-mode-hook
	  (lambda ()
	    (setq tab-width 2)))

;;Indent Python Mode
(add-hook 'python-mode-hook
	  (lambda ()
	    (setq indent-tabs-mode nil)))
(add-hook 'python-mode-hook
	  (lambda ()
	    (setq tab-width 4)))

;;paren-mode
(setq show-paren-delay 0)
(show-paren-mode t)

(setq show-paren-style 'expression)

;; Markdown-Mode
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;;Helm
(require 'helm-config)

;;auto-complete
(when (require 'auto-complete-config nil t)
  (define-key ac-mode-map (kbd "M-TAB") 'auto-complete)
  (ac-config-default)
  (setq ac-use-menu-map t)
  (setq ac-ignore-case nil))

;;color-moccur
(when (require 'color-moccur nil t)
  (define-key global-map (kbd "M-o") 'occur-by-moccur)
  (setq moccur-split-word t)
  (add-to-list 'dmoccur-exclusion-mask "\\.DS_Store")
  (add-to-list 'dmoccur-exclusion-mask "^#.+#$"))

;;moccur-edit
(require 'moccur-edit nil t)

;;wgrep
(require 'wgrep nil t)

;;undohist
(when (require 'undohist nil t)
  (undohist-initialize))

;;undotree
(when (require 'undo-tree nil t)
  (global-undo-tree-mode))

;;ElScreen
(setq elscreen-prefix-key (kbd "C-z"))
(elscreen-start)
(setq elscreen-tab-display-kill-screen nil)
(setq elscreen-tab-display-control nil)
(setq elscreen-buffer-to-nickname-alist
      '(("^dired-mode$" .
	 (lambda ()
	   (format "Dired(%s)" dired-directory)))
	("^Info-mode$"  .
	 (lambda ()
	   (format "Info(%s)" (file-name-directory Info-current-file))))
	("^mew-draft-mode$" .
	 (lambda ()
	   (format "Info(%s)" (buffer-name (current-buffer)))))
	("^mew-" . "Mew")
	("^irchat-" . "IRChat")
	("^liece-"."Liece")
	("^lookup-" . "Lookup")))
(setq elscreen-mode-to-nickname-alist
      '(("[Ss]hell"."shell")
	("compilation" . "compile")
	("-telnet" . "telnet")
	("dict" . "OnlineDict")
	("*WL:Message*"."Wanderlust")))

;;cua-mode
(cua-mode t)
(setq cua-enable-cua-keys nil)
(define-key global-map (kbd "C-x SPC") 'cua-set-rectangle-mark)

;;projectile
(when (require 'helm-projectile-fuzzy-match nil)
  (setq projectile-completion-system 'helm))
