;;; config/cp.el -*- lexical-binding: t; -*-


(defun cisco/contest ()
  (interactive)
  (let* (
         ;; base paths (aligned with your config)
         (org-base "~/git/docs/org/")
         (contest-base (concat org-base "contest/"))

         ;; timestamp
         (timestamp (format-time-string "%Y-%m-%d-%H%M"))

         ;; folder + files
         (contest-dir (concat contest-base timestamp "/"))
         (main-file (concat contest-dir "main.cpp"))
         (input-file (concat contest-dir "input.txt"))
         (output-file (concat contest-dir "output.txt"))
         (notes-file (concat contest-dir "notes.org"))

         ;; relative path for org linking
         (relative-path (concat "contest/" timestamp "/"))
         )

    ;; ensure base exists
    (unless (file-directory-p contest-base)
      (make-directory contest-base t))

    ;; create contest folder
    (make-directory contest-dir t)

    ;; create files
    (unless (file-exists-p main-file)
      (with-temp-file main-file
        (insert "#include <bits/stdc++.h>\nusing namespace std;\n\nint main() {\n    ios::sync_with_stdio(false);\n    cin.tie(NULL);\n\n    \n\n    return 0;\n}\n")))

    (unless (file-exists-p input-file)
      (write-region "" nil input-file))

    (unless (file-exists-p output-file)
      (write-region "" nil output-file))

    (unless (file-exists-p notes-file)
      (with-temp-file notes-file
        (insert "#+title: Contest " timestamp "\n\n* Problems\n\n")))

    ;; layout (like your screenshot)
    (delete-other-windows)
    (find-file main-file)

    (split-window-right)
    (other-window 1)
    (find-file input-file)

    (split-window-below)
    (other-window 1)
    (find-file output-file)

    (other-window -2)

    ;; ORG-ROAM DAILY LINKING (fixed)
    (when (featurep 'org-roam)
      (let* ((main-win (selected-window))
             (link (format "[[file:%s][Contest %s]]"
                           (expand-file-name notes-file)
                           timestamp)))

        (save-window-excursion
          (org-roam-dailies-capture-today)
          (goto-char (point-max))
          (insert (format "\n* Contest\n- %s\n" link))
          (save-buffer))

        ;; restore focus to main.cpp
        (select-window main-win)))))

(defun cisco/run-cpp ()
  (interactive)
  (let* ((dir (file-name-directory (buffer-file-name)))
         (default-directory dir)
         (compile-cmd "g++ -std=c++17 -O2 main.cpp -o main")
         (run-cmd "./main < input.txt > output.txt")
         (output-buffer (get-file-buffer "output.txt")))

    (message "Compiling...")
    (if (= 0 (shell-command compile-cmd))
        (progn
          (message "Running...")
          (shell-command run-cmd)

          ;; refresh output buffer if open
          (when output-buffer
            (with-current-buffer output-buffer
              (revert-buffer :ignore-auto :noconfirm)))

          (message "Done! Output refreshed"))
      (message "Compilation failed"))))

(map! :leader
      :desc "Run C++ (CP)"
      "r" #'cisco/run-cpp)

(after! smartparens
  ;; disable < > auto pairing ONLY in C++
  (sp-local-pair 'c++-mode "<" nil :actions nil))
