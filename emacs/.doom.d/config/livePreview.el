;;; config/livePreview.el -*- lexical-binding: t; -*-


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

