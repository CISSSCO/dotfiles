;;; config/basic.el -*- lexical-binding: t; -*-


;; org journal settings
(setq org-journal-date-prefix "#+TITLE: "
      org-journal-time-prefix "** "
      org-journal-date-format "%a, %d-%m-%Y"
      org-journal-file-format "%d-%m-%Y.org")

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (python . t)
   (lisp . t)
   (C . t)
   (C++ . t)
   (Cpp . t)
   (fortran . t)
   (bash . t)
   (javascript . t)))


(setq org-confirm-babel-evaluate nil)
;; (setq-default evil-escape-key-sequence "kj")
;;(setq-default evil-escape-key-sequence "jk")

;; Disable subscript and superscript interpretation during export
(setq org-export-with-sub-superscripts '{})


;;; Theme and Fonts ----------------------------------------

;; Load up doom-palenight for the System Crafters look
;;(load-theme 'doom-palenight t)


;; Set tab width to 4 spaces globally
(setq-default tab-width 4)

;; Use spaces instead of tabs
(setq-default indent-tabs-mode nil)

;; Enable auto-indentation globally
(electric-indent-mode 1)

;; Enable auto-indentation in programming modes
(add-hook 'prog-mode-hook 'electric-indent-mode)

;; Specific settings for Python
(use-package! python
  :config
  (setq python-indent-offset 4))

;; Specific settings for C/C++
(use-package! cc-mode
  :config
  (setq c-basic-offset 4))


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; EVIL ESCAPE (jk / kj)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(after! evil-escape
  (setq evil-escape-key-sequence "jk"
        evil-escape-unordered-key-sequence t
        evil-escape-delay 0.2))


;(setq org-pandoc-options '((pdf-engine . "pdflatex")))
; (setq org-pandoc-options '((pdf-engine . "wkhtmltopdf")))

(defun cisco/kill-other-buffers ()
  "Kill all buffers except current and important ones."
  (interactive)
  (let ((current (current-buffer))
        (protected '("*Messages*" "*scratch*" "*doom*" "*Async-native-compile-log*")))
    (dolist (buf (buffer-list))
      (let ((name (buffer-name buf)))
        (unless (or (eq buf current)
                    (member name protected)
                    (string-prefix-p " " name)) ;; hidden buffers
          (kill-buffer buf)))))
  (message "Cleaned buffers 🚀"))
