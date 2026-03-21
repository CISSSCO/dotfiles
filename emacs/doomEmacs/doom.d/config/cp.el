;;; config/cp.el -*- lexical-binding: t; -*-
(defun cisco/contest ()
  (interactive)
  (let* (
         ;; updated paths
         (org-base "~/git/org/")
         (roam-base "~/git/org/roam/")
         (contest-base (concat org-base "contest/"))

         ;; timestamp
         (timestamp (format-time-string "%Y-%m-%d-%H%M"))

         ;; contest folder (code files)
         (contest-dir (concat contest-base timestamp "/"))
         (main-file (concat contest-dir "main.cpp"))
         (input-file (concat contest-dir "input.txt"))
         (output-file (concat contest-dir "output.txt"))

         ;; roam files
         (contest-node (concat roam-base "contest/" timestamp ".org"))
         (central-node (concat roam-base "contest/contest.org"))

         contest-id central-id
         )

    ;; ensure dirs
    (make-directory contest-dir t)
    (make-directory (file-name-directory contest-node) t)

    ;; create central contest node if not exists
    (unless (file-exists-p central-node)
      (with-temp-file central-node
        (insert "#+title: Contest\n#+filetags: contest\n\n* All Contests\n")))

    ;; ensure central node has ID
    (with-current-buffer (find-file-noselect central-node)
      (org-id-get-create)
      (setq central-id (org-id-get))
      (save-buffer))

    ;; create symlink inside contest folder → points to roam node
    (let ((symlink-path (concat contest-dir "contest.org")))
    (unless (file-exists-p symlink-path)
        (make-symbolic-link (expand-file-name contest-node) symlink-path)))

    ;; create contest node
    (unless (file-exists-p contest-node)
      (with-temp-file contest-node
        (insert (format "#+title: Contest %s\n#+filetags: contest\n\n* Files\n- [[file:%s][Open Folder]]\n"
                        timestamp contest-dir))))

    ;; ensure contest node has ID
    (with-current-buffer (find-file-noselect contest-node)
      (org-id-get-create)
      (setq contest-id (org-id-get))
      (save-buffer))

    ;; append ID-based link to central node (GRAPH FIX)
    (with-current-buffer (find-file-noselect central-node)
      (goto-char (point-max))
      (insert (format "\n- [[id:%s][Contest %s]]"
                      contest-id timestamp))
      (save-buffer))

    ;; create code files (UNCHANGED)
    (unless (file-exists-p main-file)
      (with-temp-file main-file
        (insert "#include <bits/stdc++.h>\nusing namespace std;\n\nint main() {\n    ios::sync_with_stdio(false);\n    cin.tie(NULL);\n\n    \n\n    return 0;\n}\n")))

    (unless (file-exists-p input-file)
      (write-region "" nil input-file))

    (unless (file-exists-p output-file)
      (write-region "" nil output-file))

    ;; layout (UNCHANGED)
    (delete-other-windows)
    (find-file main-file)

    (split-window-right)
    (other-window 1)
    (find-file input-file)

    (split-window-below)
    (other-window 1)
    (find-file output-file)

    (other-window -2)

    ;; DAILY LINK (NOW USING ID → graph connected)
    (when (featurep 'org-roam)
      (let* ((main-win (selected-window))
             (link (format "[[id:%s][Contest %s]]"
                           contest-id
                           timestamp)))

        (save-window-excursion
          (org-roam-dailies-capture-today)
          (goto-char (point-max))
          (insert (format "\n* Contest\n- %s\n" link))
          (save-buffer))

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
