;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets. It is optional.
;; (setq user-full-name "John Doe"
;;       user-mail-address "john@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom:
;;
;; - `doom-font' -- the primary font to use
;; - `doom-variable-pitch-font' -- a non-monospace font (where applicable)
;; - `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;; - `doom-symbol-font' -- for symbols
;; - `doom-serif-font' -- for the `fixed-pitch-serif' face
;;
;; See 'C-h v doom-font' for documentation and more examples of what they
;; accept. For example:
;;
;;(setq doom-font (font-spec :family "Fira Code" :size 12 :weight 'semi-light)
;;      doom-variable-pitch-font (font-spec :family "Fira Sans" :size 13))
;;
;; If you or Emacs can't find your font, use 'M-x describe-font' to look them
;; up, `M-x eval-region' to execute elisp code, and 'M-x doom/reload-font' to
;; refresh your font settings. If Emacs still can't find your font, it likely
;; wasn't installed correctly. Font issues are rarely Doom issues!

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
;; (setq doom-theme 'doom-one)
(setq doom-theme 'doom-gruvbox)

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type 'relative)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")


;; Whenever you reconfigure a package, make sure to wrap your config in an
;; `after!' block, otherwise Doom's defaults may override your settings. E.g.
;;
;;   (after! PACKAGE
;;     (setq x y))
;;
;; The exceptions to this rule:
;;
;;   - Setting file/directory variables (like `org-directory')
;;   - Setting variables which explicitly tell you to set them before their
;;     package is loaded (see 'C-h v VARIABLE' to look up their documentation).
;;   - Setting doom variables (which start with 'doom-' or '+').
;;
;; Here are some additional functions/macros that will help you configure Doom.
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;; Alternatively, use `C-h o' to look up a symbol (functions, variables, faces,
;; etc).
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.

;; org journal settings
(setq org-journal-date-prefix "#+TITLE: "
      org-journal-time-prefix "** "
      org-journal-date-format "%a, %d-%m-%Y"
      org-journal-file-format "%d-%m-%Y.org")

(org-babel-do-load-languages
 'org-babel-load-languages
 '((emacs-lisp . t)
   (python . t)
   (C . t)
   (C++ . t)
   (fortran . t)
   (bash . t)
   (javascript . t)))


(setq org-confirm-babel-evaluate nil)
(setq-default evil-escape-key-sequence "kj")
;;(setq-default evil-escape-key-sequence "jk")

;; Disable subscript and superscript interpretation during export
(setq org-export-with-sub-superscripts '{})


;;; Theme and Fonts ----------------------------------------

;; Install doom-themes
(unless (package-installed-p 'doom-themes)
  (package-install 'doom-themes))

;; Load up doom-palenight for the System Crafters look
;;(load-theme 'doom-palenight t)


;; Set tab width to 4 spaces globally
(setq-default tab-width 4)

;; Use spaces instead of tabs
(setq-default indent-tabs-mode nil)

;; Enable auto-indentation globally
(electric-indent-mode 1)

;; Enable auto-indentation in programming modes
(add-hook 'prog-mode-hook 'electric-indent-mode)

;; Specific settings for Python
(use-package! python
  :config
  (setq python-indent-offset 4))

;; Specific settings for C/C++
(use-package! cc-mode
  :config
  (setq c-basic-offset 4))


(use-package dmenu
  :ensure t
  :bind
  ("C-c d d" . dmenu))


;; (require 'exwm-randr)
;; (exwm-randr-enable)
;; (start-process-shell-command "xrandr" nil "xrandr -s 1920x1080")

;; (require 'exwm-systemtray)
;; (exwm-systemtray-enable)

;;; ~/.doom.d/config.el

;; ---------------------------
;; EXWM (Emacs X Window Manager)
;; ---------------------------

;;(use-package exwm
;; :ensure t
;; :config
;; )

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
            (lambda (&rest args)
              (ignore-errors
                (my/org-present-show-current-only)))))


;; ================================
;; GitHub-style realtime Org preview
;; ================================

;; Disable Org's own CSS and htmlize (CRITICAL)
(setq org-html-head-include-default-style nil)
(setq org-html-head-include-scripts nil)
(setq org-html-htmlize-output-type nil)

(defun cisco/org-html-filter (buffer)
  (with-current-buffer buffer
    (let ((html
           (org-export-as
            'html nil nil t
            '(:with-toc nil
              :section-numbers nil
              :html-postamble nil
              :html-preamble nil
              :html-head nil
              :html-head-extra nil
              :with-author nil
              :with-date nil))))
      (concat
       "<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8'>
<meta name='viewport' content='width=device-width, initial-scale=1'>

<link rel='stylesheet'
 href='https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/5.5.1/github-markdown.min.css'>

<style>
/* --- GitHub dark mode base --- */
body {
  background-color: #0d1117;
  margin: 0;
}

/* --- GitHub markdown container --- */
.markdown-body {
  box-sizing: border-box;
  max-width: 980px;
  margin: 0 auto;
  padding: 32px;
  background-color: #0d1117;
  color: #c9d1d9;
  font-family: -apple-system, BlinkMacSystemFont,
               'Segoe UI', Helvetica, Arial, sans-serif;
}

/* --- Headings --- */
.markdown-body h1,
.markdown-body h2,
.markdown-body h3,
.markdown-body h4,
.markdown-body h5,
.markdown-body h6 {
  border-bottom: none;
}

/* --- Code blocks --- */
.markdown-body pre {
  background-color: #161b22 !important;
  padding: 16px;
  border-radius: 6px;
}

/* Inline code */
.markdown-body code {
  background-color: #161b22;
  padding: 0.2em 0.4em;
  border-radius: 6px;
}

/* --- Tables --- */
.markdown-body table {
  background-color: #0d1117;
  border-collapse: collapse;
}

.markdown-body table th,
.markdown-body table td {
  border: 1px solid #30363d;
  padding: 6px 13px;
}

/* --- Blockquotes --- */
.markdown-body blockquote {
  color: #8b949e;
  border-left: 0.25em solid #30363d;
}

/* --- Org-specific cleanup --- */
.org-center { text-align: center; }
.org-right { text-align: right; }
.org-left  { text-align: left; }

/* Remove Org-generated wrappers */
#content, #table-of-contents { display: none; }
</style>
</head>

<body>
<article class='markdown-body'>
"
       html
       "
</article>
</body>
</html>"))))

(defun cisco/org-live-preview ()
  "True realtime GitHub-style Org preview."
  (interactive)
  (require 'impatient-mode)
  (require 'simple-httpd)

  (setq httpd-port 8080)
  (httpd-start)

  (setq impatient-mode-delay 0.1)

  ;; Register buffer for realtime updates
  (imp-set-user-filter #'cisco/org-html-filter)
  (imp-visit-buffer)
  (impatient-mode 1)

  ;; Correct impatient-mode URL
  (browse-url
   (format "http://localhost:%d/imp/live/%s/"
           httpd-port
           (url-hexify-string (buffer-name)))))

;; ==========================================
;; Org → GitHub Flavored Markdown live preview
;; ==========================================

(require 'simple-httpd)
(require 'impatient-mode)

(setq httpd-port 8080)

(defun cisco/org-to-gfm ()
  "Convert current Org buffer to GitHub Flavored Markdown."
  (let* ((org-file (buffer-file-name))
         (tmp-md (make-temp-file "org-preview" nil ".md")))
    (call-process
     "pandoc" nil nil nil
     org-file
     "-f" "org"
     "-t" "gfm"
     "--wrap=none"
     "-o" tmp-md)
    (with-temp-buffer
      (insert-file-contents tmp-md)
      (buffer-string))))

(defun cisco/org-gfm-html-filter (buffer)
  (with-current-buffer buffer
    (let ((md (cisco/org-to-gfm)))
      (concat
       "<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8'>
<meta name='viewport' content='width=device-width, initial-scale=1'>

<link rel='stylesheet'
 href='https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/5.5.1/github-markdown.min.css'>

<style>
body {
  background-color: #0d1117;
  margin: 0;
}

.markdown-body {
  box-sizing: border-box;
  max-width: 980px;
  margin: 0 auto;
  padding: 32px;
  background-color: #0d1117;
  color: #c9d1d9;
  font-family: -apple-system, BlinkMacSystemFont,
               'Segoe UI', Helvetica, Arial, sans-serif;
}
</style>
</head>

<body>
<article class='markdown-body' id='content'>
<script src='https://cdn.jsdelivr.net/npm/marked/marked.min.js'></script>
<script>
document.getElementById('content').innerHTML =
  marked.parse(`"
       md
       "`);
</script>
</article>
</body>
</html>"))))

(defun cisco/org-gfm-live-preview ()
  "Realtime Org → GitHub README preview."
  (interactive)
  (httpd-start)

  (setq impatient-mode-delay 0.1)

  (imp-set-user-filter #'cisco/org-gfm-html-filter)
  (imp-visit-buffer)
  (impatient-mode 1)

  (browse-url
   (format "http://localhost:%d/imp/live/%s/"
           httpd-port
           (url-hexify-string (buffer-name)))))

;; ==========================================
;; GitHub-style realtime Markdown preview
;; ==========================================

(require 'simple-httpd)
(require 'impatient-mode)

(setq httpd-port 8080)

(defun cisco/md-html-filter (buffer)
  (with-current-buffer buffer
    (let ((md (buffer-string)))
      (concat
       "<!DOCTYPE html>
<html>
<head>
<meta charset='utf-8'>
<meta name='viewport' content='width=device-width, initial-scale=1'>

<link rel='stylesheet'
 href='https://cdnjs.cloudflare.com/ajax/libs/github-markdown-css/5.5.1/github-markdown.min.css'>

<style>
body {
  background-color: #0d1117;
  margin: 0;
}

.markdown-body {
  box-sizing: border-box;
  max-width: 980px;
  margin: 0 auto;
  padding: 32px;
  background-color: #0d1117;
  color: #c9d1d9;
  font-family: -apple-system, BlinkMacSystemFont,
               'Segoe UI', Helvetica, Arial, sans-serif;
}
</style>
</head>

<body>
<article class='markdown-body' id='content'></article>

<script src='https://cdn.jsdelivr.net/npm/marked/marked.min.js'></script>
<script>
document.getElementById('content').innerHTML =
  marked.parse(`"
       md
       "`);
</script>

</body>
</html>"))))

(defun cisco/md-live-preview ()
  "Realtime GitHub-style Markdown preview."
  (interactive)
  (httpd-start)

  (setq impatient-mode-delay 0.1)

  (imp-set-user-filter #'cisco/md-html-filter)
  (imp-visit-buffer)
  (impatient-mode 1)

  (browse-url
   (format "http://localhost:%d/imp/live/%s/"
           httpd-port
           (url-hexify-string (buffer-name)))))
