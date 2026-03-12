;;; ~/.doom.d/init.el -*- lexical-binding: t; -*-

(doom!

 :input
 ;;bidi              ; (tfel ot) thgir etirw uoy gnipleh
 ;;chinese
 ;;japanese
 ;;layout            ; auie,ctsrnm is the superior home row

 :completion
 (company +childframe)
 (vertico +icons)

 :ui
 doom
 doom-dashboard
 hl-todo
 modeline
 nav-flash
 ophints
 (popup +all)
 vc-gutter
 workspaces

 :editor
 (evil +everywhere)
 file-templates
 fold
 snippets
 word-wrap

 :emacs
 dired
 electric
 undo
 vc

 :term
 vterm

 :checkers
 syntax
 spell

 :tools
 lookup
 lsp
 magit
 tree-sitter

 :os
 (:if IS-LINUX tty)

 :lang
 emacs-lisp
 (org +roam2 +pretty)
 markdown
 sh

 :config
 (default +bindings +smartparens))
