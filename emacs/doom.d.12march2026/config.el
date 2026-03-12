;;; ~/.doom.d/config.el -*- lexical-binding: t; -*-

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; BASIC ORG SETTINGS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
(setq org-directory "~/git/docs/org/")
(setq org-roam-directory (file-truename "~/git/docs/org/roam/"))
(after! org
  (setq org-agenda-files
        (directory-files-recursively "~/git/docs/org/" "\\.org$")))

(after! org
  (setq org-startup-indented t
        org-hide-emphasis-markers t
        org-pretty-entities t)

  ;; auto create IDs for headings when linking
  (setq org-id-link-to-org-use-id 'create-if-interactive))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ORG MODERN UI
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package! org-modern
  :hook (org-mode . org-modern-mode))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ORG ROAM CORE
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;


(unless (file-directory-p org-roam-directory)
  (make-directory org-roam-directory t))

(after! org-roam

  ;; autosync database
  (org-roam-db-autosync-mode)

  ;; improve performance
  (setq org-roam-db-gc-threshold most-positive-fixnum)

  ;; faster database updates
  (setq org-roam-db-update-method 'immediate)

  ;; better search display
  (setq org-roam-node-display-template
        (concat "${title:*} "
                (propertize "${tags:20}" 'face 'org-tag)))

  ;; backlinks sidebar width
  (setq org-roam-buffer-width 0.33)

  ;; backlinks sections
  (setq org-roam-mode-sections
        '(org-roam-backlinks-section
          org-roam-reflinks-section
          org-roam-unlinked-references-section))

  ;; roam notes (no capture buffer)
  (setq org-roam-capture-templates
        '(("d" "default" plain "%?"
           :if-new
           (file+head "%<%Y%m%d%H%M%S>-${slug}.org"
                      "#+title: ${title}\n#+date: %U\n\n")
           :immediate-finish t
           :jump-to-captured t
           :unnarrowed t)

          ("r" "reference" plain "%?"
           :if-new
           (file+head "reference/%<%Y%m%d%H%M%S>-${slug}.org"
                      "#+title: ${title}\n#+date: %U\n#+filetags: reference\n\n")
           :immediate-finish t
           :jump-to-captured t
           :unnarrowed t)

          ("p" "project" plain "%?"
           :if-new
           (file+head "projects/${slug}.org"
                      "#+title: ${title}\n#+date: %U\n#+filetags: project\n\n* Goals\n\n* Tasks\n\n* Notes\n")
           :immediate-finish t
           :jump-to-captured t
           :unnarrowed t))))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; DAILY NOTES (DIRECT OPEN)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(setq org-roam-dailies-directory "daily/")

(setq org-roam-dailies-capture-templates
      '(("d" "daily" plain "%?"
         :if-new
         (file+head "%<%Y-%m-%d>.org"
                    "#+title: %<%Y-%m-%d>\n\n")
         :immediate-finish t
         :jump-to-captured t
         :unnarrowed t)))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ORG SUPER LINKS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package! org-super-links
  :after org)

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; ORG ROAM UI (GRAPH VIEW)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(use-package! org-roam-ui
  :after org-roam
  :config
  (setq org-roam-ui-sync-theme t
        org-roam-ui-follow t
        org-roam-ui-update-on-save t
        org-roam-ui-open-on-start nil))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; EVIL ESCAPE (jk / kj)
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(after! evil-escape
  (setq evil-escape-key-sequence "jk"
        evil-escape-unordered-key-sequence t
        evil-escape-delay 0.2))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; KEYBINDINGS
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(map! :leader
      (:prefix ("n r" . "org-roam")
       :desc "Find/Create note" "f" #'org-roam-node-find
       :desc "Insert link" "i" #'org-roam-node-insert
       :desc "Capture node" "c" #'org-roam-node-find
       :desc "Toggle backlinks buffer" "b" #'org-roam-buffer-toggle
       :desc "Graph UI" "g" #'org-roam-ui-open
       :desc "Today note" "d t" #'org-roam-dailies-capture-today))

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; QUICK NOTE SHORTCUT
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(map! :leader
      :desc "Quick roam note"
      "n n"
      #'org-roam-node-find)


(setq org-agenda-files
      '("~/git/docs/org/"
        "~/git/docs/org/roam/"))
