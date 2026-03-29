;;; config/orgModern.el -*- lexical-binding: t; -*-


;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ORG MODERN UI
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

;; Modern Org visuals + original org-modern bullets
(use-package! org-modern
  :hook (org-mode . org-modern-mode)
  :config
  ;; restore original org-modern bullet hierarchy
  (setq org-modern-star
        '("◉" "◈" "✸" "✿" "✦" "○"))

  ;; keep stars hidden
  (setq org-modern-hide-stars t)

  ;; list bullets
  (setq org-modern-list
        '((?- . "•")
          (?+ . "➤")
          (?* . "•")))

  ;; visuals
  (setq org-modern-block-fringe nil
        org-modern-table nil)

  ;; FIX: prevent variable font from collapsing bullets
  (set-face-attribute 'org-modern-symbol nil
                      :inherit 'fixed-pitch
                      :height 1.0
                      :weight 'normal))

