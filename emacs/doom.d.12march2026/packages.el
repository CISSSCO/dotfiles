;; org-roam ecosystem
(package! org-roam-ui)
(package! websocket)
(package! simple-httpd)

;; UI improvements
(package! org-modern)

;; bidirectional linking
(package! org-super-links
  :recipe (:host github :repo "toshism/org-super-links"))

;; optional
(package! org-roam-timestamps)
