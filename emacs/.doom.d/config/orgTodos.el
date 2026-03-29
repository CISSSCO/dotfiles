;;; config/orgTodos.el -*- lexical-binding: t; -*-

(after! org
  ;; open in current window (no split)
  (setq org-capture-window-setup 'current-window)

  ;; force fullscreen
  (add-hook 'org-capture-mode-hook #'delete-other-windows)

  ;; disable doom popup
  (set-popup-rule! "^\\*Org Capture" :ignore t))

