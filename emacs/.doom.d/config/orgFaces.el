;;; config/orgFaces.el -*- lexical-binding: t; -*-


;; ================================
;; Beautiful Org Mode (Doom-safe)
;; ================================

(after! org
  ;; General Org behavior (safe before faces)
  (setq org-hide-emphasis-markers t
        org-ellipsis " ▾"
        org-pretty-entities t
        org-fontify-quote-and-verse-blocks t
        org-fontify-whole-heading-line t
        org-fontify-done-headline t
        org-fontify-todo-headline t
        org-startup-indented t))

;; (with-eval-after-load 'org-faces
(after! org
  ;; Document title
  (set-face-attribute 'org-document-title nil
                      :height 1.6
                      :weight 'bold
                      :foreground (or (doom-color 'fg) 'unspecified))

  ;; Headings
  (set-face-attribute 'org-level-1 nil :height 1.35 :weight 'bold)
  (set-face-attribute 'org-level-2 nil :height 1.25 :weight 'bold)
  (set-face-attribute 'org-level-3 nil :height 1.18 :weight 'bold)
  (set-face-attribute 'org-level-4 nil :height 1.12 :weight 'bold)
  (set-face-attribute 'org-level-5 nil :height 1.08)

  ;; Code & blocks
  (set-face-attribute 'org-block nil
                      :background (or (doom-color 'bg-alt) 'unspecified)
                      :extend t)

  (set-face-attribute 'org-block-begin-line nil
                      :foreground (or (doom-color 'comments) 'unspecified)
                      :background (or (doom-color 'bg-alt) 'unspecified)
                      :extend t)

  (set-face-attribute 'org-block-end-line nil
                      :foreground (or (doom-color 'comments) 'unspecified)
                      :background (or (doom-color 'bg-alt) 'unspecified)
                      :extend t)

  ;; Quote blocks
  (set-face-attribute 'org-quote nil
                      :background (or (doom-color 'bg-alt) 'unspecified)
                      :slant 'italic
                      :extend t)

  ;; Example blocks (guarded: face removed in newer Org)
  (when (facep 'org-example)
    (set-face-attribute 'org-example nil
                        :background (or (doom-color 'bg-alt) 'unspecified)
                        :extend t))

  ;; Fixed-pitch for code-like elements
  (set-face-attribute 'org-code nil
                      :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil
                      :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-meta-line nil
                      :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-special-keyword nil
                      :inherit '(font-lock-comment-face fixed-pitch))

  ;; Tables
  (set-face-attribute 'org-table nil
                      :inherit 'fixed-pitch))



(defun cisco/org-faces ()
  ;; Document title
  (set-face-attribute 'org-document-title nil
                      :height 1.6
                      :weight 'bold
                      :foreground (or (doom-color 'fg) 'unspecified))

  ;; Headings
  (set-face-attribute 'org-level-1 nil :height 1.35 :weight 'bold)
  (set-face-attribute 'org-level-2 nil :height 1.25 :weight 'bold)
  (set-face-attribute 'org-level-3 nil :height 1.18 :weight 'bold)
  (set-face-attribute 'org-level-4 nil :height 1.12 :weight 'bold)
  (set-face-attribute 'org-level-5 nil :height 1.08)

  ;; Blocks
  (set-face-attribute 'org-block nil
                      :background (or (doom-color 'bg-alt) 'unspecified)
                      :extend t)

  (set-face-attribute 'org-block-begin-line nil
                      :foreground (or (doom-color 'comments) 'unspecified)
                      :background (or (doom-color 'bg-alt) 'unspecified)
                      :extend t)

  (set-face-attribute 'org-block-end-line nil
                      :foreground (or (doom-color 'comments) 'unspecified)
                      :background (or (doom-color 'bg-alt) 'unspecified)
                      :extend t)

  ;; Quote
  (set-face-attribute 'org-quote nil
                      :background (or (doom-color 'bg-alt) 'unspecified)
                      :slant 'italic
                      :extend t)

  ;; Example
  (when (facep 'org-example)
    (set-face-attribute 'org-example nil
                        :background (or (doom-color 'bg-alt) 'unspecified)
                        :extend t))

  ;; Code
  (set-face-attribute 'org-code nil
                      :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-verbatim nil
                      :inherit '(shadow fixed-pitch))
  (set-face-attribute 'org-meta-line nil
                      :inherit '(font-lock-comment-face fixed-pitch))
  (set-face-attribute 'org-special-keyword nil
                      :inherit '(font-lock-comment-face fixed-pitch))

  ;; Tables
  (set-face-attribute 'org-table nil
                      :inherit 'fixed-pitch))

(add-hook 'doom-load-theme-hook #'cisco/org-faces)
