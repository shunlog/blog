(require 'ox-publish)
(require 'htmlize)

(setq org-html-validation-link nil
      org-html-head-include-scripts nil
      org-html-head-include-default-style nil
      org-html-head "<link rel=\"stylesheet\" href=\"https://cdn.simplecss.org/simple.min.css\" />"
      org-html-link-up ""
      org-html-link-home "")

(setq org-export-global-macros
      '(("timestamp" . "@@html:<span class=\"timestamp\">[$1]</span>@@")))

(defun my/org-sitemap-date-entry-format (entry style project)
  "Format ENTRY in org-publish PROJECT Sitemap format ENTRY ENTRY STYLE format that includes date."
  (let ((filename (org-publish-find-title entry project)))
    (if (= (length filename) 0)
        (format "*%s*" entry)
      (format "{{{timestamp(%s)}}} [[file:%s][%s]]"
              (format-time-string "%Y-%m-%d"
                                  (org-publish-find-date entry project))
              entry
              filename))))


;; Define the publishing project
(let*
    ((current-path (file-name-directory (or load-file-name buffer-file-name)))
     (html-preamble "<nav>
  <a href=\"/\">&lt; Home</a>
  <a href=\"/posts\">Posts</a>
</nav>
<div id=\"updated\">Updated: %C</div>"))
  
  (setq org-publish-project-alist
        `(("root"
           :recursive nil
           :base-extension "org"
           :base-directory ,(expand-file-name "./content" current-path)
           :publishing-directory ,(expand-file-name "./public" current-path)
           :publishing-function org-html-publish-to-html
           :html-preamble ,html-preamble)
          
          ("posts"
           :recursive t
           :base-extension "org"
           :base-directory ,(expand-file-name "./content/posts" current-path)
           :publishing-directory ,(expand-file-name "./public/posts" current-path)
           :publishing-function org-html-publish-to-html
           :html-preamble ,html-preamble

           :auto-sitemap t
           :sitemap-filename "index.org"
           :sitemap-title "Posts"
           :sitemap-sort-files anti-chronologically
           :sitemap-format-entry my/org-sitemap-date-entry-format

           :with-toc nil
           :with-author nil
           :with-creator t
           :section-numbers nil
           :time-stamp-file t)

          ("all"
           :components ("root" "posts")))))


(org-publish "all" 't)
