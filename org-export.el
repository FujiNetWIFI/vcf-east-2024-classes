;;; org-export.el --- presentation export script

;;; Commentary:
;;; Requirements:

(defvar package-archives)
(defvar package-list)
(defvar package-archive-contents)

(setq package-archives (list))
(add-to-list 'package-archives '("nongnu" . "https://elpa.nongnu.org/nongnu/") t)
(add-to-list 'package-archives '("elpa" . "https://elpa.gnu.org/packages/") t)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
(add-to-list 'package-archives '("org" . "https://orgmode.org/elpa/") t)

(setq package-list
      '(org
        ox-reveal
        htmlize))

(package-initialize)

(unless package-archive-contents
  (package-refresh-contents))

(dolist (package package-list)
  (unless (package-installed-p package)
    (package-install package)))

(require 'org)
(require 'ox)
(require 'ox-publish)
(require 'ox-reveal)
(require 'htmlize)

;;; Code:

;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; mark-fisher presentation
(setq user-full-name "Mark Fisher")
(setq user-mail-address "mark.j.fisher@gmail.com")

(setq org-publish-project-alist
      '(("vcfe-assembler-basics"
         :base-directory "mark-fisher"
         :publishing-directory "build/mark-fisher/"
         ;; :publishing-function org-html-publish-to-html
         :publishing-function org-reveal-publish-to-reveal)))

;; force publish to happen
(setq org-publish-use-timestamps-flag nil)
(org-mode)

;; start publishing
(org-publish-project "vcfe-assembler-basics")

;; additional files
(copy-directory "mark-fisher/images" "build/mark-fisher/images"
                :parents t)


(provide 'org-export)

;;; org-export.el ends here