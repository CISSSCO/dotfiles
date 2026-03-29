;;; config/appLauncher.el -*- lexical-binding: t; -*-


;;; ================================
;;; SAFE APP LAUNCHER (FIXED)
;;; ================================

(use-package! app-launcher
  :defer t)

(defun my/center-frame ()
  "Center the current frame on screen."
  (let* ((frame (selected-frame))
         (fw (frame-pixel-width frame))
         (fh (frame-pixel-height frame))
         (sw (display-pixel-width))
         (sh (display-pixel-height)))
    (set-frame-position
     frame
     (/ (- sw fw) 2)
     (/ (- sh fh) 3))))

(defun my/delete-frame-safe ()
  "Delete frame without killing Emacs."
  (when (frame-live-p (selected-frame))
    ))

;; -------------------------------
;; MAIN launcher (SAFE)
;; -------------------------------
(defun emacs-run-launcher ()
  "Popup app launcher without killing Emacs."
  (interactive)
  (require 'app-launcher)

  ;; center frame
  (run-at-time "0.05 sec" nil #'my/center-frame)

  (condition-case nil
      (app-launcher-run-app)
    (quit nil)) ;; ignore ESC / cancel

  ;; always close only this frame
  (my/delete-frame-safe))

;; -------------------------------
;; Counsel launcher (SAFE)
;; -------------------------------
(defun emacs-counsel-launcher ()
  (interactive)
  (require 'counsel)

  (run-at-time "0.05 sec" nil #'my/center-frame)

  (condition-case nil
      (counsel-linux-app)
    (quit nil))

  (my/delete-frame-safe))
