;;; config/pdf.el -*- lexical-binding: t; -*-


(defvar cisco/fullscreenpdf-state nil)

(defun cisco/fullscreenpdf ()
  (interactive)
  (if cisco/fullscreenpdf-state
      ;; restore
      (progn
        (setq mode-line-format (default-value 'mode-line-format))
        (setq cisco/fullscreenpdf-state nil)
        (force-mode-line-update)
        (redraw-display))
    ;; hide
    (progn
      (setq mode-line-format nil)
      (setq cisco/fullscreenpdf-state t)
      (force-mode-line-update)
      (redraw-display))))
