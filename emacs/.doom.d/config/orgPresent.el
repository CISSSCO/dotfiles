;;; config/orgPresent.el -*- lexical-binding: t; -*-


;; org present
;; Robust org-present folding behavior
(after! org-present
  ;; Helper: fold everything and reveal only current entry (safe)
  (defun my/org-present-show-current-only (&rest _)
    "Fold the buffer, then show only the current headline entry.
Accepts arbitrary args so it is safe as a hook function."
    (ignore-errors
      ;; Fold everything
      (when (fboundp 'org-overview) (org-overview))
      ;; Show current headline body
      (when (fboundp 'org-show-entry) (org-show-entry))
      ;; Keep direct children collapsed (show only the headline, not expanded)
      ;; org-show-children can accept an arg; wrap in ignore-errors to avoid bad-arg errors
      (ignore-errors (when (fboundp 'org-show-children) (org-show-children 0)))))

  ;; Hook to run when entering org-present-mode
  (add-hook 'org-present-mode-hook
            (lambda ()
              (ignore-errors
                ;; Apply folding behaviour right away
                (my/org-present-show-current-only)
                ;; Hide mode-line if available
                (when (fboundp 'hide-mode-line-mode) (hide-mode-line-mode 1)))))

  ;; Hook to reapply on navigation; accepts any args from the caller
  (add-hook 'org-present-after-navigate-functions
            (lambda (&rest _)
              (ignore-errors
                (my/org-present-show-current-only)))))

