;;; config/reveal.el -*- lexical-binding: t; -*-


(with-eval-after-load 'ox
  (require 'ox-reveal))


(after! ox-reveal
  (setq org-reveal-root "https://cdn.jsdelivr.net/npm/reveal.js"
        org-reveal-theme "solarized"
        org-reveal-transition "fade"
        org-reveal-slide-number t
        ;; OPTIONAL: Use heading level 2 as slide break depth
        org-export-headline-levels 2))

(after! ox-reveal
  (setq org-reveal-extra-css "~/.config/doom/org-reveal/scroll.css"))
(after! ox-reveal
  (setq org-reveal-center nil))   ;; <— this stops vertical centering
